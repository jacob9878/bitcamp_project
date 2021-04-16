<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<%!
// 댓글의 depth와 image를 추가하는 함수	
// depth = 1   ' '->	
// depth = 2   '  '->
public String arrow(int depth){
	String rs = "<i class='fa fa-angle-right icon-red' aria-hidden='true'>댓글</i>";
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
String search = (String)request.getAttribute("search");
if(choice == null){
	choice = "";
}
if(search == null){
	search = "";
}
%>


<%

//Conroller부터 list
List<BbsDto> list = (List<BbsDto>)request.getAttribute("list");


int bbsPage = Integer.parseInt((String)request.getAttribute("bbsPage"));
System.out.println("bbsPage:" + bbsPage);

int pageNumber = Integer.parseInt((String)request.getAttribute("pageNumber"));
System.out.println("pageNumber:" + pageNumber);

int len = Integer.parseInt((String)request.getAttribute("len"));
System.out.println("len:" + len);

%>   

<%@include file="top.jsp" %> 


<style>
  input[type=text], select { width: 10%; /*입력 칸 (input field) 의 폭을 지정하기 위해, 폭 속성 (width property) 를 사용하였습니다.*/
    border : 2px solid skyblue;
    border-radius : 5px;
   }
   
 .paging a.select {
      .paging .hide {display:block;height:0;width:0;font-size:0;line-height:0;margin:0;padding:0;overflow:hidden;}

.paging{padding:19px;text-align:center;}

.paging a{display:inline-block;width:23px;height:23px;padding-top:2px;vertical-align:middle;}

.paging a:hover{text-decoration:underline;}

.paging .btn_arr{text-decoration:none;}

.paging .btn_arr, .paging .on{margin:0 3px;padding-top:0;border:1px solid #ddd; border-radius:30px;

/* background:url(/front/img/com/btn_paging.png) no-repeat; */}

.paging .on{padding-top:1px;height:22px;color:#fff;font-weight:bold;background:#000;}

.paging .on:hover{text-decoration:none;}
    }
	
  table {
  		 float: right;
    }	
    	
*.icon-red {color: red}      	
    	
    	
</style>

<script type="text/javascript">
$(document).ready(function() {
	// 검색어 있는 경우
	let search = "<%=search %>" ;	
	//alert(search);
	$("#searchText").val(search);			// id값으로 search 정의
	if(search == "") return;
	
	// select
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	// alert(choice);
	obj.setAttribute("selected", "selected");
});
</script>  


      
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
<!-- 검색 -->
<div class="container"style="padding-left: 600px">
	<form class="form-inline" onsubmit="return false">
	<!--<input type="hidden" name="param" value="goPage">-->
		<input type="hidden" name="bbsType" value="0">
				<select name="choice" id="choice" class="custom-select" data-style="btn-primary" data-width="fit">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
				</select>
		
			   <input type="search" class="form-control" name="searchText" id="searchText"style="width:300px" onkeyup="enterkey()">
			   <input type="button" value="검색" class="btn btn-primary" id="searchBtn" onclick="searchBbs()">
	 </form>
</div>
	<!--  <button type="button" class="btn btn-danger" onclick="goFreedombbswrite()">새로글쓰기</button> -->

<br>
<div class="container">
	<div class="row justify-content-center">
	  <div class="col-sm-12">
			<table class="table table-bordered">

				<col width="5"><col width="20"><col width="350"><col width="80"><col width="40"><col width="50">
				<thead class="thead-dark" align="center">
					<tr>
						<th>번호</th><th>분류<th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th>
					</tr>
				</thead>

				<tbody id="td_th">
				<%
					if(list == null || list.size() == 0){
				%>
				<tr>
					<td colspan="5">작성된 글이 없습니다</td>
				</tr>
				<%
					}else{
	
						for(int i = 0;i < list.size(); i++){
							BbsDto bbs = list.get(i);
				%>
			 	<tr>
					<td align="center"><b><%=(i+1) + pageNumber*10 %></b></td>
					<td><%= bbs.getDivision() %></td>
					<td>
				<%
					if(bbs.getDel() == 0){
				%>
							<%=arrow( bbs.getDepth() ) %>			
						<a href="bbs?param=homefitFreedombbsdetail&seq=<%=bbs.getSeq() %>" style="color: black;">
							<%=bbs.getTitle() %>
						</a>
						<%
					}else{
						%>		
						<font color="#ff0000">삭제되었습니다</font> 
						<%
						}
						%>
					</td>
					<td align="center">
						<%= bbs.getMemberId()%>
						<img alt="" src="images/level/<%=bbs.getMemLevel() %>.gif" style="width: 15px; height: 15px;">
					</td>
					<td align="center"><%=bbs.getReadcount() %></td>
					<!--<td align="center"><%--=bbs.getWdate() --%></td>  -->
					<td align="center"><%=bbs.getWdate().substring(0, 10) %></td>
					<%-- <td><fmt:parseDate  value="${Wdate}" pattern="yyyy-MM-dd"/></td> --%>
				</tr>
			
						<%
						}
					}
				%>
				</tbody>
			</table>
		</div>	
	</div>
</div>
		
		
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
						}else { %>
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

<br>



	

<!-- 글쓰기, 목록보기 버튼 -->
<br>
<div class="container">
	<div class="row justify-content-center">
		<input type="button" class="btn btn-secondary" value="목록" onclick="location.href = 'bbs?param=homefitFreedomboardList'">&emsp;
		<input type="button" class="btn btn-primary" value="글쓰기" onclick="goFreedombbswrite()">
	</div>
</div>
<br>

<script type="text/javascript">


function enterkey() {
	   if (window.event.keyCode == 13) {
	      let choice = document.getElementById("choice").value;
	      let search = document.getElementById("searchText").value;
	   //   alert(choice);
	   //   alert(search);
	   
	   location.href = "bbs?param=homefitFreedomboardList&choice=" + choice + "&search="+search ;
	   }
}

function searchBbs() {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("searchText").value;
//	alert(choice);
//	alert(search);
	
	location.href = "bbs?param=homefitFreedomboardList&choice=" + choice + "&search="+search ;
}

function goPage( pageNum ) {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("searchText").value;
	
	location.href = "bbs?param=homefitFreedomboardList&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;	
}
function goFreedombbswrite() {
	location.href = "bbs?param=homefitFreedombbswrite";
}

</script>
	
      
      <!-- ======================================내용 END =================================== -->
      
<%@include file="bottom.jsp" %>    