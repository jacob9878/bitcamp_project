<%@page import="dao.CalendarDao"%>
<%@page import="dto.CalendarDto"%>
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
              <h1 class="h2">일정 상세 정보</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                <li class="breadcrumb-item"><a href="index.html">운동캘린더</a></li>
                <li class="breadcrumb-item active">일정 상세 정보</li>
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
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto = (CalendarDto)request.getAttribute("dto");

%>




<div class="row">
<div class="col-xl-2"></div>
<div class="col-xl-8">
<br><br><br>
<div align="center">
<table class="table">
<col width="200"><col width="500">



<tr>
	<th>제목</th>
	<th><%=dto.getCalTitle() %></th>
</tr>

<tr>
	<th>일정</th>
	<th><%=toDates(dto.getCalRdate()) %></th>
</tr>

<tr>
	<th>내용</th>
	<th>
		<%=dto.getCalContent() %>
		
	</th>
</tr>

<tr align="right">
	<th colspan="2">
		<input type="button" value="수정" class="btn btn-outline-primary" onclick="location.href='calendar?param=calupdate&seq=<%=dto.getCalSeq() %>'">
		<input type="button" value="삭제" class="btn btn-outline-primary" onclick="location.href='calendar?param=caldel&seq=<%=dto.getCalSeq() %>'">
	</th>
</tr>

</table>

</div>

</div>
<div class="col-xl-2"></div>
</div>




      <!-- ======================================내용 END =================================== -->
      
     
<%@include file="bottom.jsp" %>    
      
  