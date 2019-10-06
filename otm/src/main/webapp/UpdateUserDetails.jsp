<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fo" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyConnect</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<jsp:include page="include_script.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>
<style type="text/css">
	.error {
		color: red;
	}
	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript"></script>
<script>
$(function() {
    $("#username_error_message").hide();
    $("#password_error_message").hide();
   
    var error_username = false;
    var error_password = false;
   
    $("#name").focusout(function(){
       check_username();
    });
    $("#password").focusout(function() {
       check_password();
    });
    
    function check_username() {
       var pattern = "/^[A-Z][A-Za-z 0-9_-]*$/";
       var username = $("#name").val();
       if (pattern.test(username) && username !== '') {
          $("#username_error_message").hide();
       } else {
          $("#username_error_message").html("Should contain only Characters and at least ");
          $("#username_error_message").show();
          $("#form_username").css("border-bottom","2px solid #F90A0A");
          error_username = true;
       }
    
      
    function check_password() {
       var password_length = $("#password").val().length;
       if (password_length < 8) {
          $("#password_error_message").html("Atleast 8 Characters");
          $("#password_error_message").show();
          $("#form_password").css("border-bottom","2px solid #F90A0A");
          error_password = true;
       } else {
          $("#password_error_message").hide();
          $("#form_password").css("border-bottom","2px solid #34F458");
       }
    }

    $("#updateform").submit(function() {
        error_username = false;
        error_password = false;
        check_username();
        check_password();
        check_retype_password();
        if (error_username === false && error_password === false ) {
           alert("Updated Successfull");
           return true;
        } else {
           alert("Please Fill the form Correctly");
           return false;
        }
    });
    });
</script>
</head>

<body>

	<header id="header">
		<div class="container">

			<div id="logo" class="pull-left" style="width: 100%">

				<nav id="nav-menu-container">
					<ul class="nav-menu" style="width: 100%;">
						<li class="menu-active"><a href="user">Home</a></li>
						<li><a href="givetest">Give Test</a></li>
						<li><a href="getresult">Get Result</a></li>
						<li><a href="updateuser">Update Profile</a></li>
					</ul>
					<ul class="nav nav-menu nav-navbar nav-right">
						<li><a class="button" href="logout"><i
								class="fa fa-sign-in"></i>&nbsp;Logout</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</header>


	<main id="main"> <br>
	<section id="portfolio">
		<div class="container wow fadeInUp">
			<div class="section-header">
				<h3 class="section-title">Update User</h3>
				<p class="section-description">Enter the User details to be
					Updated here</p>
			</div>
			<fo:form id="updateform" action="updateusersubmit" method="post"
				modelAttribute="user">
				<div class="row">
					<div class="text-center col-md-6 col-lg-6">User Id:</div>
					<div class="col-md-4 col-lg-4">
						<input type="text" name="userId" value="${Update.userId}" readonly />
					</div>
				</div>
				<div class="row">
					<div class="text-center col-md-6 col-lg-6">User Name:</div>
					<div class="col-md-4 col-lg-4">
						<input id="name" type="text" name="userName" value="${Update.userName}" />
						<span id="username_error_message"></span>
					</div>
				</div>
				<div class="row">
					<div class="text-center col-md-6 col-lg-6">User Password:</div>
					<div class="col-md-4 col-lg-4">
						<input id="password" type="text" name="userPassword"
							value="${Update.userPassword}" />
						<span id="password_error_message"></span>
					</div>
				</div>
				<div class="row">
					<div class="text-center col-md-6 col-lg-6"></div>
					<div class="col-md-4 col-lg-4">
						<button type="submit" class="btn btn-primary">Update</button>
					</div>
				</div>
				<br>
			</fo:form>
		</div>
	</section>

	</main>


	<!--==========================
    Footer
  ============================-->
	<footer id="footer" style="position: fixed; bottom: 0px; width: 100%;">
		<div class="footer-top">
			<div class="container"></div>
		</div>
	</footer>
	<!-- #footer -->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>




</body>
</html>
