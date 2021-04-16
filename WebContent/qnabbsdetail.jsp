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
              <h1 class="h2">Q&A</h1>
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
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
%>

<div class="row">
 <div class="col-xl-2">

 </div>
<div class="col-xl-8">
<br>
	<div align="center" style="padding-bottom: 100px">
	
		<table class="table" style="width: 1000px; margin-top: 50px">
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
				<td colspan="2">작성일&nbsp;&nbsp;&nbsp; <%=bbs.getWdate().substring(0, 16) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 조회수&nbsp;&nbsp; <%=bbs.getReadcount() %></td>			
			</tr>		
		</table>
		
		<!-- 추천 버튼  -->
		<div>	
			<form id="like_form">
			<table id="list">
			<tr>
				<th>
					<button type="button" id='bbtn' class="btn btn-outline-primary" onclick="return like()"><i class="fa fa-thumbs-o-up fa-lg" aria-hidden="true"> </i><div id="like_result">${bbs.likecount}</div></button>
				</th>
			</tr>
			<tr>
				<th>
					<input type="hidden" name="command" value="like_it">
					<input type="hidden" name="bbs_seq" value="${bbs.seq}">
				</th>
			</tr>
			</table>
			</form>
		</div>
		
		
		
		
		
		
				
	<br>
	<button type="button" class= "btn btn-outline-primary" onclick="answerbbs(<%=bbs.getSeq() %>)">답변</button>
	
	<button type="button" class= "btn btn-outline-primary" onclick="location.href='qnabbs?param=qnabbslist'">글목록</button>
	<%
	if(bbs.getMemberId().equals(mem.getMemberID())){
		%>	
		<button type="button" class= "btn btn-outline-primary" onclick="updateBbs(<%=bbs.getSeq() %>)">수정</button>
		<button type="button" class= "btn btn-outline-primary" onclick="deleteBbs(<%=bbs.getSeq() %>)">삭제</button>
		<%
	}
	%>
	</div>
</div>
	<div class="col-xl-2"></div>
</div>




<script type="text/javascript">
function updateBbs(seq) {
	location.href = "qnabbs?param=qnabbsupdate&seq=" + seq;
	
}

function deleteBbs(seq) {
	location.href = "qnabbs?param=qnabbsdelete&seq=" + seq;
}

function answerbbs(seq) {
	location.href = "qnabbs?param=qnaanswer&seq=" + seq;	
}

function like(){
	
	
	document.getElementById("bbtn").innerHTML = "<i class='fa fa-thumbs-up fa-lg' aria-hidden='true'></i><div id='like_result'>${bbs.likecount}</div>";
    	
	$.ajax({
		url: "qnabbs?param=like",
		type: "POST",
		cache: false,
		dataType: "json",
		data: $('#like_form').serialize(), //아이디가 like_form인 곳의 모든 정보를 가져와 파라미터 전송 형태(표준 쿼리형태)로 만들어줌
		success:function(data){ //ajax통신 성공시 넘어오는 데이터 통째 이름 =data
		
		$("#like_result").html(data.like); //id값이 like_result인 html을 찾아서 data.like값으로 바꿔준다.
		},
		error:
		function (request, status, error){
		alert("ajax실패")
				}
			});
		
	}


</script>




      <!-- ======================================내용 END =================================== -->
      
     
<%@include file="bottom.jsp" %>    