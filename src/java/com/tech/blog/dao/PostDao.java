package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList();

        try {
            String query = "select * from categories";

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                // ek row ki teeno details niklegi aur in teen variable me jygi 
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String description = rs.getString("description");

                // then ek category ke object me ye teeno values jygi store hongi
                Category c = new Category(cid, name, description);
                // aur finally array list me jygi jisme ek value category type ki hogi
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;        // if no categories will there 0 will be returned 
    }

    public boolean savePost(Post p) {
        boolean f = false;

        try {

            String query = "insert into posts(ptitle , pcontent , pcode , ppic , catid , userid ) values(?,?,?,?,?,?)";

            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());

            pstmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public List<Post> getAllPost() {
        List<Post> list = new ArrayList<>();
        //  fetch all post 
        try {

            String query = "select * from posts order by pid";
            PreparedStatement pstmt = con.prepareStatement(query);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("ptitle");
                String pContent = rs.getString("pcontent");
                String pCode = rs.getString("pcode");
                String pPic = rs.getString("ppic");
                Timestamp date = rs.getTimestamp("pdate");
                int catId = rs.getInt("catid");
                int userId = rs.getInt("userid");

                System.out.println("Pic :- " + pPic);
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Post> getPostByCatId(int catId) {
        List<Post> list = new ArrayList<>();
        //  fetch all post by id 
        // jo category user select karrega use category k post yha show honge

        try {

            String query = "select * from posts where catid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, catId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("ptitle");
                String pContent = rs.getString("pcontent");
                String pCode = rs.getString("pcode");
                String pPic = rs.getString("ppic");
                Timestamp date = rs.getTimestamp("pdate");
                int userId = rs.getInt("userid");

                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Post getPostByPostId(int postId) {
        Post post = null;

        try {
            String query = "select * from posts where pid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setInt(1, postId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("ptitle");
                String pContent = rs.getString("pcontent");
                String pCode = rs.getString("pcode");
                String pPic = rs.getString("ppic");
                Timestamp date = rs.getTimestamp("pdate");
                int userId = rs.getInt("userid");
                int catId = rs.getInt("catid");

                post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return post;
    }

}
