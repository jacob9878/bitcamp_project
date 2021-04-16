<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<%@include file="top.jsp" %>
      
      
      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">트레이너 신청서</h1>
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
		<form action="bbs" method="post">
			<input type="hidden" name="param" value="bbswriteAf">
			<input type="hidden" name="bbsType" value="4">
			<div class="col-md-15 col-md-offset-1">
				<table class="table table-bordered" border ="1" >
					<tr>
						<th>ID</th>
						<td style="padding-left: 10px">${mem.memberID }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
						${mem.memberID }님의 트레이너 신청서
						</td>
					</tr>
					<tr>
						<th>신청서 양식</th>
						<td>
							<div class="row">
								<div class="col-md-16 panel panel-heading" style="margin: 5px; padding: 8px; font-size: 18px;">&nbsp;&nbsp;하단의 신청 양식대로 기입해 주세요.</div>
								<br>
							</div>
						
							<div class="form-group">
								<br>
			                    <label for="title" class="cols-sm-2 control-label">소개글 제목</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <input type="text" class="form-control" name="title" id="title" />
			                            <br>
			                        </div>
			                    </div>
			                </div>
							<div class="form-group">
			                    <label for="content" class="cols-sm-2 control-label">경력 & 자기소개</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <textarea rows="20px;" cols="80px;" id="content" name="content"></textarea>
			                            <br>
			                        </div>
			                    </div>
			                </div>
							<div class="form-group">
			                    <label for="price1" class="cols-sm-2 control-label">PT 1회 가격</label>
			                    <div class="col-sm-6">
			                        <div class="input-group">
			                            <input type="text" class="form-control" name="price1" id="price1" /> 원
			                            <br>
			                        </div>
			                    </div>
			                </div>
							<div class="form-group">
			                    <label for="price10" class="cols-sm-2 control-label">PT 10회 가격</label>
			                    <div class="col-sm-6">
			                        <div class="input-group">
			                            <input type="text" class="form-control" name="price10" id="price10" /> 원
			                            <br>
			                        </div>
			                    </div>
			                </div>
							<div class="form-group">
			                    <label for="price30" class="cols-sm-2 control-label">PT 30회 가격</label>
			                    <div class="col-sm-6">
			                        <div class="input-group">
			                            <input type="text" class="form-control" name="price30" id="price30" /> 원
			                            <br>
			                        </div>
			                    </div>
			                </div>
							<div class="form-group">
			                    <label for="instaLink" class="cols-sm-2 control-label">인스타그램 ID (선택)</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <input type="text" class="form-control" name="instaLink" id="instaLink" />
			                            <br>
			                        </div>
			                    </div>
			                </div>
							<div class="form-group">
			                    <label for="faceLink" class="cols-sm-2 control-label">페이스북 주소 (선택)</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <input type="text" class="form-control" name="faceLink" id="faceLink" />
			                            <br>
			                        </div>
			                    </div>
			                </div>
							<div class="form-group">
			                    <label for="gymLocation" class="cols-sm-2 control-label">헬스장 위치</label>
			                    <div class="cols-sm-20">
			                        <div class="input-group">
			                       		<input type="text" class="form-control" id="gymLocation" name="gymLocation" placeholder="주소">
										<input type="button" class="btn btn-primary" onclick="execDaumPostcode()" value="주소 검색"><br>
									    <!-- <div id="map" style="width:250px;height:250px;margin-top:5px;display:none"></div> -->
			                            <br>
			                        </div>
			                    </div>
			                </div>
						</td>
					</tr>
				</table>
				<div class="row justify-content-center">
					<input type="submit" class="btn btn-primary" value="글쓰기">
					<input type="button" class="btn btn-secondary" value="뒤로" onclick="location.href='bbs?param=goPage&bbsType=4'">
				</div>
			</div>
		</form>
	</div>
</div>		
<br>
      
      <!-- ======================================내용 END =================================== -->
      
     
     
  <%@include file="bottom.jsp" %>    
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f78d728ed516c4d926997cfadba50b79&libraries=services"></script>    
  <script type="text/javascript">
  
  
	$(function () {		
		$('#price1').blur(function () {
			var num_check=/^[0-9]*$/;
			if(!num_check.test($('#price1').val())) {
				alert ( "숫자만 입력할 수 있습니다." );
				$('#price1').val('');
				$('#price1').focus();
			}
		})
	});
	$(function () {		
		$('#price10').blur(function () {
			var num_check=/^[0-9]*$/;
			if(!num_check.test($('#price10').val())) {
				alert ( "숫자만 입력할 수 있습니다." );
				$('#price10').val('');
				$('#price10').focus();
			}
		})
	});
	$(function () {		
		$('#price30').blur(function () {
			var num_check=/^[0-9]*$/;
			if(!num_check.test($('#price30').val())) {
				alert ( "숫자만 입력할 수 있습니다." );
				$('#price30').val('');
				$('#price30').focus();
			}
		})
	});
	

	
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


    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수
                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("gymLocation").value = addr;
            }
        }).open();
    }
	
  
  </script>
  
  
</html>