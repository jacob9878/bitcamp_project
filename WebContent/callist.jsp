<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  

<%

String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

List<CalendarDto> list = (List<CalendarDto>)request.getAttribute("list");

%>

<%@include file="top.jsp" %>         
      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">운동 캘린더</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                <li class="breadcrumb-item"><a href="calendar?param=calendar&year=<%=year%>&month=<%=month%>&day=<%=day%>">운동캘린더</a></li>
                <li class="breadcrumb-item active">일정목록</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
 
 
      
      
      <!-- ======================================내용=================================== -->






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






<div class="row">
<div class="col-xl-2"></div>
<div class="col-xl-8">
<h2 style="font-style: italic; padding: 50px"><%=year %>년 <%=month %>월 <%=day %>일 일정</h2>




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
		<th><button type="button" class="btn btn-outline-primary" onclick="Gocalwrite()">일정추가</button></th>		
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
<div class="col-xl-2"></div>
</div>







      
      <!-- ======================================내용 END =================================== -->
      
     
<%@include file="bottom.jsp" %>    
    
    <script type="text/javascript">
    function Gocalwrite() {
    	location.href = "calendar?param=calwrite&year=<%=year%>&month=<%=month%>&day=<%=day%>";
		
	}
    
    
    </script>
    
    
    
  </body>
</html>
    


















