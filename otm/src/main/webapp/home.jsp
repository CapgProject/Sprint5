<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fo" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>MyConnect</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">
	<jsp:include page="include_script.jsp"></jsp:include>
<script type="text/javascript">
$(function(){

	if(${param.error} != null){
		alert(msg);
	}
	
	
	$("#username_error_message").hide();
	$("#password_error_message").hide();
	var error_username = false;
	var error_password = false;

	$("#username").focusout(function(){
		check_username();
	});
	$("#password").focusout(function(){
		check_password();
	});

	function check_username(){
		var username_length = $("#username").val().length;
		if(username_length<5 || username_length>20)	{
			$("#username_error_message").html("Should be 5-20 characters long");
			$("#username_error_message").show();
			error_username = true;
		}
		else{
			$("#username_error_message").hide();	
		}
	}

	function check_password(){
		var pattern =new RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/i);
		if(pattern.test($("#password").val())){
			$("#password_error_message").hide();
		}
		else{
			$("#password_error_message").html("Invalid Password");
			$("#password_error_message").show();
			error_password = true;	
		}
	}

	$("#login").submit(function(){
		error_username = false;
		error_password = false;
		check_username();
		check_password();
		if(error_username == false && error_password == false){
			return true;
		}
		else{
			return false;
		}
	});

	$("#username_error").hide();
	$("#password_error").hide();
	var error_username2 = false;
	var error_password2 = false;

	$("#usernametwo").focusout(function(){
		check_username_register();
	});
	$("#userpassword").focusout(function(){
		check_password_register();
	});

	function check_username_register(){
		var username_length = $("#usernametwo").val().length;
		if(username_length<5 || username_length>20)	{
			$("#username_error").html("Should be 5-20 characters long");
			$("#username_error").show();
			error_username2 = true;
		}
		else{
			$("#username_error").hide();	
		}
	}

	function check_password_register(){
		var pattern =new RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/i);
		if(pattern.test($("#userpassword").val())){
			$("#password_error").hide();
		}
		else{
			$("#password_error").html("Password should contain at least one upper case character, one lower case character, one numeric character, one special character and length should be at least eight characters");
			$("#password_error").show();
			error_password2 = true;	
		}
	}

	$("#register").submit(function(){
		error_username2 = false;
		error_password2 = false;
		check_username_register();
		check_password_register();
		if(error_username2 == false && error_password2 == false){
			return true;
		}
		else{
			return false;
		}
	});
	
});
</script>
<style type="text/css">
.error{
	color: red;
}
</style>
</head>

<body>

  <header id="header">
    <div class="container">

      <div id="logo" class="pull-left" style="width: 100%">

      <nav id="nav-menu-container">
        <ul class="nav-menu">
          <li class="menu-active"><a href="#hero">Home</a></li>
          <li><a href="#about">About Us</a></li>
          <li><a href="#contact">Contact Us</a></li>
        </ul>
        <ul class="nav nav-menu nav-navbar nav-right">
          <li><a class="button" href="" data-toggle="modal" data-target="#LoginForm"><i class="fa fa-sign-in"></i>&nbsp;Login</a></li>          
        </ul>
      </nav>
    </div>
  </header>

  <section id="hero" class = "home">
    <div class="hero-container">
      <h1>Welcome to MyTest</h1><div>${param.error}</div>
      <h2>A platform to manage and give all your exams online</h2>
      <a href="" class="btn-get-started" data-toggle="modal" data-target="#RegisterForm">Register Now</a>
    </div>
  </section><!-- #hero -->

  <main id="main">

    <section id="about">
      <div class="container">
        <div class="row about-container">

          <div class="col-lg-6 content order-lg-1 order-2">
            <h2 class="title">Few Words About Us</h2>
            <p>
              A global leader in consulting, technology services and digital transformation, Capgemini is at the forefront of innovation to address the entire breadth of clients’ opportunities in the evolving world of cloud, digital and platforms.
            </p>

          </div>

          <div class="col-lg-6 background order-lg-2 order-1 wow fadeInRight"></div>
        </div>

      </div>
    </section>


    <section id="contact">
      <div class="container wow fadeInUp">
        <div class="section-header">
          <h3 class="section-title">Contact</h3>
          <p class="section-description">You can get in touch with us in the following ways</p>
        </div>
      </div>

      <div class="container wow fadeInUp mt-5">
        <div class="row justify-content-center">

          <div class="col-lg-3 col-md-4">

            <div class="info">
              <div>
                <i class="fa fa-map-marker"></i>
                <p>CKP<br>Airoli, Navi Mumbai</p>
              </div>

              <div>
                <i class="fa fa-envelope"></i>
                <p>info@example.com</p>
              </div>

              <div>
                <i class="fa fa-phone"></i>
                <p>+91 5589554885</p>
              </div>
            </div>

            <div class="social-links">
              <a href="#" class="twitter"><i class="fa fa-twitter"></i></a>
              <a href="#" class="facebook"><i class="fa fa-facebook"></i></a>
              <a href="#" class="instagram"><i class="fa fa-instagram"></i></a>
              <a href="#" class="google-plus"><i class="fa fa-google-plus"></i></a>
              <a href="#" class="linkedin"><i class="fa fa-linkedin"></i></a>
            </div>

          </div>
        </div>

      </div>
    </section><!-- #contact -->
    <!-- Modal -->
