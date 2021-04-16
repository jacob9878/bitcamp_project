package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.ExDto;

public class ExDao {

   private static ExDao dao = new ExDao();

   private ExDao() {
      DBConnection.initConnection();
   }
   
   public static ExDao getInstance() {
      return dao;
   }
      
    
   
    public List<ExDto> exTypeSearch(String exType, int exDiff, String exPart , int page) { //s : 뭐로 검색
      //content : 결과
          
         String sql = " SELECT EXNAME, EXPART, EXTYPE, EXDIFF, EXIMG, EXSEQ " 
               + " FROM  ";
         
         sql += "(SELECT ROW_NUMBER()OVER(ORDER BY EXSEQ) AS RNUM, " + 
               "   EXNAME, EXPART, EXTYPE, EXDIFF, EXIMG, EXSEQ " + 
               "   FROM EXERCISE ";
          
         if(exType.equals("없음")&&exDiff==0&&exPart.equals("없음")) {
             sql+= " )"; 
           
         }
         
           else if(exDiff==0&&exPart.equals("없음")) { 
             
              sql+= " WHERE EXTYPE=? )"; 
              } 
           else if(exType.equals("없음")&&exPart.equals("없음")) {
              sql+= " WHERE EXDIFF=? )"; 
              } 
           else if(exType.equals("없음")&&exDiff==0) { 
              sql+=" WHERE EXPART=? )"; }
           
           else if(exType.equals("없음")) { 
             
              sql+= " WHERE EXDIFF=? AND EXPART=? )"; 
              } 
           else if(exDiff==0) {
            
              sql+= " WHERE EXTYPE=? AND EXPART=? )"; 
              }
           else if(exPart.equals("없음")) { 
             
              sql+=" WHERE EXTYPE=? AND EXDIFF=? )"; 
              }
           else if(!exPart.equals("없음")&&exDiff!=0&&!exType.equals("없음")) { 
               
               sql+=" WHERE EXTYPE=? AND EXDIFF=? AND EXPART=? )"; 
               }
         sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";
         
         
         System.out.println(sql);
         
         int start = 1 + 12 * page;
         int end = 12 + 12 * page;      
         
           Connection conn = null; PreparedStatement psmt = null; ResultSet rs = null;
           
           List<ExDto> list = new ArrayList<ExDto>();
           
           
           try {
           
              conn = DBConnection.getConnection(); 
              System.out.println("1/3 exTypeSearch success");
           
              psmt = conn.prepareStatement(sql);
              //System.out.println(sql);
              if(exType.equals("없음")&&exDiff==0&&exPart.equals("없음")) {
                 System.out.println("처음 다 불러오기 쿼리 진행 중/ 처음 페이지 : "+start+","+end);
                 psmt.setInt(1, start);
                   psmt.setInt(2, end);
               }
            
               else if(exDiff==0&&exPart.equals("없음")) { 
                  System.out.println("O,X,X"); 
                  psmt.setString(1, exType); 
                  psmt.setInt(2, start); 
                  psmt.setInt(3, end); 
                  } 
              
               else if(exType.equals("없음")&&exPart.equals("없음")) { 
                  psmt.setInt(1, exDiff);
                  psmt.setInt(2, start); 
                  psmt.setInt(3, end); } 
               else if(exType.equals("없음")&&exDiff==0) { 
                  psmt.setString(1, exPart);
                  psmt.setInt(2, start); 
                  psmt.setInt(3, end); } 
              
               else if(exType.equals("없음")) {  
                  psmt.setInt(1, exDiff); 
                  psmt.setString(2, exPart); 
                  psmt.setInt(3, start);
                  psmt.setInt(4, end); } 
              else if(exDiff==0) { 
                 psmt.setString(1, exType);
                 psmt.setString(2, exPart); 
                 psmt.setInt(3, start); 
                 psmt.setInt(4, end); } 
              
              else if(exPart.equals("없음")) { 
                 psmt.setString(1, exType); 
                 psmt.setInt(2, exDiff);
                 psmt.setInt(3, start); 
                 psmt.setInt(4, end); }
              else if(!exPart.equals("없음")&&exDiff!=0&&!exType.equals("없음")) { 
                 psmt.setString(1, exType); 
                  psmt.setInt(2, exDiff);
                  psmt.setString(3, exPart); 
                  psmt.setInt(4, start); 
                  psmt.setInt(5, end);
                 
                  }
            
               
               
              System.out.println("2/3 exTypeSearch success");
           
              rs = psmt.executeQuery(); 
              System.out.println("3/3 exTypeSearch success");
           
              //DTO : ID, PART, DIFFI, IMG 
              while(rs.next()) { 
                 ExDto dto = new ExDto(        rs.getString(1), 
                                       rs.getString(2), 
                                       rs.getString(3), 
                                       rs.getInt(4), 
                                       rs.getString(5),
                                       rs.getInt(6)
                                         );
                    list.add(dto);
           
           } System.out.println("4/4 exTypeSearch");
           
           } catch (SQLException e) { 
                                System.out.println("exTypeSearch fail");
                                e.printStackTrace(); }
           finally { 
              DBClose.close(conn, psmt, rs); 
              } 
           //System.out.println(list.size());
           return list;
       }
    
