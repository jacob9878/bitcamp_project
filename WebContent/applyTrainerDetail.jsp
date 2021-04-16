<%@page import="dto.TrainerDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<%@include file="top.jsp" %>
      
<%
BbsDto bbs = (BbsDto)request.getAttribute("bbs");
request.getAttribute("writerDto");
request.getAttribute("trainer");
%>
      
      
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
				<div class="col-md-15 col-md-offset-1">
					<table class="table table-bordered" border ="1" >
						<tr>
							<th>ID</th>
							<td style="padding-left: 10px">${writerDto.memberID }</td>
						</tr>
						<tr>
							<th>이름</th>
							<td style="padding-left: 10px">${writerDto.name }</td>
						</tr>
						<% if(bbs.getDepth() == 0) { %>
							<tr>
								<th>프로필사진</th>
								<td>
									<img alt="" src="upload/${writerDto.profileImg }">
								</td>
							</tr>
						<%} else { %>
							<tr>
								<th>제목</th>
								<td>${bbs.title }</td>
							</tr>
						
						
						<% } %>
						<tr>
							<th>작성날짜</th>
							<td style="padding-left: 10px">${bbs.wdate }</td>
						</tr>
						<tr>
						<% if(bbs.getDepth() == 0) { %>
							<th>신청서 양식</th>
							<td>
								<div class="form-group">
									<br>
				                    <label for="title" class="cols-sm-2 control-label">소개글 제목</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <input type="text" class="form-control" name="title" id="title" value="${bbs.title }" readonly="readonly" />
				                            <br>
				                            <p id="idCheck" style="font-size: 12px"></p>
				                        </div>
				                    </div>
				                </div>
								<div class="form-group">
				                    <label for="content" class="cols-sm-2 control-label">경력 & 자기소개</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <textarea rows="20px;" cols="80px;" id="content" name="content" readonly="readonly">${bbs.content }</textarea>
				                            <br>
				                            <p id="idCheck" style="font-size: 12px"></p>
				                        </div>
				                    </div>
				                </div>
								<div class="form-group">
				                    <label for="price1" class="cols-sm-2 control-label">PT 1회 가격</label>
				                    <div class="col-sm-6">
				                        <div class="input-group">
				                            <input type="text" class="form-control" name="price1" id="price1" value="${trainer.price1 }" readonly="readonly"/> 원
				                            <br>
				                            <p id="idCheck" style="font-size: 12px"></p>
				                        </div>
				                    </div>
				                </div>
								<div class="form-group">
				                    <label for="price10" class="cols-sm-2 control-label">PT 10회 가격</label>
				                    <div class="col-sm-6">
				                        <div class="input-group">
				                            <input type="text" class="form-control" name="price10" id="price10" value="${trainer.price10 }" readonly="readonly" /> 원
				                            <br>
				                            <p id="idCheck" style="font-size: 12px"></p>
				                        </div>
				                    </div>
				                </div>
								<div class="form-group">
				                    <label for="price30" class="cols-sm-2 control-label">PT 30회 가격</label>
				                    <div class="col-sm-6">
				                        <div class="input-group">
				                            <input type="text" class="form-control" name="price30" id="price30" value="${trainer.price30 }" readonly="readonly"/> 원
				                            <br>
				                            <p id="idCheck" style="font-size: 12px"></p>
				                        </div>
				                    </div>
				                </div>
								<div class="form-group">
				                    <label for="instaLink" class="cols-sm-2 control-label">인스타그램 ID (선택)</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <input type="text" class="form-control" name="instaLink" id="instaLink" value="${trainer.instaLink }" readonly="readonly" />
				                            <br>
				                            <p id="idCheck" style="font-size: 12px"></p>
				                        </div>
				                    </div>
				                </div>
								<div class="form-group">
				                    <label for="faceLink" class="cols-sm-2 control-label">페이스북 주소 (선택)</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <input type="text" class="form-control" name="faceLink" id="faceLink" value="${trainer.faceLink }" readonly="readonly" />
				                            <br>
				                            <p id="idCheck" style="font-size: 12px"></p>
				                        </div>
				                    </div>
				                </div>
								<div class="form-group">
				                    <label for="gymLocation" class="cols-sm-2 control-label">헬스장 위치</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <input type="text" class="form-control" name="gymLocation" id="gymLocation" value="${trainer.gymLocation }" readonly="readonly"/>
				                            <br>
				                            <p id="idCheck" style="font-size: 12px"></p>
				                        </div>
				                    </div>
				                </div>
							</td>
							<%} else { %>
							<th>답변 내용</th>
							<td>
							<div class="form-group">
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <textarea rows="20px;" cols="80px;" id="content" name="content" readonly="readonly">${bbs.content }</textarea>
				                            <br>
				                            <p id="idCheck" style="font-size: 12px"></p>
				                        </div>
				                    </div>
				                </div>
				            </td>
							<%} %>
					</tr>
					</table>
					<div class="row justify-content-center">
						<c:if test="${mem.memType == 2 }">
						 <input type="button" class="btn btn-secondary" value="답변" onclick="location.href='bbs?param=goAnswerBbs&seq=${bbs.seq}'">&emsp;
						 <input type="button" class="btn btn-outline-primary" value="트레이너 등록" onclick="location.href='bbs?param=acceptTrainer&id=${writerDto.memberID }&seq=${bbs.seq}'">&emsp;
                   		</c:if>
                   		<c:if test="${mem.memberID == bbs.memberId ||mem.memType == 2}">
							<input type="button" class="btn btn-danger disabled" value="삭제" onclick="deleteBbs()">&emsp;
							<input type="button" class="btn btn-primary" value="수정" onclick="location.href='bbs?param=goUpdateBbs&seq=${bbs.seq}'">&emsp;
						</c:if>	
						<input type="button" class="btn btn-secondary" value="뒤로" onclick="location.href='bbs?param=goPage&bbsType=4'">
					</div>
				</div>
		</div>
	</div>		
	<br>


      
      <!-- ======================================내용 END =================================== -->
      
<%@include file="bottom.jsp" %>     

  
  <script type="text/javascript">
  
  function deleteBbs() {
		 if (confirm("정말 삭제하시겠습니까?") == true){    //확인
			 location.href="bbs?param=deleteBbs&seq=${bbs.seq}";
		 }else{   //취소
		     return false;
		 }
	}
  
  
  
  </script>
  
  
</html>