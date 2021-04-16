package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import db.DBClose;
import db.DBConnection;

import dto.MemberDto;

public class ManageDao {
	private static ManageDao dao = new ManageDao();
	private ManageDao() {
		DBConnection.initConnection();
	}
	
	public static ManageDao getInstance(){
		return dao;
	}
	
	public List<MemberDto> NmlistNmAll() {
		System.out.println("@1 F 일반 회원 ");
		String sql = " SELECT MEMBERID, NAME, EMAIL, GENDER, TRAINERID, AGE, MEMLEVEL "
					+ " FROM MEMBER "
					+ " WHERE MEMTYPE = 0 ";
		System.out.println(sql);
		
		 Connection conn = null;
	      PreparedStatement psmt = null;
	      ResultSet rs = null;
	      
	      List<MemberDto> list = new ArrayList<MemberDto>();
	      
	      
	      try {
	    	    conn = DBConnection.getConnection();
				System.out.println("1/4 NmlistNmAll");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 NmlistNmAll");
				rs= psmt.executeQuery();
				System.out.println("3/4 NmlistNmAll");


				
			while(rs.next()) {
				MemberDto dto = new MemberDto(  rs.getString(1), 
												rs.getString(2), 
												rs.getString(3),
												rs.getString(4),
												rs.getString(5), 
												rs.getInt(6), 
												rs.getInt(7) 
										 );
				list.add(dto);
				
				}
			System.out.println("4/4 NmlistNmAll");
			
		} catch (SQLException e) {
			System.out.println("NmlistNmAll fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
		
	}
	public List<MemberDto> TmlistTmAll() {
		System.out.println("@2 T 트레이너 회원 ");
		String sql = " SELECT MEMBERID, NAME, EMAIL, GENDER, PROFILEIMG, AGE, MEMTYPE, GYMNAME "
					+ " FROM MEMBER "
					+ " WHERE MEMTYPE = 1 OR MEMTYPE = 5 ";
		System.out.println(sql);
		
		 Connection conn = null;
	      PreparedStatement psmt = null;
	      ResultSet rs = null;
	      
	      List<MemberDto> list = new ArrayList<MemberDto>();
	      
	      
	      try {
	    	    conn = DBConnection.getConnection();
				System.out.println("1/4 listNmAll");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 listNmAll");
				rs= psmt.executeQuery();
				System.out.println("3/4 listNmAll");


				
			while(rs.next()) {
				MemberDto dto = new MemberDto(  rs.getString(1), 
												rs.getString(2), 
												rs.getString(3),
												rs.getString(4),
												rs.getString(5), 
												rs.getInt(6), 
												rs.getInt(7),
												rs.getString(8)
										 );
				list.add(dto);
				
				}
			System.out.println("4/4 listNmAll");
			
		} catch (SQLException e) {
			System.out.println("listNmAll fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
	      //System.out.println(list.size());
		return list;
		
	}
	
	public  int[] countAge(int memType, int memType2) {
		//System.out.println(memType);
		System.out.println("@3  회원 연령");
		String sql = " SELECT AGE "
					+ " FROM MEMBER "
					+ " WHERE MEMTYPE =? ";
		
		if(memType2 !=0) {
			sql += " OR MEMTYPE =?";
		}
		
		System.out.println(sql);
		
		 Connection conn = null;
	      PreparedStatement psmt = null;
	      ResultSet rs = null;
	      
	      ManageDao dao = ManageDao.getInstance();
	      int memCount = dao.countmem(memType,memType2);
	      int[] memAge = new int[memCount];
	      
	      
	      try {
	    	    conn = DBConnection.getConnection();
				System.out.println("1/4 listNmAll");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 listNmAll");
				
				psmt.setInt(1, memType);

				if(memType2 !=0) {
					psmt.setInt(2, memType2);
				}
				rs= psmt.executeQuery();
				System.out.println("3/4 listNmAll");


				int i=0;
				
			while(rs.next()) {
				
				memAge[i++] = rs.getInt(1); 
				
				}
			System.out.println("4/4 listNmAll");
			
		} catch (SQLException e) {
			System.out.println("listNmAll fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return memAge;
	}
	
	public int countmem(int memType, int memType2) {
		System.out.println("@4  회원 수");
		String sql = " SELECT COUNT(*) "
					+ " FROM MEMBER "
					+ " WHERE MEMTYPE =? ";
		

		if(memType2 !=0) {
			sql += " OR MEMTYPE =?";
		}
		
		System.out.println(sql);
		
		 Connection conn = null;
	      PreparedStatement psmt = null;
	      ResultSet rs = null;
	      
	      int memCount = 0;
	      
	      
	      try {
	    	    conn = DBConnection.getConnection();
				System.out.println("1/4 listNmAll");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 listNmAll");
				
				psmt.setInt(1, memType);

				if(memType2 !=0) {
					psmt.setInt(2, memType2);
				}
				rs= psmt.executeQuery();
				System.out.println("3/4 listNmAll");


				int i=0;
				
			if(rs.next()) {
				
				memCount = rs.getInt(1); 
				
				}
			System.out.println("4/4 listNmAll");
			
		} catch (SQLException e) {
			System.out.println("listNmAll fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
	      return memCount;
	}
	
	public int countLikes() {
		String sql = " SELECT SUM(EXLIKE) "
					+ " FROM EXERCISE ";
		System.out.println(sql);
		
		 Connection conn = null;
	      PreparedStatement psmt = null;
	      ResultSet rs = null;
	      
	      int countLikes = 0;
	      
	      
	      try {
	    	    conn = DBConnection.getConnection();
				System.out.println("1/4 listNmAll");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 listNmAll");
				
			
				rs= psmt.executeQuery();
				System.out.println("3/4 listNmAll");


				int i=0;
				
			if(rs.next()) {
				
				countLikes = rs.getInt(1); 
				
				}
			System.out.println("4/4 listNmAll");
			
		} catch (SQLException e) {
			System.out.println("listNmAll fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
	      return countLikes;
				
	}
	
	public int countBbs() {
		String sql = " SELECT COUNT(*) "
					+ " FROM BBS ";
		System.out.println(sql);
		
		 Connection conn = null;
	      PreparedStatement psmt = null;
	      ResultSet rs = null;
	      
	      int countBbs = 0;
	      
	      
	      try {
	    	    conn = DBConnection.getConnection();
				System.out.println("1/4 listNmAll");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 listNmAll");
				
			
				rs= psmt.executeQuery();
				System.out.println("3/4 listNmAll");


				int i=0;
				
			if(rs.next()) {
				
				countBbs = rs.getInt(1); 
				
				}
			System.out.println("4/4 listNmAll");
			
		} catch (SQLException e) {
			System.out.println("listNmAll fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
	      return countBbs;
				
	}
	
	 public HashMap<String, Integer> MbbsCount(int bbsType) {
         
         String sql =   " SELECT COUNT(*), WDATE "
                     + " FROM (SELECT SUBSTR(WDATE,1,5) AS WDATE,  "
                            + " ROW_NUMBER()OVER(ORDER BY WDATE ASC) AS RNUM,"
                            + " BBSTYPE FROM BBS ORDER BY WDATE DESC) "
                      + " WHERE BBSTYPE=? "
                      + " GROUP BY WDATE "
                      + " ORDER BY WDATE ";
         
         Connection conn = null;
         PreparedStatement psmt = null;
         ResultSet rs = null;
         HashMap<String, Integer> clist = new HashMap<String, Integer>();
         
         System.out.println(sql);
         try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 S MbbsCount");
            
            psmt = conn.prepareStatement(sql);
            System.out.println("2/3 S MbbsCount");
             
            psmt.setInt(1, bbsType);
      
            rs = psmt.executeQuery();
            

            while(rs.next()) {
              clist.put(rs.getString(2), rs.getInt(1));
              }

            
            System.out.println("3/3 S MbbsCount");
            
         } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("MbbsCount fail");
         } finally {
            DBClose.close(conn, psmt, rs);
         }
         return clist;
      }
	 
	 
	 public int Ptcount() {
		String sql = " SELECT COUNT(*) "
					+ " FROM MEMBER "
					+ " WHERE TRAINERID IS NOT NULL";
		System.out.println(sql);
		

		 Connection conn = null;
	      PreparedStatement psmt = null;
	      ResultSet rs = null;
	      
	      int Ptcount = 0;
	      
	      
	      try {
	    	    conn = DBConnection.getConnection();
				System.out.println("1/4 Ptcount");
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 Ptcount");
				
			
				rs= psmt.executeQuery();
				System.out.println("3/4 Ptcount");


				int i=0;
				
			if(rs.next()) {
				
				Ptcount = rs.getInt(1); 
				
				}
			System.out.println("4/4 Ptcount");
			
		} catch (SQLException e) {
			System.out.println("Ptcount fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
	      return Ptcount;
	}
  
  
}
