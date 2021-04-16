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
import dto.CalendarDto;

public class CalendarDao {
	
	private CalendarDao() {
		
	}
	
	private static CalendarDao dao = new CalendarDao();
	
	public static CalendarDao getInstance() {
		
		return dao;				
	}
	
	public List<CalendarDto> getCalendarList(String id, String yydd){
		
		String sql = " SELECT CALSEQ, MEMBERID, CALTITLE, CALCONTENT, CALWDATE, CALRDATE "
				+ " FROM "
					+ " (SELECT ROW_NUMBER()OVER(PARTITION BY SUBSTR(CALRDATE, 1, 8)ORDER BY CALRDATE ASC) AS RNUM, "
					+ "			CALSEQ, MEMBERID, CALTITLE, CALCONTENT, CALWDATE, CALRDATE "
					+ " FROM EXERCALENDAR "
					+ " WHERE MEMBERID=? AND SUBSTR(CALRDATE, 1, 6)=? ) "
				+ " WHERE RNUM BETWEEN 1 AND 5";  
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/4 getCalendarList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yydd);
			System.out.println("2/4 getCalendarList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getCalendarList success");
			
			while(rs.next()) {
				
				CalendarDto dto = new CalendarDto(
													rs.getInt(1), 
													rs.getString(2), 
													rs.getString(3), 
													rs.getString(4), 
													rs.getString(5), 
													rs.getString(6)
																		);
				list.add(dto);												
			}
			
			System.out.println("4/4 getCalendarList success");
						
		} catch (SQLException e) {
			
			System.out.println("getCalendarList fail");
			e.printStackTrace();
			
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
				
	}
	
	public boolean addCalendar(CalendarDto cal) {	
		
		String sql = " INSERT INTO EXERCALENDAR(CALSEQ, MEMBERID, CALTITLE, CALCONTENT, CALWDATE, CALRDATE) "
				+ " VALUES(SEQ_CAL.NEXTVAL, ?, ?, ?, SYSDATE, ?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addCalendar success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, cal.getMemberId());
			psmt.setString(2, cal.getCalTitle());
			psmt.setString(3, cal.getCalContent());
			psmt.setString(4, cal.getCalRdate());
			System.out.println("2/3 addCalendar success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addCalendar success");
			
		} catch (SQLException e) {
			System.out.println("addCalendar fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
				
				
	}
	
	public CalendarDto getDay(int seq) {
		
		String sql = " SELECT CALSEQ, MEMBERID, CALTITLE, CALCONTENT, CALWDATE, CALRDATE "
				+ " FROM EXERCALENDAR "
				+ " WHERE CALSEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		CalendarDto dto = null;
		
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/4 getDay success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getDay success");	
			
			psmt.setInt(1, seq);
			rs = psmt.executeQuery();
			
			System.out.println("3/4 getDay success");	
			
			while(rs.next()) {
				dto = new CalendarDto();
				dto.setCalSeq(rs.getInt(1));
				dto.setMemberId(rs.getString(2));
				dto.setCalTitle(rs.getString(3));
				dto.setCalContent(rs.getString(4));
				dto.setCalWdate(rs.getString(5));
				dto.setCalRdate(rs.getString(6));
			
			}
			System.out.println("4/4 getDay success");	
			
			
		} catch (SQLException e) {
			System.out.println(" getDay fail");	
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
			
	}
	
	public boolean updateCalendar(CalendarDto dto) {	// 수정
		
		String sql = " UPDATE EXERCALENDAR SET "
				+ " CALTITLE=?, CALCONTENT=?, CALWDATE=SYSDATE, CALRDATE=? "
				+ " WHERE CALSEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
						
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/3 updateCalendar success");
						
			psmt = conn.prepareStatement(sql);			
			psmt.setString(1, dto.getCalTitle());
			psmt.setString(2, dto.getCalContent());
			psmt.setString(3, dto.getCalRdate());
			psmt.setInt(4, dto.getCalSeq());
			System.out.println("2/3 updateCalendar success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 updateCalendar success");
						
			
		} catch (SQLException e) {
			System.out.println("updateCalendar fail");	
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
				
	}
	
	public boolean deleteCalendar(int seq) {	// 
		
		String sql = " DELETE FROM EXERCALENDAR "
				+ " WHERE CALSEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteCalendar Success");	
			
			psmt = conn.prepareStatement(sql);			
			psmt.setInt(1, seq);
			System.out.println("2/3 deleteCalendar Success");	
			
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteCalendar Success");	
			
		} catch (SQLException e) {
			System.out.println("deleteCalendar fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
				
	}
	
	public List<CalendarDto> getAllCalendar(String id, String yydd){	
		
		String sql = " SELECT CALSEQ, MEMBERID, CALTITLE, CALCONTENT, "
					+ " CALWDATE, CALRDATE "
					+ " FROM EXERCALENDAR "
					+ " WHERE MEMBERID=? AND SUBSTR(CALRDATE, 1, 8)=? "
					+ " ORDER BY CALRDATE ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
				
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/4 getAllCalendar Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yydd.trim());
			System.out.println("2/4 getAllCalendar Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getAllCalendar Success");
			
			while(rs.next()) {
				
				CalendarDto dto = new CalendarDto();
				
				dto.setCalSeq(rs.getInt(1));
				dto.setMemberId(rs.getString(2));
				dto.setCalTitle(rs.getString(3));
				dto.setCalContent(rs.getString(4));
				dto.setCalWdate(rs.getString(5));
				dto.setCalRdate(rs.getString(6));
				
				list.add(dto);
				
				
			}
			System.out.println("4/4 getAllCalendar Success");
			
		} catch (SQLException e) {
			System.out.println("getAllCalendar fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;		
	}
	
	/*
	 * public List<CalendarDto> getCalSearch(String search) { // 제목으로만 검색
	 * 
	 * String sql =
	 * " SELECT CALSEQ, MEMBERID, CALTITLE, CALCONTENT, CALWDATE, CALRDATE " +
	 * " FROM EXERCALENDAR " + " WHERE CALTITLE LIKE %?% " + " ORDER BY CALRDATE ";
	 * 
	 * Connection conn = null; PreparedStatement psmt = null; ResultSet rs = null;
	 * 
	 * 
	 * 
	 * conn = DBConnection.getConnection();
	 * System.out.println("getCalSearch s 1/4");
	 * 
	 * List<CalendarDto> list = new ArrayList<CalendarDto>();
	 * 
	 * try {
	 * 
	 * psmt = conn.prepareStatement(sql); psmt.setString(1, search);
	 * System.out.println("2/4 s getCalSearch");
	 * 
	 * rs = psmt.executeQuery(); System.out.println("3/4 s getCalSearch");
	 * 
	 * 
	 * while(rs.next()) {
	 * 
	 * CalendarDto dto = new CalendarDto();
	 * 
	 * dto.setCalSeq(rs.getInt(1)); dto.setMemberId(rs.getString(2));
	 * dto.setCalTitle(rs.getString(3)); dto.setCalContent(rs.getString(4));
	 * dto.setCalWdate(rs.getString(5)); dto.setCalRdate(rs.getString(6));
	 * 
	 * list.add(dto); } System.out.println("4/4 s getCalSearch");
	 * 
	 * } catch (SQLException e) { System.out.println("getCalSearch fail");
	 * e.printStackTrace(); }finally { DBClose.close(conn, psmt, rs); }
	 * 
	 * return list; }
	 * 
	 */
	
	
	
	

}

