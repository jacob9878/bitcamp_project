package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ExDao;
import dao.ReviewDao;
import dto.BbsDto;
import dto.ExDto;
import dto.ReviewDto;

@WebServlet("/review")
public class ReviewController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException,  IOException {
		
		System.out.println("ReviewController doProcess");
		req.setCharacterEncoding("utf-8");
		
		String param = req.getParameter("param");
		 if(param.equals("rvWriteAf")) {
			
			String memId = req.getParameter("memid");
			int exSeq = Integer.parseInt( req.getParameter("exSeq"));
			String exComment = req.getParameter("exComment");

			ReviewDao dao = ReviewDao.getInstance();
			boolean b = dao.exReviewW(memId, exSeq, exComment);
			if(b) {
				resp.sendRedirect("exercise?param=exdetail&exSeq=" + exSeq);
			}
		}else if(param.equals("delRv")) {
			
			int exSeq =  Integer.parseInt( req.getParameter("exSeq") );
			int rvSeq =  Integer.parseInt( req.getParameter("rvSeq") );
			ReviewDao dao = ReviewDao.getInstance();
			boolean b = dao.deleteRv(rvSeq);
			if(b) {
				resp.sendRedirect("exercise?param=exdetail&exSeq=" + exSeq);
			}
			
		}
	}

	public void forward(String arg, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(arg);
		dispatch.forward(req, resp);			
	}
		
	
}
