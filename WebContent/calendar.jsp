<%@page import="util.UtilEx"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="top.jsp" %>       
    

<%!

// Date -> String	
// String -> Date   yyyy-mm-dd
public String toDates(String mdate){
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
	
	// 201810021607	-> 2018-10-02 16:07 
	String s = mdate.substring(0, 4) + "-"	// yyyy 
			+ mdate.substring(4, 6) + "-"	// MM
			+ mdate.substring(6, 8) + " "	// dd
			+ mdate.substring(8, 10) + ":"	// hh
			+ mdate.substring(10, 12) + ":00";
	
	Timestamp d = Timestamp.valueOf(s);
	
	return sdf.format(d);
}
%>        


<style type="text/css">
    


// ==========================================
// calendar
// ==========================================

.clearfix::after,
.calendar ol::after {
  content: ".";
  display: block;
  height: 0;
  clear: both;
  visibility: hidden;
}

/* ================
Calendar Styling */
.calendar {
  border-radius: 10px;
  height: 650px;
}

.month {
  font-size: 2rem;
}

@media (min-width: 992px) {
  .month {
    font-size: 2.5rem;
  }
}

.calendar ol li {
  float: left;
  width: 14.28571%;
}

.calendar .day-names {
  border-bottom: 1px solid #eee;
}

.calendar .day-names li {
  text-transform: uppercase;
  margin-bottom: 0.5rem;
}

.calendar .days li {
  border-bottom: 1px solid #eee;
  min-height: 5rem;
}

.calendar .days li .date {
  margin: 0.5rem 0;
}

.calendar .days li .event {
  font-size: 0.75rem;
  padding: 0.4rem;
  color: white;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  border-radius: 4rem;
  margin-bottom: 1px;
} 

 .calendar .days li .event.span-2 {
  width: 200%;
}

.calendar .days li .event.begin {
  border-radius: 1rem 0 0 1rem;
}

.calendar .days li .event.end {
  border-radius: 0 1rem 1rem 0;
}

.calendar .days li .event.clear {
  background: none;
}

.calendar .days li:nth-child(n+29) {
  border-bottom: none;
}

.calendar .days li.outside .date {
  color: #ddd;
}


/*
*
* ==========================================
* FOR DEMO PURPOSES
* ==========================================
*
*/
tbody {
  min-height: 50vh;
}
    
    
    
</style>
    
	
	<!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">운동 캘린더</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="#">운동일지</a></li>
                <li class="breadcrumb-item active">운동 캘린더</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
<!-- ======================================내용=================================== -->	

<%	
	Calendar cal = Calendar.getInstance();

	cal.set(Calendar.DATE, 1); 	// 2021/03/19 -> 2021/03/01
	
	String syear = request.getParameter("year");
	String smonth = request.getParameter("month");
		
	int year = cal.get(Calendar.YEAR);
	if(UtilEx.nvl(syear) == false){	// parameter가 넘어 와서 syear 값이 있는 경우
		year = Integer.parseInt(syear);
	}
	
	int month = cal.get(Calendar.MONTH) + 1;
	
	int day = cal.get(Calendar.DATE);

	
	if(UtilEx.nvl(smonth) == false){
		month = Integer.parseInt(smonth);
	}
	
	if(month < 1){
		month = 12;
		year--;
	}
	if(month > 12){
		month = 1;
		year++;
	}
	
	cal.set(year, month - 1, 1);	// 연 월 일이 셋팅 완료
	
	// 요일
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		
	
		// <	month--
		String p = String.format("<a href='%s?year=%d&month=%d'><i class='fa fa-angle-left' aria-hidden='true' style='font-size: 35px; color: black'></i></a>", 
									"calendar.jsp", year, month-1);
		
		// >	month++
		String n = String.format("<a href='%s?year=%d&month=%d'><i class='fa fa-angle-right' aria-hidden='true' style='font-size: 35px; color: black'></i></a>", 
									"calendar.jsp", year, month+1);
		

		CalendarDao dao = CalendarDao.getInstance();
		List<CalendarDto> list 
			= dao.getCalendarList(mem.getMemberID() , year + UtilEx.two(month + "")); 
		
		List<CalendarDto> callist = (List<CalendarDto>)request.getAttribute("list");
		
		
		
		// 검색하기 위한 값
		String search = (String)request.getAttribute("search");
		if(search == null){
			search = "";
		}
		List<CalendarDto> searchlist = (List<CalendarDto>)request.getAttribute("searchlist");
		
%>

<!-- 일정 관리 -->
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Calendar list</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="background-color: white;">   
              
         <h2 style="font-style: italic; "><%=year %>년 <%=month %>월 일정</h2>

<table class="table">
    <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>날짜</th>
            <th>삭제</th>
        </tr>
    </thead>
    <tbody>
    <%
