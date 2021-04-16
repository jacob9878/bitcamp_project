<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="top.jsp" %>       
    
    
<%
BbsDto bbs = (BbsDto)request.getAttribute("bbs");
%>

      
      
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

<form action="bbs" method="post">
	<div align="center">
		<h2>댓글</h2>
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-sm-10">
						<input type="hidden" name="param" value="freedomanswerAf">
						<input type="hidden" name="seq" value="<%=bbs.getSeq() %>">
						<input type="hidden" name="bbsType" value="0">

						<table class="table table-bordered" border="1">
							<col width="100"><col width="300">
							<thead class="thead-dark">
								<tr>
									<th>아이디</th>
									<td>
										<input type="text" name="id" size="50" readonly="readonly"value="<%=mem.getMemberID() %>">
									</td>
								</tr>
							    <tr>
									<th>분류</th>
										<td>
											<input type="text" name="division" size="50" readonly="readonly"value="<%=bbs.getDivision() %>">
 										</td>
								</tr> 
						
						
								<tr>
									<th>제목</th>
									<td>
										<input type="text" name="title" size="50" id="title">
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<textarea rows="10" cols="50" name="content"></textarea>
									</td>
								</tr>
							</thead>
						</table>
					</div>	
				<br><br>
				</div>
			</div>		
		<input type="submit" class="btn btn-primary"value="답글작성완료">
		<input type="button"class="btn btn-secondary" onclick="gohomefitFreedomboardList()"value="글목록">	
	</div>	
</form>
<br><br>

<script type="text/javascript">
function gohomefitFreedomboardList() {
	location.href="bbs?param=homefitFreedomboardList";
}




</script>


      
      <!-- ======================================내용 END =================================== -->
      
     
 <%@include file="bottom.jsp" %>    