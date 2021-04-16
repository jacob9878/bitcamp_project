<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    

<% 
Object ologin = session.getAttribute("login");
String logincheck = (String)(request.getAttribute("logincheck"));
MemberDto mem = null;

if(ologin == null){
   %>   
   <script>
   </script>   
   <%
}
else{
   mem = (MemberDto)ologin;
   request.setAttribute("mem", mem);
}



if(logincheck != null) {
	if(logincheck.equals("NO")) {
%>		
		<script>
			alert('아이디, 패드워드가 맞지 않습니다.');
		</script>
<%		
	}
}
%>
    
    
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>HOME FIT - 홈 핏</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <!-- Google fonts - Noto Sans KR-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
    <!-- Bootstrap Select-->
    <link rel="stylesheet" href="vendor/bootstrap-select/css/bootstrap-select.min.css">
    <!-- owl carousel-->
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.carousel.css">
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.theme.default.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="css/style.default.css" id="theme-stylesheet">
    <link rel="stylesheet" href="css/custom.css">
    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
    <link rel="apple-touch-icon" href="img/apple-touch-icon.png">
    <link rel="apple-touch-icon" sizes="57x57" href="img/apple-touch-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="72x72" href="img/apple-touch-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="img/apple-touch-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="img/apple-touch-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="img/apple-touch-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="img/apple-touch-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="img/apple-touch-icon-152x152.png">
    
  </head>
  <body>
  
  	
    <div id="all">
      <!-- ===============최상단 아이디, 레벨 표기. 로그인, 회원가입 링크============== -->
      <div class="top-bar">
        <div class="container">
          <div class="row d-flex align-items-center">
            <div class="col-md-6 d-md-block d-none">
             <c:if test="${mem.memberID != null }">
             <%
             	if(ologin != null && mem.getMemType()==0){
             		%>
             			<p><img alt="" src="images/level/${mem.memLevel }.gif" style="width: 18px; height: 18px;"> <b>${mem.memberID }</b> 님 반갑습니다.&emsp;다음 레벨까지 <b><%=20-mem.getCount() %></b> pt 남았습니다.</p>
             		<%
             	}
             	else if(ologin != null && mem.getMemType()==1 || mem.getMemType()==5){
             		%>
         			<p><img alt="" src="images/level/${mem.memLevel }.gif" style="width: 18px; height: 18px;"> <b>${mem.memberID }</b> 님 반갑습니다. 트레이너로 입장하셨습니다. </p>
         			<%
             	}
             	else if(ologin != null && mem.getMemType()==2){
             		%>
         			<p><img alt="" src="images/level/${mem.memLevel }.gif" style="width: 18px; height: 18px;"> <b>${mem.memberID }</b> 님 반갑습니다. 관리자로 입장하셨습니다. </p>
         			<%
             	}
             %>
             </c:if>  
            </div>
            <div class="col-md-6">
              <div class="d-flex justify-content-md-end justify-content-between">
                 <div class="login">
                      <%
                      if(mem == null || mem.getMemberID().equals("")){ 
                         %>
                         <a href="#" data-toggle="modal" data-target="#login-modal" class="login-btn"><i class="fa fa-sign-in"></i><span class="d-none d-md-inline-block">Sign In</span></a>
                              <a href="regi.jsp" class="signup-btn"><i class="fa fa-user"></i><span class="d-none d-md-inline-block">Sign Up</span></a>
                         <%
                      }
                      //로그인 후 
                      else{
                         %>
                           <a href="member?param=logout" class="signup-btn"><i class="fa fa-user"></i><span class="d-none d-md-inline-block">Logout</span></a>
                          <%
                      }%>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- ===========최상단 아이디, 레벨 표기. 로그인, 회원가입 링크 END============ -->
      
      
      
      <!-- =========Login 클릭 시 Modal =========== -->
      <div id="login-modal" tabindex="-1" role="dialog" aria-labelledby="login-modalLabel" aria-hidden="true" class="modal fade">
        <div role="document" class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 id="login-modalLabel" class="modal-title">HOME FIT LOGIN</h4>
              <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
            
            <!-- memberController - logincheck로 이동 -->
              <form action="member" method="post">
                 <input type="hidden" name="param" value="logincheck">
                <div class="form-group">
                  <input id="email_modal" type="text" placeholder="ID" name="id" class="form-control">
                </div>
                <div class="form-group">
                  <input id="password_modal" type="password" name="pwd" placeholder="password" class="form-control">
                </div>
                <p class="text-center">
                  <button class="btn btn-template-outlined"><i class="fa fa-sign-in"></i> Login</button>
                </p>
              </form>
              
              
              <p class="text-center text-muted">아직 회원가입을 안하셨나요?</p>
              <p class="text-center text-muted"><a href="regi.jsp"><strong>가입하기</strong></a> 나만의 운동 루틴으로 집에서도 편안하게 운동해보세요!</p>
            </div>
          </div>
        </div>
      </div>

      <!-- =======Login 클릭 시 Modal END =========-->
      
      
      
      
      <!-- ========상단 로고 & 네비게이션 ==========-->
      <header class="nav-holder make-sticky">
        <div id="navbar" role="navigation" class="navbar navbar-expand-lg">
          <div class="container"><a href="main.jsp" class="navbar-brand home"><img src="images/logo-black.png" alt="HOME-FIT logo" class="d-none d-md-inline-block" style="width: 180px; height: 120px"><img src="images/logo-black-small.png" alt="HOME-FIT logo" class="d-inline-block d-md-none"><span class="sr-only">HomeFit - go to homepage</span></a>
            <button type="button" data-toggle="collapse" data-target="#navigation" class="navbar-toggler btn-template-outlined"><span class="sr-only">Toggle navigation</span><i class="fa fa-align-justify"></i></button>
            <div id="navigation" class="navbar-collapse collapse">
              <ul class="nav navbar-nav ml-auto">
         
                <!-- ============= Dropdown 메뉴 ===============-->
                <li class="nav-item dropdown"><a href="#" data-toggle="dropdown" class="dropdown-toggle">운동하기 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="exercise?param=exMine&memId=${mem.memberID}" class="nav-link">나의 루틴</a></li>
                    <li class="dropdown-item"><a href="exercise?param=exSearch" class="nav-link">운동 선택</a></li>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a href="#" data-toggle="dropdown" class="dropdown-toggle">운동일지 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="calendar?param=calendar" class="nav-link">운동 캘린더</a></li>
                    <li class="dropdown-item"><a href="member?param=dweightGraph" class="nav-link">체중량 그래프</a></li>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a href="#" data-toggle="dropdown" class="dropdown-toggle">트레이너 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="howToUseTraining.jsp" class="nav-link">이용 방법</a></li>
                     <li class="dropdown-item"><a href="bbs?param=goTrainerListPage" class="nav-link">트레이너 소개</a></li>
                      <%	//트레이너나 관리자만 볼 수 있는 메뉴
                    if(mem != null && mem.getMemType() != 0){
                    	%>
                    	 <li class="dropdown-item"><a href="bbs?param=goPage&bbsType=4" class="nav-link">pt 자격 신청</a></li>
                    	 
                    	 <%//트레이너만 볼 수 있는 메뉴
                    	 	if(mem.getMemType()==5){
                    	 		%>
                    	 		<li class="dropdown-item"><a href="chat?param=goChatManager" class="nav-link">채팅 관리</a></li>
                    	 		<%
                    	 	}
                    	 %>
                    	 
                    	<%
                    }%>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a href="#" data-toggle="dropdown" class="dropdown-toggle">커뮤니티 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="bbs?param=homefitFreedomboardList&bbsType=0" class="nav-link">자유게시판</a></li>
                    <li class="dropdown-item"><a href="qnabbs?param=qnabbslist" class="nav-link">Q&A</a></li>
                    <li class="dropdown-item"><a href="bbs?param=goPage&bbsType=2" class="nav-link">바디프로필</a></li>
                  </ul>
                </li>
                <%	//트레이너나 관리자만 볼 수 있는 메뉴
                if(mem != null &&mem.getMemType()==2){
                	%>
                <li class="nav-item dropdown"><a href="#" data-toggle="dropdown" class="dropdown-toggle">관리 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="manage?param=searchNm" class="nav-link">회원관리</a></li>
                    <li class="dropdown-item"><a href="manage?param=searchTm" class="nav-link">트레이너 관리</a></li>
                  </ul>
                </li>
                <%
                }%>
              </ul>
                <!-- ============= Dropdown 메뉴 END ===============-->
            </div>
            <div id="search" class="collapse clearfix">
              <form role="search" class="navbar-form">
                <div class="input-group">
                  <input type="text" placeholder="Search" class="form-control"><span class="input-group-btn">
                    <button type="submit" class="btn btn-template-main"><i class="fa fa-search"></i></button></span>
                </div>
              </form>
            </div>
          </div>
        </div>
      </header>
      <!-- ===========상단 로고 & 네비게이션 END========== -->

      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">회원가입</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item active">트레이너 회원 가입</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->

