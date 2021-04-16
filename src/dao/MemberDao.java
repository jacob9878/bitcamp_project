package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.DweightDto;
import dto.MemberDto;


public class MemberDao {

   private static MemberDao dao = new MemberDao();
   
   private MemberDao() {
      DBConnection.initConnection();
   }
   
   public static MemberDao getInstance() {
      return dao;
   }
   
   // 회원 추가
   public boolean addMember(MemberDto dto) {
      
      
      String sql = " INSERT INTO MEMBER(MEMBERID, PWD, EMAIL, NAME, PHONENUM, GENDER, "
            + " TRAINERID, PROFILEIMG, AGE, HEIGHT, GWEIGHT, MEMLEVEL, "
            + " MEMTYPE, GYMNAME, TRAINERCONTENT, WEIGHT, COUNT ) "
            + " VALUES(?, ?, ?, ?, ?, ?, "
            + "         ?, ?, ?, ?, ?, ?, "
            + "         ?, ?, ?, ?, ?) ";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      int count = 0; 
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/3 S addMember");   
         
         psmt = conn.prepareStatement(sql);
         System.out.println("2/3 S addMember");
         
         psmt.setString(1, dto.getMemberID());  
         psmt.setString(2, dto.getPwd());
         psmt.setString(3, dto.getEmail());
         psmt.setString(4, dto.getName()); 
         psmt.setString(5, dto.getPhoneNum()); 
         psmt.setString(6, dto.getGender()); 
         
         
         
         psmt.setString(7, dto.getTrainerID());
         psmt.setString(8, dto.getProfileImg());
         psmt.setInt(9, dto.getAge());
         psmt.setDouble(10, dto.getHeight());
         psmt.setDouble(11, dto.getgWeight());
         psmt.setDouble(12, dto.getMemLevel());
         
         psmt.setDouble(13, dto.getMemType());
         psmt.setString(14, dto.getGymName());
         psmt.setString(15, dto.getTrainerContent());
         psmt.setDouble(16, dto.getWeight());
         psmt.setInt(17, dto.getCount());
         
         count = psmt.executeUpdate();
         System.out.println("3/3 S addMember");
      } catch (SQLException e) {
         e.printStackTrace();
         System.out.println("addMember fail");
      } finally {
         DBClose.close(conn, psmt, null);
      }
      
