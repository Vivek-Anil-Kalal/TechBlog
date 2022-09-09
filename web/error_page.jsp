<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
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
        <title>Sorry ! Something went wrong</title>
    </head>
    <body>
        <div class="container text-center">
            <img src="img/error.png" class="img-fluid"/>
            <h3 class="display-3">Sorry ! Something went wrong...</h3>
            <%= exception %>
            <br>
            <a href="index.jsp" class="btn primary-background text-white">Go to Home page</a>
        </div>
    </body>
</html>
