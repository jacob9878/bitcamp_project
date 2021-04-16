package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;

public class QnABbsDao {
	
private static QnABbsDao dao = new QnABbsDao();
	
	private QnABbsDao() {
	}
	
	public static QnABbsDao getInstance() {
		return dao;
	}
	
	public List<BbsDto> getBbsList() {
		
		String sql = " SELECT MEMBERID, SEQ, REF, STEP, DEPTH, "
						+ " TITLE, CONTENT, WDATE, "
						+ " DEL, READCOUNT, LIKECOUNT, IMG, DIVISION, BBSTYPE "
					+ " FROM BBS "
					+ " WHERE BBSTYPE=1 "
					+ " ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsList success");
				
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getBbsList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbsList success");
			
			while(rs.next()) {
				BbsDto dto = new BbsDto(rs.getString(1), 
										rs.getInt(2), 
										rs.getInt(3), 
										rs.getInt(4), 
										rs.getInt(5), 
										rs.getString(6), 
										rs.getString(7), 
										rs.getString(8), 
										rs.getInt(9), 
										rs.getInt(10),
										rs.getInt(11),
										rs.getString(12),
										rs.getString(13),
										rs.getInt(14), 0);
				list.add(dto);
			}			
			System.out.println("4/4 getBbsList success");
			
		} catch (SQLException e) {	
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {			
			DBClose.close(conn, psmt, rs);			
		}
		
		return list;
	}
	
	public boolean writeBbs(BbsDto dto) {
			
			String sql = " INSERT INTO BBS "
						+ " (SEQ, MEMBERID, REF, STEP, DEPTH, "
						+ " TITLE, CONTENT, WDATE, "
						+ " DEL, READCOUNT, LIKECOUNT, IMG, DIVISION, BBSTYPE) "
						+ " VALUES( SEQ_BBS.NEXTVAL, ?, "
								+ "	(SELECT NVL(MAX(REF), 0)+1 FROM BBS), 0, 0, "
								+ " ?, ?, SYSDATE, "
								+ " 0, 0, 0, ?, ?, 1) "; 
			
			Connection conn = null;
			PreparedStatement psmt = null;
			
			int count = 0;
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 writeBbs success");
				
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, dto.getMemberId());
				psmt.setString(2, dto.getTitle());
				psmt.setString(3, dto.getContent());
				psmt.setString(4, dto.getImg());
				psmt.setString(5, dto.getDivision());
				System.out.println("2/3 writeBbs success");
				
				count = psmt.executeUpdate();
				System.out.println("3/3 writeBbs success");			
				
			} catch (Exception e) {
				System.out.println("writeBbs fail");	
				e.printStackTrace();
			} finally {
				
				DBClose.close(conn, psmt, null);			
			}
			return count>0?true:false;
		}

	public BbsDto getBbs(int seq) {
		String sql =  " SELECT MEMBERID, SEQ, REF, STEP, DEPTH, "
					+ " TITLE, CONTENT, WDATE, "
					+ " DEL, READCOUNT, LIKECOUNT, IMG, DIVISION, BBSTYPE "
					+ " FROM BBS "
					+ " WHERE SEQ=? ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbs success");
		
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getBbs success");
			
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbs success");
			
			if(rs.next()) {				
				 	dto = new BbsDto(rs.getString(1), 
						rs.getInt(2), 
						rs.getInt(3), 
						rs.getInt(4), 
						rs.getInt(5), 
						rs.getString(6), 
						rs.getString(7), 
						rs.getString(8), 
						rs.getInt(9), 
						rs.getInt(10),
						rs.getInt(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14), 0);
			}
			System.out.println("4/4 getBbs success");
			
		} catch (Exception e) {
			System.out.println("getBbs fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
		return dto;
	}

	public void readcount(int seq) {
		String sql = " UPDATE BBS "
				+ " SET READCOUNT=READCOUNT+1 "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 readcount success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 readcount success");
			
			psmt.executeUpdate();
			System.out.println("3/3 readcount success");
			
		} catch (SQLException e) {
			System.out.println("readcount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}				
	}
	
	public void likecount(int seq) {
		String sql = " UPDATE BBS "
				+ " SET LIKECOUNT=LIKECOUNT+1 "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 readcount success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 readcount success");
			
			psmt.executeUpdate();
			System.out.println("3/3 readcount success");
			
		} catch (SQLException e) {
			System.out.println("readcount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}				
	}
	
	public boolean updateBbs(int seq, String title, String content) {
		String sql = " UPDATE BBS SET "
				+ " TITLE=?, CONTENT=? "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S updateBbs");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			
			System.out.println("2/3 S updateBbs");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 S updateBbs");
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(conn, psmt, null);			
		}		
		
		return count>0?true:false;
	}
	
	public boolean deleteBbs(int seq) {
			
			String sql = " UPDATE BBS "
						+ " SET DEL=1 "
						+ " WHERE SEQ=? ";
			
			Connection conn = null;
			PreparedStatement psmt = null;
			int count = 0;
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 S deleteBbs");
				
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, seq);
				System.out.println("2/3 S deleteBbs");
				
				count = psmt.executeUpdate();
				System.out.println("3/3 S deleteBbs");
				
			} catch (Exception e) {		
				System.out.println("fail deleteBbs");
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, null);			
			}
			
			return count>0?true:false;
		}
	
	
	public boolean answer(int seq, BbsDto bbs) {
		// update
		String sql1 = " UPDATE BBS "
				+ "	SET STEP=STEP+1 "
				+ " WHERE REF=(SELECT REF FROM BBS WHERE SEQ=? ) "
				+ "		AND STEP>(SELECT STEP FROM BBS WHERE SEQ=? )";		
		
		// insert
		String sql2 = " INSERT INTO BBS "
						+ " (SEQ, MEMBERID, "
						+ " REF, STEP, DEPTH, "
						+ " TITLE, CONTENT, WDATE, DEL, READCOUNT, "
						+ " LIKECOUNT, IMG, DIVISION, BBSTYPE) "
						+ " VALUES(SEQ_BBS.NEXTVAL, ?, "
						+ "        (SELECT REF FROM BBS WHERE SEQ=?), "	// REF
						+ "			(SELECT STEP FROM BBS WHERE SEQ=?) + 1, " // STEP
						+ "         (SELECT DEPTH FROM BBS WHERE SEQ=?) + 1, " // DEPTH
						+ "         ?, ?, SYSDATE, 0, 0, 0, NULL, ?, 1) ";     
		
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();		
			conn.setAutoCommit(false);
			System.out.println("1/6 success answer");
			
			// update
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("2/6 success answer");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 success answer");
			
			// psmt 초기화
			psmt.clearParameters();
			
			// insert
			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, bbs.getMemberId());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, bbs.getTitle());
			psmt.setString(6, bbs.getContent());
			psmt.setString(7, bbs.getDivision());
			System.out.println("4/6 success answer");
			
			count = psmt.executeUpdate();
			System.out.println("5/6 success answer");
			
			conn.commit();
			System.out.println("6/6 success answer");
			
		} catch (SQLException e) {
			System.out.println("answer fail");			
			try {
				conn.rollback();
			} catch (SQLException e1) {				
				e1.printStackTrace();
			}			
			e.printStackTrace();
		} finally {
			
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {				
				e.printStackTrace();
			}			
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;		
	}
	
	public List<BbsDto> getBbsSearchList(String choice, String search) {
			
		String sql = " SELECT MEMBERID, SEQ, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, WDATE, "
				+ " DEL, READCOUNT, LIKECOUNT, IMG, DIVISION, BBSTYPE "
			+ " FROM BBS "
			+ " WHERE BBSTYPE=1 ";
			
			
			String sWord = "";
			if(choice.equals("title")) {
				sWord = " AND REPLACE(TITLE,' ','') LIKE '%" + search + "%' ";
			}else if(choice.equals("content")) {
				sWord = " AND CONTENT LIKE '%" + search + "%' ";
			}else if(choice.equals("writer")) {
				sWord = " AND MEMBERID='" + search + "'";
			} 
			sql = sql + sWord;
			
			sql = sql + " ORDER BY REF DESC, STEP ASC ";
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			List<BbsDto> list = new ArrayList<BbsDto>();
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/4 getBbsSearchList success");
					
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 getBbsSearchList success");
				
				rs = psmt.executeQuery();
				System.out.println("3/4 getBbsSearchList success");
				
				while(rs.next()) {
					BbsDto dto = new BbsDto(rs.getString(1), 
							rs.getInt(2), 
							rs.getInt(3), 
							rs.getInt(4), 
							rs.getInt(5), 
							rs.getString(6), 
							rs.getString(7), 
							rs.getString(8), 
							rs.getInt(9), 
							rs.getInt(10),
							rs.getInt(11),
							rs.getString(12),
							rs.getString(13),
							rs.getInt(14), 0);
					list.add(dto);
				}			
				System.out.println("4/4 getBbsSearchList success");
				
			} catch (SQLException e) {	
				System.out.println("getBbsSearchList fail");
				e.printStackTrace();
			} finally {			
				DBClose.close(conn, psmt, rs);			
			}
			
			return list;
		}
	
