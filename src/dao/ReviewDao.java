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
import dto.ReviewDto;

public class ReviewDao {

	private static ReviewDao dao = new ReviewDao();
	
	public ReviewDao() {
		DBConnection.initConnection();
	}
	
	public static ReviewDao getInstance() {
		return dao;
	}
	
	// 운동리뷰 불러오기
	public List<ReviewDto> exReviewS(int exSeq, int page) {
		
		String sql = " SELECT MEMBERID, EXCOMMENT, RVDATE, RVSEQ "
					+ " FROM ";
		
		sql += " (SELECT ROW_NUMBER()OVER(ORDER BY RVDATE DESC) AS RNUM, " + 
				"	MEMBERID, EXCOMMENT, RVDATE, RVSEQ " + 
				"	FROM REVIEW " + 
				"	WHERE EXSEQ=? " +
				" 	ORDER BY RVDATE DESC) " +
			" WHERE RNUM >=? AND RNUM <=?";
		
		
		int start, end;
		start = 1 + 5 * page; 
		end = 5 + 5 * page;
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ReviewDto> list = new ArrayList<ReviewDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 exReviewS success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, exSeq);
			psmt.setInt(2, start);
			psmt.setInt(3, end);
			System.out.println("2/4 exReviewS success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 exReviewS success");
			
			while(rs.next()) {	
				ReviewDto dto = new ReviewDto(  rs.getString(1), 
												rs.getString(2), 
												rs.getString(3),
												rs.getInt(4)
										);
				list.add(dto);
			}
			System.out.println("4/4 exReviewS success");
		} catch (SQLException e) {
			System.out.println("exReviewS fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
				
	}
	
	
	// 운동리뷰 작성
	public boolean exReviewW(String memId, int exSeq, String exReview) {
		
		String sql = " INSERT INTO REVIEW "
							+ " (MEMBERID, EXSEQ, EXCOMMENT, RVDATE, RVSEQ) "
					+ " VALUES(?, ?, ?, SYSDATE, SEQ_RV.NEXTVAL) ";
			
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0; 
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S exReviewW");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 S exReviewW");
			  
			  psmt.setString(1, memId); 
			  psmt.setInt(2, exSeq); 
			  psmt.setString(3, exReview);
			
			count = psmt.executeUpdate();
			System.out.println("3/3 S exReviewW");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("exReviewW fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
	// 운동리뷰 총 수
	public int allReviewNum(int exSeq) {
		
		String sql = " SELECT COUNT(*) FROM REVIEW "
					+ " WHERE EXSEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		// 올린 글의 총 수
		int len = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 allReviewNum success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, exSeq);
			System.out.println("2/3 allReviewNum success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {  
				len = rs.getInt(1);
			}
			System.out.println("3/3 allReviewNum success");
			
		} catch (SQLException e) {
			System.out.println("allReviewNum fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return len;			
	}
	
	// 운동리뷰 수정 - 즐
	
	// 운동리뷰 삭제
	public boolean deleteRv(int rvSeq) {
		
		String sql = " DELETE FROM REVIEW "
					+ " WHERE RVSEQ=?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbs success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getBbs success");
			
			psmt.setInt(1, rvSeq);
			psmt.executeUpdate();
			
			System.out.println("3/4 getBbs success");
			
		
			System.out.println("4/4 getBbs success");
			
		} catch (SQLException e) {
			System.out.println("getBbs fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return true;
	}
}
