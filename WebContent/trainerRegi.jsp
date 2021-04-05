<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="./css/main.css">
<title>홈피트 Home-Fitness 회원가입</title>
</head>
<body>


<div class="container">
	<div class="row justify-content-center">
			<div class="col-md-8 col-md-offset-1">
			    <div class="card">
			        <div class="card-header">트레이너 회원가입</div>
			        <div class="card-body">
			
			            <form class="form-horizontal" id="fileForm" method="post" action="#" enctype="multipart/form-data">
			
			               <div class="form-group">
			                    <label for="id" class="cols-sm-2 control-label">ID</label>
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
			                    <label for="password" class="cols-sm-2 control-label">비밀번호</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
			                            <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." />
			                        </div>
			                    </div>
			                </div>
			                <div class="form-group">
			                    <label for="confirm" class="cols-sm-2 control-label">비밀번호 재확인</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
			                            <input type="password" class="form-control" name="pwd2" id="pwd2" placeholder="비밀번호를 다시 한번 입력하세요." />
			                            <p id="pwdCheck" style="font-size: 12px"></p>
			                        </div>
			                    </div>
			                </div>
			                <div class="form-group">
			                    <label for="username" class="cols-sm-2 control-label">이름</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
			                            <input type="text" class="form-control" name="name" id="name" placeholder="이름을 입력하세요." />
			                        </div>
			                    </div>
			                </div>
			                <div class="form-group">
			                    <label for="phoneNum" class="cols-sm-4 control-label">전화번호</label>
			                    <div class="row">
				                    <div class="col-sm-2">
										<input type="text" class="form-control" name="phoneNum1" id="phoneNum1" value="010" />
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
			                            <span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
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
								<label for="gender" class="cols-sm-2 control-label">성별</label>
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
								<label class="cols-sm-2 control-label">프로필 사진</label>	
								<div class="row">
									<div class="col-sm-7">
										<img id="imgInput" style="width: auto; height: 150px; align-content: center;"/>
										&nbsp;<input type='file' id="profileImg" name="profileImg"/>
									</div>
								</div>
							</div>
							<!-- 피트니스 센터 이름 -->
							<div class="form-group">
			                    <label for="gymName" class="cols-sm-2 control-label">센터명</label>
			                    <div class="cols-sm-10">
			                        <div class="input-group">
			                            <span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
			                            <input type="text" class="form-control" name="gymName" id="gymName" placeholder="운영 중인 피트니스 센터 이름을 적어주세요." />
			                        </div>
			                    </div>
			                </div>
							
							<!-- 소개글 -->
							<div class="form-group">
								<label class="cols-sm-2 control-label">소개글</label>
								<div class="cols-sm-8">
									<div class="row">
										<div class="col-sm-10">
											<textarea id="trainerContent" name="trainerContent" rows="10%" cols="50%" style="resize: none;" placeholder="트레이너 이력/자기소개를 적어주세요."></textarea>
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
				                            <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
				                            <input type="number" class="form-control" name="age" id="age" placeholder="나이를 입력하세요." />
				                        </div>
				                    </div>
				                </div>
				                <div class="form-group">
				                    <label for="height" class="cols-sm-2 control-label">키</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
				                            <input type="number" class="form-control" name="height" id="height" placeholder="(cm)" />
				                        </div>
				                    </div>
				                </div>
				                <div class="form-group">
				                    <label for="weight" class="cols-sm-2 control-label">현재 몸무게</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
				                            <input type="number" class="form-control" name="weight" id="weight" placeholder="(kg)" />
				                        </div>
				                    </div>
				                </div>
				                <div class="form-group">
				                    <label for="weight" class="cols-sm-2 control-label">목표 몸무게</label>
				                    <div class="cols-sm-10">
				                        <div class="input-group">
				                            <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
				                            <input type="number" class="form-control" name="gWeight" id="gWeight" placeholder="(kg)" />
				                        </div>
				                    </div>
				                </div>
				            </div> 
							
							
				            <div class="form-group">
				            	<button type="button" id="regiBtn" class="btn btn-primary btn-lg btn-block login-button">회원 가입</button>
				            </div>
			                <div class="login-register">
			                    <a href="#">Login</a>
			                </div>
			            </form>
			        </div>
			
			    </div>
			</div>
	</div>
</div>


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
		$.ajax({
			type: "post",
			url: "member?param=idCheck",
			data: { "id":$("#id").val() },
			success:function( data ){
			//	alert('chkIdBtn success');
				if(data.msg == "YES"){
					$("#idCheck").css("color", "#0000ff");
					$("#idCheck").html('사용 가능한 ID입니다.');
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
$(function () {
	$("#emailBtn").click(function () {
		
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
				alert('1 error');
			}			
		});
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
     alert("시간초과");
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
	$('#pwd2').blur(function(){
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
	$('#email').blur(function () {
	
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
$(document).on("blur",'input',function() {
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


</body>
</html>