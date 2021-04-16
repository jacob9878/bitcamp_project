<%@page import="dao.ManageDao"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="top.jsp" %>    

  <style type="text/css">
  
    
    
  </style>

   <link rel="stylesheet" href="./css/manage.css">    
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">회원 관리</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="#">관리</a></li>
                <li class="breadcrumb-item active">트레이너 관리</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->
<%
List<MemberDto> list = (List)request.getAttribute("list");
Object ocount = (Object)request.getAttribute("countMem");
String count = ocount.toString();	//회원 수

Object pcount = (Object)request.getAttribute("countPtMem");
String ptMcount = pcount.toString();	//회원 수

Object ptmcount = (Object)request.getAttribute("Ptcount");
String PtMemcount = ptmcount.toString();	//회원 수
%><br><br><br><br><br><br><br><br>
  <div class="main">
  <div class="main-inner">
    <div class="container">
      <div class="row">
      <div class="col-md-2"></div>
      <div class="col-md-8">
        <div class="span6">
<div class="widget widget-nopad">
            <div class="widget-header"><h2><i class="fa fa-newspaper-o" aria-hidden="true"></i>
           	Home Fit's Stats</h2>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <div class="widget big-stats-container">
                <div class="widget-content">
                  <h6 class="bigstats">아래는 우리 홈페이지 트레이너 회원들에 관한 정보입니다. 일반 회원의 정보를 보러가려면  <a href="manage?param=searchNm" target="_blank">여기</a>를 누르세요.</h6>
                  <div id="big_stats" class="cf">
                    <div class="stat"><i class="fa fa-user-circle" aria-hidden="true"></i><h6 >회원</h6> <span class="value"><%=count %></span>   </div>
                    <!-- .stat -->
                    
                   
                    <!-- .stat -->
                    
                    <div class="stat"><i class="fa fa-check-square-o" aria-hidden="true"></i><h6 >PT 자격</h6><span class="value"><%=ptMcount %>  </span> </div>
                    <!-- .stat -->
                    
                    <div class="stat"> <i class="fa fa-users" aria-hidden="true"></i><h6 >PT 진행중 </h6> <span class="value"><%=PtMemcount %></span> </div>
                    <!-- .stat --> 
                  </div>
                </div>
                <!-- /widget-content --> 
                
              </div>
            </div>
          </div>
          </div>
          </div>
          <div class="col-md-2"></div>
          </div></div></div></div>
         