      return count>0?true:false;
      
   }
   
   
   // 로그인확인
   public MemberDto login(String id, String pwd) {
      
      String sql = " SELECT * "
            + " FROM MEMBER "
            + " WHERE MEMBERID=? AND PWD=? ";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      MemberDto mem = null;
      
      try {
         conn = DBConnection.getConnection();
         psmt = conn.prepareStatement(sql);
         System.out.println("1/3 S login");
         
         psmt.setString(1, id);
         psmt.setString(2, pwd);
         
         System.out.println("2/3 S login");
         
         rs = psmt.executeQuery();
         
         if(rs.next()) {
            String memberID = rs.getString(1);
            String email = rs.getString(3);
            String name = rs.getString(4);
            String phoneNum = rs.getString(5);
            String gender = rs.getString(6);
            String trainerID = rs.getString(7);
            String profileImg = rs.getString(8);
            int age = rs.getInt(9);
            double height = rs.getDouble(10);
            double gWeight = rs.getDouble(11);
            int memLevel = rs.getInt(12);
            int memType = rs.getInt(13);
            String gymName = rs.getString(14);
            String trainerContent = rs.getString(15);
            double weight = rs.getDouble(16);
            int count = rs.getInt(17);
            
//         // DTO생성자추가      
            mem = new MemberDto(memberID, pwd, email, name, phoneNum, gender,
            					trainerID, profileImg, age, height, gWeight,
            					memLevel, memType, gymName, trainerContent, weight, count);   
         }
         System.out.println("3/3 login suc");
         
      } catch (Exception e) {
         System.out.println("login fail");
         e.printStackTrace();
      } finally {
         DBClose.close(conn, psmt, rs);         
      }
            
      return mem;
   }
      
   // id중복체크
   public boolean getId(String id) {
      
      String sql = " SELECT MEMBERID "
            + " FROM MEMBER "
            + " WHERE MEMBERID=? ";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      boolean findid = false;
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/3 S getId");
         
         psmt = conn.prepareStatement(sql);
         System.out.println("2/3 S getId");
         
         psmt.setString(1, id.trim());
         
         rs = psmt.executeQuery();
         System.out.println("3/3 S getId");
         
         if(rs.next()) {   // 존재
            findid = true;
         }
         
      } catch (SQLException e) {
         e.printStackTrace();
         System.out.println("getId fail");
      } finally {
         DBClose.close(conn, psmt, rs);
      }
      return findid;
   }
   
   
 //카운트 
 	public int setCountZero(MemberDto dto) {
 		String sql = " SELECT COUNT "
 				  + " WHERE MEMBERID=? ";
 		
 		Connection conn = null;
 		PreparedStatement psmt = null;
 		ResultSet rs = null;
 		int count = 0;
 		System.out.println(sql);
 		try {
 			conn = DBConnection.getConnection();
 			System.out.println("1/3 S setCountZero");
 			
 			psmt = conn.prepareStatement(sql);
 			System.out.println("2/3 S setCountZero");
 			
 			psmt.setString(1, dto.getMemberID());
 		
 			rs = psmt.executeQuery();
 			System.out.println("3/3 S setCountZero");
 			
 			if(rs.next()) {	// 존재
 				count = rs.getInt(1);
 				//findid = true;
 			}
 			
 		} catch (SQLException e) {
 			e.printStackTrace();
 			System.out.println("setCountZero fail");
 		} finally {
 			DBClose.close(conn, psmt, rs);
 		}
 		return count;
 	}
 	
 	
 	//로그인 할 떄 count up
 	public boolean countUp(MemberDto dto, int count) {
 		String sql = " UPDATE MEMBER ";
 				 
 		System.out.println(count);
 		if(count>=20) {
 			sql+= " SET COUNT = 0 "
 					 + " WHERE MEMBERID=?";
 		}
 		else {
 			sql+=  " SET COUNT =( SELECT COUNT+1 "
 								+ " FROM MEMBER "
 								+ " WHERE MEMBERID=?) "
 	  				+ " WHERE MEMBERID=?";
 		}
 		Connection conn = null;
 		PreparedStatement psmt = null;
 		ResultSet rs = null;
 		boolean countck = false;
 		System.out.println(sql);
 		try {
 			conn = DBConnection.getConnection();
 			System.out.println("1/3 S countup");
 			
 			psmt = conn.prepareStatement(sql);
 			System.out.println("2/3 S countup");
 			
 			if(count>=20) {
 				psmt.setString(1, dto.getMemberID());
 			}
 			else {
 				psmt.setString(1, dto.getMemberID());
 				psmt.setString(2, dto.getMemberID());
 			}
 			
 			
 			rs = psmt.executeQuery();
 			System.out.println("3/3 S countup");
 			
 			if(rs.next()) {	// 존재
 				countck = true;
 			}
 			
 		} catch (SQLException e) {
 			e.printStackTrace();
 			System.out.println("countup fail");
 		} finally {
 			DBClose.close(conn, psmt, rs);
 		}
 		return countck;
 	}
 	
 	//레벨 업
 	public boolean leverUp(MemberDto dto) {
 		String sql = " UPDATE MEMBER "
 				  + " SET MEMLEVEL =( SELECT MEMLEVEL+1 "
 				  				+ " FROM MEMBER "
 				  				+ " WHERE MEMBERID=?) "
 				  + " WHERE MEMBERID=? ";
 		Connection conn = null;
 		PreparedStatement psmt = null;
 		ResultSet rs = null;
 		boolean levelck = false;
 		System.out.println(sql);
 		try {
 			conn = DBConnection.getConnection();
 			System.out.println("1/3 S leverUp");
 			
 			psmt = conn.prepareStatement(sql);
 			System.out.println("2/3 S leverUp");
 			
 			psmt.setString(1, dto.getMemberID());
 			psmt.setString(2, dto.getMemberID());
 			
 			rs = psmt.executeQuery();
 			System.out.println("3/3 S leverUp");
 			
 			if(rs.next()) {	// 존재
 				levelck = true;
 			}
 			
 		} catch (SQLException e) {
 			e.printStackTrace();
 			System.out.println("levelup fail");
 		} finally {
 			DBClose.close(conn, psmt, rs);
 		}
 		return levelck;
 	}
 	

 // 일반회원의 체중량입력
    public boolean dailyWeight(String memberId, Double dweight) {
       
       String sql = " MERGE INTO WCHART "
                + "   USING DUAL "
                + " ON (WDATE=TO_CHAR(SYSDATE,'YYYY-MM-DD') AND MEMBERID=?) "
                + " WHEN MATCHED THEN "
                + " UPDATE SET DWEIGHT=? "
                + " WHEN NOT MATCHED THEN "
                + " INSERT(MEMBERID, WDATE, DWEIGHT) "
                + " VALUES(?,TO_CHAR(SYSDATE,'YYYY-MM-DD'),?) ";
                
       
       Connection conn = null;
       PreparedStatement psmt = null;
       int count = 0; 
       
       try {
          
          conn = DBConnection.getConnection();
          System.out.println("1/3 S dailyWeight");
          
          psmt = conn.prepareStatement(sql);
          System.out.println("2/3 S dailyWeight");
          
            psmt.setString(1, memberId); 
            psmt.setDouble(2, dweight);
            psmt.setString(3, memberId);            
            psmt.setDouble(4, dweight);
          
          count = psmt.executeUpdate();
          System.out.println("3/3 S dailyWeight");
          
       } catch (SQLException e) {
          
          e.printStackTrace();
          System.out.println("dailyWeight fail");
          
       } finally {
          DBClose.close(conn, psmt, null);
       }
       return count>0?true:false;
    }
 	
 	
    // 일반회원의 체중량변화 그래프(main-최근15개)
    public List<DweightDto> graph(String memberId) {
       
       String sql = " SELECT MEMBERID, WDATE, DWEIGHT "
                + " FROM ";

       sql += " (SELECT ROW_NUMBER()OVER(ORDER BY WDATE DESC) AS RNUM, " + 
             "   MEMBERID, WDATE, DWEIGHT " + 
             "   FROM WCHART WHERE MEMBERID=? " +
             "   ORDER BY WDATE ASC) " +
             
             " WHERE RNUM <= 15 ";
       
       Connection conn = null;
       PreparedStatement psmt = null;
       ResultSet rs = null;
       
       List<DweightDto> dwlist = new ArrayList<DweightDto>();
       
       try {
       conn = DBConnection.getConnection();
       System.out.println("1/4 S graph");
       
       psmt = conn.prepareStatement(sql);
       psmt.setString(1, memberId);
       System.out.println("2/4 S graph");
       
       rs = psmt.executeQuery();
       System.out.println("3/4 S graph");
       
       while(rs.next()) {   
          DweightDto wdto = new DweightDto(   rs.getString(1),
                                     rs.getString(2).substring(0, 10),
                                     rs.getDouble(3));
          dwlist.add(wdto);
       }
       System.out.println("4/4 S graph");
       } catch (SQLException e) {
       System.out.println("graph fail");
       e.printStackTrace();
       } finally {
       DBClose.close(conn, psmt, rs);
       }
       return dwlist;
       }
 	
 	// 그래프 날짜 검색해서 띄우기
 	public List<DweightDto> searchGraph(String memberId, String wdate) {

 		String sql = " SELECT MEMBERID, WDATE, DWEIGHT "
 					+ " FROM WCHART " 
 					+ " WHERE MEMBERID=? " 
 					+ " AND SUBSTR(WDATE, 1, 5)=?  ";
 		
 		Connection conn = null;
 		PreparedStatement psmt = null;
 		ResultSet rs = null;
 		
 		List<DweightDto> slist = new ArrayList<DweightDto>();
 		
 		try {
 		conn = DBConnection.getConnection();
 		System.out.println("1/4 S searchGraph");
 		
 		psmt = conn.prepareStatement(sql);
 		psmt.setString(1, memberId);
 		psmt.setString(2, wdate);
 		System.out.println("2/4 S searchGraph");
 		
 		rs = psmt.executeQuery();
 		System.out.println("3/4 S searchGraph");
 		
 		while(rs.next()) {	
 			DweightDto wdto = new DweightDto(	rs.getString(1),
 												rs.getString(2).substring(0, 10),
 												rs.getDouble(3));
 			slist.add(wdto);
 		}
 		System.out.println("4/4 S searchGraph");
 		} catch (SQLException e) {
 		System.out.println("searchGraph fail");
 		e.printStackTrace();
 		} finally {
 		DBClose.close(conn, psmt, rs);
 		}
 		return slist;
 	}
 	
 	
 	public MemberDto infoMem(String memId) {
		//System.out.println(memId);
		String sql = " SELECT * "
					+ " FROM MEMBER "
					+ " WHERE MEMBERID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		MemberDto dto=null; 
		System.out.println(sql);
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S infoMem");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 S infoMem");
			
			psmt.setString(1, memId);
		
			rs = psmt.executeQuery();
			System.out.println("3/3 S infoMem");
			
			if(rs.next()) {	// 존재
				dto = new MemberDto(
										rs.getString(1),
										rs.getString(2),
										rs.getString(3),
										rs.getString(4),
										Integer.toString(rs.getInt(5)),
										rs.getString(6),
										rs.getString(7),
										rs.getString(8),
										rs.getInt(9),
										rs.getDouble(10),
										rs.getDouble(11),
										rs.getInt(12),
										rs.getInt(13),
										rs.getString(14),
										rs.getString(15),
										rs.getDouble(16),
										rs.getInt(17)
									);
				
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("infoMem fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return dto;
	}
	
	public boolean updateMem(String memId, String update, String val) {
		
		String sql = " UPDATE MEMBER "
					+ " SET "+update+"= '"+val
					+ "' WHERE MEMBERID='"+memId+"' ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0; 
		
		System.out.println(memId+","+update+","+val);
		System.out.println(sql);
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S updateMem");	
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 S updateMem");
			
			
			count = psmt.executeUpdate();
			System.out.println("3/3 S updateMem");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("updateMem fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
	// 트레이너 매칭
	 	public boolean trainerSet(String id, String trainerID) {
	 		String sql = " UPDATE MEMBER "
	 				   + " SET TRAINERID = ? "
	 				   + " WHERE MEMBERID = ? ";
	 		
	 		Connection conn = null;
	 		PreparedStatement psmt = null;
	 		int count = 0;
	 		
	 		try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 trainerSet success");
					
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, trainerID);
				psmt.setString(2, id);
				System.out.println("2/3 trainerSet success");
				
				count = psmt.executeUpdate();
				System.out.println("3/3 trainerSet success");
				
			} catch (SQLException e) {
				System.out.println("trainerSet fail");
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, null);
			}				
	 		
	 		return count>0?true:false;
	 	}
   
   
   
   
}