<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    

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
		<form class="form-horizontal" id="fileForm" method="post" action="bbs?param=bodyProfileWriteAf" enctype="multipart/form-data">
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
			                            <input type="text" class="form-control" name="title" id="title" />
			                        </div>
			                    </div>
			                </div>
						</td>
					</tr>
					<tr>
						<th>사진 추가</th>
						<td>
							<div class="form-group">
			                    <div class="row">
									<div class="col-sm-7">
										<img alt="" id="imgInput"/>
										&nbsp;<input type='file' id="profileImg" name="profileImg"/>
									</div>
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
			                            <textarea rows="10" cols="80" id="content" name="content" class="form-control" style="resize: none;"></textarea>
			                        </div>
			                    </div>
			                </div>
						</td>
					</tr>
					
				</table>
				<div class="row justify-content-center">
				    <button type="submit" id="writeBtn" class="btn btn-primary" disabled="disabled">글쓰기</button>
					<input type="button" class="btn btn-secondary" value="뒤로" onclick="location.href='bbs?param=goPage&bbsType=4'">
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

  

  /* 필수 입력 사항 체크해야 글쓰기 버튼 활성화 */
  $(document).on("mousemove", function() {
  		if($("#title").val() == null || $("#title").val() == "" ||
  			$("#profileImg").val() == null || $("#profileImg").val() == "" ||
  				$("#content").val() == null || $("#content").val() == "") {
  			$('#writeBtn').attr('disabled', true);
  		} else {
  			$('#writeBtn').attr('disabled', false);
  		};
  });
   
 
  
  </script>
  
  
  
</html>