<br>
<div class="container">
	<div class="row justify-content-center">
			<div class="col-md-8 col-md-offset-1">
			    <div class="card">
			        <div class="card-header">트레이너 회원가입</div>
			        <div class="card-body">
			
			            <form class="form-horizontal" id="fileForm" method="post" action="#" enctype="multipart/form-data">
			
			               <div class="form-group">
			                    <label for="id" class="cols-sm-2 control-label">ID (필수)</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
			                            <input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요." />
			                            <input type="button" class="btn btn-secondary" name="chkIdBtn" id="chkIdBtn" value="중복확인"/>
			                            <br>
			                            <p id="idCheck" style="font-size: 12px"></p>
			                        </div>
			                    </div>
			                </div>
			                <div class="form-group">
			                    <label for="password" class="cols-sm-2 control-label">비밀번호 (필수)</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <span class="input-group-addon"><i class="fa fa-key fa" aria-hidden="true"></i></span>
			                            <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." />
			                        </div>
			                    </div>
			                </div>
			                <div class="form-group">
			                    <label for="confirm" class="cols-sm-2 control-label">비밀번호 재확인 (필수)</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <span class="input-group-addon"><i class="fa fa-key fa" aria-hidden="true"></i></span>
			                            <input type="password" class="form-control" name="pwd2" id="pwd2" placeholder="비밀번호를 다시 한번 입력하세요." />
			                            <p id="pwdCheck" style="font-size: 12px"></p>
			                        </div>
			                    </div>
			                </div>
			                <div class="form-group">
			                    <label for="username" class="cols-sm-2 control-label">이름 (필수)</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
			                            <input type="text" class="form-control" name="name" id="name" placeholder="이름을 입력하세요." />
			                        </div>
			                    </div>
			                </div>
			                <div class="form-group">
			                    <label for="phoneNum" class="cols-sm-4 control-label">전화번호 (필수)</label>
			                    <div class="row">
				                    <div class="col-sm-2">
				                    	<div class="input-group">
				                    		<span class="input-group-addon"><i class="fa fa-phone fa" aria-hidden="true"></i></span>
											<input type="text" class="form-control" name="phoneNum1" id="phoneNum1" value="010" />
						                </div>
				                    </div>
				                    -
				                    <div class="col-sm-3">
				                    	<input type="text" class="form-control" name="phoneNum2" id="phoneNum2" />
				                    </div>
				                    -
				                    <div class="col-sm-3">
				                    	<input type="text" class="form-control" name="phoneNum3" id="phoneNum3" />
				                    </div>
			                    </div>
			                </div>
			                 <div class="form-group">
			                    <label for="email" class="cols-sm-2 control-label">이메일 (필수)</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
			                            <input type="text" class="form-control" name="email" id="email" placeholder="이메일 주소를 입력하세요. ex) example@gmail.com" />
			                            <p id="emailCheck" style="font-size: 12px"></p>
			                            <input type="button" class="btn btn-secondary" id="emailBtn" name="emailBtn" value="본인 인증" disabled="disabled">
			                        </div>
			                        <br>
			                    </div>
		                        <div class="cols-sm-6" id="authNumber">
		                        </div>
			                </div>
							<div class="form-group">
								<label for="gender" class="cols-sm-2 control-label">성별 (필수)</label>
								<div class="cols-sm-10">
									<div class="row">
										<div class="col-sm-3">
											<label class="radio-inline">
												<input type="radio" name="gender" value="F" checked="checked"> 여자
											</label>
										</div>
										<div class="col-sm-3">
											<label class="radio-inline">
												<input type="radio" name="gender" value="M"> 남자
											</label>
										</div>
									</div>
								</div>
							</div>


							<!-- 프로필 사진 -->
							<div class="form-group">
								<span class="input-group-addon"><i class="fa fa-image fa" aria-hidden="true"></i></span>
								<label class="cols-sm-2 control-label">프로필 사진 (필수)</label>	
								<div class="row">
									<div class="col-sm-7">
										<img id="imgInput" style="width: auto; height: 150px; align-content: center;"/>
										&nbsp;<input type='file' id="profileImg" name="profileImg"/>
									</div>
								</div>
							</div>
							<!-- 피트니스 센터 이름 -->
							<div class="form-group">
			                    <label for="gymName" class="cols-sm-2 control-label">센터명 (필수)</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <span class="input-group-addon"><i class="fa fa-location-arrow fa" aria-hidden="true"></i></span>
			                            <input type="text" class="form-control" name="gymName" id="gymName" placeholder="운영 중인 피트니스 센터 이름을 적어주세요." />
			                        </div>
			                    </div>
			                </div>
							
							<!-- 소개글 -->
							<div class="form-group">
								<label class="cols-sm-2 control-label">소개글 (필수)</label>
								<div class="cols-sm-8">
									<div class="row">
										<div class="col-sm-10">
											<textarea id="trainerContent" name="trainerContent" rows="10%" cols="75%" style="resize: none;" placeholder="트레이너 이력/자기소개를 적어주세요."></textarea>
										</div>
									</div>
								</div>
							</div>
							
							<div style="border: 1px solid #bdbdbd; padding: 5px;">
								<div class="form-group">
									<div class="row">
										<div class="col-md-16 panel panel-heading">&nbsp;&nbsp;다양한 서비스를 위해 아래 몇 가지 정보를 추가로 입력하세요. (선택)</div>
										<div class="col-md-4 panel panel-heading" style="display:none; color:red" id="address_error"></div>
									</div>
								</div>
								
				                <div class="form-group">
				                    <label for="age" class="cols-sm-2 control-label">나이</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <span class="input-group-addon"><i class="fa fa-edit" aria-hidden="true"></i></span>
				                            <input type="number" class="form-control" name="age" id="age" placeholder="나이를 입력하세요." />
				                        </div>
				                    </div>
				                </div>
				                <div class="form-group">
				                    <label for="height" class="cols-sm-2 control-label">키</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <span class="input-group-addon"><i class="fa fa-edit" aria-hidden="true"></i></span>
				                            <input type="number" class="form-control" name="height" id="height" placeholder="(cm)" />
				                        </div>
				                    </div>
				                </div>
				                <div class="form-group">
				                    <label for="weight" class="cols-sm-2 control-label">현재 몸무게</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <span class="input-group-addon"><i class="fa fa-edit" aria-hidden="true"></i></span>
				                            <input type="number" class="form-control" name="weight" id="weight" placeholder="(kg)" />
				                        </div>
				                    </div>
				                </div>
				                <div class="form-group">
				                    <label for="weight" class="cols-sm-2 control-label">목표 몸무게</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <span class="input-group-addon"><i class="fa fa-edit" aria-hidden="true"></i></span>
				                            <input type="number" class="form-control" name="gWeight" id="gWeight" placeholder="(kg)" />
				                        </div>
				                    </div>
				                </div>
				            </div> 
							
							
				            <div class="form-group">
				            	<button type="button" id="regiBtn" class="btn btn-primary btn-lg btn-block login-button">회원 가입</button>
				            </div>
			            </form>
			        </div>
			
			    </div>
			</div>
	</div>
