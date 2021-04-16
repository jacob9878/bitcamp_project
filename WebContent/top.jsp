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
   alert('로그인이 필요한 서비스입니다.');
   location.href = "main.jsp";
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
              
              
              <p class="text-center text-muted">아직 회원가입을 안하셨나요? <a href="regi.jsp"><strong>가입하기</strong></a> </p>
              <p class="text-center text-muted">나만의 운동 루틴으로 집에서도 편안하게 운동해보세요!</p>
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
                    	 	if(mem.getMemType() == 5){
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