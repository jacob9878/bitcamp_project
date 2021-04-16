<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    

<%
BbsDto bbs = (BbsDto)request.getAttribute("bbs");
request.getAttribute("writerDto");
%>


<%@include file="top.jsp" %>
      
      
       <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">바디프로필</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="bbs?param=goPage&bbsType=0">커뮤니티</a></li>
                <li class="breadcrumb-item active">바디프로필</li>
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
		<form class="form-horizontal" id="fileForm" method="post" action="bbs?param=bodyProfileUpdateAf&seq=${bbs.seq }" enctype="multipart/form-data">
			<input type="hidden" name="bbsType" value="2">
			<div class="col-md-40 col-md-offset-1">
				<table class="table table-bordered" border ="1" >
					<tr>
						<th>ID</th>
						<td style="padding-left: 10px">${mem.memberID }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<div class="form-group">
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                        	<input type="text" class="form-control" name="title" id="title" value="${bbs.title }"/>
			                        </div>
			                    </div>
			                </div>
						</td>
					</tr>
					<tr>
						<th>사진</th>
						<td>
							<div class="form-group">
								<div class="col-sm-7">
									<img alt="" id="imgInput" src="upload/${bbs.img }">
									&nbsp;&nbsp;<input type='file' id="profileImg" name="profileImg"/>
								</div>
			                </div>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<div class="form-group">
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <textarea rows="10" cols="80" id="content" name="content" class="form-control" style="resize: none;">${bbs.content }</textarea>
			                        </div>
			                    </div>
			                </div>
						</td>
					</tr>
				</table>
				<div class="row justify-content-center">
				    <button type="submit" id="updateBtn" class="btn btn-primary">수정</button>&emsp;
					<input type="button" class="btn btn-secondary" value="뒤로" onclick="location.href='bbs?param=goPage&bbsType=2'">
				</div>
			</div>
		</form>
	</div>
</div>		
<br>
      <!-- ======================================내용 END =================================== -->
      
     
<%@include file="bottom.jsp" %>     
  
  
  <script type="text/javascript">
  
  /* 프로필 사진 미리보기 */
  function readURL(input) {
   if (input.files && input.files[0]) {
    var reader = new FileReader();
    
    reader.onload = function (e) {
     $('#imgInput').attr('src', e.target.result);  
    }
    
    reader.readAsDataURL(input.files[0]);
    }
  }
   
  $("#profileImg").change(function(){
     readURL(this);
  });

  
  
  
  </script>
  
  
  
</html>