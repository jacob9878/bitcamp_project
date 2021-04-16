package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QnABbsDao;
import dto.BbsDto;
import net.sf.json.JSONObject;

public class QnABbsController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		System.out.println("BbsController doProcess");
			
		req.setCharacterEncoding("utf-8");	
		
		QnABbsDao dao = QnABbsDao.getInstance();
		
		String param = req.getParameter("param");
		if(param.equals("qnabbslist")) {
			
			String choice = req.getParameter("choice");
			String search = req.getParameter("search");
			String spage = req.getParameter("pageNumber");
			System.out.println(choice);
			System.out.println(search);
			System.out.println(spage);
			
			
			int page = 0;
			if(spage != null && !spage.equals("")) {
				page = Integer.parseInt(spage);
			}
			if(choice == null) {
				choice = "";
			}
			if(search == null) {
				search = "";
			}
			
			
			List<BbsDto> list = dao.getBbsPagingList(choice, search, page);
			req.setAttribute("list", list);
			
		
			
			int len = dao.getAllBbs(choice, search);
			int bbsPage = len / 10;		// 23 -> 2
			if((len % 10) > 0){
				bbsPage = bbsPage + 1;
			}
			req.setAttribute("bbsPage", bbsPage + "");
			req.setAttribute("pageNumber", page + "");
			req.setAttribute("choice", choice);
			req.setAttribute("search", search);
			req.setAttribute("len", len+"");
			forward("qnabbslist.jsp", req, resp);	
			
		}else if(param.equals("qnabbswrite")) {
			
			resp.sendRedirect("qnabbswrite.jsp");
			
		}else if(param.equals("qnabbswriteAf")) {
			
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			boolean isS = dao.writeBbs(new BbsDto(id, title, content));
			if(isS) {				
				resp.sendRedirect("qnabbs?param=qnabbslist");
			}else {
				resp.sendRedirect("qnabbswrite.jsp");
			}
			
		}else if(param.equals("qnabbsdetail")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			
			dao.readcount(seq);		// 조회수 늘리기
			
			BbsDto dto = dao.getBbs(seq);			
			
			req.setAttribute("bbs", dto);
			
			forward("qnabbsdetail.jsp", req, resp);
			
		}else if(param.equals("qnabbsupdate")) {
			
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq.trim());

			BbsDto dto = dao.getBbs(seq);
			
			req.setAttribute("bbs", dto);
			
			forward("qnabbsupdate.jsp", req, resp);
			
		}else if(param.equals("qnabbsupdateAf")) {
			
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq.trim());

			String title = req.getParameter("title");
			String content = req.getParameter("content");

			boolean isS = dao.updateBbs(seq, title, content);			
			if(!isS) {
				resp.sendRedirect("qnabbs?param=qnabbsupdate&seq=" + sseq);
			}else {
			resp.sendRedirect("qnabbs?param=qnabbslist");
			}
			
		}else if(param.equals("qnabbsdelete")) {
			
			int seq = Integer.parseInt( req.getParameter("seq") );
			System.out.println("seq:" + seq);

			dao.deleteBbs(seq);
			
			resp.sendRedirect("qnabbs?param=qnabbslist");
		}else if(param.equals("qnaanswer")) {
			
			int seq = Integer.parseInt( req.getParameter("seq") );
			BbsDto dto = QnABbsDao.getInstance().getBbs(seq);
			
			req.setAttribute("bbs", dto);
			
			forward("qnaanswer.jsp", req, resp);
			
		}else if(param.equals("qnaanswerAf")) {
			System.out.println("qnaanswerAf");
			int seq = Integer.parseInt( req.getParameter("seq") );
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			

			boolean isS = dao.answer(seq, new BbsDto(id, title, content));
			if(!isS){
				resp.sendRedirect("qnabbs?param=qnaanswer&seq=" + seq);
			}else {
			resp.sendRedirect("qnabbs?param=qnabbslist");
			}
		}else if(param.equals("like")){
			System.out.println("likeeee");
			int bbsseq = Integer.parseInt(req.getParameter("bbs_seq"));
			
			
			dao.update_Like(bbsseq);
			
			int like = dao.select_Like(bbsseq);
			System.out.println("like 개수:"+ like);

			JSONObject obj = new JSONObject();
			obj.put("like",like);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);

						
		}						
	}
	
	public void forward(String arg, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(arg);
		dispatch.forward(req, resp);			
	}
}
