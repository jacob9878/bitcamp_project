package controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.BbsDao;
import dto.BbsDto;




public class FileUploadController extends HttpServlet {
	  ServletConfig mConfig = null;
		
	  
	  
	@Override
	public void init(ServletConfig config) throws ServletException {
	      mConfig = config;
	}
		
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String param = req.getParameter("param");
		
		if(param.equals("homefitFreedombbswrite")) {
			resp.sendRedirect("homefitFreedombbswrite.jsp");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("아오");
			
		// 지정 폴더 - client
		//String fupload = "d:\\tmp";
		// tomcat 배포 - server
		String fupload = mConfig.getServletContext().getRealPath("/upload");		
		System.out.println("업로드 폴더:" + fupload);

		String yourTempDir = fupload;

		int yourMaxRequestSize = 100 * 1024 * 1024;	// 1 Mbyte
		int yourMaxMemorySize = 100 * 1024;			// 1 Kbyte
		//form field의 데이터를 저장할 변수
		String memberID = "";
		String title = "";
		String content = "";
		String division ="";
		String img ="";
		String newfilename ="";
						
		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		if(isMultipart == true){
			
			// FileItem 생성
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			factory.setSizeThreshold(yourMaxMemorySize);
			factory.setRepository(new File(yourTempDir));
			
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(yourMaxRequestSize);
	
			
			List<FileItem> items = null;
			
			try {
				items = upload.parseRequest(req);
			} catch (FileUploadException e) {				
				e.printStackTrace();
			}
			Iterator<FileItem> it = items.iterator();
		
	    //	list에 정보 저장후 꺼내기
	    //     List<FileItem> items = null;
	    // 	 Iterator<FileItem> it = items.iterator();
	        
	     	 while(it.hasNext()){	     		
	     		FileItem item = it.next();
	     		
	     		if(item.isFormField()){	// id, title, content
	     			if(item.getFieldName().equals("memberid")){
	     				memberID = item.getString("utf-8");
	     			}else if(item.getFieldName().equals("division")){
	     				division = item.getString("utf-8");			
	     			}else if(item.getFieldName().equals("title")){
	     				title = item.getString("utf-8");
	     			}else if(item.getFieldName().equals("content")){
	     				content = item.getString("utf-8");
	     			}
	     		}
	     		else{	// file
	     			
	     			if(item.getFieldName().equals("fileload")){				
	     				// 확장자 명
	     				if(item.getName() != null && !item.getName().equals("")) {
		     				String fileName = item.getName();
		     				int lastInNum = fileName.lastIndexOf(".");
		     				String exName = fileName.substring(lastInNum);
		     				
		     			// 새로운 파일명
		    				newfilename = (new Date().getTime()) + "";
		    				newfilename = newfilename + exName;
		    				System.out.println(newfilename);
		     				
		     				
		     				img = processUploadFile(item,newfilename, fupload);
		     				System.out.println("아니 왜 안돼는거야??");
	     				}
	     			}
	     		}
	     	 }
		  }	 
	     		
			 BbsDao dao = BbsDao.getInstance();
			 boolean isS = dao.writeBbs(new BbsDto(memberID, title, content, img, newfilename, division));
			 if(isS){
					System.out.println("파일업로드성공");
					resp.sendRedirect("bbs?param=homefitFreedomboardList");
					
			 } else {
				 	System.out.println("파일업로드실패");
				 	resp.sendRedirect("bbs?param=homefitFreedomboardList");	 			
			 }
	}

	// upload 함수
	public String processUploadFile(FileItem fileItem, String newfilename, String dir)throws IOException{

		String img = fileItem.getName();	// 경로 + 파일명
		long sizeInBytes = fileItem.getSize();
		
		if(sizeInBytes > 0){	// 파일이 정상?		// d:\\tmp\\abc.txt d:/tmp/abc.txt 
			
			int idx = img.lastIndexOf("\\"); 
			if(idx == -1){
				idx = img.lastIndexOf("/");
			}
			
			img = img.substring(idx + 1);
			File uploadFile = new File(dir, newfilename);
			//File uploadFile = new File(dir, img); //  파일 명으로
		
			try{	
				fileItem.write(uploadFile);		// 실제 upload되는 부분
			}catch(Exception e){
				e.printStackTrace();
			}		
		}
		return img;	// DB에 저장하기 위한 return;
	}    
	public void forward(String arg, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(arg);
		dispatch.forward(req, resp);			
	}

}

