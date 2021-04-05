<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="top.jsp" %>


<h2>회원가입</h2>


<div id="context">
	<div align="center">
		<h3>회원유형 선택</h3><br>
		<div style="float: left;">
			<div style="width: 280px; height: 280px; background-color: #BDBDBD;">
				<p style="padding-top : 80px; font-size: 22px; font: bold;">일반회원</p>
				<button type="button" id="normalRegi" class="btn btn-primary btn-lg" style="margin: 35px">가입하기</button>
			</div>
		</div>
		
		<div>
			<div style="width: 280px; height: 280px; background-color: #BDBDBD;">
				<p style="padding-top : 80px; font-size: 22px; font: bold;">트레이너</p>
				<button type="button" id="trainerRegi" class="btn btn-warning btn-lg" style="margin: 35px">가입하기</button>
			</div>
		</div>
	</div>
</div>




<%@include file="bottom.jsp" %>

<script type="text/javascript">

$('#normalRegi').click(function() {
	location.href = "normalRegi.jsp";
});

$('#trainerRegi').click(function() {
	location.href = "trainerRegi.jsp";
});


</script>

</html>