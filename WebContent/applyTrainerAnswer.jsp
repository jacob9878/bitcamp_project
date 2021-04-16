<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<%@include file="top.jsp" %>

<%
request.getAttribute("bbs");
%>
      
      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">트레이너 신청서</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="howToUse.jsp">트레이너</a></li>
                <li class="breadcrumb-item active">트레이너 신청서</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->


<br>		
<div class="container">
	<div class="row justify-content-center">
		<form action="bbs" method="post">
			<input type="hidden" name="param" value="answerBbs">
			<input type="hidden" name="seq" value="${bbs.seq }">
			<input type="hidden" name="bbsType" value="4">
			<div class="col-md-15 col-md-offset-1">
				<h2>답글</h2><br>
				<table class="table table-bordered" border ="1" >
					<tr>
						<th>ID</th>
						<td style="padding-left: 10px">${mem.memberID }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
						<input type="text" size="50" name="title">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
						<textarea rows="20" cols="100" name="content"></textarea>
						</td>
					</tr>
				</table>
				<div class="row justify-content-center">
					<input type="submit" class="btn btn-primary" value="작성">
					<input type="button" class="btn btn-secondary" value="뒤로" onclick="location.href='bbs?param=getDetail&seq=${bbs.seq}'">
				</div>
			</div>
		</form>
	</div>
</div>		
<br>
      
      

      
      <!-- ======================================내용 END =================================== -->
      
     
<%@include file="bottom.jsp" %>   
      