   //bbslist 글 총수 
     public int getAllBbs(String exType, int exDiff, String exPart) {
        
        
        String sql = " SELECT COUNT(*) FROM EXERCISE ";
        
        if(exType.equals("없음")&&exDiff==0&&exPart.equals("없음")) {
           System.out.println("#2 처음 글 수 함수");
        }
     
        else if(exDiff==0&&exPart.equals("없음")) {
           System.out.println("dd");
           sql+=  " WHERE EXTYPE=? ";
        }
        else if(exType.equals("없음")&&exPart.equals("없음")) {
           sql+=  " WHERE EXDIFF=? ";
        }
        else if(exType.equals("없음")&&exDiff==0) {
           sql+=  " WHERE EXPART=? ";
        }

        else if(exType.equals("없음")) {
           System.out.println("4");
           sql+=  " WHERE EXDIFF=? AND EXPART=? ";
        }
        else if(exDiff==0) {
           System.out.println("5");
           sql+=  " WHERE EXTYPE=? AND EXPART=? ";
        }
        else if(exPart.equals("없음")) {
           System.out.println("6");
           sql+=  " WHERE EXTYPE=? AND EXDIFF=? ";
        }
        
        
        //System.out.println(sql);
        
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        
        int len = 0; 
        try {
           conn = DBConnection.getConnection();
           System.out.println("1/4 getAllBbs success");
              
           psmt = conn.prepareStatement(sql);
           if(exType.equals("없음")&&exDiff==0&&exPart.equals("없음")) {
              System.out.println("처음 글 수 구하기 쿼리 진행 중");
           }
           else if(exDiff==0&&exPart.equals("없음")) {
               System.out.println("D");
               psmt.setString(1, exType); 
               psmt.setString(1, exType); 
              
           }
           else if(exType.equals("없음")&&exPart.equals("없음")) {
               psmt.setInt(1, exDiff);
               
           }
           else if(exType.equals("없음")&&exDiff==0) {
               psmt.setString(1, exPart); 
              
           }
           else if(exType.equals("없음")) {
               
             psmt.setInt(1, exDiff);
             psmt.setString(2, exPart);
            
           }
           else if(exDiff==0) {
               psmt.setString(1, exType); 
               psmt.setString(2, exPart); 
              
           }
           else if(exPart.equals("없음")) {
               psmt.setString(1, exType); 
               psmt.setInt(2, exDiff);
              
           }
           System.out.println("2/4 getAllBbs success");
           
           rs = psmt.executeQuery();         
           System.out.println("3/4 getAllBbs success");
           
           if(rs.next()) {
              len = rs.getInt(1);
           }         
           System.out.println("4/4 getAllBbs success");
           
        } catch (SQLException e) {   
           System.out.println("getAllBbs fail");
           e.printStackTrace();
        } finally {         
           DBClose.close(conn, psmt, rs);         
        }
        
        return len;
     }
    
     
   
