package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import chat.ChatDAO;
import chat.ChatDTO;
import dto.MemberDto;

public class ChatController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		System.out.println("ChatController doProcess");
		
		req.setCharacterEncoding("utf-8");
	    resp.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = resp.getWriter();
	    ChatDAO dao = ChatDAO.getInstance();
	    String param = req.getParameter("param");
	    
	    //로그인 해야 게시판 이용가능하니 세션 로그인 속성 불러왔습니다.
    	MemberDto mem = (MemberDto) req.getSession().getAttribute("login");
	      
	    
	    if(param.equals("")) {   
	    	System.out.println("param 빈값 들어옴");
	    }
	    else if(param.equals("goChatManager")) {
	    	System.out.println("ChatController goChatManager 들어옴");
	    	
	    	List<ChatDTO> list = dao.getRecentAllList(mem.getMemberID());
	    	
	    	/*
	    	for (int i = 0; i < list.size(); i++) {
	    		System.out.println(list.get(i).getFromID());
	    		System.out.println(list.get(i).getToID());
	    		System.out.println(list.get(i).getChatContent());
	    		System.out.println(list.get(i).getChatTime());
			}
			*/
	    	
	    	
	    	req.setAttribute("recentList", list);
	    	
	    	forward("trainerChatManager.jsp", req, resp);
	    	
	    	
	    }
		
		
		
		
		
		
	}
		
	
	
	public void forward(String arg, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
	      RequestDispatcher dispatch = req.getRequestDispatcher(arg);
	      dispatch.forward(req, resp);         
	}

}