</div>




       <!--  =============운동페이지 링크 배너 =============== -->
      <div class="get-it">
        <div class="container">
          <div class="row">
            <div class="col-lg-8 text-center p-3">
              <h3>오늘 HOME FIT과 함께 트레이닝 하셨나요?</h3>
            </div>
            <div class="col-lg-4 text-center p-3">   <a href="exercise?param=exSearch" class="btn btn-template-outlined-white">운동하러 가기</a></div>
          </div>
        </div>
      </div>
      <!--  =============운동페이지 링크 배너 END ============== -->
      
      <!-- ==============FOOTER================= -->
      <footer class="main-footer">
        <div class="container">
          <div class="row">
            <div class="col-lg-3">
              <h4 class="h6">About Us</h4>
              
              <p class="text-uppercase"><strong>HOME FIT</strong><br>In line with the current situation of not being able to go to the gym The house is enough and comfortable to use The best home training community site in Korea.</p>
              <hr class="d-block d-lg-none">
            </div>
            <div class="col-lg-3">
              <h4 class="h6">고객센터</h4>
              <p><strong>bit210324@gmail.com</strong></p>
              <p>문의사항은 위 이메일 주소로 연락주시면 빠른 시일 내에 회신드리겠습니다. <br>If you have any inquiries, please contact us at the above email address and we will reply as soon as possible.</p>
              <hr class="d-block d-lg-none">
            </div>
            <div class="col-lg-3">
              <h4 class="h6">Contact</h4>
              <p class="text-uppercase"><strong>Universal Ltd.</strong><br>TEL : 070-1234-5678<br>Newtown upon River <br>CONTACT FOR MORE INFOMATION<br>COMPANY: HOME FIT<br>BUSINESS LICENSE: 123-45-12345</p>
              <hr class="d-block d-lg-none">
            </div>
            <div class="col-lg-3">
            <h4 class="h6">제휴업체</h4>
            <br>
              <ul class="list-inline photo-stream">
                <li class="list-inline-item"><a href="http://www.bansuksports.com/" target="_blank"><img src="images/bansuk_logo.jpg" alt="..." class="img-fluid"></a></li>
                <li class="list-inline-item"><a href="http://melkinsports.com/" target="_blank"><img src="images/melkin_logo.png" alt="..." class="img-fluid"></a></li>
                <li class="list-inline-item"><a href="http://www.myprotein.co.kr" target="_blank"><img src="images/myprotein_logo.jpg" alt="..." class="img-fluid"></a></li>
                <li class="list-inline-item"><a href="https://www.rankingdak.com/" target="_blank"><img src="images/ranking_logo.png" alt="..." class="img-fluid"></a></li>
              </ul>
            </div>
          </div>
        </div>
        
        <div class="copyrights">
          <div class="container">
            <div class="row">
              <div class="col-lg-4 text-center-md">
                <p>&copy; 2021. Home Fit / Personal Home Training</p>
              </div>
              <div class="col-lg-8 text-right text-center-md">
                <p> Contect TEL : <a href="https://bootstrapious.com/snippets">070-1234-5678 </a> & FAX :  <a href="#">050-5678-1234</a></p>
                <!-- Please do not remove the backlink to us unless you purchase the Attribution-free License at https://bootstrapious.com/donate. Thank you. -->
              </div>
            </div>
          </div>
        </div>
      </footer>
    </div>
      <!-- ==============FOOTER END================= -->
      
 </body>     
 
    <!-- Javascript files-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/waypoints/lib/jquery.waypoints.min.js"> </script>
    <script src="vendor/jquery.counterup/jquery.counterup.min.js"> </script>
    <script src="vendor/owl.carousel/owl.carousel.min.js"></script>
    <script src="vendor/owl.carousel2.thumbs/owl.carousel2.thumbs.min.js"></script>
    <script src="js/jquery.parallax-1.1.3.js"></script>
    <script src="vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
    <script src="vendor/jquery.scrollto/jquery.scrollTo.min.js"></script>
    <script src="js/front.js"></script>
    
    
