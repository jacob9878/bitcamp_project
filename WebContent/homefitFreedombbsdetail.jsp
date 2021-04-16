<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
BbsDto bbs = (BbsDto)request.getAttribute("bbs");
%>

<%@include file="top.jsp" %>   


<style type="text/css">

   		table, td {
   			margin: auto;		
   		}
   		.thead-dark {
 			 th {
    		color: $table-dark-color;
    		background-color: $table-dark-bg;
    		border-color: $table-dark-border-color;
    		margin: auto;
 	   			 }
 	   	}
 	    table img {
             max-width: 100%; 
             height: auto;

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

<br><br>
		<div align="center"> 

	<table class="table table-bordered" style="width: 1000px">
	
		<thead class="thead-dark">
			<tr align="center">
				<th>작성자</th>
				<td><%=bbs.getMemberId() %></td>
			</tr>

			<tr align="center">
				<th>제목</th>
				<td><%=bbs.getTitle() %></td>
			</tr>
			
			<% 
			 if(bbs.getNewfilename() !=null && !bbs.getNewfilename().equals("") ) { 
			%>	
			<tr align="center">
			 	<th>사진</th>
				<td>		 	
					<img alt="" src = "upload/<%=bbs.getNewfilename()%>">
				</td>
			 </tr>
			<%
			 }
			%>
			<tr align="center">
				<th>작성일</th>
				<td><%=bbs.getWdate().substring(0, 16) %></td>
			</tr>

			<tr align="center">
				<th>조회수</th>
				<td><%=bbs.getReadcount() %></td>
			</tr>

			<tr align="center">
				<th class="contentarea">내용</th>
				<td align="center">
				<p><%=bbs.getContent() %></p>
				</td>
			</tr>
		</thead>
	</table>
</div>

<div align="center">
<button type="button" class="btn btn-success" onclick="freedomanswerbbs(<%=bbs.getSeq() %>)">답글</button>

<button type="button" class="btn btn-primary" onclick="location.href='bbs?param=homefitFreedomboardList'">글목록</button>


<%
if(bbs.getMemberId().equals(mem.getMemberID())){
	%>	
	<button type="button" class="btn btn-light" onclick="updateBbs(<%=bbs.getSeq() %>)">수정</button>
	<button type="button" class="btn btn-secondary" onclick="deleteBbs(<%=bbs.getSeq() %>)">삭제</button>
	<%
}
%>
</div>
<br><br>
<script type="text/javascript">
function updateBbs(seq) {
	location.href = "bbs?param=homefitFreedombbsupdate&seq=" + seq;
}

function deleteBbs(seq) {
	location.href = "bbs?param=homefitFreedombbsdelete&seq=" + seq;
}

function freedomanswerbbs(seq) {
	location.href = "bbs?param=homefitFreedomanswer&seq=" + seq;	
}
</script>















      
      <!-- ======================================내용 END =================================== -->
      
     
     
<%@include file="bottom.jsp" %>    