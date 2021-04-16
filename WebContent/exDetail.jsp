<%@page import="dto.ReviewDto"%>
<%@page import="dto.ExDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="dto.DweightDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
// 운동dto
ExDto dto = (ExDto) request.getAttribute("exdto");

// 후기 list
List<ReviewDto> rlist = ( List<ReviewDto> ) request.getAttribute("rlist");

// 관련영상 list
List<ExDto> relist = ( List<ExDto> ) request.getAttribute("relist");

// 후기 전체 페이지
int rvPage = Integer.parseInt((String)request.getAttribute("rvPage"));
System.out.println("rvPage:" + rvPage);

// 후기 현재 페이지
int pageNumber = Integer.parseInt((String)request.getAttribute("pageNumber"));
System.out.println("pageNumber:" + pageNumber);
%>


  	
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">    
<!-- Site CSS -->
<link rel="stylesheet" href="css/exDetailStyle.css">    


<!-- yt api -->
<script src="https://www.youtube.com/player_api"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>	
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
  	
  	
<%@include file="top.jsp" %>
 
 
 
      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">운동하기</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="exercise?param=exSearch">운동하기</a></li>
                <li class="breadcrumb-item active">운동선택</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->
<div class="row">
				<div class="col-lg-12">
					<div class="heading-title text-center">
						<h2  class="ng" ><%=dto.getExName() %></h2>
						<!-- <hr class="two"> -->
					</div>
				</div>
			</div>
			
<!-- Start blog details -->
	<div class="blog-box">
		<div class="container">
			<div class="row">
				<div class="col-xl-8 col-lg-8 col-12">
					<div class="blog-inner-details-page">
						<div class="blog-inner-box">
						<div class="inner-blog-detail details-page">

				<!-- video start -->
			    <div class="youtubevideowrapper" style="padding-left: 12px;padding-top: 3px;padding-bottom: 20px"> 
			
			  		<div class="youtubevideowrapperdiv youtubevideowrapperdiv4-3" >
					<div id="player"></div>					    
					</div>
			 	</div>  
			<!--  video end -->


							
								<h3 style="margin-left: 8px;"><%=dto.getExName()%></h3>
								<ul style="margin-left: 2.5px;">
									<li><i class="zmdi zmdi-account"></i>유형 : <span><%=dto.getExType() %></span></li>
									<li>|</li>
									<li><i class="zmdi zmdi-time"></i>난이도 : <span><%=dto.getExDiff() %></span></li>
									<li>|</li>
									<li><i class="zmdi zmdi-time"></i>부위 : <span><%=dto.getExPart() %></span></li>
								</ul>
								<blockquote style="margin-left: 10px;margin-top: 30px">
									<p><%=dto.getExContent() %></p>
								</blockquote>
								
<!----------------------- likes Start --------------------------->						
					
				<div class="likebtn" style="margin-right: 40px;">		
						<form id="like_form" onclick="return like()" class="tm-bg-white px-5 mb-4 d-inline-block tm-text-primary tm-likes-box tm-liked" style="padding-top: 8px;">					
						 <i id="ll"></i>
							<input type="hidden" name="command" value="like_it">
							<input type="hidden" name="exSeq" value="<%=dto.getExSeq() %>">
						<!-- 	<i class="fas fa-heart mr-3 tm-liked-icon"></i>
								<i class="far fa-heart mr-3 tm-not-liked-icon"></i> -->
							<span id="tm-likes-count"><%=dto.getExLike() %> likes</span>
						</form>
					</div>
						
					</div>
				</div>
						
			<script type="text/javascript">
				function like(){
					$.ajax({
						url: "exercise?param=likes",
						type: "POST",
						cache: false,
						dataType: "json",
						data: $('#like_form').serialize(),
						success:
						function(data){
							$("#tm-likes-count").html(data.like + " likes");
							$( "#ll,#dd" ).toggleClass( "press", 1000 );
						}
					});
				
				}
				
			</script>		
		
		<!--------------- likes End ------------------>
						
						
		<!-- 후기 -->				
						
		<div class="blog-comment-box">
			<h3>Comments</h3>
			<%
			if(rlist == null || rlist.size() == 0){	
				%>
				작성된 후기가 없습니다
				<%
			}else{	
				for(int i = 0; i < rlist.size(); i++){
					ReviewDto rvdto = rlist.get(i);	
				%>
			<div class="comment-item">
				
				<div class="comment-item-right">
					<div class="pull-left">
						<a href="#"><%=rvdto.getMemberID() %></a>
						<%
						if(mem.getMemberID().equals(rvdto.getMemberID())){
							%>
							  <a href="review?param=delRv&rvSeq=<%=rvdto.getRvSeq() %>&exSeq=<%=dto.getExSeq() %>"><img class="delRv" src="images/imagesdelicon.jpg"></a>
						<%
						}
						%>
					</div>
					<div class="pull-right">
						<i class="fa fa-clock-o" aria-hidden="true"></i><span><%=rvdto.getRvDate().substring(0, 16) %></span>
					</div>
					<div class="des-l">
						<p style="margin-top: 8px;margin-bottom: 8px;"><%=rvdto.getExComment() %></p>
					</div>
				</div>
			</div>
			<%
				}
			}
			%>
		
		
			<div class="page_wrap">
				<div class="page_nation"">
				<%
				for(int i = 0; i < rvPage; i++){
					if(pageNumber == i){
						%>
						<a href="#" class="active" >
							<%=i + 1 %>
						</a> 
						<%
					}else{
						%>
						<a href="#" onclick="goPage(<%=i %>)">    
							<%=i + 1 %>
						</a>		 
					   <%
					}
				} 
				%>
				</div>	
		</div>					
			
			</div>							
						

  					
						
						
		<!--  코멘트 작성 -->				
			<div class="comment-respond-box">
				<h3>Leave your comment</h3>
				<div class="comment-respond-form">
					<form action="review" method="post" id="commentrespondform" class="comment-form-respond row" method="post">
					<input type="hidden" name="param" value="rvWriteAf">
					<input type="hidden" name="exSeq" value="<%=dto.getExSeq() %>">
						
						<div class="col-lg-6 col-md-6 col-sm-6">
							<div class="form-group">
								<input id="name_com" class="form-control" name="memid" type="text" value="<%=mem.getMemberID() %>" readonly="readonly">  
							</div>
							<div class="form-group">
								<input id="email_com" class="form-control" name="email" value="<%=mem.getEmail() %>" readonly="readonly">
							</div>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-6">
							<div class="form-group">
								<textarea class="form-control" id="textarea_com" name="exComment" placeholder="Your Message" rows="2"></textarea>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12">									
							<button type="submit" class=" btn-submit">후기 남기기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
			
