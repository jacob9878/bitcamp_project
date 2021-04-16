package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ManageDao;
import dto.MemberDto;
@WebServlet("/manage")
public class ManageController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		System.out.println("우선 admin 컨트롤러 진입");
		
		String param = req.getParameter("param");
		
		if(param.equals("searchNm")) {
			System.out.println("일반 회원 정보 다 끌어오기");
			ManageDao dao = ManageDao.getInstance();
			
			List<MemberDto> list = dao.NmlistNmAll();
			int count = dao.countmem(0,0);
			int countLikes = dao.countLikes();
			int countBbs = dao.countBbs();
			//System.out.println(count+"sss");
		
			req.setAttribute("list", list);
			req.setAttribute("countMem", count);
			req.setAttribute("countLikes", countLikes);
			req.setAttribute("countBbs", countBbs);
			
			//System.out.println("glglglgl");
			req.getRequestDispatcher("manageNm.jsp").forward(req, resp);
			
			
			
			
		}
		
		else if(param.equals("searchTm")) {
			System.out.println("트레이너 회원 정보 다 끌어오기");
			ManageDao dao = ManageDao.getInstance();
			
			List<MemberDto> list=dao.TmlistTmAll();
			int count = dao.countmem(1,5);
			int countPtMem = dao.countmem(5,0);
			int Ptcount = dao.Ptcount();
			//System.out.println(countPtMem);
			req.setAttribute("list", list);
			req.setAttribute("countMem", count);
			req.setAttribute("countPtMem", countPtMem);
			req.setAttribute("Ptcount", Ptcount);
			//System.out.println("memtype"+list.get(0).getMemType());
			req.getRequestDispatcher("manageTm.jsp").forward(req, resp);
		}
	
		
		
	}
	
	
	
	
	
	
	
	
}