public List<BbsDto> getBbsPagingList(String choice, String search, int page) {
		
	String sql = " SELECT B. MEMBERID, B.SEQ, B.REF, B.STEP,B. DEPTH, "
			+ "  B.TITLE, B.CONTENT, B.WDATE, B.DEL, B.READCOUNT, B.LIKECOUNT, "
			+ " B.IMG, B.DIVISION, B.BBSTYPE, M.MEMLEVEL "
			+ " FROM ";
		
		sql += "(SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, " + 
				" MEMBERID, SEQ, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT, "
				+ " LIKECOUNT, IMG, DIVISION, BBSTYPE "
				 + " FROM BBS "
				+ " WHERE DEL = 0 AND BBSTYPE=1 ";
				
		String sWord = "";
		
		if(choice.equals("title")) {
			sWord = " AND TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) {
			sWord = " AND CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("writer")) {
			sWord = " AND MEMBERID='" + search + "'";
		} 
		
		sql = sql + sWord;
		
		sql = sql + " ORDER BY REF DESC, STEP ASC) B, MEMBER M ";
		
		sql = sql + " WHERE  B.MEMBERID = M.MEMBERID AND RNUM >= ? AND RNUM <= ? ";
		
		int start, end;
		start = 1 + 10 * page;
		end = 10 + 10 * page;		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsPagingList success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/4 getBbsPagingList success");
			
			rs = psmt.executeQuery();			
			System.out.println("3/4 getBbsPagingList success");
			
			while(rs.next()) {
				BbsDto dto = new BbsDto(
						rs.getString(1), 
						rs.getInt(2), 
						rs.getInt(3), 
						rs.getInt(4), 
						rs.getInt(5), 
						rs.getString(6), 
						rs.getString(7), 
						rs.getString(8), 
						rs.getInt(9), 
						rs.getInt(10),
						rs.getInt(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14),
						rs.getInt(15)
						);
				list.add(dto);
			}			
			System.out.println("4/4 getBbsPagingList success");
			
		} catch (SQLException e) {	
			System.out.println("getBbsPagingList fail");
			e.printStackTrace();
		} finally {			
			DBClose.close(conn, psmt, rs);			
		}
		
		return list;
	}




	public int getAllBbs(String choice, String search) {
		String sql = " SELECT COUNT(*) FROM BBS "
				+ " WHERE DEL=0 AND BBSTYPE=1 ";
		
		String sWord = "";
		
		if(choice.equals("title")) {
			sWord = " AND TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) {
			sWord = " AND CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("writer")) {
			sWord = " AND MEMBERID='" + search + "'";
		} 
		
		sql = sql + sWord;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int len = 0;
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllBbs success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllBbs success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				len = rs.getInt(1);
			}
			System.out.println("3/3 getAllBbs success");
			
		} catch (SQLException e) {
			System.out.println("getAllBbs fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
		
		return len;
	}
	
	
	//좋아요 업데이트
	   public void update_Like(int seq){
		   
		   String sql = "UPDATE BBS SET LIKECOUNT=LIKECOUNT+1 WHERE SEQ=?";
		   Connection conn = null;
		   PreparedStatement psmt = null;
		   try{
			   
			   conn = DBConnection.getConnection();
			   System.out.println("1/3 update_Like success");
			   psmt = conn.prepareStatement(sql);
			   System.out.println("2/3 update_Like success");
			   psmt.setInt(1,seq);
			   psmt.executeUpdate();
			   System.out.println("3/3 update_Like success");
			   
		   }catch(SQLException e){
			   e.printStackTrace();
		   }finally {
			   DBClose.close(conn, psmt, null);
		   		}  	   
		  }
	   
	
	   
		   //좋아요 개수 찾기
		   public int select_Like(int seq){
			   
			   String sql = "SELECT LIKECOUNT FROM BBS WHERE SEQ=?";
			   Connection conn = null;
			   PreparedStatement psmt = null;
			   ResultSet rs = null;
			   int like=0;
			   
			   try{
			   conn = DBConnection.getConnection();
			   System.out.println("1/3 select_Like success");
			   
			   psmt = conn.prepareStatement(sql);
			   System.out.println("2/3 select_Like success");
			   
			   psmt.setInt(1,seq);			   
			   rs= psmt.executeQuery();
			   
			   if(rs.next()){
				   
			   like = rs.getInt("LIKECOUNT");
			   
			   		}
			   
			   System.out.println("3/3 select_Like success");
			   
			   }catch(SQLException e){
				   e.printStackTrace();
			   }finally {
				   
				   DBClose.close(conn, psmt,rs);
			   }
			   return like;
	   }
	
	
	
	

}
