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
import dto.MemberDto;
import dto.TrainerDto;

public class BbsDao {
	
private static BbsDao dao = new BbsDao();
	
	private BbsDao() {
	}
	
	public static BbsDao getInstance() {
		return dao;
	}
	
	
	public boolean writeBbs(BbsDto dto) {
		
		String sql = " INSERT INTO BBS "
					+ " (SEQ, MEMBERID, REF, STEP, DEPTH, "
					+ " TITLE, CONTENT, WDATE, "
					+ " DEL, READCOUNT, LIKECOUNT, IMG, NEWFILENAME, DIVISION, BBSTYPE) "
					+ " VALUES( SEQ_BBS.NEXTVAL, ?, "
							+ "	(SELECT NVL(MAX(REF), 0)+1 FROM BBS), 0, 0, "
							+ " ?, ?, SYSDATE, "
							+ " 0, 0, 0, ?, ?, ?, ?) "; 
		
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
			psmt.setString(5, dto.getNewfilename());
			psmt.setString(6, dto.getDivision());
			psmt.setInt(7, dto.getBbstype());
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
					+ " DEL, READCOUNT, LIKECOUNT, IMG, NEWFILENAME, DIVISION, BBSTYPE "
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
						rs.getString(14),
						rs.getInt(15));
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
			System.out.println("1/3 likecount success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 likecount success");
			