if(list.size() == 0 || list == null ){
	%>
	<tr align="center">		
		<th  colspan="3">일정이 없습니다. 일정을 추가 해 보세요 !</th>
		<th><button type="button" class="btn btn-outline-primary" onclick="location.href='calendar?param=calwrite&year=<%=year %>&month=<%=month %>&day=<%=day %> '">일정추가</button></th>		
	<tr>
	<%
}else{
	for(int i = 0;i < list.size(); i++ ){
	CalendarDto dto = list.get(i);
	%>
	<tr style="font-style: italic;">	
		<th><%=i + 1 %></th>
		
		<th>
			<a href="calendar?param=caldetail&seq=<%=dto.getCalSeq() %>">
				<%=dto.getCalTitle() %>
			</a>
		</th>
		<th><%=toDates(dto.getCalRdate()) %></th>
		<th>
			<form action="calendar?param=caldel" method="post">
				<input type="hidden" name="seq" value="<%=dto.getCalSeq() %>">
				<input type="submit" class="btn btn-outline-primary" value="일정삭제">
			</form>
		</th>	
	</tr>
	<%
	}
}
%>
        
    </tbody>
</table>           
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
        </div>        
      </div>
    </div>
  </div> 
</div>

<div class="row">
	<div class="col-xl-2" style="padding-top: 100px">	
		<div class="container" align="center">		
			<div>
			  <h3><%=month %>월 일정&nbsp;&nbsp;&nbsp;<i class="fa fa-calendar-check-o" aria-hidden="true"></i></h3>
			  <!-- Button to Open the Modal -->
			  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
			    일정 관리
			  </button>
			</div>
		</div>	
		
		<div align="center" style="padding-top: 100px">
			<h3>일정 , 약속 &nbsp;&nbsp;<i class="fa fa-pencil" aria-hidden="true"></i></h3>
			
			<button type="button" class="btn btn-primary" onclick="location.href='calendar?param=calwrite&year=<%=year %>&month=<%=month %>&day=<%=day %> '" >글쓰기</button>
		</div>
	</div>
	


<!-- Calendar -->

<div class="col-xl-8">  
<table>
	<tbody>
		<div class="container py-5">	  
		  <div class="calendar shadow bg-white p-5" >
		    <div class="d-flex align-items-center"> <i class="fa fa-calendar fa-3x mr-3" ></i>
		     <%=p %>&nbsp;&nbsp;&nbsp;<h2 class="month font-weight-bold mb-0 text-uppercase"><%=String.format("%d", year) %></h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		     &nbsp;&nbsp;&nbsp;<h2 class="month font-weight-bold mb-0 text-uppercase"><%=String.format("%d", month) %></h2>&nbsp;&nbsp;<%=n %>
		    </div>
		    <br>
		    <ol class="day-names list-unstyled">
		      <li class="font-weight-bold text-uppercase" style="color: red">Sun</li>
		      <li class="font-weight-bold text-uppercase">Mon</li>
		      <li class="font-weight-bold text-uppercase">Tue</li>
		      <li class="font-weight-bold text-uppercase">Wed</li>
		      <li class="font-weight-bold text-uppercase">Thu</li>
		      <li class="font-weight-bold text-uppercase">Fri</li>
		      <li class="font-weight-bold text-uppercase" style="color: blue">Sat</li>
		    </ol>
		
		    <ol class="days list-unstyled">
		     <%
		// 위쪽 빈칸
		for(int i = 1;i < dayOfWeek; i++){
			%>
			<li style="background-color: #fffff">&nbsp;</li>
			<%
		}
		     
		  // 날짜
		     int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		     for(int i = 1;i <= lastday; i++){
		     %>  
			<li class="listclick" onclick="listclick(<%=i%>)">
		     	<%=UtilEx.callist(year, month, i) %>
		     	<br>
				<%=UtilEx.makeTable(year, month, i, list) %>
		    <%
			if( (i + dayOfWeek - 1) % 7 == 0 && i != lastday){
				%>	
			</li>
			</ol>
				
				
			<ol class="days list-unstyled">
				<%
			}	
		}
		%>
		<%--밑의 빈칸 --%>
		<%
		cal.set(Calendar.DATE, lastday);	// 그 달의 마지막 날짜로 셋팅
		int weekday = cal.get(Calendar.DAY_OF_WEEK);
		for(int i = 0;i < 7 - weekday; i++){
			%>
			<li style="background-color: #ffffff">&nbsp;</li>	
			<%
		}
		%>
		
		    </ol>
		</div>
	</tbody>
</table>   
</div>
	<div class="col-xl-2"></div>
</div>



<!-- ======================================내용 END =================================== -->

<%@include file="bottom.jsp" %>   

<script type="text/javascript">
		 	 
	 function listclick(i) {
		 
		$('.listclick').click(function() {
			
			
			location.href="calendar?param=calwrite&year=<%=year%>&month=<%=month%>&day="+i;
			
		})
		
		
		function changeColor(){
			
			$('.listclick').mouseover(function(){
			$(this).addClass('changeColor');
			}).mouseout(function() {
			$(this).removeClass('changeColor');
			});
			
			}
		
		var color_old;
		$(document).ready(function() {
		  $(".listclick").bind('mouseover', function(event){
		    color_old = $(this).css('background-color');
		    $(this).css('background-color', '#EBF5FF');
		  });
		  $(".listclick").bind('mouseout',  function(event){
		    $(this).css('background-color', color_old);
		  });
		}); 
	}		
	</script>

</body>
</html>