<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
    
<%
request.getAttribute("List");
int pageNumber =((Integer)request.getAttribute("pageNumber")).intValue(); //현재 페이지 번호
int len = ((Integer)request.getAttribute("len")).intValue();	//게시글 수
int bbsPage =((Integer)request.getAttribute("bbsPage")).intValue();	//총 페이지수

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
              <h1 class="h2">바디프로필</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="bbs?param=homefitFreedomboardList&bbsType=0">커뮤니티</a></li>
                <li class="breadcrumb-item active">바디프로필</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      

      <!-- ======================================내용=================================== -->



	<div id="content">
        <div class="container">
          <div class="row bar">
            <div class="col-md-12">
              <p class="text-muted lead text-center">회원님의 사진을 다른 회원들과 공유하세요.</p>
              
              
              <!-- 사진 첫번째 줄 -->
              <div class="products-big">
                <div class="row products">
                
                <c:choose>
					<c:when test="${List == null || List.size() == 0}">
							<p>작성된 글이 없습니다</p>
					</c:when>
					<c:otherwise>
             		   <c:forEach items="${List }" var="bbs" varStatus="i" >
		                  <div class="col-lg-3 col-md-4">
		                    <div class="product">
		                      <div class="image"><a href="bbs?param=getTrainerDetail&seq=${bbs.seq }"><img src="upload/${bbs.img }" alt="" class="img-fluid image1"></a></div>
		                      
		                      <div class="text">
		                        <h5 class="h5"><a href="bbs?param=getTrainerDetail&seq=${bbs.seq }">${bbs.title }</a></h5>
		                        <p class="id">${bbs.memberId }</p>
								<div class="col-md-8" style="margin: 0px auto;">
									<img alt="" id="${bbs.seq }" name="likeImg" src="images/like.png" style="width: 20px; height: 20px;">
									<pre style="display: inline-flex;"> ${bbs.likecount }</pre>
								</div>
		                      </div>
		                      
		                      <div class="ribbon-holder">
		                       <c:if test="${bbs.readcount > 80 }">
		                       	<div class="ribbon hot">HOT</div>
		                       </c:if>
		                       
		                       <jsp:useBean id="today" class="java.util.Date" />
		                       <c:set var="sysHour"><fmt:formatDate value="${today}" pattern="yyyyMMddHH" /></c:set> 
		                       
		                       <fmt:parseDate var="wDate" value="${bbs.wdate}" pattern="yyyy-MM-dd HH:mm:ss.0" />
		                       <c:set var="writeHour"><fmt:formatDate value="${wDate }" pattern="yyyyMMddHH" /></c:set>
		                       
		          			   <c:if test="${sysHour - writeHour < 100 }">
		                         <div class="ribbon new">NEW</div>
		                       </c:if>
		                      </div>
		                    </div>
		                  </div><br><br><br>
						</c:forEach>
					</c:otherwise>
				</c:choose>				

                </div>
              </div>

           <!-- 하단 배너 -->
              <div class="row">
                <div class="col-md-12 banner mb-small text-center"><a href="#"><img src="/images/adBanner.jpg" alt="" class="img-fluid"></a></div>
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
              <br>
		  	  <div class="container">
				<div class="row justify-content-center">
					<input type="button" class="btn btn-primary" value="글쓰기" onclick="location.href = 'bodyProfileWrite.jsp'">
					<input type="button" class="btn btn-light" value="메인" onclick="location.href = 'main.jsp'">
				</div>
			  </div>
			  <br> <br>
              
              
            </div>
              
              

              
            </div>
          </div>
        </div>
      </div>




      
      <!-- ======================================내용 END =================================== -->
      
 <%@include file="bottom.jsp" %> 
  
  <script type="text/javascript">
	
  function goPage(pageNum) {
		let selectBBS = $('#selectBBS').val();
		let searchText = $('#searchText').val();
		location.href = "bbs?param=goPage&selectBBS=" + selectBBS + "&searchText=" +searchText+
			"&pageNumber=" + pageNum + "&bbsType=2";
	}

  $("img[name=likeImg]").one("click", function () {
	  
	  var $this = $(this);
	  $(this).attr("src", "images/likeAf.png");
	  $(this).attr("style", "width: 23px; height: 23px;");
	  
	  let seq = $(this).attr('id');
	  
	  $.ajax({
		type:"post",
		url:"bbs?param=likes",
		datatype: "json",
		data:{
			"seq":seq
		},
		success:function(data) {
			//alert("좋아요를 눌렀습니다.");
			let likeCount = JSON.stringify(data.like);
			$this.next().text(" "+likeCount);
		}
	  });
});
  
  </script>

</html>