<script type="text/javascript">

/* 프로필 사진 미리보기 */
function readURL(input) {
 if (input.files && input.files[0]) {
  var reader = new FileReader();
  
  reader.onload = function (e) {
   $('#imgInput').attr('src', e.target.result);  
  }
  
  reader.readAsDataURL(input.files[0]);
  }
}
 
$("#profileImg").change(function(){
   readURL(this);
});


/* 아이디 중복확인 버튼 클릭 */
$(function () {
	$("#chkIdBtn").click(function () {
		
		var userIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);
		if(!userIdCheck.test($('#id').val())) {
			alert("ID는 영문 대소문자, 숫자, _ , - 만 입력 가능하며 5~20 글자만 가능합니다. ");
			return;
		};
		
		$.ajax({
			type: "post",
			url: "member?param=idCheck",
			data: { "id":$("#id").val() },
			success:function( data ){
			//	alert('chkIdBtn success');
				if(data.msg == "YES"){
					$("#idCheck").css("color", "#0000ff");
					$("#idCheck").html('사용 가능한 ID입니다.');
					$('#id').attr('disabled', true);
					$('#idCheck').attr('disabled', true);
				}else{
					$("#idCheck").css("color", "#ff0000");
					$("#idCheck").html('이미 존재하는 ID입니다.');
					$("#id").val("");
				}
			},
			error:function(){
				alert('error');
			}			
		});
		
	});	
});




