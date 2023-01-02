<%@page import="java.util.List"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- BootStrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">        
        <!-- My CSS -->
        <link rel="stylesheet" href="css/stylesheet.css" />
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 84% 0, 100% 0, 100% 94%, 78% 90%, 50% 100%, 24% 96%, 0 100%, 0 0, 17% 0);
            }
            body{
                background: linear-gradient(to right, #2980b9, #6dd5fa, #ffffff);
            }
        </style>

        <title>Home</title>
    </head>
    <body>

        <%@include file="normal_navbar.jsp" %>

        <div class="container-fluid p-0 m-0 banner-background">

            <div class="jumbotron bg-dark text-light ">
                <h3 class="display-3">Welcome To TechBlog</h3>
                <p>A programming language is any set of rules that converts strings, or graphical program elements in the case of visual programming languages, to various kinds of machine code output.[citation needed] Programming languages are one kind of computer language, and are used in computer programming to implement algorithms.</p>

                <p>Most programming languages consist of instructions for computers. There are programmable machines that use a set of specific instructions, rather than general programming languages. Since the early 1800s, programs have been used to direct the behavior of machines such as Jacquard looms, music boxes and player pianos.</p>

                <button class="btn btn-outline-light mr-2"> <span class="fa fa-free-code-camp"></span> Start! It's Free</button>
                <a href="login_page.jsp" class="btn btn-outline-light"> <span class="fa fa-user-circle-o fa-spin"></span> Login</a>
            </div>

        </div>

        <!-- Cards -->

        <div class="container">
            <div class="row">
                <%
                    PostDao pdao = new PostDao(ConnectionProvider.getDbConnection());
                    List<Post> list = pdao.getAllPost();

                    for (Post post : list) {

                %>

                <div class="col-md-3 d-flex align-items-stretch">
                    <div class="card mb-3" >
                        <div class="card-header primary-background text-light">
                            <%= post.getpTitle()%>
                        </div>
                        <div class="card-body bg-dark">
                            <img class="card-img-top" src="blog_posts/<%= post.getpPic()%>" alt="Card image cap">
                            <p class="text-light"><%= post.getpContent()%></p>
                        </div>
                        <div class="card-footer text-center primary-background">
                            <a href="show_blog_page.jsp?post_id=<%= post.getpId()%>" class="btn btn-outline-light btn-sm">Read more..</a> 
                            <a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"> <span>10</span></i></a> 
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
