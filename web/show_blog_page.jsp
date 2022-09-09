<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%

    // to validate if user is looged in or not
    User user = (User) session.getAttribute("currentUser");

//    System.out.println("User : " + user);
    // agar koi useer login nhi h aur url box me profile ka url fire hua to ye direct redirect karega login page par
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }

    // get the post id to show then post which is been clicked 
    int postId = Integer.parseInt(request.getParameter("post_id"));

    PostDao d = new PostDao(ConnectionProvider.getDbConnection());
    Post post = d.getPostByPostId(postId);

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= post.getpTitle()%></title>
        <!-- BootStrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">        
        <!-- My CSS -->
        <link rel="stylesheet" href="css/stylesheet.css" />
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            body{
                background: url(img/penwritting.jpg);
                background-size: cover;
                background-attachment: fixed;
            }

            .banner-background{
                clip-path: polygon(50% 0%, 84% 0, 100% 0, 100% 94%, 78% 90%, 50% 100%, 24% 96%, 0 100%, 0 0, 17% 0);                
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;                     
            }
            .post-code{
                font-weight: 100;
                font-size: 25px; 
            }
            .post-user-info{
                font-size: 1.1em ;
            }
            .post-date{
                font-size: 12px;
                font-weight: bold;
                font-style: italic;
            }
            .post-row{
                padding-top: 15px;
                border-bottom: 1px solid black;
                border-top: 1px solid black;
                margin-bottom: 5px;
            }
        </style>

    </head>
    <body>
        <!--Facebook comments plugin-->
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v14.0" nonce="fBKhI5IU"></script>

        <!-- NavBar --> 
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"> <span class="fa fa-cubes"></span> TechBlog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="profile_page.jsp"><span class="fa fa-graduation-cap"></span> Learn with Ayaan<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-lightbulb-o"></span> Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Project Implementation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#"> <span class="fa fa-handshake-o"></span> Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#add-post-modal"> <span class="fa fa-location-arrow"></span> DoPost</a>
                    </li>

                </ul>

                <!--see from upper tags of ul for classes--> 

                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-model" > <span class="fa fa-user-circle-o"></span> <%= user.getName()%></a>
                    </li>                    
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"> <span class="fa fa-share-square-o"></span> Logout</a>
                    </li>                    
                </ul>
            </div>
        </nav>

        <!-- End of Navbar --> 

        <!--Main content of the body-->
        <main>
            <div class="container">
                <div class="row my-4">
                    <div class="col-md-6 offset-md-3">
                        <div class="card">
                            <div class="card-header text-center primary-background text-white">
                                <h4 class="post-title"> <%= post.getpTitle()%> </h4>
                            </div>
                            <div class="card-body">
                                <img class="card-img-top" src="blog_posts/<%= post.getpPic()%>" alt="Card image cap">
                                <br>
                                <br>
                                <div class="row post-row">
                                    <div class="col-md-8">
                                        <%
                                            UserDao ud = new UserDao(ConnectionProvider.getDbConnection());
                                        %>
                                        <p class="post-user-info"> <a href="#"> <%= ud.getUserByUserId(post.getUserId()).getName()%> </a> has posted this blog </p>
                                    </div>
                                    <div class="col-md-4">
                                        <p class="post-date"> <%= post.getpDate().toLocaleString()%> </p>
                                    </div>
                                </div>
                                <p class="post-content"><%= post.getpContent()%></p>
                                <div class="post-code">
                                    <pre><%= post.getpCode()%></pre>
                                </div>
                            </div>


                            <div class="card-footer primary-background text-white">
                                <%
                                    LikeDao ld = new LikeDao(ConnectionProvider.getDbConnection());
                                %>

                                <a href="#" onclick="doLike(<%= post.getpId()%>, <%= user.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"> <span class="like-counter"><%= ld.countLikeOnPost(post.getpId())%></span></i></a> 
                                <a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"> <span>10</span></i></a> 

                            </div>

                                <div class="card-footer">
                                    <div class="fb-comments" data-href="http://localhost:9494/TechBlog/show_blog_page.jsp?post_id=<%= post.getpId() %>" data-width="" data-numposts="5"></div>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
        </main>

        <!--end of main content of the body-->s

        <!-- Modal -->
        <!--yha profile-model id di h to jab data-toggle wle option par click hoga toh ye model visible hoga uske liye login account par 
        data-target likh dena h aur is id ka naam wha dena h --->
        <div class="modal fade " id="profile-model" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius: 50% ; width: 100px" />
                            <br>
                            <h5 class="modal-title" id="exampleModalLabel"><%= user.getName()%></h5>

                            <div id="profile-details">       <!-- Wrap in div for edit option -->
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td scope="row"><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email :</th>
                                            <td scope="row"><%= user.getEmail()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td scope="row"><%= user.getGender()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Status :</th>
                                            <td scope="row"><%= user.getAbout()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Reg. On :</th>
                                            <td scope="row"><%= user.getDatetime().toString()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>


                            <!-- profile edit --> 
                            <div id="profile-edit" style="display:none;">
                                <h3 class="mt-2">Please Edit Carefully</h3>
                                <!--enctype is a attribute which tells that we are sending multiple type of data not only text 
                                i.e image , file etc-->
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>ID :</td>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td>Name :</td>
                                            <td><input type="text" name="user_name" class="form-control" value="<%= user.getName()%>"/></td>
                                        </tr>
                                        <tr>
                                            <td>Email :</td>
                                            <!--Value me email dene se uska pehele ka email ajyga by default text box me user ko sirf edit krna hoga-->
                                            <td><input type="email" name="user_email" class="form-control" value="<%= user.getEmail()%>"/></td>
                                        </tr>
                                        <tr>
                                            <td>Password :</td>
                                            <td><input type="password" name="user_password" class="form-control" value="<%= user.getPassword()%>"/></td>
                                        </tr>
                                        <tr>
                                            <td>About :</td>
                                            <td>
                                                <textarea class="form-control" name="user_about" rows="2">
                                                    <%= user.getAbout()%>
                                                </textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>New Profile:</td>
                                            <td><input type="file" name="image" class="form-control"/></td>
                                        </tr>
                                    </table>
                                    <input type="submit" class="btn btn-outline-success" />
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="close-profile-btn" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- end of demo model -->



        <!--add post modal-->

        <!-- Modal -->
        <!--ab upr jake dopost me data-toggle attribute aur data-target attribute dena hoga--> 
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide Post details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" action="AddPostServlet" method="post">

                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>--- Select Categories ---</option>
                                    <%
                                        PostDao postDao = new PostDao(ConnectionProvider.getDbConnection());
                                        ArrayList<Category> list = postDao.getAllCategories();
                                        for (Category c : list) {
                                    %>
                                    <option value="<%=c.getCid()%>"><%= c.getName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control" />
                            </div>

                            <div class="form-group">
                                <textarea name="pContent" style="height: 150px" placeholder="Enter Your Content" class="form-control"></textarea>
                            </div>

                            <div class="form-group">
                                <textarea name="pCode" style="height: 150px" placeholder="Enter Your Code (if any)" class="form-control"></textarea>
                            </div>

                            <div class="form-group">
                                <label>Select the image</label>
                                <br>
                                <input type="file" name="pic" />
                            </div>

                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--end of add post modal-->




        <!-- < JavaScripts > -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="js/myjs.js" type="text/javascript"></script>
        <!--Sweet alert cdn-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <!--My js to ajax form-->
        <script>
                                    $(document).ready(function () {
                                        let editStatus = false;
                                        $('#edit-profile-btn').click(function () {

                                            if (!(editStatus)) {    // mtlb if edit karna baki h toh details hide hojygi aur edit wla option enable hojyga
                                                $('#profile-details').hide();
                                                $('#profile-edit').show();
                                                editStatus = true;
                                                $(this).html("Back");
                                                $('#close-profile-btn').hide();
                                            } else {
                                                $('#profile-details').show();
                                                $('#profile-edit').hide();
                                                editStatus = false;
                                                $(this).html("Edit");
                                                $('#close-profile-btn').show();
                                            }
                                        });
                                    });
        </script>


        <!--add post js-->
        <script>
            $(document).ready(function () {
                $('#add-post-form').on('submit', function (event) {
                    // this code is called when form is submitted...
                    event.preventDefault();  // is se syncronous behaviour ruk jata h form k submit hone ka
                    console.log("You've click on submit...")
                    let form = new FormData(this);   // this Form object can store information of form...

                    // sending form through ajax ... 
                    // now requesting to server..
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            // jab request successfully accept hojygi 
                            console.log(data);
                            if (data.trim() === 'Done') {
                                swal("Good job!", "Post uploaded Successfully", "success");
                            } else {
                                swal("Error!!", "Something went Wrong", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            /// Jab koi error occur hojygi
                            swal("Error!!", "Something went Wrong", "error");
                        },
                        // jab ye dono chize false hongi tabhi form se images and files transfer or send hongi else nhi hogi
                        //                    content type batata h ki kis type me apko data bhejna h json k form me ya koi aur 
                        processData: false,
                        contentType: false

                    });
                });
            });
        </script>

    </body>
</html>
