<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%
List<BbsDto> list =(List<BbsDto>)request.getAttribute("List");
int len = ((Integer)request.getAttribute("len")).intValue();	//게시글 수
int bbsPage =((Integer)request.getAttribute("bbsPage")).intValue();	//총 페이지수
int pageNumber =((Integer)request.getAttribute("pageNumber")).intValue(); //현재 페이지 번호

System.out.println("len(게시글 수) : " +len);
System.out.println("bbsPage(총 페이지수) : " +bbsPage);
System.out.println("pageNumber(현재페이지번호) : " +pageNumber);

%>

<%@include file="top.jsp" %>   


      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">트레이너 신청</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="howToUse.jsp">트레이너</a></li>
                <li class="breadcrumb-item active">트레이너 신청</li>
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
		<div class="col-sm-10">
			<table class="table table-bordered" border="1">
				<col width="50"><col width="380"><col width="90"><col width="60"><col width="60">
				<thead class="thead-dark">
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">조회수</th>
					<th scope="col">추천</th>
				</tr>
				</thead>
				
				<c:choose>
					<c:when test="${List == null || List.size() == 0}">
						<tr>
							<td colspan="3">작성된 글이 없습니다</td>
						</tr>
						<tr>
							<td>${List[0].seq }</td>
							<td>${List[1] }</td>
							<td><c:out value="${List[0].seq }" />  </td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${List }" var="bbs" varStatus="i" >
							<tr>
								<th>${i.index + 1}</th>
								<td>
								 	<c:if test="${bbs.depth > 0 }">
										<c:forEach begin="0" end="${bbs.depth }" step="1">
											&nbsp;&nbsp;
										</c:forEach> 
										<!-- <img src='./images/arrow.png'> -->
										[Re]
									</c:if> 
								 	<c:choose>
								 		<c:when test="${bbs.depth == 0 }">
											<a class="text-dark" href="bbs?param=getDetail&seq=${bbs.seq }">
												${bbs.memberId }님의 트레이너 신청서 입니다.
											</a>
										</c:when>
										<c:otherwise>
											<a class="text-dark" href="bbs?param=getDetail&seq=${bbs.seq }">
												${bbs.title }
											</a>
										</c:otherwise>
									</c:choose>
									<jsp:useBean id="today" class="java.util.Date" />
			                        <c:set var="sysHour"><fmt:formatDate value="${today}" pattern="yyyyMMddHH" /></c:set> 
			                        
			                        <fmt:parseDate var="wDate" value="${bbs.wdate}" pattern="yyyy-MM-dd HH:mm:ss.0" />
			                        <c:set var="writeHour"><fmt:formatDate value="${wDate }" pattern="yyyyMMddHH" /></c:set>
			                        <c:if test="${sysHour - writeHour < 10 }">
										<span class="badge badge-danger">new</span>
		                      		</c:if>
								</td>
								<td>${bbs.memberId }</td>
								<td>${bbs.readcount }</td>
								<td>${bbs.likecount }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
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


 
<!-- 검색 -->
<div class="container">
	<form action="bbs" method="get">
		<input type="hidden" name="param" value="goPage">
		<input type="hidden" name="bbsType" value="4">
		<div class="row justify-content-center">
			<div class="col-sm-8">
			    <div class="input-group">
			    	<div class="col-sm-2">
						<select name="selectBBS" id="selectBBS" class="custom-select"  style="width: 80px">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="writer">작성자</option>
						</select>
					</div>
					<input type="search" class="form-control" name="searchText" id="searchText">
			        <input type="submit" value="검색" class="btn btn-primary" id="searchBtn">
			    </div>
			</div>
		</div>
	</form>
</div>


<!-- 글쓰기, 목록보기 버튼 -->
<br>
<div class="container">
	<div class="row justify-content-center">
		<input type="button" class="btn btn-primary" value="글쓰기" onclick="goWrite()">
		<input type="button" class="btn btn-light" value="메인" onclick="location.href = 'main.jsp'">
	</div>
</div>
<br>

</div>

      
      <!-- ======================================내용 END =================================== -->
      
     
     
<%@include file="bottom.jsp" %>    

  
  
	<script type="text/javascript">
  
	function goWrite() {
		
		let memType = '<%=mem.getMemType() %>';
		if(memType == 5) {
			alert('이미 트레이너 인증을 받으셨습니다.');
			return;
		}
		
		location.href = "bbs?param=goApplyTrainerWrite";
	}
	

	function goPage(pageNum) {
		let selectBBS = $('#selectBBS').val();
		let searchText = $('#searchText').val();
		location.href = "bbs?param=goPage&selectBBS=" + selectBBS + "&searchText=" +searchText+
			"&pageNumber=" + pageNum + "&bbsType=4";
	}
	</script>
  
  
  
  
  
  
</html>