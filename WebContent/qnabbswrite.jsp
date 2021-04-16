<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@include file="top.jsp" %>
      
      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">Q&A 글쓰기</h1>
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

<!-- 글을 작성 -->
<div align="center" >
	<form action="qnabbs" method="post">
		<input type="hidden" name="param" value="qnabbswriteAf">
	
		<table class="table" style="width: 1000px">
		
		<tr>
			<th>제목</th>
			<td>
				<input type="hidden" name="id" size="70px" value="<%=mem.getMemberID() %>">
				<input type="text" class="form-control" name="title" style="width: 300px">
			</td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="5" cols="40" class="form-control" name="content"></textarea>
			</td>
		</tr>
		<tr align="right">
			<td colspan="2">
				&nbsp;&nbsp;<input type="submit" class= "btn btn-outline-primary" value="글쓰기">
			</td>
		</tr>
		
		</table>
	</form>
</div>

      <!-- ======================================내용 END =================================== -->
      
     
<%@include file="bottom.jsp" %>   