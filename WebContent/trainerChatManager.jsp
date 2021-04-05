<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    

<% 
Object ologin = session.getAttribute("login");
MemberDto mem = null;
if(ologin == null){
   %>   
   <script>
   alert('로그인 해 주십시오');
   </script>   
   <%
}
else{
   mem = (MemberDto)ologin;
   request.setAttribute("mem", mem);
}
%>
    
    
<%
request.getAttribute("recentList");

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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <style class="cp-pen-styles">
    
  /*   	body {
		  display: flex;
		  align-items: center;
		  justify-content: center;
		  min-height: 100vh;
		  background: #27ae60;
		  font-family: "proxima-nova", "Source Sans Pro", sans-serif;
		  font-size: 1em;
		  letter-spacing: 0.1px;
		  color: #32465a;
		  text-rendering: optimizeLegibility;
		  text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.004);
		  -webkit-font-smoothing: antialiased;
		} */
		
		#frame {
		  width: 95%;
		  min-width: 360px;
		  max-width: 1000px;
		  height: 92vh;
		  min-height: 300px;
		  max-height: 720px;
		  background: #E6EAEA;
		}
		@media screen and (max-width: 360px) {
		  #frame {
		    width: 100%;
		    height: 100vh;
		  }
		}
		#frame #sidepanel {
		  float: left;
		  min-width: 280px;
		  max-width: 340px;
		  width: 40%;
		  height: 100%;
		  background: #2c3e50;
		  color: #f5f5f5;
		  overflow: hidden;
		  position: relative;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel {
		    width: 58px;
		    min-width: 58px;
		  }
		}
		#frame #sidepanel #profile {
		  width: 80%;
		  margin: 25px auto;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile {
		    width: 100%;
		    margin: 0 auto;
		    padding: 5px 0 0 0;
		    background: #32465a;
		  }
		}
		#frame #sidepanel #profile.expanded .wrap {
		  height: 210px;
		  line-height: initial;
		}
		#frame #sidepanel #profile.expanded .wrap p {
		  margin-top: 20px;
		}
		#frame #sidepanel #profile.expanded .wrap i.expand-button {
		  -moz-transform: scaleY(-1);
		  -o-transform: scaleY(-1);
		  -webkit-transform: scaleY(-1);
		  transform: scaleY(-1);
		  filter: FlipH;
		  -ms-filter: "FlipH";
		}
		#frame #sidepanel #profile .wrap {
		  height: 60px;
		  line-height: 60px;
		  overflow: hidden;
		  -moz-transition: 0.3s height ease;
		  -o-transition: 0.3s height ease;
		  -webkit-transition: 0.3s height ease;
		  transition: 0.3s height ease;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap {
		    height: 55px;
		  }
		}
		#frame #sidepanel #profile .wrap img {
		  width: 50px;
		  border-radius: 50%;
		  padding: 3px;
		  border: 2px solid #e74c3c;
		  height: auto;
		  float: left;
		  cursor: pointer;
		  -moz-transition: 0.3s border ease;
		  -o-transition: 0.3s border ease;
		  -webkit-transition: 0.3s border ease;
		  transition: 0.3s border ease;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap img {
		    width: 40px;
		    margin-left: 4px;
		  }
		}
		#frame #sidepanel #profile .wrap img.online {
		  border: 2px solid #2ecc71;
		}
		#frame #sidepanel #profile .wrap img.away {
		  border: 2px solid #f1c40f;
		}
		#frame #sidepanel #profile .wrap img.busy {
		  border: 2px solid #e74c3c;
		}
		#frame #sidepanel #profile .wrap img.offline {
		  border: 2px solid #95a5a6;
		}
		#frame #sidepanel #profile .wrap p {
		  float: left;
		  margin-left: 15px;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap p {
		    display: none;
		  }
		}
		#frame #sidepanel #profile .wrap i.expand-button {
		  float: right;
		  margin-top: 23px;
		  font-size: 0.8em;
		  cursor: pointer;
		  color: #435f7a;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap i.expand-button {
		    display: none;
		  }
		}
		#frame #sidepanel #profile .wrap #status-options {
		  position: absolute;
		  opacity: 0;
		  visibility: hidden;
		  width: 150px;
		  margin: 70px 0 0 0;
		  border-radius: 6px;
		  z-index: 99;
		  line-height: initial;
		  background: #435f7a;
		  -moz-transition: 0.3s all ease;
		  -o-transition: 0.3s all ease;
		  -webkit-transition: 0.3s all ease;
		  transition: 0.3s all ease;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap #status-options {
		    width: 58px;
		    margin-top: 57px;
		  }
		}
		#frame #sidepanel #profile .wrap #status-options.active {
		  opacity: 1;
		  visibility: visible;
		  margin: 75px 0 0 0;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap #status-options.active {
		    margin-top: 62px;
		  }
		}
		#frame #sidepanel #profile .wrap #status-options:before {
		  content: '';
		  position: absolute;
		  width: 0;
		  height: 0;
		  border-left: 6px solid transparent;
		  border-right: 6px solid transparent;
		  border-bottom: 8px solid #435f7a;
		  margin: -8px 0 0 24px;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap #status-options:before {
		    margin-left: 23px;
		  }
		}
		#frame #sidepanel #profile .wrap #status-options ul {
		  overflow: hidden;
		  border-radius: 6px;
		}
		#frame #sidepanel #profile .wrap #status-options ul li {
		  padding: 15px 0 30px 18px;
		  display: block;
		  cursor: pointer;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap #status-options ul li {
		    padding: 15px 0 35px 22px;
		  }
		}
		#frame #sidepanel #profile .wrap #status-options ul li:hover {
		  background: #496886;
		}
		#frame #sidepanel #profile .wrap #status-options ul li span.status-circle {
		  position: absolute;
		  width: 10px;
		  height: 10px;
		  border-radius: 50%;
		  margin: 5px 0 0 0;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap #status-options ul li span.status-circle {
		    width: 14px;
		    height: 14px;
		  }
		}
		#frame #sidepanel #profile .wrap #status-options ul li span.status-circle:before {
		  content: '';
		  position: absolute;
		  width: 14px;
		  height: 14px;
		  margin: -3px 0 0 -3px;
		  background: transparent;
		  border-radius: 50%;
		  z-index: 0;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap #status-options ul li span.status-circle:before {
		    height: 18px;
		    width: 18px;
		  }
		}
		#frame #sidepanel #profile .wrap #status-options ul li p {
		  padding-left: 12px;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #profile .wrap #status-options ul li p {
		    display: none;
		  }
		}
		#frame #sidepanel #profile .wrap #status-options ul li#status-online span.status-circle {
		  background: #2ecc71;
		}
		#frame #sidepanel #profile .wrap #status-options ul li#status-online.active span.status-circle:before {
		  border: 1px solid #2ecc71;
		}
		#frame #sidepanel #profile .wrap #status-options ul li#status-away span.status-circle {
		  background: #f1c40f;
		}
		#frame #sidepanel #profile .wrap #status-options ul li#status-away.active span.status-circle:before {
		  border: 1px solid #f1c40f;
		}
		#frame #sidepanel #profile .wrap #status-options ul li#status-busy span.status-circle {
		  background: #e74c3c;
		}
		#frame #sidepanel #profile .wrap #status-options ul li#status-busy.active span.status-circle:before {
		  border: 1px solid #e74c3c;
		}
		#frame #sidepanel #profile .wrap #status-options ul li#status-offline span.status-circle {
		  background: #95a5a6;
		}
		#frame #sidepanel #profile .wrap #status-options ul li#status-offline.active span.status-circle:before {
		  border: 1px solid #95a5a6;
		}
		#frame #sidepanel #profile .wrap #expanded {
		  padding: 100px 0 0 0;
		  display: block;
		  line-height: initial !important;
		}
		#frame #sidepanel #profile .wrap #expanded label {
		  float: left;
		  clear: both;
		  margin: 0 8px 5px 0;
		  padding: 5px 0;
		}
		#frame #sidepanel #profile .wrap #expanded input {
		  border: none;
		  margin-bottom: 6px;
		  background: #32465a;
		  border-radius: 3px;
		  color: #f5f5f5;
		  padding: 7px;
		  width: calc(100% - 43px);
		}
		#frame #sidepanel #profile .wrap #expanded input:focus {
		  outline: none;
		  background: #435f7a;
		}
		#frame #sidepanel #search {
		  border-top: 1px solid #32465a;
		  border-bottom: 1px solid #32465a;
		  font-weight: 300;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #search {
		    display: none;
		  }
		}
		#frame #sidepanel #search label {
		  position: absolute;
		  margin: 10px 0 0 20px;
		}
		#frame #sidepanel #search input {
		  font-family: "proxima-nova",  "Source Sans Pro", sans-serif;
		  padding: 10px 0 10px 46px;
		  width: calc(100% - 25px);
		  border: none;
		  background: #32465a;
		  color: #f5f5f5;
		}
		#frame #sidepanel #search input:focus {
		  outline: none;
		  background: #435f7a;
		}
		#frame #sidepanel #search input::-webkit-input-placeholder {
		  color: #f5f5f5;
		}
		#frame #sidepanel #search input::-moz-placeholder {
		  color: #f5f5f5;
		}
		#frame #sidepanel #search input:-ms-input-placeholder {
		  color: #f5f5f5;
		}
		#frame #sidepanel #search input:-moz-placeholder {
		  color: #f5f5f5;
		}
		#frame #sidepanel #contacts {
		  height: calc(100% - 177px);
		  overflow-y: scroll;
		  overflow-x: hidden;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #contacts {
		    height: calc(100% - 149px);
		    overflow-y: scroll;
		    overflow-x: hidden;
		  }
		  #frame #sidepanel #contacts::-webkit-scrollbar {
		    display: none;
		  }
		}
		#frame #sidepanel #contacts.expanded {
		  height: calc(100% - 334px);
		}
		#frame #sidepanel #contacts::-webkit-scrollbar {
		  width: 8px;
		  background: #2c3e50;
		}
		#frame #sidepanel #contacts::-webkit-scrollbar-thumb {
		  background-color: #243140;
		}
		#frame #sidepanel #contacts ul li.contact {
		  position: relative;
		  padding: 10px 0 15px 0;
		  font-size: 0.9em;
		  cursor: pointer;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #contacts ul li.contact {
		    padding: 6px 0 46px 8px;
		  }
		}
		#frame #sidepanel #contacts ul li.contact:hover {
		  background: #32465a;
		}
		#frame #sidepanel #contacts ul li.contact.active {
		  background: #32465a;
		  border-right: 5px solid #435f7a;
		}
		#frame #sidepanel #contacts ul li.contact.active span.contact-status {
		  border: 2px solid #32465a !important;
		}
		#frame #sidepanel #contacts ul li.contact .wrap {
		  width: 88%;
		  margin: 0 auto;
		  position: relative;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #contacts ul li.contact .wrap {
		    width: 100%;
		  }
		}
		#frame #sidepanel #contacts ul li.contact .wrap span {
		  position: absolute;
		  left: 0;
		  margin: -2px 0 0 -2px;
		  width: 10px;
		  height: 10px;
		  border-radius: 50%;
		  border: 2px solid #2c3e50;
		  background: #95a5a6;
		}
		#frame #sidepanel #contacts ul li.contact .wrap span.online {
		  background: #2ecc71;
		}
		#frame #sidepanel #contacts ul li.contact .wrap span.away {
		  background: #f1c40f;
		}
		#frame #sidepanel #contacts ul li.contact .wrap span.busy {
		  background: #e74c3c;
		}
		#frame #sidepanel #contacts ul li.contact .wrap img {
		  width: 40px;
		  border-radius: 50%;
		  float: left;
		  margin-right: 10px;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #contacts ul li.contact .wrap img {
		    margin-right: 0px;
		  }
		}
		#frame #sidepanel #contacts ul li.contact .wrap .meta {
		  padding: 5px 0 0 0;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #contacts ul li.contact .wrap .meta {
		    display: none;
		  }
		}
		#frame #sidepanel #contacts ul li.contact .wrap .meta .name {
		  font-weight: 600;
		}
		#frame #sidepanel #contacts ul li.contact .wrap .meta .preview {
		  margin: 5px 0 0 0;
		  padding: 0 0 1px;
		  font-weight: 400;
		  white-space: nowrap;
		  overflow: hidden;
		  text-overflow: ellipsis;
		  -moz-transition: 1s all ease;
		  -o-transition: 1s all ease;
		  -webkit-transition: 1s all ease;
		  transition: 1s all ease;
		}
		#frame #sidepanel #contacts ul li.contact .wrap .meta .preview span {
		  position: initial;
		  border-radius: initial;
		  background: none;
		  border: none;
		  padding: 0 2px 0 0;
		  margin: 0 0 0 1px;
		  opacity: .5;
		}
		#frame #sidepanel #bottom-bar {
		  position: absolute;
		  width: 100%;
		  bottom: 0;
		}
		#frame #sidepanel #bottom-bar button {
		  float: left;
		  border: none;
		  width: 50%;
		  padding: 10px 0;
		  background: #32465a;
		  color: #f5f5f5;
		  cursor: pointer;
		  font-size: 0.85em;
		  font-family: "proxima-nova",  "Source Sans Pro", sans-serif;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #bottom-bar button {
		    float: none;
		    width: 100%;
		    padding: 15px 0;
		  }
		}
		#frame #sidepanel #bottom-bar button:focus {
		  outline: none;
		}
		#frame #sidepanel #bottom-bar button:nth-child(1) {
		  border-right: 1px solid #2c3e50;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #bottom-bar button:nth-child(1) {
		    border-right: none;
		    border-bottom: 1px solid #2c3e50;
		  }
		}
		#frame #sidepanel #bottom-bar button:hover {
		  background: #435f7a;
		}
		#frame #sidepanel #bottom-bar button i {
		  margin-right: 3px;
		  font-size: 1em;
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #bottom-bar button i {
		    font-size: 1.3em;
		  }
		}
		@media screen and (max-width: 735px) {
		  #frame #sidepanel #bottom-bar button span {
		    display: none;
		  }
		}
		#frame .content {
		  float: right;
		  width: 60%;
		  height: 100%;
		  overflow: hidden;
		  position: relative;
		}
		@media screen and (max-width: 735px) {
		  #frame .content {
		    width: calc(100% - 58px);
		    min-width: 300px !important;
		  }
		}
		@media screen and (min-width: 900px) {
		  #frame .content {
		    width: calc(100% - 340px);
		  }
		}
		#frame .content .contact-profile {
		  width: 100%;
		  height: 60px;
		  line-height: 60px;
		  background: #f5f5f5;
		}
		#frame .content .contact-profile img {
		  width: 40px;
		  border-radius: 50%;
		  float: left;
		  margin: 9px 12px 0 9px;
		}
		#frame .content .contact-profile p {
		  float: left;
		}
		#frame .content .contact-profile .social-media {
		  float: right;
		}
		#frame .content .contact-profile .social-media i {
		  margin-left: 14px;
		  cursor: pointer;
		}
		#frame .content .contact-profile .social-media i:nth-last-child(1) {
		  margin-right: 20px;
		}
		#frame .content .contact-profile .social-media i:hover {
		  color: #435f7a;
		}
		#frame .content .messages {
		  height: auto;
		  min-height: calc(100% - 93px);
		  max-height: calc(100% - 93px);
		  overflow-y: scroll;
		  overflow-x: hidden;
		}
		@media screen and (max-width: 735px) {
		  #frame .content .messages {
		    max-height: calc(100% - 105px);
		  }
		}
		#frame .content .messages::-webkit-scrollbar {
		  width: 8px;
		  background: transparent;
		}
		#frame .content .messages::-webkit-scrollbar-thumb {
		  background-color: rgba(0, 0, 0, 0.3);
		}
		#frame .content .messages ul li {
		  display: inline-block;
		  clear: both;
		  float: left;
		  margin: 15px 15px 5px 15px;
		  width: calc(100% - 25px);
		  font-size: 0.9em;
		}
		#frame .content .messages ul li:nth-last-child(1) {
		  margin-bottom: 20px;
		}
		#frame .content .messages ul li.sent img {
		  margin: 6px 8px 0 0;
		}
		#frame .content .messages ul li.sent p {
		  background: #435f7a;
		  color: #f5f5f5;
		}
		#frame .content .messages ul li.replies img {
		  float: right;
		  margin: 6px 0 0 8px;
		}
		#frame .content .messages ul li.replies p {
		  background: #f5f5f5;
		  float: right;
		}
		#frame .content .messages ul li img {
		  width: 22px;
		  border-radius: 50%;
		  float: left;
		}
		#frame .content .messages ul li p {
		  display: inline-block;
		  padding: 10px 15px;
		  border-radius: 20px;
		  max-width: 205px;
		  line-height: 130%;
		}
		@media screen and (min-width: 735px) {
		  #frame .content .messages ul li p {
		    max-width: 300px;
		  }
		}
		#frame .content .message-input {
		  position: absolute;
		  bottom: 0;
		  width: 100%;
		  z-index: 99;
		}
		#frame .content .message-input .wrap {
		  position: relative;
		}
		#frame .content .message-input .wrap input {
		  font-family: "proxima-nova",  "Source Sans Pro", sans-serif;
		  float: left;
		  border: none;
		  width: calc(100% - 90px);
		  padding: 11px 32px 10px 8px;
		  font-size: 0.8em;
		  color: #32465a;
		}
		@media screen and (max-width: 735px) {
		  #frame .content .message-input .wrap input {
		    padding: 15px 32px 16px 8px;
		  }
		}
		#frame .content .message-input .wrap input:focus {
		  outline: none;
		}
		#frame .content .message-input .wrap .attachment {
		  position: absolute;
		  right: 60px;
		  z-index: 4;
		  margin-top: 10px;
		  font-size: 1.1em;
		  color: #435f7a;
		  opacity: .5;
		  cursor: pointer;
		}
		@media screen and (max-width: 735px) {
		  #frame .content .message-input .wrap .attachment {
		    margin-top: 17px;
		    right: 65px;
		  }
		}
		#frame .content .message-input .wrap .attachment:hover {
		  opacity: 1;
		}
		#frame .content .message-input .wrap button {
		  float: right;
		  border: none;
		  width: 50px;
		  padding: 12px 0;
		  cursor: pointer;
		  background: #32465a;
		  color: #f5f5f5;
		}
		@media screen and (max-width: 735px) {
		  #frame .content .message-input .wrap button {
		    padding: 16px 0;
		  }
		}
		#frame .content .message-input .wrap button:hover {
		  background: #435f7a;
		}
		#frame .content .message-input .wrap button:focus {
		  outline: none;
		}
		</style>
	  
  </head>
  <body>
  
  	
    <div id="all">
      <!-- ===============최상단 아이디, 레벨 표기. 로그인, 회원가입 링크============== -->
      <div class="top-bar">
        <div class="container">
          <div class="row d-flex align-items-center">
            <div class="col-md-6 d-md-block d-none">
             <c:if test="${mem.memberID != null }">
              <p><img alt="" src="images/level/${mem.memLevel }.gif" style="width: 18px; height: 18px;"> <b>${mem.memberID }</b> 님 반갑습니다.&emsp;다음 레벨까지 <b>${20-mem.count }</b> pt 남았습니다.</p>
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
              
              
              <p class="text-center text-muted">아직 회원가입을 안하셨나요?</p>
              <p class="text-center text-muted"><a href="#"><strong>가입하기</strong></a> 나만의 운동 루틴으로 집에서도 편안하게 운동해보세요!</p>
            </div>
          </div>
        </div>
      </div>

      <!-- =======Login 클릭 시 Modal END =========-->
      
      
      
      
      <!-- ========상단 로고 & 네비게이션 ==========-->
      <header class="nav-holder make-sticky">
        <div id="navbar" role="navigation" class="navbar navbar-expand-lg">
          <div class="container"><a href="main.jsp" class="navbar-brand home"><img src="images/logo-black.png" alt="HOME-FIT logo" class="d-none d-md-inline-block" style="width: 180px; height: 120px"><img src="images/logo-black-small.png" alt="HOME-FIT logo" class="d-inline-block d-md-none"><span class="sr-only">Universal - go to homepage</span></a>
            <button type="button" data-toggle="collapse" data-target="#navigation" class="navbar-toggler btn-template-outlined"><span class="sr-only">Toggle navigation</span><i class="fa fa-align-justify"></i></button>
            <div id="navigation" class="navbar-collapse collapse">
              <ul class="nav navbar-nav ml-auto">
         
                <!-- ============= Dropdown 메뉴 ===============-->
                <li class="nav-item dropdown"><a href="javascript: void(0)" data-toggle="dropdown" class="dropdown-toggle">운동하기 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="contact.html" class="nav-link">나의 루틴</a></li>
                    <li class="dropdown-item"><a href="contact2.html" class="nav-link">운동 선택</a></li>
                    <li class="dropdown-item"><a href="contact3.html" class="nav-link">부위 선택</a></li>
                    <li class="dropdown-item"><a href="contact4.html" class="nav-link">난이도 선택</a></li>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a href="javascript: void(0)" data-toggle="dropdown" class="dropdown-toggle">운동일지 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="contact.html" class="nav-link">운동 캘린더</a></li>
                    <li class="dropdown-item"><a href="contact2.html" class="nav-link">체중량 그래프</a></li>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a href="javascript: void(0)" data-toggle="dropdown" class="dropdown-toggle">트레이너 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="howToUseTraining.jsp" class="nav-link">이용 방법</a></li>
                    <li class="dropdown-item"><a href="bbs?param=goTrainerListPage" class="nav-link">트레이너 소개</a></li>
                    <c:if test="${mem.memType > 0 }">
                    	<li class="dropdown-item"><a href="bbs?param=goPage&bbsType=4" class="nav-link">트레이너 신청</a></li>
                    	<li class="dropdown-item"><a href="bbs?param=goChatManager" class="nav-link">채팅 관리</a></li>
                    </c:if>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a href="javascript: void(0)" data-toggle="dropdown" class="dropdown-toggle">커뮤니티 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="bbs?param=goPage&bbsType=0" class="nav-link">자유게시판</a></li>
                    <li class="dropdown-item"><a href="bbs?param=goPage&bbsType=1" class="nav-link">Q&A</a></li>
                    <li class="dropdown-item"><a href="bbs?param=goPage&bbsType=2" class="nav-link">바디프로필</a></li>
                  </ul>
                </li>
                <!-- ============= Dropdown 메뉴 END ===============-->
              </ul>
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
              <h1 class="h2">트레이너 회원 관리</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                <li class="breadcrumb-item"><a href="index.html">트레이너</a></li>
                <li class="breadcrumb-item active">트레이너 회원 관리</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      

      <!-- ======================================내용=================================== -->



