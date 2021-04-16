<%@page import="java.util.Calendar"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@include file="top.jsp" %>   
      
      
      <!-- ============페이지 이름과 경로 상세 링크================ -->
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">운동 캘린더</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="main.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="calendar?param=calendar">운동캘린더</a></li>
                <li class="breadcrumb-item active">일정추가</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- ==========페이지 이름과 경로 상세 링크 END=========== -->
      
      
      
      <!-- ======================================내용=================================== -->






    

    
<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
%>    




<%
Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) + 1;
int tday = cal.get(Calendar.DATE);
int thour = cal.get(Calendar.HOUR_OF_DAY);
int tmin = cal.get(Calendar.MINUTE);

cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
%>
    






<div class="row">
<div class="col-xl-2"></div>
<div class="col-xl-8">
<form action="calendar?param=calwriteAf" method="post">

<table class="table" >
<col width="50px"><col width="200px">
<tr align="center">
	<th align="center" colspan="2">
		<h2 style="font-style: italic;">일정 추가</h2>
	</th>
</tr>
<tr>
	<th>ID</th>
	<td>
		<%=mem.getMemberID() %>
		<input type="hidden" name="id" value="<%=mem.getMemberID()%>">		
	</td>	
</tr>
<tr>
	<th>제목</th>
    <th>
    	<input type="text" class="form-control" name="title"  autofocus>
    </th>
</tr>
<tr>
	<th>일시</th>
	<td>
		<select name="year" class="form-select" aria-label="Default select example">
		<%
			for(int i = tyear - 5;i <= tyear + 5; i++){
				%>
				<option <%=year.equals(i + "")?"selected='selected'":"" %> value="<%=i %>" >
					<%=i %>
				</option>
				<%
			}		
		
		%>		
		</select>년	
		
		<select name="month" class="form-select" aria-label="Default select example">
		<%
			for(int i = 1;i <= 12; i++){
				%>
				<option <%=month.equals(i + "")?"selected='selected'":"" %> value="<%=i %>" >
					<%=i %>
				</option>
				<%
			}		
		
		%>		
		</select>월
		
		<select name="day" class="form-select" aria-label="Default select example">
		<%			
			for(int i = 1;i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
				%>
				<option <%=day.equals(i + "")?"selected='selected'":"" %> value="<%=i %>" >
					<%=i %>
				</option>
				<%
			}		
		
		%>		
		</select>일
		
		<select ty name="hour" class="form-select" aria-label="Default select example">
		<%
			for(int i = 1;i < 24; i++){
				%>
				<option <%=(thour + "").equals(i + "")?"selected='selected'":"" %> value="<%=i %>" >
					<%=i %>
				</option>
				<%
			}		
		
		%>		
		</select>시
		
		<select name="min" class="form-select" aria-label="Default select example">
		<%
			for(int i = 0;i < 60; i++){
				%>
				<option <%=(tmin + "").equals(i + "")?"selected='selected'":"" %> value="<%=i %>" >
					<%=i %>
				</option>
				<%
			}		
		
		%>		
		</select>분		
	</td>
</tr>

<tr>
	<th>내용</th>
	<td>
		<textarea rows="5" cols="60" name="content" class="form-control"></textarea>
	</td>
</tr>

<tr>
	<td colspan="2" align="center">
		<input type="submit" value="일정추가" class="btn btn-outline-primary">
	</td>
</tr>

</table>

</form>

</div>
<div class="col-xl-2"></div>
</div>







      
      <!-- ======================================내용 END =================================== -->
      
     
<%@include file="bottom.jsp" %>    