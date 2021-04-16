<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.ManageDao"%>
<%@page import="dao.MemberDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>
<%@page import="dto.MemberDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="top.jsp" %>
<link rel="stylesheet" href="./css/manage.css">
  
 
       <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">회원관리</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="#">관리</a></li>
                <li class="breadcrumb-item active">회원관리</li>

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
int pcount=0;

	for(int i=0; i<list.size();i++){
		MemberDto dto= list.get(i);
		if(dto.getTrainerID()!= null){
			pcount++;
		}
	}
 Object lcount = (Object)request.getAttribute("countLikes");
 String countLikes = lcount.toString();	//좋아요 수 
 
 Object bcount = (Object)request.getAttribute("countBbs");
 String countBbs = bcount.toString();	//좋아요 수 
 
 
 
 
%><br><br>
<br><br><br>  <br><br><br><br>
  <!-- Start Welcome area -->
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
                  <h6 class="bigstats">아래는 우리 홈페이지 일반 회원들에 관한 정보입니다. 트레이너 회원의 정보를 보러가려면  <a href="manage?param=searchTm" target="_blank">여기</a>를 누르세요.</h6>
                  <div id="big_stats" class="cf">
                    <div class="stat"><i class="fa fa-user-circle" aria-hidden="true"></i><h6 >회원</h6> <span class="value"><%=count %></span>   </div>
                    <!-- .stat -->
                    
                    <div class="stat"><i class="fa fa-thumbs-up" aria-hidden="true"></i> <h6 >좋아요</h6> <span class="value"><%=countLikes %></span> </div>
                    <!-- .stat -->
                    
                    <div class="stat"><i class="fa fa-upload" aria-hidden="true"></i><h6 >게시물</h6>  <span class="value"><%=countBbs %></span> </div>
                    <!-- .stat -->
                    
                    <div class="stat"> <i class="fa fa-users" aria-hidden="true"></i><h6 >PT</h6> <span class="value"><%=pcount %></span> </div>
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

                <div class="orders">
                    <div class="row">
                    <div class="col-xl-3"></div>
                        <div class="col-xl-6">
                        
                        <h1><i class="fa fa-id-card-o" aria-hidden="true"></i> 일반 회원 정보</h1>
                        <div id="warning" style="background-color:White ">CHECK OUR NORMAL MEMBER</div>
                           <br><br> <div class="card">
                                
                                
                                    <div class="table-stats order-table ov-h">
                                        <table class="table ">
                                            <thead>
                                                <tr>
                                                   
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Email</th>
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
                                            		System.out.println(dto.getTrainerID());
                                            		if(dto.getTrainerID()==null){
                                            			ncount++;
                                            		}
                                            		else {
                                            			ptcount++;
                                            		} 
                                            		%>
                                            		 <tr>
                                                    
                                                    <td> <%=dto.getMemberID() %> </td>
                                                    <td>  <span class="name"><%=dto.getName() %></span> </td>
                                                    <td> <span class="product"><%=dto.getEmail() %></span> </td>
                                                    <td><span class="count"><%=dto.getGender() %></span></td>
                                                    <td><span class="count"><%=dto.getAge()%></span></td>
                                                     <td><span class="count"><%=dto.getMemLevel()%></span></td>
                                                   
                                                    <td>
                                                    		<%
                                                    			if(dto.getTrainerID()==null){
                                                    			%>
                                                    				 <span class="badge badge-complete">PT X</span>
                                                    			<%
                                                    			}
                                                    		else{
                                                    		%>
                                                        		<span class="badge badge-pending">PT O</span>
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
             
                <br><br><br><br><br><br><br><br>
                
                 <div class="row">
                 
                  	<div class="col-xl-3"></div>
 					 <div class="col-xl-3">	
 					  <h1><i class="fa fa-female" aria-hidden="true"></i><i class="fa fa-male" aria-hidden="true"></i>  남녀 비율  </h1>
 					 		<div id="chart_div"></div>
 					 </div> 
 					 <div class="col-xl-3">		
 					  <h1><i class="fa fa-users" aria-hidden="true"></i> PT 신청 비율  </h1>
 					 		<div id="chart_div2"></div>
            		</div> 
            		
            	 	<div class="col-xl-3"></div>
            	 	 			
				
				</div>
            	 	  <br><br><br><br><br><br><br><br>
            	 	       <!--  연령대  -->
               <div class="row">
               	<div class="col-xl-3"></div>
                  	  <div class="col-lg-6">
                  	  <h1><i class="fa fa-bar-chart" aria-hidden="true"></i> 일반 회원의 연령대 </h1>
                        <div class="card">
                            
                                
                              
                                    <div class="card-body">
                                    <%
                                    ManageDao dao = ManageDao.getInstance();
                                    int[] memAge = dao.countAge(list.get(0).getMemType(),0);
                                    int memCount = dao.countmem(list.get(0).getMemType(),0);
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
               	<div class="col-xl-3"></div>
               	</div>
            	 	  <br><br><br><br>  <br><br><br><br>
            	 	
 
 
 
 
				


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
          ['PT 신청함', <%=ptcount%>],
          ['PT 신청 안함', <%=ncount%>]
        
        ]);

        var options = {'title':'PT신청 비율',
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



      
      <!-- ======================================내용 END =================================== -->
      
     <br><br><br>
     
      
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
        오후 1:22 2021-03-31<div class="container">
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
</html>