<%@page import="dto.DweightDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %> 


<%

List<DweightDto> dwlist = (List<DweightDto>) request.getAttribute("dwlist");
// 현재 날짜
Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) + 1;


String year = request.getParameter("year");
String month = request.getParameter("month");

if(year == null){
   year = "";
}

if(month == null){
   month = "";
}

%>

    

  
<link rel="stylesheet" href="css/exDetailStyle.css">    
     
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
     



<style type="text/css">

.chartcontainer{
width:100%;
margin: 100px;
}
</style>  

   
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">체중량 그래프</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="calendar?param=calendar">운동일지</a></li>
                <li class="breadcrumb-item active">체중량 그래프</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->
      
      <!-- 날짜 선택 -->
<br><br>

<div class="row">
     <div class="col-xl-5"></div>
   
   <div class="col-xl-5" style="margin-left: 100px" >
         <select class="selectpicker" id = "year" data-style="btn btn-outline-dark">
            <%           
            for(int i = tyear; i >= tyear - 4; i--){
               %>
               <option <%=tyear==i?"selected='selected'":"" %> value="<%=i %>" >
                  <%=i %>
               </option>
               <%
            }
         %>
           </select>      
           
           
          <select class="selectpicker" id = "month" data-style="btn btn-outline-dark">
          <%        
            for(int i = 1; i <= 12; i++){
               %>   
               <option <%=tmonth==i?"selected='selected'":"" %> value="<%=i %>" >
                  <%=i %>
               </option>
               <%
            }
         %>
           </select>
            
            
         <button type="button" class ="btn btn-secon" onclick="graphDate()" >검색</button>
         <button type="button" class ="btn btn-sec" onclick="graphReturn()">최근데이터보기</button>
   <div class="col-xl-2"></div>
   </div>

</div>

   <div class="chartcontainer">
   
   <%if(dwlist.size()==0){
      %>
      <div class="row">
         <div class="col-xl-3"></div>
         <div class="col-xl-6">
             <p style="font-weight: 200">등록된 데이터가 없습니다.<p>
         </div>
         <div class="col-xl-3"></div>
      </div>
   <%
   } 
   %>
   
   <div class="row">
      <div class="col-xl-3"></div>
      <div class="col-xl-6">
           <button type="button" class ="btn btn-se" onclick="insertDweight()">오늘의 체중 입력</button>
      </div>
      <div class="col-xl-3"></div>
   </div>
   <!-- chart -->
   

      <div class="container">
         <canvas id="myChart"></canvas>
      </div>

      <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>   
      
   </div>


    <!-- The Modal -->
    <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
      
      <div class="col-xl-14">
               <img class="delw" src="images/imagesdelicon.jpg" onclick="hidethis()" align="right">
      </div>
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">DAILY WEIGHT</span></b></span></p>
                <p style="text-align: center; line-height: 1.5;"><br /><input type="text" id="dweight"></p>
                <p><br /></p>
            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="pop_bt" style="font-size: 13pt;" >
                        저장
                </span>
            </div>
      </div>
 
    </div>

     
<%@include file="bottom.jsp" %>

<script type="text/javascript">


jQuery(document).ready(function() {
        $('#myModal').hide();
        
});

function insertDweight(){
   $('#myModal').show();
};

//팝업 Close & 데이터
function close_pop(flag) {
   
   // memberid 넘기기 추가 -> 컨트롤ㄹ러
   let dweight = document.getElementById("dweight").value;
   location.href="member?param=dailyWeight&dweight=" + dweight;
};

function hidethis(){
   $('#myModal').hide();
};

function graphDate(){
   
   let year = document.getElementById("year").value;
   let month = document.getElementById("month").value;
   
   // 다시 자기 view부름
   location.href="member?param=graphDate&year=" + year + "&month=" + month;
}


function graphReturn(){
   location.href="member?param=dweightGraph";
}


var ctx = document.getElementById('myChart').getContext('2d');


var chart = new Chart(ctx, {
      type: 'line',
      data: {
         labels: [
            
            <%if(dwlist.size()!=0){
               for(int i = 0; i < dwlist.size() - 1; i++){
                  DweightDto dwdto = dwlist.get(i);
               %>
                  '<%=dwdto.getwDate() %>',
               <%
               } 
               %>
                  '<%=dwlist.get(dwlist.size()-1).getwDate() %>'],
               <%
            }else{
               %>
               ' '],
            <%
            }
            %>
            
         //   'January', 'February', 'March', 'April', 'May', 'June', 'July'], 
         
         datasets: [{ 
            label: '체중', 
            backgroundColor: 'transparent',
            pointHoverBackgroundColor: '#4F4C4C',
            lineTension: '0',
            borderColor: '#4F4C4C', 
            pointBackgroundColor: '#f4d160',
            pointRadius: '5',
            pointHoverRadius: '5',
            data: [
               <%if(dwlist.size()!=0){
                  for(int i = 0; i < dwlist.size() - 1; i++){
                     DweightDto dwdto = dwlist.get(i);
                  %>
                     '<%=dwdto.getdWeight() %>',
                  <%
                  } 
                  %>
                     '<%=dwlist.get(dwlist.size()-1).getdWeight() %>']
                  <%
               }else{
                  %>
                  ' ']
               <%
               }
               %>

         //      [0, 10, 5, 2, 20, 30, 45] 
         }]    
      }
   });
</script>
      
   
      
      <!-- ======================================내용 END =================================== -->
      
