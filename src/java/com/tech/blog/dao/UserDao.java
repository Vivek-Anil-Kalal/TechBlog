package com.tech.blog.dao;

import com.tech.blog.entities.User;
import java.sql.*;

public class UserDao {

    private Connection con;

    // Dao == Data Access Object
    public UserDao(Connection con) {
        this.con = con;
    }

    // method to insert user to database 
    public boolean saveUser(User user) {

        boolean isUpdated = false;
        try {

            // code to store user in db
            String query = "insert into user(name, email , password , gender , about ) values( ? , ? , ? , ? , ? )";

            PreparedStatement pstmt = this.con.prepareStatement(query);

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            // the will be taken as current date 

            isUpdated = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdated;
    }

    // get user emailid and password at login ...
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;

        try {
            String query = "select * from user where email = ? and password = ?";

            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();

//            This is done when there are multiple rows output but will get only one user   
//            while( rs.next()){
//                user.setName(rs.getString("name"));
//                user.setEmail(rs.getString("email"));
//                user.setPassword(rs.getString("password"));
//                user.setGender(rs.getString("gender"));
//                user.setAbout(rs.getString("about"));
//            }
//        for one user resultset 
            if (rs.next()) {    // means agar ek bhi row h toh data nikal lo sara 
                user = new User();

                user.setName(rs.getString("name"));
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setAbout(rs.getString("about"));
                user.setDatetime(rs.getTimestamp("regdate"));
                user.setProfile(rs.getString("profile"));

            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        // change null to user obj  
        return user;
    }

    public boolean updateUser(User user) {
        boolean f = false;

        try {
            String query = "update user set name=? , email=? , password=? , gender=? , about=? , profile=? where id=?";

            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            pstmt.setString(6, user.getProfile());
            pstmt.setInt(7, user.getId());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    public User getUserByUserId(int userId) {
        User user = null;

        try {
            String query = "select * from user where id=?";

            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);
            
            user = new User();
            ResultSet rs = pstmt.executeQuery();

//            This is done when there are multiple rows output but will get only one user   
            while( rs.next()){
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setAbout(rs.getString("about"));
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return user;
    }

}
