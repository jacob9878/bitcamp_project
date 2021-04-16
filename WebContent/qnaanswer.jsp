<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="top.jsp" %>      
      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">Q&A 답변</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="bbs?param=homefitFreedomboardList&bbsType=0">커뮤니티</a></li>
                <li class="breadcrumb-item active">Q&A</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->


<%
BbsDto bbs = (BbsDto)request.getAttribute("bbs");
%>    


<div class="row">
	<div class="col-xl-2">
	</div>
<div class="col-xl-8">


<br>
<div align="center">
<h2 align="left"><i class="fa fa-quora" aria-hidden="true"></i></h2>


<table class="table" style="width: 1000px">
<col width="50px"><col width="300px">
<tr>
	<th>작성자</th>
	<td><%=bbs.getMemberId() %></td>
</tr>

<tr>
	<th>제목</th>
	<td><%=bbs.getTitle() %></td>
</tr>

<tr>
	<th>내용</th>
	<td>
	<%=bbs.getContent() %>
	</td>
</tr>

<tr align="right">
			<td colspan="2">작성일&nbsp;&nbsp;&nbsp; <%=bbs.getWdate().substring(0, 16) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 조회수&nbsp;&nbsp;&nbsp; <%=bbs.getReadcount() %></td>			
		</tr>




</table>
</div>

<div align="center" style="padding-bottom: 50px">



<h3 align="left">A</h3>

<form action="qnabbs" method="post">
<input type="hidden" name="param" value="qnaanswerAf">
<input type="hidden" name="seq" value="<%=bbs.getSeq() %>">

<table class="table" style="width: 1000px">
<col width="200"><col width="500">

<tr>
	<td>아이디</td>
	<td>
		<input type="hidden" name="id" size="50" readonly="readonly"
			value="<%=mem.getMemberID() %>">
			<%=mem.getMemberID() %>
	</td>
</tr>
<tr>
	<td>제목</td>
	<td>
		<input type="text" class= "form-control" name="title" size="50">
	</td>
</tr>
<tr>
	<td>내용</td>
	<td>
		<textarea rows="5" cols="40" class= "form-control" name="content"></textarea>
	</td>
</tr>
<tr align="right">
	<td colspan="2">
		<input type="submit" class="btn btn-outline-primary" value="답글작성완료" >
	</td>
</tr>



</table>

</form>
<a  href='qnabbs?param=qnabbslist'>글목록</a>

</div>

</div>
<div class="col-xl-2"></div>
</div>





	





      
      <!-- ======================================내용 END =================================== -->
      
     
<%@include file="bottom.jsp" %>   