     public boolean addtoRoutine(String memId, String exSeq) {
       
       String sql = " INSERT INTO MYROUTINE(MEMBERID, EXSEQ) "
                   + " VALUES(?, ?) ";
       
       Connection conn = null;
       PreparedStatement psmt = null;
       int count = 0; 
       
       try {
          
            conn = DBConnection.getConnection();
          System.out.println("1/3 S addtoRoutine");   
          
          psmt = conn.prepareStatement(sql);
          psmt.setString(1, memId);
          psmt.setString(2, exSeq);
          System.out.println("2/3 S addtoRoutine");
          
          count = psmt.executeUpdate();
          System.out.println("3/3 S addtoRoutine");
       } catch (SQLException e) {
          e.printStackTrace();
          System.out.println("addtoRoutine fail");
       } finally {
          DBClose.close(conn, psmt, null);
       }
       
       return count>0?true:false;
          
    }
    
   
   // myroutine 중복체크
     public boolean myRoutineCheck(String memId, String exSeq) {
       
       String sql = " SELECT MEMBERID, EXSEQ "
             + " FROM MYROUTINE "
             + " WHERE MEMBERID=? AND EXSEQ=? ";
       
       Connection conn = null;
       PreparedStatement psmt = null;
       ResultSet rs = null;
       
       boolean findRoutine = false;
       
       try {
          conn = DBConnection.getConnection();
          System.out.println("1/3 S myRoutineCheck");
          
          psmt = conn.prepareStatement(sql);
          System.out.println("2/3 S myRoutineCheck");
          
          psmt.setString(1, memId);
          psmt.setString(2, exSeq);
          
          rs = psmt.executeQuery();
          System.out.println("3/3 S myRoutineCheck");
          
          if(rs.next()) {   // 존재
             findRoutine = true;
          }
          
       } catch (SQLException e) {
          e.printStackTrace();
          System.out.println("myRoutineCheck fail");
       } finally {
          DBClose.close(conn, psmt, rs);
       }
       return findRoutine;
    }
    
   
   
  
     public ExDto getEx(int exSeq) {
       
       String sql = " SELECT EXNAME, EXPART, EXTYPE, EXDIFF, EXCONTENT, EXADDRESS, EXIMG, EXLIKE "
                + " FROM EXERCISE "
                + " WHERE EXSEQ=? ";

       Connection conn = null;
       PreparedStatement psmt = null;
       ResultSet rs = null;
       
       ExDto dto = null;
       
       try {
          
            conn = DBConnection.getConnection();
          System.out.println("1/4 getEx success");
       
          psmt = conn.prepareStatement(sql);
          System.out.println("2/4 getEx success");
          
          psmt.setInt(1, exSeq);
          
          rs = psmt.executeQuery();
          System.out.println("3/4 getEx success");
          
          if(rs.next()) {            
          
             dto = new ExDto(   exSeq,
                            rs.getString(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getInt(4),
                            rs.getString(5),
                            rs.getString(6),
                            rs.getString(7),
                            rs.getInt(8)
                         );
          }
          System.out.println("4/4 getEx success");
       } catch (Exception e) {
          System.out.println("getEx fail");
          e.printStackTrace();
       } finally {
          DBClose.close(conn, psmt, rs);         
       }
       return dto;
    }
   
     
     public List<ExDto> getRelatedEx(ExDto exdto) {
       
       String sql = " SELECT EXSEQ, EXNAME, EXPART, EXTYPE, EXDIFF, EXCONTENT, EXADDRESS, EXIMG, EXLIKE "
                + " FROM EXERCISE "
                + " WHERE EXTYPE=? AND EXDIFF=? AND NOT EXSEQ=? ";

       Connection conn = null;
       PreparedStatement psmt = null;
       ResultSet rs = null;
       
       List<ExDto> relist = new ArrayList<ExDto>();
       
       try {
          
            conn = DBConnection.getConnection();
          System.out.println("1/4 getRelatedEx success");
       
          psmt = conn.prepareStatement(sql);
          System.out.println("2/4 getRelatedEx success");
          
          psmt.setString(1, exdto.getExType());
          psmt.setInt(2, exdto.getExDiff());
          psmt.setInt(3, exdto.getExSeq());
          
          rs = psmt.executeQuery();
          System.out.println("3/4 getRelatedEx success");
          
           while(rs.next()) {
                ExDto dto = new ExDto(       rs.getInt(1),
                                  rs.getString(2),
                                  rs.getString(3),
                                  rs.getString(4),
                                  rs.getInt(5),
                                  rs.getString(6),
                                  rs.getString(7),
                                  rs.getString(8),
                                  rs.getInt(9));
                   relist.add(dto);
                   
                   }
          System.out.println("4/4 getRelatedEx success");
       } catch (Exception e) {
          System.out.println("getRelatedEx fail");
          e.printStackTrace();
       } finally {
          DBClose.close(conn, psmt, rs);         
       }
       return relist;
    }
     
     
     public void addlikes(int exSeq) {
       
       String sql = " UPDATE EXERCISE "
                + " SET EXLIKE=EXLIKE+1 "
                + " WHERE EXSEQ=? ";
       
       Connection conn = null;
       PreparedStatement psmt = null;
       
       try {
          conn = DBConnection.getConnection();
          System.out.println("1/3 addlikes success");
          
          psmt = conn.prepareStatement(sql);
          psmt.setInt(1, exSeq);
          System.out.println("2/3 addlikes success");
          
          psmt.executeUpdate();
          System.out.println("3/3 addlikes success");
       } catch (SQLException e) {
          System.out.println("addlikes fail");
          e.printStackTrace();
       } finally {
          DBClose.close(conn, psmt, null);
       }      
    }
     
     //유저 별 exseq 가져오기 
     public int[] exSeqMine(String memId) {
        //몇 개 인지 가져오기 
        int excount =excount(memId); 
       // System.out.println(excount);
        int[] exSeq = new int[excount];
        
         String sql = " SELECT EXSEQ " 
                  + " FROM MYROUTINE "
                  + " WHERE MEMBERID=? ";
        
         System.out.println(sql);
             Connection conn = null;
         PreparedStatement psmt = null;
         ResultSet rs = null;
         int i = 0;
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/3 S getId");
         
         psmt = conn.prepareStatement(sql);
         System.out.println("2/3 S getId");
         
         psmt.setString(1, memId);
         
         rs = psmt.executeQuery();
         System.out.println("3/3 S getId");
         
         while(rs.next()) {   // 존재
             exSeq[i++]= rs.getInt(1);
         }
         
      } catch (SQLException e) {
         e.printStackTrace();
         System.out.println("getId fail");
      } finally {
         DBClose.close(conn, psmt, rs);
      }
      /*
       * for(int j=0; j<exSeq.length;j++) { System.out.println(exSeq[j]); }
       */
      return exSeq;
   }
     
