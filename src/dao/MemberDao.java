package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;

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
   //운동을 다보거나, 로그인 할 떄 올라간다?
   
   
   
   
}