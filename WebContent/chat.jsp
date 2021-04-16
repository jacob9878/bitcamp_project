
<%@page import="dto.BbsDto"%>
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
String tID = request.getParameter("tID");
%>    
	    
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="robots" content="all,follow">
	<!-- Chat CSS -->
	<link rel="stylesheet" href="css/custom.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <!-- Google fonts - Noto Sans KR -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
    <!-- Bootstrap Select -->
    <link rel="stylesheet" href="vendor/bootstrap-select/css/bootstrap-select.min.css">
    <!-- owl carousel -->
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.carousel.css">
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.theme.default.css">
    <!-- theme stylesheet -->
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
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css">
	<title>HOME FIT 트레이너 1:1 채팅</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	<script type="text/javascript">
		

		/* alert창 정해진 시간 후에 저절로 꺼지게 */
		function autoClosingAlert(selector, delay) {
			let alert = $(selector).alert();
			alert.show();
			window.setTimeout(function() { alert.hide() }, delay);
		}
		
		/* 보내기 버튼 누를때 */
		function submitFunction() {
			//보내는 사람
			let fromID = '<%=mem.getMemberID() %>';
			
			//alert("fromID : " +fromID);
			
			//받는사람
			let toID = '<%=tID %>';
			//alert("toID : " +toID);
			
			let chatContent = $('#chatContent').val();
			
			$.ajax({
				type: "POST",
				url: "./ChatSubmitServlet",
				data: {
					fromID: encodeURIComponent(fromID),
					toID: encodeURIComponent(toID),
					chatContent: encodeURIComponent(chatContent)
				},
				success: function(result){
					if(result == 1) {
						autoClosingAlert('#successMessage', 2000);
					} else if(result == 0) {
						autoClosingAlert('#dangerMessage', 2000);
					} else {
						autoClosingAlert('#warningMessage', 2000);
					}
				},
				error: function(){
					alert('submitFunction() error');
				}
			});
			
			$('#chatContent').val(''); // 내용입력공간 비워주기
		}
		
		var lastID = 0;	//마지막 대화 의 챗ID
		
		
		/* 채팅 리스트를 DB에서 가져오는 함수 */
		function chatListFunction(type) {
			let fromID = '<%=mem.getMemberID() %>';
			let toID = '<%=tID %>';
			
			$.ajax ({
				type: "POST",
				url: "./ChatListServlet",
				data: {
					fromID: encodeURIComponent(fromID),
					toID: encodeURIComponent(toID),
					listType: type
				},
				success: function(data) {
					if(data == "") return;
					//alert(data);
					var parsed = JSON.parse(data);
					var result = parsed.result;
					//alert(result.length);
					for(var i = 0; i < result.length; i++) {
						addChat(result[i][0].value, result[i][2].value, result[i][3].value);
						console.log(result[i][0].value +" "+ result[i][2].value +" "+ result[i][3].value);
					}
					lastID = Number(parsed.last);
					console.log(lastID);
				},
				error: function(){
					alert('chatListFunction() error');
				}
			});
		}
		
		function addChat(chatName, chatContent, chatTime) {
			
			$('#chatList').append(
				'<div class="row">' +
					'<div class="col-lg-12">' +
						'<div class="media">' +
							'<a class="pull-left" href="#">' +
								'<img class="media-object img-circle" style="width: 33px; height: 33px;" src="images/circleIcon.png" alt="">' +
							'</a>' +
							'<div class="media-body">' +
								'<h4 class="media-heading">' +
									chatName +
										'<span class="small pull-right">' +
										chatTime +
										'</span>' +
								'</h4>' +
								'<p>' +
									chatContent +
								'</p>' +
							'</div>' +
						'</div>' +
					'</div>' +
				'</div>' +
				'<hr>');
			$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
		}
		
		/* 채팅을 계속 보여지게 하는 함수 */
		function getInfiniteChat() {
			setInterval(function() {
				chatListFunction(lastID);	//채팅이 새로 쳐질 때마다
			}, 1000);
		}
	
	</script>
	
	
</head>
<body>
	
	
	<!-- 채팅창 -->
	<div class="container bootstrap snippet">
		<div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-default">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h4><i class="fa fa-circle text-green"></i> PT 상담 </h4>
						</div>
						<div class="clearfix"></div>
					</div>
					<div id="chat" class="panel-collapse collapse in">
						<div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 600px;">
						</div>
						<div class="portlet-footer">
							<div class="row" style="height: 90px">
								<div class="form-group col-xs-10">
									<textarea style="height: 80px; resize: none; " id="chatContent" class="form-control" placeholder="메시지를 입력하세요." maxlength="100"></textarea>
								</div>
								<div class="form-group col-xs-2">
									<button type="button" class="btn btn-primary" onclick="submitFunction();">전송</button>
									<div class="clearfix"></div>
								</div> 
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- 	
	<div class="alert alert-success" id="successMessage" style="display: none;">
		<strong>메시지 전송에 성공했습니다.</strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display: none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display: none;">
		<strong>데이터 오류가 발생했습니다.</strong>
	</div>
	 -->
	
	
		<!-- ---------중복체크 & 회원가입 버튼 alert--------- -->
	<%
		/* UserRegisterServlet.java에서 성공 or 오류 메세지 중 어떤걸 받았는지와 그에대한 정보값을 알려준다. */
		
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String)session.getAttribute("messageContent");
		}
		
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageType = (String)session.getAttribute("messageType");
		}
			
		if(messageContent != null) { //성공 or 에러 메세지를 출력하는 경우 --> 회원가입 버튼 누를 때 
	 %>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content 
				<% if(messageType.equals("오류 메세지")) out.println("panel-warning"); 
					else out.println("panel-success"); %>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%=messageType %>
						</h4>
					</div>	
					
					<div class="modal-body">
						<%=messageContent %>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>					
				</div>
			</div>
		</div>
	</div>
	
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
		
		
		<script>
			$('#messageModal').modal("show");
		</script>
		<%
			session.removeAttribute("messageContent");
			session.removeAttribute("messageType");
		}
		%>
		
		<script type="text/javascript">
		$(document).ready(function() {
			chatListFunction('ten');
			getInfiniteChat();
		})
		</script>

</body>
</html>