<!-- right side -->			

				<div class="col-xl-4 col-lg-4 col-md-6 col-sm-8 col-12 blog-sidebar">
					<div class="right-side-blog" style="padding-left: 36px;">
						 
		                     <div class="routine-box">

										<div class="hover14">
										  <div>
											    <figure>
											    <a href="exercise?param=addroutine&memId=<%if(ologin!=null){%><%=mem.getMemberID() %><%}%>&exSeq=<%=dto.getExSeq() %>"><img src="img/routine.png"/></a>
												</figure>
										  </div>
									</div>
									<p style="font-weight: 700">[ 나의 루틴에 추가하기 ]</p>
								</div>
						
						<h3 style="font-size: 25px;text-align: center;background-color: #F7F7F7;font-weight: 700;margin-bottom: 48px;">Related Videos</h3>
						<div class="post-box-blog">
							<div class="recent-post-box">
							
							<% for(int i = 0; i < relist.size(); i++){
								ExDto redto = relist.get(i);	
							%>
									<figure class="snip1401">
										  <img src="exercise?param=exPic&imgname=<%=redto.getExImg() %>" />
										  <figcaption>
										    	<h2><%=redto.getExName() %></h2>
										  </figcaption><i class="ion-ios-home-outline"></i>
										  <a href="exercise?param=exdetail&exSeq=<%=redto.getExSeq() %>&pageNumber=0"></a>
									</figure>
									<br>
							<%
							}
							%>
							
								
								
							</div>
						</div>
						
						
					</div>
				</div>
		
				
				
			</div>
		</div>
	</div>
	
	<!-- End details -->
	
	
	<a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>

	<script type="text/javascript">

// 영상에 대한 값, 이벤트 넣어 줄 변수
var player;

function onYouTubePlayerAPIReady() {
	
	
	try {
	    player = new YT.Player('player', {
        //  height: '520',
        //  width: '1016',
	        videoId: '<%=dto.getExAdr() %>',
	        playerVars: {
	            'autoplay': 0,    	 	// 자동실행여부
	            'controls': 1,    		// 재생컨트롤 노출여부 (0:no)
	            'autohide': 1,   	    // 재생컨트롤이 자동으로 사라질지의 여부
	            'rel': 0,     		    // 동영상 재생완료 후 유사동영상 노출여부(0:yes)
	            'modestbranding':1,	    // 컨트롤바 표시여부 (0:no)
	       //   'disablekb':1 			// 키보드제어
	            'wmode': 'transparent'
	        },
	        events: {
	            'onReady': onPlayerReady,	// 동영상이 준비되면 발생하는 함수
	            'onStateChange': onPlayerStateChange	// 상태가 변함에 따라 해당 함수 발
	        }
	    });
	} catch (e) {
	}
	
	function onPlayerReady(event) {
		
	}
	
	function onPlayerStateChange(event) {
		
		// 종료
		if (event.data === 0) {
	        alert('시청완료');
	    }
	}

}

function goPage( pageNum ) {
	location.href="exercise?param=exdetail&exSeq=<%=dto.getExSeq() %>&pageNumber=" + pageNum;
}
</script>


      
      <!-- ======================================내용 END =================================== -->
      
     
 <%@include file="bottom.jsp" %>    
