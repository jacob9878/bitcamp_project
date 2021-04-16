<%@page import="java.util.Date"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    

<%
request.getAttribute("List");
int pageNumber =((Integer)request.getAttribute("pageNumber")).intValue(); //현재 페이지 번호

System.out.println("pageNumber(현재페이지번호) : " +pageNumber);

%>

<%@include file="top.jsp" %>

      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">트레이너 소개</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="howToUse.jsp">트레이너</a></li>
                <li class="breadcrumb-item active">트레이너 소개</li>
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
              <p class="text-muted lead text-center">트레이닝을 받고 싶은 강사의 프로필을 확인하세요.</p>
              <p class="text-muted lead text-center">10회 가격</p>
              
              
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
		                      <div class="image"><a href="bbs?param=getTrainerDetail&seq=${bbs.seq }"><img src="upload/${bbs.memProfileImg }" alt="" class="img-fluid image1"></a></div>
		                      <div class="text">
		                        <h3 class="h5"><a href="bbs?param=getTrainerDetail&seq=${bbs.seq }">${bbs.title }</a></h3>
		                        <p class="price"><del><fmt:formatNumber value = " ${bbs.trainerPrice * 1.2} " type="number" />원</del><fmt:formatNumber value="${bbs.trainerPrice }" type="number" /> 원</p>
		                      </div>
		                      
		                      <div class="ribbon-holder">
		                       <c:if test="${bbs.readcount > 80 }">
		                       	<div class="ribbon hot">HOT</div>
		                       </c:if>
		                       
		                       <jsp:useBean id="today" class="java.util.Date" />
		                       <c:set var="sysHour"><fmt:formatDate value="${today}" pattern="yyyyMMddHH" /></c:set> 
		                       
		                       <fmt:parseDate var="wDate" value="${bbs.wdate}" pattern="yyyy-MM-dd HH:mm:ss.0" />
		                       <c:set var="writeHour"><fmt:formatDate value="${wDate }" pattern="yyyyMMddHH" /></c:set>
		                       
		          			   <c:if test="${sysHour - writeHour < 150 }">
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
        <!--       
              페이징
              <div class="pages">
                <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                  <ul class="pagination">
                    <li class="page-item"><a href="#" class="page-link"> <i class="fa fa-angle-double-left"></i></a></li>
                    <li class="page-item active"><a href="#" class="page-link">1</a></li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">4</a></li>
                    <li class="page-item"><a href="#" class="page-link">5</a></li>
                    <li class="page-item"><a href="#" class="page-link"><i class="fa fa-angle-double-right"></i></a></li>
                  </ul>
                </nav>
              </div>
              
               -->

              
              
            </div>
          </div>
        </div>
      </div>
      
      <!-- ======================================내용 END =================================== -->
      
     
  <%@include file="bottom.jsp" %>   