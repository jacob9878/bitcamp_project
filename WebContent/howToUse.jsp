<%@page import="dto.ExDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="dto.DweightDto"%>
<%@page import="java.util.List"%>
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
	 <!-- 이용방법 css Start -->     
    <link rel="stylesheet" href="css/howToUseStyle.css">
    <link rel="stylesheet" href="css/owl-carousel.css">

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
   <!-- 이용방법 css End -->   
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
             			<p><img alt="" src="images/level/${mem.memLevel }.gif" style="width: 18px; height: 18px;"> <a href="member?param=infoMem&memId=${mem.memberID }"><b>${mem.memberID }</b></a> 님 반갑습니다.&emsp;다음 레벨까지 <b><%=20-mem.getCount() %></b> pt 남았습니다.</p>
             		<%
             	}
             	else if(ologin != null && mem.getMemType()==1 || mem.getMemType()==5){
             		%>
         			<p><img alt="" src="images/level/${mem.memLevel }.gif" style="width: 18px; height: 18px;"> <a href="member?param=infoMem&memId=${mem.memberID }"><b>${mem.memberID }</b></a> 님 반갑습니다. 트레이너로 입장하셨습니다. </p>
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
                <ul class="list-inline contact-info d-block d-md-none">
                  <li class="list-inline-item"><a href="#"><i class="fa fa-phone"></i></a></li>
                  <li class="list-inline-item"><a href="#"><i class="fa fa-envelope"></i></a></li>
                </ul>
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
              
              
              <p class="text-center text-muted">아직 회원가입을 안하셨나요? <a href="regi.jsp"><strong>가입하기</strong></a></p>
              <p class="text-center text-muted"> 나만의 운동 루틴으로 집에서도 편안하게 운동해보세요!</p>
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
                    <li class="dropdown-item"><a href="howToUse.jsp" class="nav-link">이용 방법</a></li>
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
      
      
      <!-- ======================================내용 START =================================== -->

   <div class="fixed-side-navbar">
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link" href="#home"><span style="font-size: 20px;" >Intro</span></a></li>
            <li class="nav-item"><a class="nav-link" href="#services"><span style="font-size: 20px;" >Online Fitness</span></a></li>
            <li class="nav-item"><a class="nav-link" href="#our-story"><span style="font-size: 20px;" >신청방법</span></a></li>
            <li class="nav-item"><a class="nav-link" href="#portfolio"><span style="font-size: 20px;">운동 시작하기</span></a></li>
        </ul>
    </div>

    <div class="parallax-content baner-content" id="home">
        <div class="container">
            <div class="first-content">
                <h1>MAKE IT A LIFESTYLE,</h1>
                <h1>NOT A DUTY</h1>
                <br><br><br><br>
                <span style="font-weight: 700"><em>ONLINE PT</em> 이용 방법</span>
               
                <div class="primary-button">
                    <a href="#services"><span style="font-weight: 700">알아보기</span></a>
                </div>
            </div>
        </div>
    </div>


    <div class="service-content" id="services">
        <div class="container">
            <div class="row">
                <div class="col-md-5">
                    <div class="left-text">
                        <h4>집에서 받는 ONLINE FITNESS</h4>
                        <div class="line-dec"></div>
                        <p style="margin-bottom: 0px;">헬스장에 가고 싶지만 갈 수 없는 많은 이유들..</p>
                        <p>이제는 헬스장 대신, 집에서 PT 받으세요!</p>
                        <div class="primary-button">
                            <a href="#our-story" style="font-size: 15px">신청방법</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                
                    <div class="row">
                        <div class="col-md-6">
                            <div class="service-item">
                                <h4 style="font-size: 25px;">맞춤형 트레이너</h4>
                                <div class="line-dec"></div>
                                <p style="font-size: 16px;">전문 트레이너가 내 몸에 꼭 필요한 운동을 체계적으로 정해드립니다.</p>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="service-item">
                                <h4 style="font-size: 25px;">커뮤니티 활용하기</h4>
                                <div class="line-dec"></div>
                                <p style="font-size: 16px;">트레이너님께 궁금한 점을 자유롭게 물어보시고 운동에 대한 소감과 생각을 편안하게 나눠보세요.</p>
                            </div>
                        </div>       
                       </div>
                       
                   </div>   
                <!--    
                   <div class="col-md-2"></div>     -->         
               </div>
           </div>
       </div> 
    </div>

	
	 <div class="tabs-content" id="our-story">
        <div class="container">
     	   <br><br><br>
            <div class="row">
                <div class="col-md-8 mx-auto">
                    <div class="wrapper">
                    <section id="first-tab-group" class="tabgroup">
	                     <div id="tab1">
	                        <img src="img/1st-tab.png" alt="">
	                        <p style="font-size: 20px" >나에게 맞는 트레이너를 찾아보세요</p>
	                     </div>
	                     <div id="tab2">
	                        <img src="img/2nd-tab.png" alt="">
							<p style="font-size: 20px">PT 신청 전, 1:1채팅을 통해 트레이너님께 궁금한 점을 자유롭게 물어보세요.</p>
	                     </div>
	                     <div id="tab3">
	                        <img src="img/3rd-tab.png" alt="">
	                        <p style="font-size: 20px">선택하신 트레이너의 신청하기 버튼을 눌러서 나만의 PT 선생님을 만들어 보세요.</p>
	                     </div>
                    </section>
                    <ul class="tabs clearfix" data-tabgroup="first-tab-group">
                      <li><a href="#tab1" class="active">STEP 1</a></li>
                      <li><a href="#tab2">STEP 2</a></li>
                      <li><a href="#tab3">STEP 3</a></li>
                   </ul>
           <br><br><br><br><br>
                    </div>
                </div>
            </div>
        </div>
    </div>
	
	
    
    <div class="parallax-content projects-content" id="portfolio">
        <div class="container">
        
            <div class="row">
                <div class="col-md-12">
                    <div class="left-text" align="center">
                        <h4 style="font-size: 30px;font-weight: 500;color: #fff">다양한 HOME FIT 운동영상과 함께 ONLINE PT를 경험하세요!</h4>
                        <div class="line-dec" style="width: 500px; height: 3px; background-color: #ff7d27; margin: 20px 0px 20px 0px"></div>
                  <br><br>
                    </div>
                </div>
           </div>         
                            

        
            <div class="row">
                <div class="col-md-12">
                
                    <div id="owl-testimonials" class="owl-carousel owl-theme">
                       
                        <div class="item">
                            <div class="testimonials-item">
                                <a href="img/1st-big-item.jpg" data-lightbox="image-1"><img src="img/1st-item.jpg" alt=""></a>
                                <div class="text-content">
                                    <h4>5분 전신 유산소운동</h4>
                                    <span>유산소 | ★☆☆ | 전신</span>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimonials-item">
                                <a href="img/2nd-big-item.jpg" data-lightbox="image-1"><img src="img/2nd-item.jpg" alt=""></a>
                                <div class="text-content">
                                    <h4>랫 풀 다운</h4>
                                    <span>웨이트 | ★★☆ | 등</span>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimonials-item">
                                <a href="img/3rd-big-item.jpg" data-lightbox="image-1"><img src="img/3rd-item.jpg" alt=""></a>
                                <div class="text-content">
                                    <h4>12분  6PACK 복근운동</h4>
                                    <span>웨이트 | ★★★ | 복근</span>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimonials-item">
                                <a href="img/4th-big-item.jpg" data-lightbox="image-1"><img src="img/4th-item.jpg" alt=""></a>
                                <div class="text-content">
                                    <h4>30분 전신 필라테스</h4>
                                    <span>필라테스 | ★☆☆ | 전신</span>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimonials-item">
                                <a href="img/5th-big-item.jpg" data-lightbox="image-1"><img src="img/5th-item.jpg" alt=""></a>
                                <div class="text-content">
                                    <h4>기구가 필요없는 강력 등 운동</h4>
                                    <span>웨이트 | ★★★ | 등</span>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimonials-item">
                                <a href="img/6th-big-item.jpg" data-lightbox="image-1"><img src="img/6th-item.jpg" alt=""></a>
                                <div class="text-content">
                                    <h4>10분 상체운동</h4>
                                    <span>웨이트 | ★★☆ | 등,팔</span>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimonials-item">
                                <a href="img/2nd-big-item.jpg" data-lightbox="image-1"><img src="img/2nd-item.jpg" alt=""></a>
                                <div class="text-content">
                                    <h4>랫 풀 다운</h4>
                                    <span>웨이트 | ★★☆ | 등</span>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimonials-item">
                                <a href="img/1st-big-item.jpg" data-lightbox="image-1"><img src="img/1st-item.jpg" alt=""></a>
                                <div class="text-content">
                                    <h4>5분 전신 유산소운동</h4>
                                    <span>유산소 | ★☆☆ | 전신</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br> <br> <br> <br> <br> <br> <br> <br>
        </div>
   

    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="primary-button">
                        <a href="#home" style="font-size: 19px" >맨 위로</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

  <!-- ======================================내용 END =================================== -->
      
     
     
      
      <!--  =============운동페이지 링크 배너 =============== -->
      <div class="get-it">
        <div class="container">
          <div class="row">
            <div class="col-lg-8 text-center p-3">
              <h3>오늘 HOME FIT과 함께 트레이닝 하셨나요?</h3>
            </div>
            <div class="col-lg-4 text-center p-3">   <a href="#" class="btn btn-template-outlined-white">운동하러 가기</a></div>
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



    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
    <script src="js/vendor/bootstrap.min.js"></script> 
    <script src="js/plugins.js"></script>
    <script src="js/main.js"></script>
    <script>
        function openCity(cityName) {
            var i;
            var x = document.getElementsByClassName("city");
            for (i = 0; i < x.length; i++) {
               x[i].style.display = "none";  
            }
            document.getElementById(cityName).style.display = "block";  
        }
    </script>

    <script>
        $(document).ready(function(){
          // smooth scrolling
          $(".fixed-side-navbar a, .primary-button a").on('click', function(event) {

            // Make sure this.hash has a value before overriding default behavior
            if (this.hash !== "") {
              // Prevent default anchor click behavior
              event.preventDefault();

              // Store hash
              var hash = this.hash;

              // Using jQuery's animate() method to add smooth page scroll
              // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
              $('html, body').animate({
                scrollTop: $(hash).offset().top
              }, 800, function(){
           
                // Add hash (#) to URL when done scrolling (default click behavior)
                window.location.hash = hash;
              });
            } // End if
          });
        });
    </script>

 <!-- Javascript files-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <!-- <script src="vendor/bootstrap/js/bootstrap.min.js"></script> -->
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/waypoints/lib/jquery.waypoints.min.js"> </script>
    <script src="vendor/jquery.counterup/jquery.counterup.min.js"> </script>
    <script src="vendor/owl.carousel/owl.carousel.min.js"></script>
    <script src="vendor/owl.carousel2.thumbs/owl.carousel2.thumbs.min.js"></script>
    <script src="js/jquery.parallax-1.1.3.js"></script>
    <script src="vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
    <script src="vendor/jquery.scrollto/jquery.scrollTo.min.js"></script>
    <script src="js/front.js"></script>
</body>
</html>