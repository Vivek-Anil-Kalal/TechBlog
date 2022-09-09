package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
    Connection con ;

    public LikeDao(Connection con) {
        this.con = con;
    }
    
    // ye function like hone k bad call hoga jo like table me post id and userid pass karega
    public boolean insertLike(int pid , int uid){
        
        boolean f = false;
        
        try {
            String query = "insert into liked(pid , uid) values(?,?)" ;
            
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);

            // because this is insert query 
            pstmt.executeUpdate();
        
            f = true ;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return f ;
    }
    
    // to count likes on the post 
    public int countLikeOnPost(int pid){
        int count = 0;
        try {
            String query = "select count(*) from liked where pid = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, pid);
            
            ResultSet rs = pst.executeQuery();
            // only one row h isliye sirf if not while 
            if( rs.next()){
//                count = rs.getInt(1); // that means return first row only 
                count = rs.getInt("count(*)"); // that means return first row only 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count ;
    }
    
    // this function will check ki used ne like kiya h ki nhi kiya hoga to dubara like nhi kar skta 
    // if user liked hone k bad bhi like button par click karega toh dislike hojyga
    public boolean isLikedByUser(int pid , int uid){
        boolean f = false;
        try {
            PreparedStatement pst = con.prepareStatement("select * from liked where pid=? and uid=? ");
            pst.setInt(1, pid);
            pst.setInt(2, uid);
            
            ResultSet rs = pst.executeQuery() ;
            // condition true tabhi hogi jab ek bhi row mill jygi means like kiya h if row nhi milegi to false hogi means like nhi kiya h
            if( rs.next() ){
                f = true ;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f ;
    }

    public boolean deleteLike(int pid , int uid ){
        boolean f = false ;
        try {
            PreparedStatement pst = con.prepareStatement("delete * from liked where pid=? and uid=?");
            pst.setInt(1, pid);
            pst.setInt(2, uid);
            
            pst.executeUpdate();
            f =true ;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return f ;
    }
}
