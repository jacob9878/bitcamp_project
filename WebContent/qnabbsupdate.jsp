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
              <h1 class="h2">Q&A 글 수정</h1>
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


<div align="center">
<br>

<form action="qnabbs" method="post">
<input type="hidden" name="param" value="qnabbsupdateAf">
<input type="hidden" name="seq" value="<%=bbs.getSeq() %>">
			
<table class="table">
<col width="100"><col width="400"> 

<tr>
	<th>작성자</th>
	<td>
		<input type="hidden" name="id" value="<%=mem.getMemberID() %>"> 	
			<%=mem.getMemberID() %>	
	</td>	
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" class="form-control" style="width: 500px" value="<%=bbs.getTitle() %>">		
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="5" cols="50" class="form-control" name="content"><%=bbs.getContent() %></textarea>		
	</td>
</tr>
<tr align="right">
	<td colspan="2">
		<input type="submit" class= "btn btn-outline-primary" value="글수정">
	</td>
</tr>

</table>
</form>

<a href="qnabbs?param=qnabbslist" style="font-weight: bold;">글목록으로</a>
</div>
<br>



</div>
<div class="col-xl-2"></div>
</div>


      <!-- ======================================내용 END =================================== -->
      
<%@include file="bottom.jsp" %>    