			psmt.executeUpdate();
			System.out.println("3/3 likecount success");
			
		} catch (SQLException e) {
			System.out.println("likecount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}				
	}
	
	
	public int getLikeCount(int seq) {
		String sql = " SELECT LIKECOUNT "
				+ " FROM BBS "
				+ " WHERE SEQ=? ";
		

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int likeCount = -1;	//없는 글이면 -1로 반환하게
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getLikeCount success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 getLikeCount success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				likeCount = rs.getInt(1);
			}
			System.out.println("3/3 getLikeCount success");
			
		} catch (SQLException e) {
			System.out.println("getLikeCount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
		
		return likeCount;
		
	}
	
	
	public boolean updateBbs(int seq, String title, String content, String img,String newFilename,String division ) {
		String sql = " UPDATE BBS SET "
				+ " TITLE=?, CONTENT=? ";
				
		if(img != null && !img.equals("")) {
			sql += " , IMG='"+img+"' ";
		}
		if(newFilename !=null && !newFilename.equals("")) {
			sql += ", NEWFILENAME='"+newFilename+"'";
		}
		if(division != null && !division.equals("")) {
			sql += " , DIVISION='"+division+"'  ";
		}
		
		sql += " WHERE SEQ=? ";
				
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
						+ " (MEMBERID, SEQ, "
						+ " REF, STEP, DEPTH, "
						+ " TITLE, CONTENT, WDATE, DEL, READCOUNT, "
						+ " LIKECOUNT, IMG, DIVISION, BBSTYPE) "
						+ " VALUES(?, SEQ_BBS.NEXTVAL, "
						+ "        (SELECT REF FROM BBS WHERE SEQ=?), "	// REF
						+ "			(SELECT STEP FROM BBS WHERE SEQ=?) + 1, " // STEP
						+ "         (SELECT DEPTH FROM BBS WHERE SEQ=?) + 1, " // DEPTH
						+ "         ?, ?, SYSDATE, 0, 0, 0, NULL, ?, ?) ";     
		
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
			psmt.setInt(8, bbs.getBbstype());
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
	

	public List<BbsDto> getBbsPagingList(String choice, String search, int page, int bbstype) {
		
		System.out.println("선택 : " +choice);
		System.out.println("검색어 : " +search);
		System.out.println("페이지번호 : " +page);
		System.out.println("게시판고유번호(bbstype) : " +bbstype);
	
	
	
		String sql = " SELECT B. MEMBERID, B.SEQ, B.REF, B.STEP,B. DEPTH, "
					+ "  B.TITLE, B.CONTENT, B.WDATE, B.DEL, B.READCOUNT, B.LIKECOUNT, "
					+ " B.IMG, B.DIVISION, B.BBSTYPE, M.MEMLEVEL "
					+ " FROM ";
		
		sql += "(SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, " + 
				" MEMBERID, SEQ, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT, "
				+ " LIKECOUNT, IMG, DIVISION, BBSTYPE " 
				+ "	FROM BBS "
				+ " WHERE DEL=0 AND BBSTYPE=? ";
		
				System.out.println(sql);
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
		
		if(bbstype == 2) {
			start = 1 + 8 * page;
			end = 8 + 8 * page;		
		} else {
			start = 1 + 10 * page;
			end = 10 + 10 * page;		
		}
		
		System.out.println("start : "+start +" / end : "+end);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsPagingList success");
			System.out.println(sql);
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bbstype);
			psmt.setInt(2, start);
			psmt.setInt(3, end);
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
						rs.getInt(15));
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

	public int getAllBbs(String choice, String search, int bbsType) {
		String sql = " SELECT COUNT(*) FROM BBS "
				   + " WHERE BBSTYPE=? ";
		
		String sWord = "";
		if(choice.equals("title")) {
			sWord = " AND TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) {
			sWord = " AND CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("writer")) {
			sWord = " AND MEMBERID='" + search + "'";
		} 
		sql = sql + sWord;
		sql += " AND DEL = 0 ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int len = 0;
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllBbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bbsType);
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
	
	
	/* 시퀀스 번호로 게시판타입 찾기 (0~4) */
	public int getBbsType(int seq) {
		String sql = " SELECT BBSTYPE "
				+ 	 " FROM BBS "
				+ 	 " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int bbsType = -1;	//없는 글이면 -1로 반환하게
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllBbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 getAllBbs success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				bbsType = rs.getInt(1);
			}
			System.out.println("3/3 getAllBbs success");
			
		} catch (SQLException e) {
			System.out.println("getAllBbs fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
		
		
		return bbsType;
		
		
	}
	
	
	public boolean writeTrainerBbs(String memberID, TrainerDto dto) {
		
		
		String sql = " INSERT INTO TRAINER "
				+ " (SEQ, PRICE1, PRICE10, PRICE30, GYMLOC, INSTALINK, FACELINK) "
				+ " VALUES(( "
				+ "	SELECT SEQ "
				+ "	FROM (SELECT * FROM BBS ORDER BY WDATE DESC) "
				+ "	WHERE ROWNUM = 1 AND MEMBERID = ?) "
				+ " ,?, ?, ?, ?, ?, ?) ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 writeTrainerBbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, memberID);
			psmt.setInt(2, dto.getPrice1());
			psmt.setInt(3, dto.getPrice10());
			psmt.setInt(4, dto.getPrice30());
			psmt.setString(5, dto.getGymLocation());
			psmt.setString(6, dto.getInstaLink());
			psmt.setString(7, dto.getFaceLink());
			System.out.println("2/3 writeTrainerBbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 writeTrainerBbs success");			
			
		} catch (Exception e) {
			System.out.println("writeTrainerBbs fail");	
			e.printStackTrace();
		} finally {
			
			DBClose.close(conn, psmt, null);			
		}
		return count>0?true:false;
	}
	
	
	public TrainerDto getTrainerBbs(int seq) {
		String sql =  " SELECT PRICE1, PRICE10, PRICE30, GYMLOC, INSTALINK, FACELINK "
					+ " FROM TRAINER "
					+ " WHERE SEQ=? ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		TrainerDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getTrainerBbs success");
		
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getTrainerBbs success");
			
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getTrainerBbs success");
			
			if(rs.next()) {				
				 	dto = new TrainerDto(
				 		rs.getInt(1), 
						rs.getInt(2), 
						rs.getInt(3), 
						rs.getString(4), 
						rs.getString(5), 
						rs.getString(6)
				 		);
			}
			System.out.println("4/4 getTrainerBbs success");
			
		} catch (Exception e) {
			System.out.println("getTrainerBbs fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
		return dto;
	}
	
	
	/* 다른 사람의 글을 볼 때 해당 글 시퀀스 번호로 작성자의 회원 정보를 가져옴 */
	public MemberDto getWriterProfile(int seq) {
		String sql =  " SELECT M.MEMBERID, EMAIL, NAME, PHONENUM, GENDER, TRAINERID, PROFILEIMG, AGE, " + 
					  "	HEIGHT, GWEIGHT, MEMLEVEL, MEMTYPE, GYMNAME, TRAINERCONTENT, WEIGHT, COUNT " + 
					  " FROM MEMBER M, BBS B " + 
					  " WHERE M.MEMBERID = B.MEMBERID " + 
					  "	AND B.SEQ = ? ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getWriterProfile success");
		
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getWriterProfile success");
			
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getWriterProfile success");
			
			if(rs.next()) {				
				 	dto = new MemberDto(
				 		rs.getString(1), 
						null, 
						rs.getString(2), 
						rs.getString(3), 
						rs.getString(4), 
						rs.getString(5), 
						rs.getString(6), 
						rs.getString(7),
						rs.getInt(8), 
						rs.getDouble(9),
						rs.getDouble(10),
						rs.getInt(11),
						rs.getInt(12),
						rs.getString(13),
						rs.getString(14),
						rs.getDouble(15),
						rs.getInt(16)
				 		);
			}
			System.out.println("4/4 getWriterProfile success");
			
		} catch (Exception e) {
			System.out.println("getWriterProfile fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
		return dto;
	}
	
	
	
	/* 관리자가 트레이너 신청서를 수락하면 트레이너 소개글로 이동 ( 4-->3 ) */
	public boolean acceptTrainer(int seq) {
		
		String sql = " UPDATE BBS " + 
					 " SET BBSTYPE = 3 " + 
					 " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S acceptTrainer");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 S acceptTrainer");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 S acceptTrainer");
			
		} catch (Exception e) {		
			System.out.println("fail acceptTrainer");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;
		
	}
	
	
	/* 관리자가 트레이너 신청서를 수락하면 트레이너 인증 계정 전환 (memtype 을 5로 변환) */
	public boolean authTrainer(String id) {
		
		String sql = " UPDATE MEMBER " + 
					 " SET MEMTYPE = 5, "
					 + " MEMLEVEL = 100 " + 
					 " WHERE MEMBERID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S authTrainer");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/3 S authTrainer");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 S authTrainer");
			
		} catch (Exception e) {		
			System.out.println("fail authTrainer");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;
		
	}
	
	
	
	
	
	
	public List<BbsDto> getTrainerBbsPagingList(int page) {
		
	
		System.out.println("페이지번호 : " +page);
	
	
	
		String sql = " SELECT B.MEMBERID, B.SEQ, REF, STEP, DEPTH, "
					+ " TITLE, CONTENT, WDATE, DEL, READCOUNT, LIKECOUNT, "
					+ " IMG, DIVISION, BBSTYPE, M.PROFILEIMG, T.PRICE10  "
					+ " FROM ";
		
		sql += "(SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, " + 
				" MEMBERID, SEQ, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT, "
				+ " LIKECOUNT, IMG, DIVISION, BBSTYPE " 
				+ "	FROM BBS "
				+ " WHERE BBSTYPE=3 "
				+ " ORDER BY REF DESC, STEP ASC) B, MEMBER M, TRAINER T "
				+ " WHERE M.MEMBERID = B.MEMBERID AND B.SEQ = T.SEQ " 
				+ "	AND DEL=0 AND RNUM >= 1 "
				+ " ORDER BY B.SEQ DESC ";
		
		
		
		int end;
		end = 8 + 8 * page;		
		
		System.out.println("end : "+end);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getTrainerBbsPagingList success");
			System.out.println(sql);
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getTrainerBbsPagingList success");
			
			rs = psmt.executeQuery();			
			System.out.println("3/4 getTrainerBbsPagingList success");
			
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
						rs.getString(15),
						rs.getString(16)
						);
				list.add(dto);
			}			
			System.out.println("4/4 getTrainerBbsPagingList success");
			
		} catch (SQLException e) {	
			System.out.println("getTrainerBbsPagingList fail");
			e.printStackTrace();
		} finally {			
			DBClose.close(conn, psmt, rs);			
		}
		
		return list;
	}


}