/* 이메일 '본인 인증' 버튼 클릭 */

var authNum;		//인증번호 담아둘 전역변수
var authSuccess = false;	//인증 완료 했는지 true/false
var click = true;      // 중복클릭 방지   
$(function () {
	$("#emailBtn").click(function () {
		
		if(click) {
			
			click = !click;
			
			setTimeout(function () {
				click = true;
			}, 180000);
		
			alert("본인 확인을 위한 이메일을 전송했습니다. 이메일 인증을 진행해주세요.")
			
			// 인증번호 입력란 생성
			$("<input>", {type:'text', id:"authNum", name:"authNum", size:"30px", placeholder:"인증번호 6자리를 입력하세요."}).appendTo('#authNumber');
			$("<input>", {type:'button', "class":"btn btn-primary", id:"authNumBtn", name:"authNumBtn", disabled:"disabled", value:"인증하기"}).appendTo('#authNumber');
			$("<p></p>", {id:'time'}).appendTo('#authNumber');
			
			var display = $('#time');
	    	var leftSec = 180;	//인증 남은시간(초)
	    	
	    	// 이미 타이머가 작동중이면 중지
	    	if (isRunning){
	    		clearInterval(timer);
	    		display.html("");
	    		startTimer(leftSec, display);
	    	}else{
	    	startTimer(leftSec, display);
	    	}
			
			$.ajax({
				type: "post",
				url: "member?param=auth",
				data: { "email":$("#email").val() },
				success:function(data){
					authNum = data.authNum;
					console.log('인증번호 6자리 : ' + authNum);
				},
				error:function(){
					alert('error');
				}			
			});
		} else {
			console.log("본인 인증 중");
		};
		
	});	
});


