<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
    
    

<%!
// 댓글의 depth와 image를 추가하는 함수	
// depth = 1   ' '->	
// depth = 2   '  '->
public String arrow(int depth){
	String rs = "<i class='fa fa-angle-right' aria-hidden='true' style='color : red'>[답변]</i>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";	// 여백
	
	String ts = "";
	for(int i = 0;i < depth; i++){
		ts += nbsp;
	}
	
	return depth==0 ? "":ts + rs;	
}

%>

<%
String choice = (String)request.getAttribute("choice");
String searchText = (String)request.getAttribute("search");
if(choice == null){
	choice = "";
}
if(searchText == null){
	searchText = "";
}
%>

<%


List<BbsDto> list = (List<BbsDto>)request.getAttribute("list");


int bbsPage = Integer.parseInt((String)request.getAttribute("bbsPage"));
System.out.println("bbsPage:" + bbsPage);

int pageNumber = Integer.parseInt((String)request.getAttribute("pageNumber"));
System.out.println("pageNumber:" + pageNumber);

int len = Integer.parseInt((String)request.getAttribute("len"));
System.out.println("len: "+len);

%>

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

<br>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-sm-12">
			<div class="container" style="padding-left: 600px">
				<form class="form-inline" onsubmit="return false">
					<div class="row">
						<select id="choice" class="custom-select" data-style="btn-primary" data-width="100px"> 
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="writer">작성자</option>
						</select>
					<input type="text" id="searchText" class= "form-control" value="<%=searchText %>" onkeyup="enterkey()">
					<button type="button" class="btn btn-outline-primary" onclick="searchBbs()">검색</button>
					</div>
				</form>
			</div>
			<br>
			<!-- 게시판 테이블  -->
			<table class="table">
			<col width="30"><col width="100"><col width="50"><col width="50"><col width="50"><col width="50"><col width="50">
				<thead class="thead-dark">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>추천수</th>
						<th>작성일</th>
					</tr>
				</thead>
				<%
				if(list == null || list.size() == 0){
					%>
					<tr style="color: black;">
					<td colspan="3">작성된 글이 없습니다</td>
					</tr>
				<%
				}else{
					for(int i = 0;i < list.size(); i++){
						BbsDto bbs = list.get(i);
						%>
						<tr>
							<th><%=i + 1 + pageNumber*10 %></th>
							<td>
								<%
								if(bbs.getDel() == 0){
									%>
									<%=arrow( bbs.getDepth() ) %>			
									<a href="qnabbs?param=qnabbsdetail&seq=<%=bbs.getSeq() %>" style="color: black;">
										<%=bbs.getTitle() %>
									</a>	
									<%
								}else{
									%>		
									<font color="#ff0000">삭제됨 ㅠ</font> 
									<%
								}
								%>
							</td>
							<td><%=bbs.getMemberId() %> <img alt="" src="images/level/<%=bbs.getMemLevel() %>.gif" style="width: 15px; height: 15px;"></td>	
							<td><%=bbs.getReadcount() %></td>
							<td><%=bbs.getLikecount() %></td>
							<td><%=bbs.getWdate().substring(0, 10) %></td>
						</tr>
						<%
					}
				}
				%>
			</table>
			<!-- 부트스트랩 페이징 -->
			<div class="container">
				<div class="row justify-content-center">
					<ul class="pagination">	
						<li class="page-item"><a class="page-link" href="#">Previous</a></li>
					<%
					for(int i = 0; i < bbsPage; i++) { //bbsPage 페이지 총 수 (ex 게시글 23개 -> 3개)
						if(pageNumber == i) { %>
							<!-- 보고있는 페이지 -->
						 	<li class="page-item"><a class="page-link" href="#" style="background-color: #C4DEFF;"><%=i+1 %></a></li> 
						<%	
						}
						else { %>
							<!-- 다른 페이지 -->
							<li class="page-item"><a class="page-link" href="#" onclick="goPage(<%=i %>)"><%=i+1 %></a></li> 
							<%
						}
					}
					%>
						<li class="page-item"><a class="page-link" href="#">Next</a></li>
					</ul>
				</div>
			</div>
			
			<div align="center">
				<button type="button" class="btn btn-outline-secondary" onclick="location.href='qnabbs?param=qnabbslist'">목록</button>
				<button type="button" class="btn btn-outline-primary" onclick="location.href='qnabbs?param=qnabbswrite'">등록</button>
			</div>
			
			<br><br>
		</div>
	</div>
</div>	
	  
	








<script type="text/javascript">
function searchBbs() {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("searchText").value;
	
	location.href = "qnabbs?param=qnabbslist&choice=" + choice + "&search=" + search;
}

function goPage( pageNum ) {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("searchText").value;
	
	location.href = "qnabbs?param=qnabbslist&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;	
}

function enterkey() { 
		
	if (window.event.keyCode == 13) { 
		let choice = document.getElementById("choice").value;
		let search = document.getElementById("searchText").value; 
		location.href = "qnabbs?param=qnabbslist&choice=" + choice + "&search=" + search;
	}
}

</script>



<script type="text/javascript">
$(document).ready(function() {
	// 검색어 있는 경우
	let search = "<%=searchText %>";
	if(search == "") return;
	
	// select
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");
});
</script>


      
      <!-- ======================================내용 END =================================== -->
      
     
 <%@include file="bottom.jsp" %>        
  