<div class="container">
	<div class="row justify-content-center">
	  <p class="text-muted lead text-center" style="padding-top: 40px;">회원님에게 1:1상담을 요청한 회원입니다.</p>
      <div id="frame">
		<div id="sidepanel">
			<div id="profile">
				<div class="wrap">
					<img id="profile-img" src="upload/${mem.profileImg }" class="online" alt="" />
					<p>${mem.memberID }</p>
				</div>
			</div>
			<!-- 
			<div id="search">
				<label for=""><i class="fa fa-search" aria-hidden="true"></i></label>
				<input type="text" placeholder="아이디 검색..." />
			</div>
			 -->
			<!-- 메세지 보낸 사람 목록 -->
			<div id="contacts">
				<ul>
					<c:choose>
					<c:when test="${recentList == null || recentList.size() == 0}">
							<p>작성된 글이 없습니다</p>
					</c:when>
					<c:otherwise>
             		   <c:forEach items="${recentList }" var="recentChat" varStatus="i" >
						<li id="${recentChat.fromID }" class="contact" value="${recentChat.fromID }">
							<input id="recentListID" type="hidden" value="${recentChat.fromID }">
							<div class="wrap">
								<img src="images/circleIcon.png" alt="" />
								<div class="meta">
									<p class="name">${recentChat.fromID }</p>
									<p class="preview">${recentChat.chatContent }</p>
								</div>
							</div>
						</li>	
						</c:forEach>
					</c:otherwise>
				</c:choose>	
					
					
				<!-- 	
					<li class="contact active">
						<div class="wrap">
							<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />
							<div class="meta">
								<p class="name">Harvey Specter</p>
								<p class="preview">Wrong. You take the gun, or you pull out a bigger one. Or, you call their bluff. Or, you do any one of a hundred and forty six other things.</p>
							</div>
						</div>
					</li>
					 -->
					
					
					
					
				</ul>
			</div>
		</div>
		
		
		<!-- 채팅하는 부분 -->
		<div class="content">
			
			<!-- 상단 유저 프로필 -->
			<div class="contact-profile">
				<img src="images/circleIcon.png" alt="" />
				<p id="sendUserName"></p>
				
				<!-- 
				<div class="social-media">
					<i class="fa fa-facebook" aria-hidden="true"></i>
					<i class="fa fa-twitter" aria-hidden="true"></i>
					 <i class="fa fa-instagram" aria-hidden="true"></i>
				</div>
				 -->
				
			</div>
			
	

			<div class="messages">
				<ul>
				
					<!-- 메세지 받은 형식 -->
					<!-- 
					<li class="sent">
						<img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />
						<p>How the hell am I supposed to get a jury to believe you when I am not even sure that I do?!</p>
					</li>
					 -->
					<!-- 메세지 보낸 형식 -->
					<!-- 
					<li class="replies">
						<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />
						<p>When you're backed against the wall, break the god damn thing down.</p>
					</li>
					 -->
				</ul>
			</div>
			
			<div class="message-input">
				<div class="wrap">
				<input type="text" id="chatingContent" class="form-control" placeholder="메시지를 입력하세요." />
				<button id="chatBtn" class="button" onkeyup="enterKey();"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
				</div>
			</div>
		</div>
	</div>
  </div>
