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

<%@include file="top.jsp" %> 


<style type="text/css">
  
   .card-img-top{-ms-flex-negative:0;flex-shrink:0;width:100%}
   .card-img,
   .card-img-top{border-top-left-radius:calc(.30rem - 1px);
   border-top-right-radius:calc(.30rem - 1px)}
     .h-100{height:100%!important}
     
 </style>
 
 
 
      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">내가 찜한 운동</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item active">내가 찜한 운동</li>

              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->
 

<br><br><br><br><br><br>
<div class="container">


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
                        

                  function goPage( pageNum ) {
                   
                     //alert(exType+","+exPart);
                     location.href = "exercise?param=exSearch&pageNum=" + pageNum;   
                  }

</script> 
                  
                  
                  
<br><br><br>    
      <!-- ======================================내용 END =================================== -->
    
     
 <%@include file="bottom.jsp" %>