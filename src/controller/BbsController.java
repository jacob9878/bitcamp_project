package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.BbsDao;
import dao.ExDao;
import dto.BbsDto;
import dto.MemberDto;
import dto.TrainerDto;
import net.sf.json.JSONObject;

public class BbsController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		System.out.println("BbsController doProcess");
		
		req.setCharacterEncoding("utf-8");
	    resp.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = resp.getWriter();
	    BbsDao dao = BbsDao.getInstance();
	    String param = req.getParameter("param");
	    
	    //로그인 해야 게시판 이용가능하니 세션 로그인 속성 불러왔습니다.
    	MemberDto mem = (MemberDto) req.getSession().getAttribute("login");
	      
	    
	    if(param.equals("")) {   
	    	System.out.println("param 빈값 들어옴");
	    }
	    
		/* 게시판 (list) 이동 */
	    else if(param.equals("goPage")) {
	    	System.out.println("BbsController goPage 들어옴");
	    	
	    	 String selectBBS = req.getParameter("selectBBS");
	    	 String searchText = req.getParameter("searchText");
	    	 if(selectBBS == null) selectBBS = "";
	    	 if(searchText == null) searchText = "";
	    	 
	    	 //System.out.println("검색할 대상 : " + selectBBS);
	    	 //System.out.println("검색내용 : " + searchText);
	    	 
	    	 String bbsType = req.getParameter("bbsType"); 
	    	 
	    	 String sPageNumber = req.getParameter("pageNumber");
	    	 Integer pageNumber = 0; // 현재 페이지
	    	 if(sPageNumber != null && !sPageNumber.equals("")) {	//페이지 번호를 클릭했을 때
	    		pageNumber = Integer.parseInt(sPageNumber);
	    	 }
	    	 //System.out.println("현재 페이지 : " +pageNumber.intValue());
	    	 //System.out.println("페이지 고유번호 : " +bbsType.intValue());
	    	 
	    	 
	    	List<BbsDto> list = dao.getBbsPagingList(selectBBS, searchText, pageNumber.intValue(), Integer.parseInt(bbsType));
	    	
	    	
	    	Integer len = dao.getAllBbs(selectBBS, searchText, Integer.parseInt(bbsType));
	    	
	    	//System.out.println("총 글의 수 : " +len.intValue());
	    	//System.out.println("리스트 : " + list.size());

	    	//총 페이지 수 구하기 ex) 23개 --> 3페이지
	    	
	    	int bbsPage = 0;
	    	
	    	if(Integer.parseInt(bbsType) == 2) {
	    		bbsPage = len / 8;	
	    		if(len%8 > 0) {	// 게시글이 23개면 (20 +) 3개를 위한 페이지를 하나 더 만들어준다.
	    			bbsPage += 1;
	    		}
	    	} else {
	    		bbsPage = len / 10;	
	    		if(len%10 > 0) {	// 게시글이 23개면 (20 +) 3개를 위한 페이지를 하나 더 만들어준다.
	    			bbsPage += 1;
	    		}
	    	}
	    	 
	    	req.setAttribute("List", list);
	    	req.setAttribute("len", len);
	    	req.setAttribute("bbsPage", bbsPage);
	    	req.setAttribute("pageNumber", pageNumber);
	    	req.setAttribute("bbsType", bbsType);
	    	
	    	if(Integer.parseInt(bbsType) == 0) {	// 자유게시판 리스트 페이지 이동
	    		forward("freeBoardList.jsp", req, resp);
	    	}
	    	else if(Integer.parseInt(bbsType) == 1) {	// Q&A 리스트 페이지 이동
	    		forward("QnAList.jsp", req, resp);
	    	}
	    	else if(Integer.parseInt(bbsType) == 2) {	// 바디프로필 리스트 페이지 이동
	    		forward("bodyProfileList.jsp", req, resp);
	    	}
	    	else if(Integer.parseInt(bbsType) == 3) {	// 트레이너 소개 리스트 페이지 이동
	    		forward("trainerList.jsp", req, resp);
	    	}
	    	else if(Integer.parseInt(bbsType) == 4) {	// 트레이너 신청 리스트 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    }
	    
		/* 트레이너 신청 글쓰기 페이지 이동 */
	    else if(param.equals("goApplyTrainerWrite")) {
	    	resp.sendRedirect("applyTrainerWrite.jsp");
	    }
	    
		/* 게시판 글쓰기 완료 버튼 */
	    else if(param.equals("bbswriteAf")) {
	    	System.out.println("BbsController bbswriteAf 들어옴");

	    	
	    	String memberId = mem.getMemberID();
	    	String division = req.getParameter("division"); 
	        String title = req.getParameter("title");
	        String img = req.getParameter("img");
	        String content = req.getParameter("content");
	        String bbsType = req.getParameter("bbsType");
	        
	        
			/* 트레이너 인증 시 필요한 정보 */
	        String sPrice1 = req.getParameter("price1");
	        int price1 = 0;
	        if(sPrice1 != null && !sPrice1.equals("")) {
	        	price1 = Integer.parseInt(sPrice1);
	        }
	        String sPrice10 = req.getParameter("price10");
	        int price10 = 0;
	        if(sPrice10 != null && !sPrice10.equals("")) {
	        	price10 = Integer.parseInt(sPrice10);
	        }
	        String sPrice30 = req.getParameter("price30");
	        int price30 = 0;
	        if(sPrice30 != null && !sPrice30.equals("")) {
	        	price30 = Integer.parseInt(sPrice30);
	        }
	        String instaLink = req.getParameter("instaLink");
	        if(instaLink == null) {
	        	instaLink = "";
	        }
	        String faceLink = req.getParameter("faceLink");
	        if(faceLink == null) {
	        	faceLink = "";
	        }
	        String gymLocation = req.getParameter("gymLocation");
	        
	        
	        

	        System.out.println("로그인 아이디 확인:" + memberId);
	        System.out.println("말머리:" + division);
	        System.out.println("title:" + title);
	        System.out.println("img:" + img);
	        System.out.println("price1:" + price1);
	        System.out.println("price10:" + price10);
	        System.out.println("price30:" + price30);
	        System.out.println("instaLink:" + instaLink);
	        System.out.println("faceLink:" + faceLink);
	        System.out.println("gymLocation:" + gymLocation);
	        
			boolean isS = dao.writeBbs(new BbsDto(memberId, title, content, img, division, Integer.parseInt(bbsType)));
			
			boolean trainerIsS = dao.writeTrainerBbs(memberId, new TrainerDto(price1, price10, price30, gymLocation, instaLink, faceLink));
			
			
			
			
			
			if(!isS) {
				out.println("<script>");
				out.println("alert('글 작성에 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
				return;

			} else {
				
				resp.sendRedirect("bbs?param=goPage&bbsType="+bbsType);
				
			};
	    }
	    
		/* 게시판 디테일 페이지 이동 */
	    else if(param.equals("getDetail")) {
	    	System.out.println("BbsController getDetail 들어옴");
	    	
	    	int seq = Integer.parseInt(req.getParameter("seq"));
	    	System.out.println("게시판 디테일 글 번호 : " +seq);
	    	
	    	dao.readcount(seq);	// 조회수 1 증가
	    	
	    	BbsDto dto = dao.getBbs(seq);
	    	
	    	//디테일 글 작성자의 프로필 정보 -> wDto
	    	MemberDto wDto = dao.getWriterProfile(seq);
	    	req.setAttribute("writerDto", wDto);
	    	
	    	req.setAttribute("bbs", dto);
	    	
	    	int bbsType = dto.getBbstype();
	    	
	    	if(bbsType == 0) {	// 자유게시판 디테일 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    	else if(bbsType == 1) {	// Q&A 디테일 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    	else if(bbsType == 2) {	// 바디프로필 디테일 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    	else if(bbsType == 3) {	// 트레이너 소개 디테일 페이지 이동
	    		forward("trainerDetail.jsp", req, resp);
	    	}
	    	else if(bbsType == 4) {	// 트레이너 신청 디테일 페이지 이동
	    		TrainerDto tDto = dao.getTrainerBbs(seq);
	    		req.setAttribute("trainer", tDto);
	    		forward("applyTrainerDetail.jsp", req, resp);
	    	}
	    }
	    
		/* 글 삭제 버튼 클릭 */
	    else if(param.equals("deleteBbs")) {
	    	System.out.println("BbsController deleteBbs 들어옴");
	    	
	    	int seq = Integer.parseInt(req.getParameter("seq"));
	    	System.out.println("게시판 디테일 글 번호 : " +seq);
	    	
	    	boolean b = dao.deleteBbs(seq);
	    	int bbsType = dao.getBbsType(seq);
	    	
	    	if(b) 
	    		resp.sendRedirect("bbs?param=goPage&bbsType="+bbsType);
	    	else
	    		System.out.println("삭제 안됨");	    	
	    	
	    }
		/* 글 수정 페이지 이동 */
	    else if(param.equals("goUpdateBbs")) {
	    	int seq = Integer.parseInt(req.getParameter("seq"));
	    	System.out.println("게시판 디테일 글 번호 : " +seq);
	    	
	    	BbsDto dto = dao.getBbs(seq);
	    	
	    	req.setAttribute("bbs", dto);
	    	
	    	int bbsType = dto.getBbstype();
	    	
	    	if(bbsType == 0) {	// 자유게시판 수정 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    	else if(bbsType == 1) {	// Q&A 수정 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    	else if(bbsType == 2) {	// 바디프로필 수정 페이지 이동
	    		forward("bodyProfileUpdate.jsp", req, resp);
	    	}
	    	else if(bbsType == 3) {	// 트레이너 소개 수정 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    	else if(bbsType == 4) {	// 트레이너 신청 수정 페이지 이동
	    		forward("applyTrainerUpdate.jsp", req, resp);
	    	}
	    	
	    	
	    }
		/* 글 수정 버튼 클릭 */
	    else if(param.equals("updateBbs")) {
	    	System.out.println("BbsController updateBbs 들어옴");

	    	String memberId = mem.getMemberID();
	    	int seq = Integer.parseInt(req.getParameter("seq"));
	    	String division = req.getParameter("division"); 
	        String title = req.getParameter("title");
	        String img = req.getParameter("img");
	        String newFilename = req.getParameter("oldnewfile");
	        String content = req.getParameter("content");
	        String bbsType = req.getParameter("bbsType");

	        System.out.println("로그인 아이디 확인:" + memberId);
	        System.out.println("말머리:" + division);
	        System.out.println("title:" + title);
	        System.out.println("img:" + img);
	        System.out.println("content:" + content);
	        System.out.println("bbsType:" + bbsType);
	    	
	        boolean b = dao.updateBbs(seq, title, content, img, newFilename, division);
	       
	        if(b) 
	    		resp.sendRedirect("bbs?param=getDetail&seq="+seq);
	    	else
	    		System.out.println("삭제 안됨");	   
	        
	    }
	    
		/* 답글 페이지 이동 */
	    else if(param.equals("goAnswerBbs")) {
	    	System.out.println("BbsController goAnswerBbs 들어옴");
	    	
	    	int seq = Integer.parseInt(req.getParameter("seq"));
	    	System.out.println("게시판 디테일 글 번호 : " +seq);
	    	
	    	BbsDto dto = dao.getBbs(seq);
	    	
	    	req.setAttribute("bbs", dto);
	    	
	    	int bbsType = dto.getBbstype();
	    	
	    	if(bbsType == 0) {	// 자유게시판 답글 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    	else if(bbsType == 1) {	// Q&A 답글 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    	else if(bbsType == 2) {	// 바디프로필 답글 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    	else if(bbsType == 3) {	// 트레이너 소개 답글 페이지 이동
	    		forward("applyTrainer.jsp", req, resp);
	    	}
	    	else if(bbsType == 4) {	// 트레이너 신청 답글 페이지 이동
	    		forward("applyTrainerAnswer.jsp", req, resp);
	    	}
	    	
	    	
	    }
	    	
		/* 답글 작성 버튼 클릭 */
	    else if(param.equals("answerBbs")) {
	    	System.out.println("BbsController answerBbs 들어옴");
	    
	    	String memberId = mem.getMemberID();
	    	System.out.println("로그인 아이디 확인:" + memberId);
	    	int seq = Integer.parseInt(req.getParameter("seq"));
	    	String division = req.getParameter("division"); 
	    	System.out.println("말머리:" + division);
	        String title = req.getParameter("title");
	        System.out.println("title:" + title);
	        String img = req.getParameter("img");
	        System.out.println("img:" + img);
	        String content = req.getParameter("content");
	        System.out.println("content:" + content);
	        int bbsType = Integer.parseInt(req.getParameter("bbsType"));
	        System.out.println("bbsType:" + bbsType);
	        
	    	
	        boolean b = dao.answer(seq, new BbsDto(memberId, title, content, img, division, bbsType));
	        
	        if(b) 
	    		resp.sendRedirect("bbs?param=goPage&bbsType="+bbsType);
	    	else
	    		System.out.println("답글 안달림");	   
	        
	        
	        
	    }
	    
		/* 트레이너 수락 버튼 눌렀을 때 */
	    else if(param.equals("acceptTrainer")) {
	    	System.out.println("BbsController acceptTrainer 들어옴");
	    	
	    	int seq = Integer.parseInt(req.getParameter("seq"));
	    	String id = req.getParameter("id");
	    	System.out.println("seq : "+seq+" id : "+id);
	    	
	    	boolean b = dao.acceptTrainer(seq);
	    	boolean b2 = dao.authTrainer(id);
	    	
	    	
	    	if(b && b2) 
	    		resp.sendRedirect("bbs?param=goPage&bbsType=4");
	    	else
	    		System.out.println("트레이너 수락 안됨");	   
	    	
	    }
	    
	    
		/* 트레이너 리스트 게시판 이동 */
	    else if(param.equals("goTrainerListPage")) {
	    	System.out.println("BbsController goTrainerListPage 들어옴");
	    	

	    	 String sPageNumber = req.getParameter("pageNumber");
	    	 Integer pageNumber = 0; // 현재 페이지
	    	 if(sPageNumber != null && !sPageNumber.equals("")) {	//페이지 번호를 클릭했을 때
	    		pageNumber = Integer.parseInt(sPageNumber);
	    	 }
	    	 //System.out.println("현재 페이지 : " +pageNumber.intValue());
	    	 //System.out.println("페이지 고유번호 : " +bbsType.intValue());
	    	 
	    	 
	    	List<BbsDto> list = dao.getTrainerBbsPagingList(pageNumber.intValue());
	    	
	    	 
	    	req.setAttribute("List", list);
	    	req.setAttribute("pageNumber", pageNumber);
	    	
	    	forward("trainerList.jsp", req, resp);
	    	
	    	
	    }
	    
	    /* 트레이너 게시판 디테일 페이지 이동 */
	    else if(param.equals("getTrainerDetail")) {
	    	System.out.println("BbsController getTrainerDetail 들어옴");
	    	
	    	int seq = Integer.parseInt(req.getParameter("seq"));
	    	System.out.println("게시판 디테일 글 번호 : " +seq);
	    	
	    	dao.readcount(seq);	// 조회수 1 증가
	    	
	    	//기본 게시판 정보
	    	BbsDto dto = dao.getBbs(seq);
	    	int bbsType = dto.getBbstype();
	    	req.setAttribute("bbs", dto);
	    	
	    	//트레이너 게시판 추가 정보
	    	TrainerDto tDto = dao.getTrainerBbs(seq);
	    	req.setAttribute("trainerDto", tDto);
	    	
	    	//디테일 글 작성자의 프로필 정보 -> wDto
	    	MemberDto wDto = dao.getWriterProfile(seq);
	    	req.setAttribute("writerDto", wDto);
	    	
	    	if(bbsType == 3)
	    		forward("trainerDetail.jsp", req, resp);
	    	else if(bbsType == 2)
	    		forward("bodyProfileDetail.jsp", req, resp);
	    	

	    }
	    
	    
		/* 바디프로필 글쓰기 버튼 클릭 */
	    else if(param.equals("bodyProfileWriteAf")) {   
	          System.out.println("BbsController bodyProfileWriteAf");

	          String memberId = mem.getMemberID();
	          String fupload = req.getServletContext().getRealPath("/upload");   //저장경로 설정
	          System.out.println("업로드 폴더:" + fupload);

	          String yourTempDir = fupload;

	          int yourMaxRequestSize = 100 * 1024 * 1024;   // 1 Mbyte
	          int yourMaxMemorySize = 100 * 1024;         // 1 Kbyte

	          // form field의 데이터를 저장할 변수
	          String title = "";
	          String content = "";
	          String bbsType = "";

	          int count= 0; 
	          
	          // file명 저장
	          String profileImg = "";

	          boolean isMultipart = ServletFileUpload.isMultipartContent(req);   //멀티파트 여부 확인
	          
	          if(isMultipart == true){   //멀티파트 form이라면
	             
	             // FileItem 생성
	             DiskFileItemFactory factory = new DiskFileItemFactory();   //업로드 파일 보관하는 FileItem의 팩토리 설정
	             
	             factory.setSizeThreshold(yourMaxMemorySize);   //임시파일 한계 크기 설정
	             factory.setRepository(new File(yourTempDir));   //업로드된 파일 저장 위치
	             
	             ServletFileUpload upload = new ServletFileUpload(factory);   //업로드 요청 처리하는 팩토리 생성
	             upload.setSizeMax(yourMaxRequestSize);   // 업로드 파일 최대사이즈
	             
	             try {
	                List<FileItem> items = upload.parseRequest(req);   //아이템 추출
	                Iterator<FileItem> it = items.iterator();
	                
	                while(it.hasNext()){
	                   
	                   FileItem item = it.next();
	                   
	                   if(item.isFormField()) {   // id, title, content
	                      if(item.getFieldName().equals("title")){
	                         title = item.getString("utf-8");
	                      }
	                      else if(item.getFieldName().equals("content")){
	                         content = item.getString("utf-8");
	                      }    
	                      else if(item.getFieldName().equals("bbsType")){
	                    	  bbsType = item.getString("utf-8");
	                      }    
	                   }
	                   else {   // file
	                      System.out.println(item.getName());
	             
	                      long file_size = item.getSize();
	                      if(file_size != 0) {
	                         if(item.getFieldName().equals("profileImg")){            
	                            // 확장자 명
	                            try {
	                               String fileName = item.getName();   //파일 제목
	                               int lastInNum = fileName.lastIndexOf(".");
	                               String exName = fileName.substring(lastInNum); //확장자 구함
	                               
	                               // 새로운 파일명
	                               String newfilename = (new Date().getTime()) + "";
	                               newfilename = newfilename + exName;
	                               System.out.println(newfilename);
	                                           
	                               profileImg = processUploadFile(item, newfilename, fupload);
	                            } catch (Exception e) {
	                               System.out.println("Exception : 프로필 사진 첨부 안했을 때");
	                               e.printStackTrace();
	                            }
	                         }
	                      }
	                      else {
	                         System.out.println("파일 첨부 되지 않았음");
	                      }
	                   }      
	                }
	             } 
	             
	             catch (NumberFormatException | FileUploadException | IOException e) {
	                System.out.println("Exception : 입력 안된 값은 \"\" 또는 0으로 대체");
	                e.printStackTrace();
	             }   
	             
	          }
	          
	          
	        //memLevel은 0으로 세팅.
	          //선택사항 입력 안하면 0으로 처리 
	          
	          
	          BbsDto bbs = new BbsDto(memberId, title, content, profileImg, null, Integer.parseInt(bbsType));
	          
	          
	          boolean b = dao.writeBbs(bbs);
	          
	          if(b) 
	      		resp.sendRedirect("bbs?param=goPage&bbsType=2");
	          else
	        	System.out.println("글작성 실패");	  
	          
	    }
	    
	    
	    /* 바디프로필 수정 버튼 클릭 */
	    else if(param.equals("bodyProfileUpdateAf")) {   
	          System.out.println("BbsController bodyProfileUpdateAf");
	          String seq = req.getParameter("seq");
	          String memberId = mem.getMemberID();
	          String fupload = req.getServletContext().getRealPath("/upload");   //저장경로 설정
	          System.out.println("업로드 폴더:" + fupload);

	          String yourTempDir = fupload;

	          int yourMaxRequestSize = 100 * 1024 * 1024;   // 1 Mbyte
	          int yourMaxMemorySize = 100 * 1024;         // 1 Kbyte

	          // form field의 데이터를 저장할 변수
	          String title = "";
	          String content = "";
	          String bbsType = "";

	          int count= 0; 
	          
	          // file명 저장
	          String profileImg = "";

	          boolean isMultipart = ServletFileUpload.isMultipartContent(req);   //멀티파트 여부 확인
	          
	          if(isMultipart == true){   //멀티파트 form이라면
	             
	             // FileItem 생성
	             DiskFileItemFactory factory = new DiskFileItemFactory();   //업로드 파일 보관하는 FileItem의 팩토리 설정
	             
	             factory.setSizeThreshold(yourMaxMemorySize);   //임시파일 한계 크기 설정
	             factory.setRepository(new File(yourTempDir));   //업로드된 파일 저장 위치
	             
	             ServletFileUpload upload = new ServletFileUpload(factory);   //업로드 요청 처리하는 팩토리 생성
	             upload.setSizeMax(yourMaxRequestSize);   // 업로드 파일 최대사이즈
	             
	             try {
	                List<FileItem> items = upload.parseRequest(req);   //아이템 추출
	                Iterator<FileItem> it = items.iterator();
	                
	                while(it.hasNext()){
	                   
	                   FileItem item = it.next();
	                   
	                   if(item.isFormField()) {   // id, title, content
	                      if(item.getFieldName().equals("title")){
	                         title = item.getString("utf-8");
	                      }
	                      else if(item.getFieldName().equals("content")){
	                         content = item.getString("utf-8");
	                      }    
	                      else if(item.getFieldName().equals("bbsType")){
	                    	  bbsType = item.getString("utf-8");
	                      }    
	                   }
	                   else {   // file
	                      System.out.println(item.getName());
	             
	                      long file_size = item.getSize();
	                      if(file_size != 0) {
	                         if(item.getFieldName().equals("profileImg")){            
	                            // 확장자 명
	                            try {
	                               String fileName = item.getName();   //파일 제목
	                               int lastInNum = fileName.lastIndexOf(".");
	                               String exName = fileName.substring(lastInNum); //확장자 구함
	                               
	                               // 새로운 파일명
	                               String newfilename = (new Date().getTime()) + "";
	                               newfilename = newfilename + exName;
	                               System.out.println(newfilename);
	                                           
	                               profileImg = processUploadFile(item, newfilename, fupload);
	                            } catch (Exception e) {
	                               System.out.println("Exception : 프로필 사진 첨부 안했을 때");
	                               e.printStackTrace();
	                            }
	                         }
	                      }
	                      else {
	                         System.out.println("파일 첨부 되지 않았음");
	                      }
	                   }      
	                }
	             } 
	             
	             catch (NumberFormatException | FileUploadException | IOException e) {
	                System.out.println("Exception : 입력 안된 값은 \"\" 또는 0으로 대체");
	                e.printStackTrace();
	             }   
	             
	          }
	          
	          
	        //memLevel은 0으로 세팅.
	          //선택사항 입력 안하면 0으로 처리 
	          
	          System.out.println("dao 정보 확인 seq : " +Integer.parseInt(seq)+"title : "+title+"content :  "+ content+ 
	        		  				"profileImg : "+profileImg);
	          
	          
	          boolean b = dao.updateBbs(Integer.parseInt(seq), title, content, profileImg, null, null);
	          
	          if(b) 
	      		resp.sendRedirect("bbs?param=goPage&bbsType=2");
	          else
	        	System.out.println("글수정 실패");	  
	          
	    }
	    
	    
	    else if(param.equals("goChat")) {
	    	System.out.println("BbsController goChat 들어옴");
	    	
	    	
	    	String seq = req.getParameter("seq");
	    	BbsDto bbs = dao.getBbs(Integer.parseInt(seq));
	    	
	    	
	    	out.println("<script>");
	    	out.println("window.open('chat.jsp?tID="+bbs.getMemberId()+"', '', "
	    			+ "'width=550, height=770, resizable=no, scrollbars=no ')");
	    	out.println("</script>");
	    	
	    	
	    	//req.setAttribute("bbs", bbs);
	    	
	    }
	    else if(param.equals("goChatManager")) {
	    	System.out.println("BbsController goChatManager 들어옴");
	    	
	    	forward("trainerChatManager.jsp", req, resp);
	    	
	    }
	    else if(param.equals("homefitFreedomboardList")) {
			String choice = req.getParameter("choice");
			String search = req.getParameter("search");
			System.out.println("searchText:" + search);
			
			String spage = req.getParameter("pageNumber");
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
			System.out.println(choice+","+search+","+page);
			List<BbsDto> list = dao.getBbsPagingList(choice, search, page, 0);
		
			for (BbsDto b : list) {
				System.out.println(b.toString());
			}
						
			req.setAttribute("list", list);			
			
			int len = dao.getAllBbs(choice, search, 0);
			int bbsPage = len / 10;		// 23 -> 2
			if((len % 10) > 0){
				bbsPage = bbsPage + 1;
			}
			
			req.setAttribute("bbsPage", bbsPage + "");
			req.setAttribute("pageNumber", page + "");
			req.setAttribute("choice", choice);
			req.setAttribute("search", search);
			req.setAttribute("len", len+"");
			
			forward("homefitFreedomboardList.jsp", req, resp);			
		}	
		else if(param.equals("homefitFreedombbswrite")) {
			resp.sendRedirect("fileupload?param=homefitFreedombbswrite");
		}
	
		else if(param.equals("homefitFreedombbsdetail")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			dao.readcount(seq);		// 조회수 늘리기
			
			BbsDto dto = dao.getBbs(seq);
			
			
			
			req.setAttribute("bbs", dto);
			
			
			
			forward("homefitFreedombbsdetail.jsp", req, resp);
		}
		else if(param.equals("homefitFreedombbsupdate")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq.trim());

			BbsDto dto = dao.getBbs(seq);
			
			req.setAttribute("bbs", dto);
			
			forward("homefitFreedombbsupdate.jsp", req, resp);
		}else if(param.equals("freedombbsupdateAf")) {
			
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq.trim());

			String title = req.getParameter("title");
			String content = req.getParameter("content");
			String division = req.getParameter("division");
			String img = req.getParameter("img");
			String newfilename = req.getParameter("newfilename");

			boolean isS = dao.updateBbs(seq, title, content, division, img, newfilename);			
			if(!isS) {
				resp.sendRedirect("bbs?param=homefitFreedomboardList.jsp&seq=" + sseq);
			}else {
			resp.sendRedirect("bbs?param=homefitFreedomboardList");
			}
		}	
			
		else if(param.equals("homefitFreedombbsdelete")) {
			int seq = Integer.parseInt( req.getParameter("seq") );
			System.out.println("seq:" + seq);

			dao.deleteBbs(seq);
			
			resp.sendRedirect("bbs?param=homefitFreedomboardList");
		}
		else if(param.equals("homefitFreedomanswer")) {
			int seq = Integer.parseInt( req.getParameter("seq") );
			BbsDto dto = BbsDao.getInstance().getBbs(seq);
			
			req.setAttribute("bbs", dto);
			
			forward("homefitFreedomanswer.jsp", req, resp);
		}
		else if(param.equals("freedomanswerAf")) {
			
			
	        String img = req.getParameter("img");
	        System.out.println("img:" + img);
	        int bbsType = Integer.parseInt(req.getParameter("bbsType"));
	        System.out.println("bbsType:" + bbsType);
			
			
			
			int seq = Integer.parseInt( req.getParameter("seq") );
			String id = req.getParameter("id");
			String division = req.getParameter("division");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			if(title.equals("") || content.equals("")) {
				req.setAttribute("answer", "n");
				resp.sendRedirect("bbs?param=homefitFreedomanswer&seq=" + seq);
			}
			
			
			else {
				boolean isS = dao.answer(seq, new BbsDto(id, title, content, img, division, bbsType));
				if(!isS){
					resp.sendRedirect("bbs?param=homefitFreedomanswer&seq=" + seq);
				}
				resp.sendRedirect("bbs?param=homefitFreedomboardList");
			}

		}
	    
  		
  		else if(param.equals("likes")) {
  	
  			int seq = Integer.parseInt( req.getParameter("seq") );
  			dao.likecount(seq);
  			int likeCount = dao.getLikeCount(seq);
  			
  			JSONObject jObj = new JSONObject();
  			jObj.put("like", likeCount);
  			resp.setContentType("application/x-json; charset=UTF-8");
  			resp.getWriter().print(jObj);
  			
  		}
	    
	    
	}
	
	
	
	//계층형 게시판 Depth와 화살표 image 만들어주는 메소드
	public String arrow(int depth){
		String rs = "<img src='/images/arrow.png' width='20px' height='20px'/>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";	// 여백
		
		String ts = "";
		for(int i = 0;i < depth; i++){
			ts += nbsp;
		}
		
		return depth==0 ? "":ts + rs;	
	}
	
	
	public void forward(String arg, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
	      RequestDispatcher dispatch = req.getRequestDispatcher(arg);
	      dispatch.forward(req, resp);         
	}
	
	
	 // upload 함수
	   public String processUploadFile(FileItem fileItem, String newfilename, String dir)throws IOException{
	
	      String filename = fileItem.getName();   // 경로 + 파일명
	      long sizeInBytes = fileItem.getSize();
	      
	      if(sizeInBytes > 0){   
	         
	         int idx = filename.lastIndexOf("\\"); 
	         if(idx == -1){                     // \가 없으면
	            idx = filename.lastIndexOf("/");   // /로 찾음
	         }
	         
	         filename = filename.substring(idx + 1);   //원본 파일명만 추출
	         File uploadFile = new File(dir, newfilename); // 새로운 파일 명으로 서버에 저장
	      
	         try{   
	            fileItem.write(uploadFile);   // 실제 upload되는 부분
	         }catch(Exception e){
	            e.printStackTrace();
	         }      
	      }
	      return newfilename;   // 새로운 파일 이름으로 반환
	   }

	
	
}
