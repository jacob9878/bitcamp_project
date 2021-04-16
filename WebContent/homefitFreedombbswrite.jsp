<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="top.jsp" %>    
    
<style type="text/css">

select {
	width: 10%; /*입력 칸 (input field) 의 폭을 지정하기 위해, 폭 속성 (width property) 를 사용하였습니다.*/
	border : 2px solid skyblue;
	border-radius : 5px;
}	
.thead-dark {
	th {
		color: $table-dark-color;
		background-color: $table-dark-bg;
		border-color: $table-dark-border-color;
		-align: center;
	}				
}

</style>
      
      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">자유게시판</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="bbs?param=homefitFreedomboardList&bbsType=0">커뮤니티</a></li>
                <li class="breadcrumb-item active">자유게시판</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->
<div align="center" >

<!-- 글을 작성 -->
	<form action="fileupload" method="post" enctype="multipart/form-data">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-sm-10">
					<input type="hidden" name="param" value="freedombbswriteAf">
					<input type="hidden" name="bbstype" value="0">			<!--  자유게시판 번호 -->

					<table class="table table-bordered" style="width: 1000px">
						<thead class="thead-dark">
							<tr>
								<th>아이디</th>
								<td>
									<%-- <input type="text" name="id" size="50px" value="<%=mem.getId() %>"> --%>
									<input type="text" name="memberid" size="70px" value=<%=mem.getMemberID() %> readonly="readonly">
								</td>
							</tr>
	
							<tr>
								<th>게시글주제</th>
								<td>
									<select name="division">
										<option value="의사소통">의사소통</option>
										<option value="잡담">잡담</option>
										<option value="연애">연애</option>
										<option value="기타">기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>파일 업로드</th>
								<td>
									<input type="file" name="fileload">
								</td>
							</tr>

							<tr>
								<th>제목</th>
								<td>
									<input type="text" name="title" size="70px">
								</td>
							</tr>

							<tr>
								<th>내용</th>
								<td>
									<textarea rows="20" cols="80" name="content"></textarea>
								</td>
							</tr>
							
						</thead>
					</table>	
				</div>
			</div>
		</div>	
	<input type="submit" class="btn btn-primary" value="글쓰기">
	</form>
</div>

      
      <!-- ======================================내용 END =================================== -->
<br><br>     
     
     
 <%@include file="bottom.jsp" %>    