/*  인증번호 입력값 없으면 인증하기 버튼 비활성화  */
$(document).on("keyup","#authNum", function () {
	if($('#authNum').val().length > 0) {
		$('#authNumBtn').attr('disabled', false);
	} else {
		$('#authNumBtn').attr('disabled', true);
	}
});


/* 인증번호 입력 타이머 */
let timer = null;
let isRunning = false;
function startTimer(count, display) {
    
	var minutes, seconds;
    timer = setInterval(function () {
    minutes = parseInt(count / 60, 10);
    seconds = parseInt(count % 60, 10);

    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;

    display.html("인증 남은 시간 : "+minutes + ":" + seconds);

    // 타이머 끝
    if (--count < 0) {
     clearInterval(timer);
     alert("시간 초과. 본인 인증을 다시 진행해주세요.");
     $('#authNum').remove();
     $('#authNumBtn').remove();
     $('#time').remove();
     isRunning = false;
    }
}, 1000);
     isRunning = true;
}




/* '인증하기' 버튼 클릭 시 */

$(function () {
	$(document).on("click","#authNumBtn", function() {
		console.log('인증번호 입력값 : ' +$('#authNum').val());
		console.log('인증번호 실제값 : ' + authNum);
		
		$.ajax({
			type: "post",
			url: "member?param=authCheck",
			data: {
				"inputNum":$('#authNum').val(),
				"authNum":authNum
				},
			success:function(data){
				console.log('인증되었는지 true/false' +data.authSuccess);
				if(data.authSuccess) {
					authSuccess = data.authSuccess;
					alert("본인 인증이 완료되었습니다.");
					 $('#email').attr('disabled', true);
					 $('#emailBtn').attr('disabled', true);
					 $('#authNum').attr('disabled', true);
				     $('#authNumBtn').attr('disabled', true);
				     $('#time').remove();
				     isRunning = false;
					
				}
				else {
					alert("인증 번호가 다릅니다.");
				}
			},
			error:function(){
				alert('1 error');
			}			
		})
	})
});