<br><br>
<br><br><br>  <br><br><br><br>
<!--Manage Trainer Member -->
                <div class="orders">
                    <div class="row">
                    <div class="col-xl-3"></div>
                        <div class="col-xl-6">
                        <h1><i class="fa fa-id-card-o" aria-hidden="true"></i>  트레이너 회원 정보</h1>
                            <div class="card">
                                
                                    <div class="table-stats order-table ov-h">
                                        <table class="table ">
                                            <thead>
                                                <tr>
                                                    
                                                    <th>ID</th>
                                                     <th>Pic</th>
                                                    <th>Email</th>
                                                    <th>Name</th>
                                                    <th>Gender</th>
                                                    <th>Age</th>
                                                    <th>Level</th>
                                                    <th>PT Status</th>
                                                    
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <%	int fcount=0;
                                            	int mcount =0;
                                            	
                                            	int ptcount=0;
                                            	int ncount=0;
                                            	
                                            	for(int i=0; i<list.size();i++){
                                            		
                                            		MemberDto dto = list.get(i);
                                            		if(dto.getGender().equals("F")){
                                            			fcount++;
                                            		}
                                            		else if(dto.getGender().equals("M")){
                                            			mcount++;
                                            		}
                                            		System.out.println(dto.getMemType());
                                            		if(dto.getMemLevel()==5){
                                            			ptcount++;
                                            		}
                                            		else {
                                            			ncount++;
                                            		} 
                                            		%>
                                            		 <tr>
                                                   
                                                    <td> <%=dto.getMemberID() %> </td>
                                                     <td> <img class="rounded-circle" src="upload/<%=dto.getProfileImg() %>" alt=""></td>
                                                    <td>  <%=dto.getName() %></td>
                                                    <td><%=dto.getEmail() %></td>
                                                    <td><%=dto.getGender() %></td>
                                                    <td><%=dto.getAge()%></td>
                                                     <td><%=dto.getMemLevel()%></td>
                                                   
                                                    <td>
                                                    		<%
                                                    			if(dto.getMemLevel()==5){
                                                    			%>
                                                    				 <span class="badge badge-complete">PT O</span>
                                                    			<%
                                                    			}
                                                    		else{
                                                    		%>
                                                        		<span class="badge badge-pending">PT  X</span>
                                                       		 <%
                                                       		 }%>
                                                    	</td>
                                                    
                                                    	
                                               		 </tr>
                                            		<% 
                                            		}
                                            		%>
                                            		
                                            </tbody>
                                        </table>
                                     </div> <!-- /.table-stats -->
                                
                            </div> <!-- /.card -->
                        </div>  <!-- /.col-lg-8 -->

                         <div class="col-xl-3"></div>
                    </div>
                </div>
                <br> <br> <br><br><br><br><br><br><br><br><br>
		 <div class="row">
                  	<div class="col-xl-3"></div>
 					 <div class="col-xl-3">
 					 <h1><i class="fa fa-female" aria-hidden="true"></i><i class="fa fa-male" aria-hidden="true"></i>  남녀 비율  </h1>
 					 		<div id="chart_div"></div></div> 
 					 	 <div class="col-xl-3">
 					 	   <h1><i class="fa fa-users" aria-hidden="true"></i> PT 자격 비율  </h1>	<div id="chart_div2"></div>
            		</div> 
            		
            	 	<div class="col-xl-3"></div>
            	 	
            </div>	 	<br><br><br><br><br><br><br><br>
            	 	       <!--  Traffic  -->
                <div class="row">
                  	  <div class="col-lg-3"></div>
                       <div class="col-lg-6"> 
                       <h1><i class="fa fa-bar-chart" aria-hidden="true"></i> 트레이너의 연령대 </h1>
                       <div class="card">
                            
                                
                              
                                    <div class="card-body">
                                    <%
                                    ManageDao dao = ManageDao.getInstance();
                                    int[] memAge = dao.countAge(1,5);
                                    int memCount = dao.countmem(1, 5);
                                    double[] memcAgeCount= {0,0,0,0,0};
                                    System.out.println(memCount);
                                    int j1=1;int j2=1;int j3=1;int j4=1;int j5=1;
                                    for(int i=0; i<memAge.length;i++){
                                    	//System.out.println(memAge[i]);
                                    	
                                    	if(memAge[i]<20){
                                    		memcAgeCount[0] = j1;
                                    		j1++;
                                    	}
                                    	else if(memAge[i]<30){
                                    		memcAgeCount[1] = j2;
                                    		j2++;
                                    	}
                                    	else if(memAge[i]<40){
                                    		memcAgeCount[2] = j3;
                                    		j3++;
                                    	}
                                    	else if(memAge[i]<50){
                                    		memcAgeCount[3] = j4;
                                    		j4++;
                                    	}
                                    	else{
                                    		memcAgeCount[4] = j5;
                                    		j5++;
                                    	}
                                    }
                                    	%>
                                    	<%
                                    	for(int j=0; j<memcAgeCount.length;j++){
                                    		%>
                                    		<div class="progress-box progress-1">
                                            	<h4 class="por-title">
                                            		<%if(j==4){
                                            			%>
                                            			<%=j+1 %>0대 이상</h4>
                                            			<% 
                                            		} else{
                                            			%>
                                            				<%=j+1 %>0대</h4> 
                                            			<%
                                            		} %>
                                            	
                                            	<div class="por-txt"><%=(int)memcAgeCount[j] %> Users (
                                            	<%if(memcAgeCount[1]!=0) { 
                                            		%>
                                            			<%=(int)((double)memcAgeCount[j]/(double)memCount*100.0) %>
                                            			 %)</div>
                                            		<% 
                                            	}%>
                                            	<div class="progress mb-2" style="height: 5px;">
                                                	<div class="progress-bar bg-flat-color-1" role="progressbar" style="width: <%=(double)memcAgeCount[j]/(double)memCount*100.0%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                            	</div>
                                       	 	</div>
                                    
                                    		<%
                                    	}
                                    	%>
                                    	 
                                    
                                  
                                    </div> <!-- /.card-body -->
                                
                                 
                           
                            
                    </div><!-- /# column -->
               </div>
            	 	<div class="col-lg-3"></div>
            	 	
            	 	
				</div>
 			




      
      <!-- ======================================내용 END =================================== -->
      
     				<!-- Markup -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      
      function drawChart() {
	
    	var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['Female', <%=fcount%>],
          ['Male', <%=mcount%>]
        
        ]);

        var options = {'title':'남녀 비율',
                       'width':400,
                       'height':400,
                       slices: {
                           0: { color: 'SteelBlue' },
                           1: { color: 'LightSteelBlue' }
                          
                       }};
		
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
</script>

<script type="text/javascript">

      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      
      function drawChart() {
	
    	var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['PT 자격 신청', <%=ptcount%>],
          ['PT 자격 신청 안함', <%=ncount%>]
        
        ]);

        var options = {'title':'PT 자격 비율',
                       'width':400,
                       'height':400,
                       slices: {
                           0: { color: 'DarkSlateGrey' },
                           1: { color: 'MediumAquaMarine' }
                          
                       }};
		
        var chart = new google.visualization.PieChart(document.getElementById('chart_div2'));
        chart.draw(data, options);
      }
</script>


 <%@include file="bottom.jsp" %>    
     