     //갯수 가져오기 
     public int excount(String memId) {
         String sql = " SELECT COUNT(*) " 
                  + " FROM MYROUTINE "
                  + " WHERE MEMBERID=? ";
         
         System.out.println(sql);
            Connection conn = null;
           PreparedStatement psmt = null;
           ResultSet rs = null;
           int count = 0;
        
        try {
           conn = DBConnection.getConnection();
           System.out.println("1/3 S getId");
           
           psmt = conn.prepareStatement(sql);
           System.out.println("2/3 S getId");
           
           psmt.setString(1, memId);
           
           rs = psmt.executeQuery();
           System.out.println("3/3 S getId");
           
           if(rs.next()) {   // 존재
               count= rs.getInt(1);
           }
           
        } catch (SQLException e) {
           e.printStackTrace();
           System.out.println("getId fail");
        } finally {
           DBClose.close(conn, psmt, rs);
        }
        return count;
   }
   
     
     public List<ExDto> exMine( int page, int[] exSeq) { //s : 뭐로 검색
         //content : 결과
           
            String sql = " SELECT EXNAME, EXPART, EXTYPE, EXDIFF, EXIMG, EXSEQ " 
                  + " FROM  ";
            
            sql += "(SELECT ROW_NUMBER()OVER(ORDER BY EXSEQ) AS RNUM, " + 
                  "   EXNAME, EXPART, EXTYPE, EXDIFF, EXIMG, EXSEQ " + 
                  "   FROM EXERCISE"
                  + " WHERE ( ";
              
            
            for(int i=0; i<exSeq.length;i++) {
               sql+=" EXSEQ="+exSeq[i];
               if(i!=exSeq.length-1) {
                  sql+=" OR ";
               }
            }
               sql+= ")) ";
            
                         
            
            sql = sql + " WHERE RNUM >= ? AND RNUM <= ?  ";
            System.out.println(sql);
            
            int start = 1 + 12 * page;
            int end = 12 + 12 * page;      
            
              Connection conn = null; PreparedStatement psmt = null; ResultSet rs = null;
              
              List<ExDto> list = new ArrayList<ExDto>();
              
              
              try {
              
                 conn = DBConnection.getConnection(); 
                 System.out.println("1/3 exMine success");
              
                 psmt = conn.prepareStatement(sql);
                 //System.out.println(sql);
               
                    System.out.println("처음 다 불러오기 쿼리 진행 중/ 처음 페이지 : "+start+","+end);
                    psmt.setInt(1, start);
                      psmt.setInt(2, end);
                 
                  
                 System.out.println("2/3 exTypeSearch success");
              
                 rs = psmt.executeQuery(); 
                 System.out.println("3/3 exTypeSearch success");
              
                 //DTO : ID, PART, DIFFI, IMG 
                 while(rs.next()) { 
                    ExDto dto = new ExDto(rs.getString(1), 
                                          rs.getString(2), 
                                          rs.getString(3), 
                                          rs.getInt(4), 
                                          rs.getString(5),
                                          rs.getInt(6)
                                            );
                       list.add(dto);
              
              } System.out.println("4/4 exTypeSearch");
              
              } catch (SQLException e) { 
                                   System.out.println("exTypeSearch fail");
                                   e.printStackTrace(); }
              finally { 
                 DBClose.close(conn, psmt, rs); 
                 } 
              System.out.println(list.size());
              return list;
          }
     
     
    
    
    public int selectLikes(int exSeq) {
          
       String sql = " SELECT EXLIKE "
             + " FROM EXERCISE "
             + " WHERE EXSEQ=? ";

       Connection conn = null;
       PreparedStatement psmt = null;
       ResultSet rs = null;
       int like=0;
       
       try {
          
            conn = DBConnection.getConnection();
          System.out.println("1/4 selectLikes success");
       
          psmt = conn.prepareStatement(sql);
          System.out.println("2/4 selectLikes success");
          
          psmt.setInt(1, exSeq);
          
          rs = psmt.executeQuery();
          System.out.println("3/4 selectLikes success");
          
          if(rs.next()){
             like = rs.getInt("EXLIKE");
          }
          System.out.println("4/4 selectLikes success");
       } catch (Exception e) {
          System.out.println("selectLikes fail");
          e.printStackTrace();
       } finally {
          DBClose.close(conn, psmt, rs);         
       }
       return like;
    }
    
}