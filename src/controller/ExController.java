package controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ExDao;
import dao.ReviewDao;
import dto.ExDto;
import dto.ReviewDto;
import net.sf.json.JSONObject;


@WebServlet("/exercise")
public class ExController extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      doProcess(req, resp);
   }

   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      doProcess(req, resp);
   }

   public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException,  IOException {

      System.out.println("ExController doProcess");
      req.setCharacterEncoding("utf-8");
      
      String param = req.getParameter("param");
      
   
      
         if(param.equals("exPic")) {
               //  System.out.println("이미지 파일 이름 들어옴 ");
                 String imgname = req.getParameter("imgname");
                 
                String realFile = "D:/homefit/pimage/"+imgname;
                String fileNm = imgname;
                String ext = "jpg";
             
                BufferedOutputStream out = null;
                InputStream in = null;

                try {
                   resp.setContentType("image/png");   //사용자에게 이미지를 보여줌 
                      resp.setHeader("Content-Disposition", "inline;filename=" + fileNm);
                   
                   File file = new File(realFile);
                   if(file.exists()){
                   
                      in = new FileInputStream(file);
                     out = new BufferedOutputStream(resp.getOutputStream());
                     int len;
                      byte[] buf = new byte[1024]; 
                      while ((len = in.read(buf)) > 0) {
                         out.write(buf, 0, len);
                      }
                   }
               
                } catch (Exception e) {
                  
                } finally {
                   if(out != null){ out.flush(); }
                   if(out != null){ out.close(); }
                   if(in != null){ in.close(); }
                }
                
          }

         
          else if(param.equals("exSearch")) {
             System.out.println("!!!!exSearch");
             
             String exType = req.getParameter("exType");
             String exDiff2 = req.getParameter("exDiff");
             String exPart = req.getParameter("exPart");
             
             String spageNumber = req.getParameter("pageNum");
             
             int exDiff=0;
             int pageNumber=0;
            
                if(exType == null){
                  exType = "없음";
               }
               
                if(exDiff2 != null) {
                  exDiff = Integer.parseInt(exDiff2);
               }
                if(exPart == null){
                   exPart = "없음";
                  }
               if(spageNumber !=null) {
                  pageNumber = Integer.parseInt(spageNumber);
               }
                //System.out.println(exType+","+exDiff+","+exPart);
               
             ExDao dao= ExDao.getInstance();
             
             List<ExDto> list= dao.exTypeSearch(exType, exDiff, exPart,pageNumber);
             
             req.setAttribute("list", list);
             int len = dao.getAllBbs(exType, exDiff,exPart);
             System.out.println("총 글 수: "+len);
             
               int bbspagecount = len / 12;      // 23 -> 2
               
               if((len % 12) > 0){
                  bbspagecount = bbspagecount + 1;
               }
               System.out.println("페이지 수: "+bbspagecount);
               
               req.setAttribute("bbspagecount", bbspagecount + "");///// 총 페이지 수 
               req.setAttribute("pageNumber", pageNumber + "");/////현제 페이지 넘버
               
               req.getRequestDispatcher("exerciseMain.jsp").forward(req, resp);
             
             
          }
      
          else if(param.equals("exdetail")) {
  			int exSeq = Integer.parseInt( req.getParameter("exSeq") );
  			String spage = req.getParameter("pageNumber");

  			System.out.println("exSeq"+exSeq);
  			int page = 0;
  			if(spage != null && !spage.equals("")) {
  				page = Integer.parseInt(spage);
  			}
  			
  			ExDao dao = ExDao.getInstance();
  			
  			//해당 영상의 정보를 다 가져오는 함수 
  			ExDto exdto = dao.getEx(exSeq);
  			//System.out.println(exdto.getExName());
  			req.setAttribute("exdto", exdto);
  			
  			///////////////////////
  			List<ExDto> relist = dao.getRelatedEx(exdto);
  			req.setAttribute("relist", relist);
  			
  			ReviewDao rdao = ReviewDao.getInstance();
  			List<ReviewDto> rlist = rdao.exReviewS(exSeq, page);
  			req.setAttribute("rlist", rlist);
  			
  			int len = rdao.allReviewNum(exSeq);
  			int rvPage = len / 5;
  			if((len % 5) > 0){
  				rvPage += 1;
  			}
  			
  			req.setAttribute("rvPage", rvPage + "");
  			req.setAttribute("pageNumber", page + "");

  			forward("exDetail.jsp", req, resp);
  			
  		}
          
          else if(param.equals("addroutine")) {
  			
  			String memId = req.getParameter("memId");
  			String exSeq = req.getParameter("exSeq");
  			
  			ExDao dao = ExDao.getInstance();
  			
  			// 중복체크
  			boolean b1 = dao.myRoutineCheck(memId, exSeq);
  			
  			if(b1) {
  				
  				// alert msg
  				resp.sendRedirect("exercise?param=exdetail&exSeq=" + exSeq);
  				
  			}else {
  				
  				boolean b2 = dao.addtoRoutine(memId, exSeq);
  			
  				if(b2) {
  					
  					// alert msg
  					resp.sendRedirect("exercise?param=exdetail&exSeq=" + exSeq);
  				}
  			}
  			
  		
  		}
  		
          else if(param.equals("likes")) {
        		
  			int exSeq = Integer.parseInt( req.getParameter("exSeq") );
  			
  			ExDao dao = ExDao.getInstance();
  			dao.addlikes(exSeq);
  			
  			int like = dao.selectLikes(exSeq);
  			
  			JSONObject obj = new JSONObject();
  			obj.put("like",like);
  			
  			resp.setContentType("application/x-json; charset=UTF-8");
  			resp.getWriter().print(obj);

  		}
      
         
  		else if(param.equals("exMine")) {
  				System.out.println("!!!!exMine");
             
          
             String memId = req.getParameter("memId");
             //System.out.println(memId);
             String spageNumber = req.getParameter("pageNum");
             
           
             int pageNumber=0;
            
               if(spageNumber !=null) {
                  pageNumber = Integer.parseInt(spageNumber);
               }
                //System.out.println(exType+","+exDiff+","+exPart);
               
             ExDao dao= ExDao.getInstance();
             int exSeq[] = dao.exSeqMine(memId);	//저장한 영상의 seq가져오기 
             
             List<ExDto> list= dao.exMine(pageNumber, exSeq);
             
             req.setAttribute("list", list);
             int len = exSeq.length;
             System.out.println(list.size());
             System.out.println("총 글 수: "+len);
             
               int bbspagecount = len / 12;      // 23 -> 2
               
               if((len % 12) > 0){
                  bbspagecount = bbspagecount + 1;
               }
               System.out.println("페이지 수: "+bbspagecount);
               
               req.setAttribute("bbspagecount", bbspagecount + "");///// 총 페이지 수 
               req.setAttribute("pageNumber", pageNumber + "");/////현제 페이지 넘버
               
               req.getRequestDispatcher("exMine.jsp").forward(req, resp);
  		}
      
      
    
   }
   
   
   public void forward(String arg, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
      RequestDispatcher dispatch = req.getRequestDispatcher(arg);
      dispatch.forward(req, resp);         
   }
}