<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>

        <!-- BootStrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">        
        <!-- My CSS -->
        <link rel="stylesheet" href="css/stylesheet.css" />
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 85% 0, 100% 0, 100% 88%, 62% 97%, 33% 97%, 0 89%, 0 0, 19% 0);
            }
        </style>        

    </head>
    <body>

        <%@include file="normal_navbar.jsp" %>
        <!---->
        <main class="primary-background banner-background" style="padding-bottom: 80px" >
            <div class="container d-flex align-items-center pt-3" >
                <div class="col-md-6 offset-md-3">

                    <div class="card">
                        <div class="card-header text-center">
                            <span class="fa fa-3x fa-user-circle-o"></span>
                            <h3>Register Here</h3>
                        </div>
                        <div class="card-body">
                            <form action="RegisterServlet" id="reg-form" method="post">
                                <div class="form-group">
                                    <label for="username">User Name </label>
                                    <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter Username">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                </div>
                                <div class="form-group">
                                    <label for="gender">Select Gender</label>
                                    <br>

                                    <input type="radio" name="gender" id="gender" value="male" > Male
                                    <input type="radio" name="gender" id="gender" value="female"> Female
                                </div>
                                <div class="form-group">
                                    <textarea name="about" class="form-control" rows="5" placeholder="Enter Something about yourself"></textarea>
                                </div>
                                <div class="form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree Terms and Condition</label>
                                </div>
                                <div class="form-group text-center" style="display: none" id="loader">
                                    <span class="fa fa-refresh fa-spin fa-4x"></span>
                                    <br>
                                    <h4> Please Wait...</h4>
                                </div>
                                <button type="submit" class="btn btn-primary" id="submit-btn">Submit</button>
                            </form>
                        </div>
                        <div class="card-footer">

                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!-- < JavaScripts > -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="js/myjs.js" type="text/javascript"></script>
        <!-- Popup k liye cdn --> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
            $(document).ready(function () {
                console.log("Loaded....");

                $('#reg-form').on('submit', function (event) {
                    // this is to stop page fron going to servlet page...
                    event.preventDefault();
                    let form = new FormData(this);  // this refers to form of id reg-form 
                    // this form data object will cotains all information of form and stores in form variable

                    $('#submit-btn').hide();
                    $('#loader').show();

                    // now sending all details to register servlet

                    // create ajax object
                    $.ajax({
                        url: "RegisterServlet",
                        type: "POST",
                        data: form,
                        success: function (data, textStatus, jqXHR) {

                            console.log(data);

                            $('#submit-btn').show();
                            $('#loader').hide();

                            if (data.trim() === "Done") {

                                console.log(data);
                                swal("You are successfully registered...")
                                        .then((value) => {
                                            window.location = "login_page.jsp";
                                        });
                            } else {
                                swal("Error Something went wrong...");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);
                            $('#submit-btn').show();
                            $('#loader').hide();
                            swal("Error Something went wrong... Yes");
                        },
                        processData: false,
                        contentType: false // after making content type false also include annotation

                    });

                });
            });
        </script>


    </body>
</html>