/* 비밀번호 2번 맞게 썼는지 확인 */
$(function () {
	$('#pwd2').change(function(){
		if($('#pwd').val() != $('#pwd2').val()){
		    if($('#pwd2').val()!=''){
			$("#pwdCheck").css("color", "#ff0000");
			$("#pwdCheck").html('비밀번호가 일치하지 않습니다.');
			$('#pwd2').val('');				
			$('#pwd2').focus();
			}
		}
		else {
			$("#pwdCheck").html('');
		}
	})  	   
});



/* 이메일 형식 체크 + 본인인증 버튼 활성화 */
$(function () {		
	let filter = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	$('#email').keyup(function () {
	
		if(!filter.test($('#email').val())) {
			$("#emailCheck").css("color", "#ff0000");
			$("#emailCheck").html('이메일 형식이 올바르지 않습니다.');
			$('#emailBtn').attr('disabled', true);
		}
		else {
			$("#emailCheck").html('');
			$('#emailBtn').attr('disabled', false);
		}
	})
});



/* 회원가입 버튼 클릭 */
$(function () {
	$("#regiBtn").click(function () {
		
		$('#email').attr('disabled', false);
		$('#id').attr('disabled', false);

		/* 선택사항 입력 안하면 0으로 처리 */ 
		if($("#age").val() == null || $("#age").val() == ""){
			$("#age").val(0);
		}
		if($("#height").val() == null || $("#height").val() == ""){
			$("#height").val(0);
		}
		if($("#weight").val() == null || $("#weight").val() == ""){
			$("#weight").val(0);
		}
		if($("#gWeight").val() == null || $("#gWeight").val() == ""){
			$("#gWeight").val(0);
		}
		
		/* 파일 업로드 되게  */
		let formData = new FormData($('#fileForm')[0]);
		//formData.append("fileObj", $('#profileImg')[0].files[0]);
	
		
		
		$.ajax({
			type: "post",
			enctype: 'multipart/form-data',
			url: "member?param=normalRegi",
			data: formData,
			processData: false,
			contentType: false,
			success:function(data){
				//alert('regiBtn success');
				if(data.msg == "YES"){
					alert('회원가입이 정상적으로 처리되었습니다.');
					location.href = "main.jsp";
				}else{
					alert('오류가 발생했습니다.');
				}

			},
			error:function(){
				alert('error.');
			}			
		});
		
	});	
});


/* 필수 입력 사항 체크 & 본인인증까지 해야 회원가입 버튼 활성화 */
$(document).on('mousemove',function() {
	/* 필수 입력 사항 체크 (트레이너는 사항 추가)*/
	if($("#id").val() == null || $("#id").val() == "" ||
		$("#pwd").val() == null || $("#pwd").val() == "" ||
			$("#name").val() == null || $("#name").val() == "" ||
				$("#phoneNum1").val() == null || $("#phoneNum1").val() == "" ||
						$("#phoneNum2").val() == null || $("#phoneNum2").val() == "" ||
							$("#phoneNum3").val() == null || $("#phoneNum3").val() == "" ||
								$("#email").val() == null || $("#email").val() == "" ||
								$("#profileImg").val() == null || $("#profileImg").val() == "" ||
								$("#gymName").val() == null || $("#gymName").val() == "" ||
								$("#trainerContent").val() == null || $("#trainerContent").val() == "" || authSuccess == false) {
		$('#regiBtn').attr('disabled', true);
	} else {
		$('#regiBtn').attr('disabled', false);
	};
	
	
});
 

</script>

  
  
</html>