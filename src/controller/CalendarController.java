package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import dao.CalendarDao;
import dto.CalendarDto;
import dto.MemberDto;
import util.UtilEx;

public class CalendarController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		req.setCharacterEncoding("utf-8");
		CalendarDao dao = CalendarDao.getInstance();
		
		String param = req.getParameter("param");
		if(param.equals("calendar")) {
			
			
			String year = req.getParameter("year");
			String month = req.getParameter("month");
			
		
			forward("calendar.jsp", req, resp);
			
			
						
		}else if(param.equals("callist")) {
			
			String year = req.getParameter("year");
			String month = req.getParameter("month");
			String day = req.getParameter("day");
			
			MemberDto user = (MemberDto)req.getSession().getAttribute("login");
			
			
			String dates = year + UtilEx.two(month + "") + UtilEx.two(day + "");
			
			
			List<CalendarDto> list = dao.getAllCalendar(user.getMemberID(), dates);
			
			req.setAttribute("list", list);
			forward("callist.jsp", req, resp);			
			
						
		}else if(param.equals("calwrite")) {
			
			
			String year = req.getParameter("year");
			String month = req.getParameter("month");
			String day = req.getParameter("day");
			forward("calwrite.jsp", req, resp);
			
			
		}else if(param.equals("calwriteAf")) {

			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");

			String year = req.getParameter("year");
			String month = req.getParameter("month");
			String day = req.getParameter("day");
			String hour = req.getParameter("hour");
			String min = req.getParameter("min");
			String rdate = year + UtilEx.two(month) + UtilEx.two(day) + UtilEx.two(hour) + UtilEx.two(min); 
			


			boolean isS = dao.addCalendar(new CalendarDto(id, title, content, rdate));
			
			resp.sendRedirect("calendar.jsp");
			
		}else if(param.equals("caldetail")) {
			
			
			String seqq = req.getParameter("seq");
						
			int seq = Integer.parseInt(seqq);			
			
			
			CalendarDto dto = dao.getDay(seq);
			req.setAttribute("dto", dto);
			forward("caldetail.jsp", req, resp);
			
			
						
		}else if(param.equals("calupdate")) {
			
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			forward("calupdate.jsp", req, resp);
			
			
			
		}else if(param.equals("calupdateAf")) {
			
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			String title = req.getParameter("title");
			String content = req.getParameter("content");

			String year = req.getParameter("year");
			String month = req.getParameter("month");
			String day = req.getParameter("day");
			String hour = req.getParameter("hour");
			String min = req.getParameter("min");
			
			String rdate = year + two(month) + two(day) + two(hour) + two(min);


			boolean isS = dao.updateCalendar(new CalendarDto(seq, "", title, content, "", rdate));

			String urllist = String.format("%s&year=%s&month=%s", "calendar?param=calendar", year, month);

			resp.sendRedirect(urllist);
			
			
		}else if(param.equals("caldel")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			CalendarDto dto = dao.getDay(seq);
			
			boolean isS = dao.deleteCalendar(seq);
			
			String year = dto.getCalRdate().substring(0, 4);	// 년도
			String month = toOne(dto.getCalRdate().substring(4, 6));	// 월
			String day = toOne(dto.getCalRdate().substring(6, 8));		// 일
			
			String url = String.format("%s&year=%s&month=%s&day=%s", 
					"calendar?param=calendar", year, month, day);
			
			resp.sendRedirect(url);
		}
		
	}
	
	
	public void forward(String arg, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(arg);
		dispatch.forward(req, resp);			
	}
	
	public String two(String msg){
		return msg.trim().length()<2?"0"+msg:msg.trim();	// 1 ~ 9 -> 01
	}
	
	public String toOne(String msg){	// 08 -> 8
		return msg.charAt(0)=='0'?msg.charAt(1) + "": msg.trim();
	}

}
