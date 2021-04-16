<%@page import="dao.CalendarDao"%>
<%@page import="dto.CalendarDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    

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
                <li class="breadcrumb-item"><a href="index.html">운동캘린더</a></li>
                <li class="breadcrumb-item active">일정 수정</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->


<%!
public String toDates(String mdate){
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
	
	String s = mdate.substring(0, 4) + "-" 	// yyyy
			+ mdate.substring(4, 6) + "-"	// MM
			+ mdate.substring(6, 8) + " " 	// dd
			+ mdate.substring(8, 10) + ":"	// hh
			+ mdate.substring(10, 12) + ":00"; 
	Timestamp d = Timestamp.valueOf(s);
	
	return sdf.format(d);	
}

public String toOne(String msg){	// 08 -> 8
	return msg.charAt(0)=='0'?msg.charAt(1) + "": msg.trim();
}
%>


<%
Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);

String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto = dao.getDay(seq);

String year = dto.getCalRdate().substring(0, 4);
String month = toOne(dto.getCalRdate().substring(4, 6));
String day = toOne(dto.getCalRdate().substring(6, 8));
String hour = toOne(dto.getCalRdate().substring(8, 10));
String min = toOne(dto.getCalRdate().substring(10, 12));

%>












<div class="row">
<div class="col-xl-2"></div>
<div class="col-xl-8">
<h1 style="font-style: italic;">일정 수정</h1>
<form action="calendar?param=calupdateAf" method="post">
<table class="table">
<col width="200"><col width="500">
<tr>
	<th>제목</th>
	<th>
		<input type="hidden"  name="seq" value="<%=dto.getCalSeq() %>">	
		<input type="hidden" name="id" value="<%=dto.getMemberId() %>">
		<input type="text" class="form-control" size="60" name="title" value="<%=dto.getCalTitle() %>">
	</th>
</tr>

<tr>
	<th>일정</th>
	<th>
	
	<select name="year">
	<%
	for(int i = tyear - 5;i < tyear + 6; i++){
		%>
		<option <%=year.equals(i + "")?"selected='selected'":"" %> 
			value="<%=i %>"><%=i %></option>		
		<%	
	}	
	%>	
	</select>년	
	
	<select name="month">
	<%
	for(int i = 1;i <= 12; i++){
		%>
		<option <%=month.equals(i + "")?"selected='selected'":"" %> 
			value="<%=i %>"><%=i %></option>		
		<%	
	}	
	%>	
	</select>월
	
	<select name="day">
	<%
	for(int i = 1;i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
		%>
		<option <%=day.equals(i + "")?"selected='selected'":"" %> 
			value="<%=i %>"><%=i %></option>		
		<%	
	}	
	%>	
	</select>일
	
	<select name="hour">
	<%
	for(int i = 0;i < 24; i++){
		%>
		<option <%=(hour + "").equals(i + "")?"selected='selected'":"" %> 
			value="<%=i %>"><%=i %></option>		
		<%	
	}	
	%>	
	</select>시
	
	<select name="min">
	<%
	for(int i = 0;i < 60; i++){
		%>
		<option <%=(min + "").equals(i + "")?"selected='selected'":"" %> 
			value="<%=i %>"><%=i %></option>		
		<%	
	}	
	%>	
	</select>분
	
	</th>
</tr>

<tr>
	<th>내용</th>
	<th>
		<textarea rows="5" cols="60" class="form-control" name="content"><%=dto.getCalContent() %> </textarea>
	</th>
</tr>

<tr align="center">
	<td colspan="2">
		<input type="submit" class="btn btn-outline-primary" value="수정" onclick="modify()">
	</td>
<%
	String url = String.format("%s&year=%s&month=%s", 
						"calendar?param=calendar", year, month);
%>
	<td colspan="2">
		<a href="<%=url %>">일정보기</a>
	</td>
</tr>


<tr align="center">
	
</tr>
</table>
</form>

</div>
<div class="col-xl-2"></div>
</div>

<script type="text/javascript">
function modify() {
	var f = document.forms[0];
	f.submit();
}

</script>



      
      <!-- ======================================내용 END =================================== -->
      
      
 <%@include file="bottom.jsp" %>         
     
