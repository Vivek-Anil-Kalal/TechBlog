<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<!--this page load after database se data aajaye-->

<div class="row">

    <%
        User user = (User) session.getAttribute("currentUser");

        Thread.sleep(1000);
        PostDao p = new PostDao(ConnectionProvider.getDbConnection());
        List<Post> posts = null;

        int cid = Integer.parseInt(request.getParameter("catid"));
        if (cid == 0) {
            posts = p.getAllPost();
        } else {
            posts = p.getPostByCatId(cid);
        }

        // if no posts are there
        if (posts.size() == 0) {
            out.println("<h3 class='display-3 text-center'>No Post in This Category...</h3>");
        } else {

            for (Post post : posts) {

    %>

    <div class="col-md-6 mt-2 d-flex align-items-stretch" >
        <div class="card">
            <img class="card-img-top" src="blog_posts/<%= post.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <b><%= post.getpTitle()%></b>
                <p> <%= post.getpContent()%></p>
            </div>
            <%
                LikeDao ld = new LikeDao(ConnectionProvider.getDbConnection());
            %>
            <div class="card-footer text-center primary-background">
                <a href="#" onclick="doLike(<%= post.getpId()%>, <%= user.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"> <span id="<%=post.getpId()%>"><%= ld.countLikeOnPost(post.getpId())%></span></i></a> 
                <!-- url rewriting k through post id bheji taki dusre page par vo fetch kar ske aur fir vo post dikha ske database ko
                query karke --> 
                <a href="show_blog_page.jsp?post_id=<%= post.getpId()%>" class="btn btn-outline-light btn-sm">Read more..</a> 
                <a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"> <span>10</span></i></a> 
            </div>
        </div>
    </div>

    <%
            }
        }

    %>
</div>