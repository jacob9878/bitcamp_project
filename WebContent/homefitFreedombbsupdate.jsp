<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
BbsDto bbs = (BbsDto)request.getAttribute("bbs");
%>   

<%@include file="top.jsp" %>         
      
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
      <br><br>
      
      
      <!-- ======================================내용=================================== -->


<div align="container">	
	  <div class="row justify-content-center">
		<div class="col-sm-10">
			<form action="fileupdate" method="post" enctype="multipart/form-data">
			<input type="hidden" name="param" value="freedombbsupdateAf">
			<input type="hidden" name="seq" value="<%=bbs.getSeq() %>">
			
				<table class="table table-bordered" border="1">
					<col width="100"><col width="900"> 
					<thead class="thead-dark">				
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" name="memberid" readonly="readonly" size="60" value="<%=mem.getMemberID() %>"> 		
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
						<% 
			 			if(bbs.getNewfilename() !=null && !bbs.getNewfilename().equals("") ) { 
						%>	
						<tr>
							<th>파일 업로드</th>
							<td>
								<img alt="" src="upload/<%=bbs.getNewfilename() %>">
							</td>
						</tr>
						<tr>
							<th>변경할 파일 업로드</th>
							<td>
								<input type="file" name="fileload"  style="widows: 400px">
							</td>	
						</tr>
						<%
						 }
						%>
						<tr>
							<th>제목</th>
							<td>
								<input type="text" name="title" size="60" value="<%=bbs.getTitle() %>">		
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea rows="10" cols="60" name="content"><%=bbs.getContent() %></textarea>		
							</td>
						</tr>
					</thead>
				</table>
	
				<br><br>
				<input type="submit" class="btn btn-primary" value="글수정">
				<button type="button" class="btn btn-light" onclick="gohomefitFreedomboardList()">글목록</button>
			</form>
		</div>
	</div>	

	<script type="text/javascript">
	function gohomefitFreedomboardList() {
		location.href="bbs?param=homefitFreedomboardList";
	}	
	
	
	</script>
  
      
      
      <!-- ======================================내용 END =================================== -->
      
     <br><br>
     
     
<%@include file="bottom.jsp" %>    