<div class="modal fade" id="LoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <!--Content-->
    <fo:form id="login" action="/" method="post" modelAttribute="user">
    <div class="modal-content form-elegant">
      <!--Header-->
      <div class="modal-header text-center">
        <h3 class="modal-title w-100 dark-grey-text font-weight-bold my-3" id="myModalLabel"><strong>Sign in</strong></h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <!--Body-->
      <div class="modal-body mx-4">
        <!--Body-->
        <div class="md-form mb-5">
          <fo:input id = "username" type="text" path="userName" class="form-control" />
          <label data-error="wrong" data-success="right" for="Form-email1">Your Username</label>
          <span id = "username_error_message" class="error"></span>
        </div>

        <div class="md-form pb-3">
          <fo:input id = "password" type="password" path="userPassword" class="form-control" />
          <label data-error="wrong" data-success="right" for="Form-pass1">Your password</label>
          <span id = "password_error_message" class= "error"></span>
          <p class="font-small blue-text d-flex justify-content-end">Forgot <a href="#" class="blue-text ml-1">
              Password?</a></p>
        </div>

        <div class="text-center mb-3">
          <button type="submit" class="btn blue-gradient btn-block btn-rounded z-depth-1a">Sign in</button>
        </div>
        <p class="font-small dark-grey-text text-right d-flex justify-content-center mb-3 pt-2"> or Sign in
          with:</p>

        <div class="row my-3 d-flex justify-content-center">
          <!--Facebook-->
          <button type="button" class="btn btn-white btn-rounded mr-md-3 z-depth-1a"><i class="fab fa-facebook-f text-center"></i></button>
          <!--Twitter-->
          <button type="button" class="btn btn-white btn-rounded mr-md-3 z-depth-1a"><i class="fab fa-twitter"></i></button>
          <!--Google +-->
          <button type="button" class="btn btn-white btn-rounded z-depth-1a"><i class="fab fa-google-plus-g"></i></button>
        </div>
      </div>
    </div>
    </fo:form>
    <!--/.Content-->
  </div>
</div>
<!-- Modal -->

<div class="modal fade" id="RegisterForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <!--Content-->
    <fo:form id = "register" action="addusersubmit" method="post" modelAttribute="user">
    <div class="modal-content form-elegant">
      <!--Header-->
      <div class="modal-header text-center">
        <h3 class="modal-title w-100 dark-grey-text font-weight-bold my-3" id="myModalLabel"><strong>Register</strong></h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <!--Body-->
      <div class="modal-body mx-4">
        <!--Body-->
        <div class="md-form mb-5">
          <fo:input id="usernametwo" type="text" path="userName" class="form-control" />
          <label data-error="wrong" data-success="right" for="Form-email1">Your Username</label>
          <span id = "username_error" class= "error"></span>
        </div>

        <div class="md-form pb-3">
          <fo:input id="userpassword" type="password" path="userPassword" class="form-control" />
          <label data-error="wrong" data-success="right" for="Form-pass1">Your password</label>
          <span id = "password_error" class= "error"></span>
        </div>
        <div class="text-center mb-3">
          <button type="submit" class="btn blue-gradient btn-block btn-rounded z-depth-1a">Register</button>
        </div>
        <p class="font-small dark-grey-text text-right d-flex justify-content-center mb-3 pt-2"> or Register
          with:</p>

        <div class="row my-3 d-flex justify-content-center">
          <!--Facebook-->
          <button type="button" class="btn btn-white btn-rounded mr-md-3 z-depth-1a"><i class="fab fa-facebook-f text-center"></i></button>
          <!--Twitter-->
          <button type="button" class="btn btn-white btn-rounded mr-md-3 z-depth-1a"><i class="fab fa-twitter"></i></button>
          <!--Google +-->
          <button type="button" class="btn btn-white btn-rounded z-depth-1a"><i class="fab fa-google-plus-g"></i></button>
        </div>
       
      </div>
    </div>
    </fo:form>
    <!--/.Content-->
  </div>
</div>
<!-- Modal -->

  </main>


  <!--==========================
    Footer
  ============================-->
  <footer id="footer">
    <div class="footer-top">
      <div class="container">

      </div>
    </div>
  </footer><!-- #footer -->

  <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

</body>
</html>
	