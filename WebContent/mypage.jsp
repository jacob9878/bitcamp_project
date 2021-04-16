<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@include file="top.jsp" %>    
   
    
<%
//정보 가져오기 
Object mypage= request.getAttribute("dto");
MemberDto dto = (MemberDto)mypage;
System.out.println(dto.getMemberID());
%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
 
body{
     font-family: 'Nanum Pen Script', cursive;
}
</style>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>   

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container">
   <div class="row justify-content-center">
         <div class="col-md-8 col-md-offset-1"><h2>회원 정보 수정</h2><br>
             <div class="card">
                 <div class="card-header">
                 <b><%=dto.getMemberID() %></b>님의 정보입니다. <br>
                 </div>
                 <div class="card-body"><br>
                       <div class="row">
                                 <div class="col-md-5" ><b>아이디</b></div>
                                   <div class="col-md-7"><p><%=dto.getMemberID() %></p></div>
                          </div><br><hr><br>
                          <div class="row">
                                 <div class="col-md-5"><b>비밀번호</b></div>
                                   <div class="col-md-7"> <p><%=dto.getPwd() %></p>
                                   
                                   
                                     <p id="PWD"> <br>
                                    <button type="button" class=" btn btn-outline-secondary updateBtn">수정</button></p> 
                                   </div>
                                   
                          </div><hr><br>
                          <div class="row">
                                 <div class="col-md-5"><b>이름</b></div>
                                   <div class="col-md-7">  <p><%=dto.getName()%></p>
                                   <p id="NAME"><button type="button"  class=" btn btn-outline-secondary updateBtn">수정</button></p>
                                   </div>
                                   
                          </div><br><hr><br>
                          <div class="row">
                              <div class="col-md-5"><b>전화번호</b></div>
                               <div class="col-md-7">  
                                <div class="row">
                                    <div class="col-md-3">
                                    <%=dto.getPhoneNum().substring(1,4) %> 
                                      </div>
                                      <div class="col-md-1">-</div>
                                     <div class="col-md-3">
                                    <%=dto.getPhoneNum().substring(4,8) %> 
                                      </div>
                                      <div class="col-md-1">-</div>
                                      <div class="col-md-4">
                                    <%=dto.getPhoneNum().substring(7) %>
                                      </div>
                                      </div>
                                </div>
                          </div><br><hr><br>
                          
                          <div class="row">
                                 <div class="col-md-5"><b>이메일</b></div>
                                   <div class="col-md-7"><p><%=dto.getEmail()%></p>
                                      <p id="EMAIL"><button type="button"  class=" btn btn-outline-secondary updateBtn">수정</button></p>
                                   </div>
                          </div><br><hr><br>
                        <div class="row">
                                 <div class="col-md-5"><b>성별</b></div>
                                   <div class="col-md-7">  <p><%=dto.getGender()%></p>
                                   
                                   </div>
                          </div><br><hr><br>
                       
                     
                     <div class="row">
                      <div class="col-md-5"><b>프로필 이미지</b></div>
                        <%
                           if(dto.getProfileImg()==null||dto.getProfileImg().equals("")){
                              %>
                                 <div class="col-md-7"><p style="color: SeaGreen">*등록한 프로필 이미지 사진이 없습니다. *</p></div>
                                      
                              <%
                           }else{
                              %>
                                 <div class="col-md-7"> <p><%=dto.getProfileImg()%></p></div>
                                      
                              <%
                           }
                           
                        %></div><br><hr><br>
                        
                     <div class="row">
                      <div class="col-md-5"><b>나이</b></div>
                        <%
                        if(dto.getAge()==0){
                              %>
                                 <div class="col-md-7"><p style="color: SeaGreen">*등록한 나이가 없습니다. *</p>
                                 <p id="AGE"><button type="button" class=" btn btn-outline-secondary updateBtn">수정</button></p>
                                 </div>
                                      
                              <%
                           }else{
                              %>
                                 <div class="col-md-7">   <p><%=dto.getAge()%></p>
                                 <p id="AGE"><button type="button"  class=" btn btn-outline-secondary updateBtn">수정</button></p>
                                 </div>
                                      
                              <%
                           }
                           
                        %></div><br><hr><br>
                        
                        <div class="row">
                      <div class="col-md-5"><b>키</b></div>
                        <%
                        if(dto.getHeight()==0){
                              %>
                                 <div class="col-md-7"><p style="color: SeaGreen">*등록된 키가 없습니다. *</p>
                                 <p id="HEIGHT"><button type="button" class=" btn btn-outline-secondary updateBtn">수정</button></p>
                                 </div>
                                      
                              <%
                           }else{
                              %>
                                 <div class="col-md-7">    <p><%=dto.getHeight()%></p>
                                 <p id="HEIGHT"><button type="button"  class=" btn btn-outline-secondary updateBtn">수정</button></p>
                                 </div>
                                      
                              <%
                           }
                           
                        %></div><br><hr><br>
                        
                        <div class="row">
                      <div class="col-md-5"><b>현재 몸무게</b></div>
                        <%
                        if(dto.getWeight()==0){
                              %>
                                 <div class="col-md-7"><p style="color: SeaGreen">*등록된 현재 몸무게 없습니다. *</p>
                                 <p id="WEIGHT"><button type="button"  class=" btn btn-outline-secondary updateBtn">수정</button></p>
                                 </div>
                                      
                              <%
                           }else{
                              %>
                                 <div class="col-md-7">  <p><%=dto.getWeight()%></p>
                                 <p id="WEIGHT"><button type="button"  class=" btn btn-outline-secondary updateBtn">수정</button></p>
                                 </div>
                                      
                              <%
                           }
                           
                        %></div><br><hr><br>
                        
                        <div class="row">
                      <div class="col-md-5"><b>목표 몸무게</b></div>
                        <%
                        if(dto.getgWeight()==0){
                              %>
                                 <div class="col-md-7"><p style="color: SeaGreen">*등록된 목표 몸무게 없습니다. *</p>
                                 <p id="GWEIGHT"><button type="button"  class=" btn btn-outline-secondary updateBtn">수정</button></p>
                                 </div>
                                      
                              <%
                           }else{
                              %>
                                 <div class="col-md-7">   <p><%=dto.getgWeight()%></p>
                                 <p id="GWEIGHT"><button type="button" class=" btn btn-outline-secondary updateBtn"">수정</button></p>
                                 </div>
                                      
                              <%
                           }
                           
                        %></div><br><hr><br>
                        
                        
                         
                        <!-- 프로필 사진 -->
                     
                          
                          
                        </div>  
                        <br>
                     
                        
                 </div>
         
             </div>
         </div>
   </div>
</div>
<script type="text/javascript">
$( document ).ready(function() {
   $(".updateBtn").click(function() {
      
      let update =   $(this).parent().attr("id");
      //alert(update);
      
      $(this).parent().html('<br><input type="text" id="value" > <br><br> <button type="button" id="updateBtn2" class="btn btn-outline-secondary" value="'+update+'" onclick="updateMem()"> 수정하기</button>');
      
   })
   
});
function updateMem(){
   let update =  document.getElementById("updateBtn2").value;      //바뀔 부분
   let val =  document.getElementById("value").value;      //값
   
   //alert(val);
   //alert(update);
   location.href="member?param=updateMem&val="+val+"&memId=<%=dto.getMemberID()%>&update="+update; 
   
}   
</script>




<%@include file="bottom.jsp" %>   