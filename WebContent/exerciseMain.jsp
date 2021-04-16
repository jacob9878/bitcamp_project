<%@page import="dao.ExDao"%>
<%@page import="dto.ExDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    

<%
//페이징

ExDao dao = ExDao.getInstance();
int bbsPage = Integer.parseInt((String)request.getAttribute("bbspagecount"));   //페이지 수

String pageNum = (String)request.getAttribute("pageNumber");//현재 페이지
int pageNumber = 0;   //이게 진짜
if(pageNum != null && !pageNum.equals("")){
   pageNumber = Integer.parseInt(pageNum);
}


System.out.println("현재페이지 :" + pageNumber);
System.out.println("페이지 수:" + bbsPage);

%>

<%

String exType = request.getParameter("exType");
String exDiff2 = request.getParameter("exDiff");
String exPart = request.getParameter("exPart");

int exDiff=0;
if(exType == null){
   exType = "없음";
}
if(exDiff2 != null){
   exDiff = Integer.parseInt(exDiff2);
}
if(exPart == null){
   exPart = "없음";
}
//System.out.println(exType);
%>
 <%
      List<ExDto> list= (List)request.getAttribute("list");
       //System.out.println(list.get(1).getExSeq());
       //int len = dao.getAllBbs(exType, exDiff,exPart);
       //System.out.println("총 글의 수:" + len);
%> 

<style type="text/css">
  
   .card-img-top{-ms-flex-negative:0;flex-shrink:0;width:100%}
   .card-img,
   .card-img-top{border-top-left-radius:calc(.30rem - 1px);
   border-top-right-radius:calc(.30rem - 1px)}
     .h-100{height:100%!important}
     
 </style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Exercise Main</title>
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
 
 
 
 <%@include file="top.jsp" %>
      
      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">운동</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item active">운동</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->
 

<br><br><br>
<div class="container">
<div class="col-md-2" style="padding:1; float: left" ></div>

<div class="col-md-15" style="float: left" >
         <select class="selectpicker" id = "exType" data-style="btn btn-outline-dark">
            <option value="없음" >(선택안함)</option> 
             <option value="유산소" >유산소</option> 
            <option value="요가">요가</option> 
            <option value="필라테스">필라테스</option> 
            <option value="웨이트">웨이트</option> 
           </select>      
           
           
          <select class="selectpicker" id = "exDiff" data-style="btn btn-outline-dark">
             <option value="0" >(선택안함)</option> 
             <option value="1" >1</option> 
            <option value="2">2</option> 
            <option value="3">3</option> 
          </select>  
           
          <select class="selectpicker"  id = "exPart" data-style="btn btn-outline-dark">
                  <option value="없음" >(선택안함)</option> 
                  <option value="전신" >전신</option> 
               <option value="팔">팔</option> 
               <option value="다리">다리</option> 
               <option value="복근">복근</option> 
               <option value="엉덩이">엉덩이</option> 
               <option value="어깨">어깨</option> 
               <option value="등">등</option>
          </select>  
            
            
         <button type="button" class ="btn btn-secondary" onclick="searchEx()" >search</button>
</div>

<br><br><br><br><br><br>


<div class="row text-center">
<%
   for(int i=0; i<list.size(); i++){
      ExDto dto1 = list.get(i);
                     
%>      
      
      <div class="col-md-4" style="margin-bottom:100px">
       <div class="card h-100">
       <div class="card-header">
       <a href="exercise?param=exdetail&exSeq=<%=dto1.getExSeq() %>"><img class="card-img-top" src="exercise?param=exPic&imgname=<%=dto1.getExImg()%>" /></a> 
    
      </div>
       <div class="card-body">  
       <h4 class="card-title"><%=dto1.getExName() %></h4>
      

                 <div>
                  <ul class="social mb-0 list-inline mt-3">
                       <li class="small text-muted font-italic"><%=dto1.getExPart() %> ,  <%=dto1.getExType() %></li>
                        
                      
                        <%
                           for(int j=0; j<dto1.getExDiff(); j++){
                              
                              %>
                              <li class="list-inline-item m-0">
                              	<i class="fa fa-star text-success"></i>
                              </li>
                              <%
                           }
                        %>
                        <%
                           for(int j=0; j<3-dto1.getExDiff(); j++){
                              %>
                              <li class="list-inline-item m-0">
                              	<i class="fa fa-star-o text-success"></i>
                              </li>
                              <%
                           }
                        %>
                       
                        </ul>
                        
                    </div>
                </div>
      <div class="card-footer">
       <%System.out.println(dto1.getExSeq()); %>
       <a href="exercise?param=exdetail&exSeq=<%=dto1.getExSeq() %>" class="btn btn-outline-dark">Find Out More!</a>
      </div>
      </div>
      </div>
      
<%  
}%>
</div>

<%
//System.out.println("현재페이지 :" + pageNumber); 
//System.out.println("페이지 수:" + bbsPage);
for(int i = 0;i < bbsPage; i++){
   if(pageNumber == i){   // 현재 페이지      [1] 2 [3] 
         
      %>
      <span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
         <%=i + 1 %>
      </span>&nbsp;
      <%
   }
   else{
      %>      
      <a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
         style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none">
         [<%=i + 1 %>]
      </a>&nbsp;   
      <%
   }   
}
%>
</div>
 <script type="text/javascript">
                        
                  function searchEx() {
                     let exType = document.getElementById("exType").value;
                     let exDiff = document.getElementById("exDiff").value;
                     let exPart = document.getElementById("exPart").value;
                     //alert(exType);
                     location.href="exercise?param=exSearch&exType=" +exType+ "&exDiff=" +exDiff+"&exPart=" +exPart;
                  }
                  

                  function goPage( pageNum ) {
                     let exType = document.getElementById("exType").value;
                     let exDiff = document.getElementById("exDiff").value;
                     let exPart = document.getElementById("exPart").value;
                     //alert(exType+","+exPart);
                     location.href = "exercise?param=exSearch&exType=" +exType+ "&exDiff=" +exDiff+"&exPart=" +exPart+"&pageNum=" + pageNum;   
                  }

</script> 
                  
                  
                  
<br><br><br>    
      <!-- ======================================내용 END =================================== -->
    
     
<%@include file="bottom.jsp" %>