</div>
<br><br>

      
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
              <h4 class="h6">Blog</h4>
              <ul class="list-unstyled footer-blog-list">
                <li class="d-flex align-items-center">
                  <div class="image"><img src="img/detailsquare.jpg" alt="..." class="img-fluid"></div>
                  <div class="text">
                    <h5 class="mb-0"> <a href="post.html">Blog post name</a></h5>
                  </div>
                </li>
                <li class="d-flex align-items-center">
                  <div class="image"><img src="img/detailsquare.jpg" alt="..." class="img-fluid"></div>
                  <div class="text">
                    <h5 class="mb-0"> <a href="post.html">Blog post name</a></h5>
                  </div>
                </li>
                <li class="d-flex align-items-center">
                  <div class="image"><img src="img/detailsquare.jpg" alt="..." class="img-fluid"></div>
                  <div class="text">
                    <h5 class="mb-0"> <a href="post.html">Very very long blog post name</a></h5>
                  </div>
                </li>
              </ul>
              <hr class="d-block d-lg-none">
            </div>
            <div class="col-lg-3">
              <h4 class="h6">Contact</h4>
              <p class="text-uppercase"><strong>Universal Ltd.</strong><br>TEL : 070-1234-5678<br>Newtown upon River <br>CONTACT FOR MORE INFOMATION<br>COMPANY: HOME FIT<br>BUSINESS LICENSE: 123-45-12345</p>
              <hr class="d-block d-lg-none">
            </div>
            <div class="col-lg-3">
              <ul class="list-inline photo-stream">
                <li class="list-inline-item"><a href="#"><img src="img/detailsquare.jpg" alt="..." class="img-fluid"></a></li>
                <li class="list-inline-item"><a href="#"><img src="img/detailsquare2.jpg" alt="..." class="img-fluid"></a></li>
                <li class="list-inline-item"><a href="#"><img src="img/detailsquare3.jpg" alt="..." class="img-fluid"></a></li>
                <li class="list-inline-item"><a href="#"><img src="img/detailsquare3.jpg" alt="..." class="img-fluid"></a></li>
                <li class="list-inline-item"><a href="#"><img src="img/detailsquare2.jpg" alt="..." class="img-fluid"></a></li>
                <li class="list-inline-item"><a href="#"><img src="img/detailsquare.jpg" alt="..." class="img-fluid"></a></li>
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
  </body>
  
  
  <script type="text/javascript">
	 
	var lastID = 0;	//마지막 대화 의 챗ID
	  
	
	$(document).on('click', '#contacts li', function getList_ajax() {
		

		let fromID = '<%=mem.getMemberID() %>';
		let toID = $(this).attr('id');
		//$(this).attr('class', 'contact active');
		//alert(toID);
	 	
		
		$('#sendUserName').text(toID);
		
		$.ajax ({
			type: "POST",
			url: "./ChatListServlet",
			data: {
				fromID: encodeURIComponent(fromID),
				toID: encodeURIComponent(toID),
				listType: "ten"
			},
			success: function(data) {
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				//alert(result.length);
				//alert(result);
				
				
					$('.messages ul').empty();
					
					for(var i = 0; i < result.length; i++) {
						//testadd();
						let chatId = result[i][0].value;
						let chatContent = result[i][2].value;
						let chatDate = result[i][3].value;
						
											
						if(chatId == fromID) {
							$('.messages ul').append(
									'<li class="replies">' +
									'<img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />' +
									'<h5 align="right">'+chatId+'</h5>' +
									'<p>'+chatContent+'</p>' +
									'</li>');
						
						} else {
							$('.messages ul').append(
									'<li class="sent">' +
									'<img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />' +
									'<h5>'+chatId+'</h5>' +
									'<p>'+chatContent+'</p>' +
									'</li>');
						};
						 
						//console.log(chatId +" ///////"+ chatContent +"//////// "+ chatDate);
					
					};
					
				$('.messages').scrollTop($('.messages ul')[0].scrollHeight);
				
				lastID = Number(parsed.last);
				//console.log(lastID);
			},
			error: function(){
				alert('chatListFunction() error');
			}
	
		});
			
			
			
		
	});
	
	
	
	
	/* 보내기 버튼 누를때 */
	

	$(document).on('click', '#chatBtn', function() {
		
		//보내는 사람
		let fromID = '<%=mem.getMemberID() %>';
		//alert("fromID : " +fromID);
		
		
		//받는사람
		let toID = $('#sendUserName').text();
		//alert("toID : " +toID);
			
	 	
		let chatingContent = $('#chatingContent').val();
		
		$.ajax({
			type: "POST",
			url: "./ChatSubmitServlet",
			data: {
				fromID: encodeURIComponent(fromID),
				toID: encodeURIComponent(toID),
				chatContent: encodeURIComponent(chatingContent)
			},
			success: function() {
				//$("'#"+toID+"'").click;
				//alert(toID);
				$.ajax ({
					type: "POST",
					url: "./ChatListServlet",
					data: {
						fromID: encodeURIComponent(fromID),
						toID: encodeURIComponent(toID),
						listType: "ten"
					},
					success: function(data) {
						if(data == "") return;
						var parsed = JSON.parse(data);
						var result = parsed.result;
						//alert(result.length);
						//alert(result);
						
							$('.messages ul').empty();
							
							for(var i = 0; i < result.length; i++) {
								//testadd();
								let chatId = result[i][0].value;
								let chatContent = result[i][2].value;
								let chatDate = result[i][3].value;
								
													
								if(chatId == fromID) {
									$('.messages ul').append(
											'<li class="replies">' +
											'<img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />' +
											'<h5 align="right">'+chatId+'</h5>' +
											'<p>'+chatContent+'</p>' +
											'</li>');
								
								} else {
									$('.messages ul').append(
											'<li class="sent">' +
											'<img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />' +
											'<h5>'+chatId+'</h5>' +
											'<p>'+chatContent+'</p>' +
											'</li>');
								};
								 
								//console.log(chatId +" ///////"+ chatContent +"//////// "+ chatDate);
							
							};
							
						$('.messages').scrollTop($('.messages ul')[0].scrollHeight);
						
						lastID = Number(parsed.last);
						//console.log(lastID);
					},
					error: function(){
						alert('chatListFunction() error');
					}
			
				});
				
			},
			error: function(){
				alert('submitFunction() error');
			}
		});
		 
		$('#chatingContent').val(''); // 내용입력공간 비워주기 
		
		
		
	})
	
	
  
  </script>
  
  
  
</html>