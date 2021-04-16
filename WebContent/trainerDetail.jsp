<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<% 
   request.getAttribute("bbs");
   request.getAttribute("trainerDto");
   request.getAttribute("writerDto");

%>    

    <!-- =======카카오 지도 API======= -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f78d728ed516c4d926997cfadba50b79&libraries=services"></script>


<%@include file="top.jsp" %>

      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">트레이너 상세 페이지</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="howToUse.jsp">트레이너</a></li>
                <li class="breadcrumb-item"><a href="bbs?param=goTrainerListPage">트레이너 소개</a></li>
               <!--  <li class="breadcrumb-item active">트레이너 소개</li> -->
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->



      <div id="content" class="team-member-detail">
        <div class="container">
          <section class="bar">
          
            <div class="row">
              <div class="col-md-12">
                <div class="heading">
                  <h3>트레이너 소개</h3>
                </div>
                <h4>제목</h4>
                <h2><strong>${bbs.title }</strong></h2>
              </div>
            </div>
            
            <br><br>
            
            <div class="row">
              <div class="col-md-7">
              	<h4>트레이너 이름</h4>
                <h2>${writerDto.name }</h2>
                <br>
                <h4>트레이너 이력 & 소개</h4>
                <textarea class="form-control" cols="60px" rows="15px" readonly="readonly" style="resize: none;" >${bbs.content }</textarea>
                <br><br>
                <div class="heading">
                  <h3>트레이너와 상담을 받아보세요!</h3>
                </div>
                <!-- 1:1 채팅 이동 버튼 -->
                <c:if test="${mem.memType == 0 || mem.memType == 2  }">
                	<input type="button" class="btn btn-template-main btn-lg" onclick="chat()" value="1:1 PT 문의하기"> &emsp;
                	<input type="button" id="applyBtn" class="btn btn-info btn-lg" onclick="apply()" value="PT 신청하기">
                </c:if>
              </div>
              
              <!-- 트레이너 프로필 사진 -->
              <div class="col-md-5"><h4>프로필 사진</h4><img alt="" src="upload/${writerDto.profileImg }" class="img-fluid"></div>
            </div>
            
          </section>
          <section class="bar pt-0">
            <div class="row">
              <div class="col-md-4">
                <div class="heading">
                  <h3>트레이너 SNS</h3>
                </div>
                <ul class="social list-inline">
                  <c:if test="${trainerDto.faceLink != null }">
                  	<li class="list-inline-item"><a href="http://${trainerDto.faceLink }" target="_blank" class="external facebook"><i class="fa fa-facebook"></i></a></li>
                  </c:if>
                  <c:if test="${trainerDto.instaLink != null }">
                    <li class="list-inline-item"><a href="http://www.instagram.com/${trainerDto.instaLink }" target="_blank" class="external instagram"><i class="fa fa-instagram"></i></a></li>
                  </c:if>
                  <li class="list-inline-item"><a href="http://${writerDto.email }" target="_blank" class="email"><i class="fa fa-envelope"></i></a></li>
                </ul>
              </div>
              <div class="col-md-4">
                <div class="heading">
                  <h3>1:1 트레이닝 가격표</h3>
                </div>
                <ul class="ul-icons list-unstyled" style="font-size: 35px">
                  <li>
                    <div class="icon-filled"><i class="fa fa-check"></i></div>1회 : ${trainerDto.price1 } 원</a>
                  </li>
                  <li>
                    <div class="icon-filled"><i class="fa fa-check"></i></div>10회 : ${trainerDto.price10 } 원 </a>
                  </li>
                  <li>
                    <div class="icon-filled"><i class="fa fa-check"></i></div>30회 : ${trainerDto.price30 } 원</a>
                  </li>
                </ul>
              </div>
              <div class="col-md-4">
                <div class="heading">
                  <h3>GYM 위치</h3>
               	  <p>${trainerDto.gymLocation }</p>
                </div>
                <input type="hidden" id="gymLocation" value="${trainerDto.gymLocation }">
                <div id="map" style="width:300px;height:230px;"></div>
              </div>
            </div>
          </section>
        </div>
      </div>



      
      <!-- ======================================내용 END =================================== -->
      
      
    <%@include file="bottom.jsp" %>      
  
	<script>
	
		
		function chat() {
			
			var toID = '${bbs.memberId}';
			
			window.open('chat.jsp?tID='+toID, "_blank", "width=550, height=770, resizable=no, scrollbars=no");
			
		}
	
	
	
	  function apply() {
			 if (confirm("PT를 신청 하시겠습니까?") == true){    //확인
			 	 location.href = "member?param=applyTraining&id=<%=mem.getMemberID()%>&trainerID=${writerDto.memberID }";
			 }else{   //취소
			     return false;
			 }
		}
	  
	
	
	
		/* =======카카오 지도  API 불러오는 JS======== */
		
			/* 카카오 지도 */
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		        mapOption = {
		            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
		            level: 5 // 지도의 확대 레벨
		        };

		    //지도를 미리 생성
		    var map = new daum.maps.Map(mapContainer, mapOption);
		    //주소-좌표 변환 객체를 생성
		    var geocoder = new daum.maps.services.Geocoder();
		    //마커를 미리 생성
		    var marker = new daum.maps.Marker({
		        position: new daum.maps.LatLng(37.537187, 127.005476),
		        map: map
		    });

		    
		    $(document).ready(function(){
				let addr = $('#gymLocation').val();
				
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(addr, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    
                });
				
		    	
		    });
		    


	</script>
  
</html>