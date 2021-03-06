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


<style type="text/css">
	.error {
		color: red;
	}
	
</style>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#username_error_message").hide();
	$("#password_error_message").hide();
	var error_username = false;
	var error_password = false;

	$("#name").focusout(function(){
		check_username();
	});
	$("#password").focusout(function(){
		check_password();
	});

	function check_username(){
		var username_length = $("#name").val().length;
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
			$("#password_error_message").html("Password should contain at least one upper case character, one lower case character, one numeric character, one special character and length should be at least eight characters");
			$("#password_error_message").show();
			error_password = true;	
		}
	}

	$("#updateform").submit(function(){
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
						<span id="username_error_message" class = "error"></span>
					</div>
				</div>
				<div class="row">
					<div class="text-center col-md-6 col-lg-6">User Password:</div>
					<div class="col-md-4 col-lg-4">
						<input id="password" type="text" name="userPassword"
							value="${Update.userPassword}" />
						<span id="password_error_message" class = "error"></span>
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



      
</script>

</body>
</html>
