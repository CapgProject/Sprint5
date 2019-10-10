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
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js">
	
</script>
</head>

<body>

	<header id="header">
		<div class="container">

			<div id="logo" class="pull-left" style="width: 100%">

				<nav id="nav-menu-container">
					<ul class="nav-menu" style="width: 100%;">
						<li class="menu-active"><a href="admin">Home</a></li>
						<li class="menu-has-children"><a href="#">Test</a>
							<ul>
								<li><a href="addtest">Add Test</a></li>
								<li><a href="updatetest">Update Test</a></li>
								<li><a href="removetest">Remove Test</a></li>
								<li><a href="showalltests">Show All Test</a></li>
								<li><a href="assigntest">Assign Test</a></li>
							</ul></li>
						<li class="menu-has-children"><a href="#">Question</a>
							<ul>
								<li><a href="addquestion">Add Question</a></li>
								<li><a href="updatequestion">Update Question</a></li>
								<li><a href="removequestion">Remove Question</a></li>
								<li><a href="listquestion">List Question</a></li>
							</ul></li>
						<li><a href="showallusers">List Users</a></li>
						<li><a href="updateuser">Update Profile</a></li>
					</ul>
					<ul class="nav nav-menu nav-navbar nav-right">
						<li><a class="button" href="logout"><i
								class="fa fa-sign-in"></i>&nbsp;Logout</a></li>
					</ul>
				</nav>
			</div>
	</header>


	<main id="main"> <br>
	<section id="portfolio">
		<div class="container wow fadeInUp">
			<div class="section-header">
				<h3 class="section-title">Add Test</h3>
				<p class="section-description">Enter the test details to be
					added here</p>
			</div>
			<fo:form id="testform" action="addtestsubmit" method="post"
				modelAttribute="test">
				<div class="row">
					<div class="text-center col-md-6 col-lg-6">Enter the Test
						Name:</div>
					<div class="col-md-4 col-lg-4">
						<fo:input type="text" path="testName"
							placeholder="Enter Test Name" id="name" class="form-control" />
						<span id="name_error" style="color: red"></span>
						<span style="color:red">${error}</span>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="text-center col-md-6 col-lg-6">Enter the Test
						Duration:</div>
					<div class="col-md-4 col-lg-4">
						<fo:input type="text" path="testDuration" placeholder="(HH:MM:SS)"
							id="duration" class="form-control" />
						<span id="duration_error" style="color: red"></span>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="text-center col-md-6 col-lg-6">Enter the Test
						Start time:</div>
					<div class="col-md-4 col-lg-4">
						<fo:input type="text" path="startTime"
							placeholder="DD-MM-YYYY HH:MM:SS" id="startTime"
							class="form-control" />
							<span id="startTime_error" style="color: red"></span>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="text-center    col-md-6 col-lg-6">Enter the Test
						End time:</div>
					<div class="col-md-4 col-lg-4">
						<fo:input type="text" path="endTime"
							placeholder="DD-MM-YYYY HH:MM:SS" id="endTime"
							class="form-control" />
							<span id="endTime_error" style="color: red"></span>
					</div>
				</div>
				<br>
				<div class="row justify-content-center">
					<div class="col-lg-4">
						<button class="btn btn-primary" type="submit" name="Add Test">Add
							Test</button>
					</div>
					<div class="col-lg-4">
						<button class="btn btn-primary" type="reset" name="Clear">Clear</button>
					</div>
				</div>

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

	<script src='<c:url value = "/webjars/lib/jquery/jquery.min.js"/>'></script>
	<script
		src='<c:url value = "/webjars/lib/jquery/jquery-migrate.min.js"/>'></script>
	<script
		src='<c:url value = "/webjars/lib/bootstrap/js/bootstrap.bundle.min.js"/>'></script>
	<script src='<c:url value = "/webjars/lib/easing/easing.min.js"/>'></script>
	<script src='<c:url value = "/webjars/lib/wow/wow.min.js"/>'></script>
	<script
		src='<c:url value = "/webjars/lib/waypoints/waypoints.min.js"/>'></script>
	<script
		src='<c:url value = "/webjars/lib/counterup/counterup.min.js"/>'></script>
	<script src='<c:url value = "/webjars/lib/superfish/hoverIntent.js"/>'></script>
	<script
		src='<c:url value = "/webjars/lib/superfish/superfish.min.js"/>'></script>

	<!-- Contact Form JavaScript File -->
	<script src='<c:url value = "/webjars/contactform/contactform.js" />'></script>

	<!-- Template Main Javascript File -->
	<script src='<c:url value = "/webjars/js/main.js" />'></script>

	<script type="text/javascript">
		$(function() {
			$("#name_error").hide();
			$("#duration_error").hide();
			$("#startTime_error").hide();
			$("#endTime_error").hide();
			
			var error_name = false;
			var error_duration = false;
			var error_startTime = false;
			var error_endTime = false;
			
			$("#name").focusout(function() {
				check_name();
			});
			
			$("#duration").focusout(function() {
				check_duration();
			});
			
			$("#startTime").focusout(function() {
				check_startTime();
			});
			
			$("#endTime").focusout(function() {
				check_endTime();
			});

			function check_name() {
				var length = $("#name").val().length;
				var pattern = new RegExp("^[A-Z][A-Za-z 0-9_-]*$");
				if (length < 4) {
					$("#name_error").html(
							"Name should be greater than 4 characters!");
					$("#name_error").show();
					error_name = true;
				} else {
					if (!pattern.test($("#name").val())) {
						$("#name_error").html(
								"First character should be a capital letter!");
						$("#name_error").show();
						error_name = true;
					} else {
						$("#name_error").hide();
					}
				}
			}
			
			function check_duration() {
				var length = $("#duration").val().length;
				var pattern = new RegExp("^([0-9]{2}):([0-59]{2}):([0-59]{2})$");
				
				if(length < 8){
					$("#duration_error").html("Duration field cannot be empty!");
					$("#duration_error").show();
					error_duration = true;
				}
				else{
					if(!pattern.test($("#duration").val())){
						$("#duration_error").html("Enter duration in 'HH:mm:ss' format only!");
						$("#duration_error").show();
						error_duration = true;
					}
					else{
						$("#duration_error").hide();
					}
				}
			}
			
			function check_startTime(){
				var length = $("#startTime").val().length;
				var pattern = new RegExp(/^(0[1-9]|1[0-9]|2[0-9]|3[01])-(0[1-9]|1[012])-([0-2][0-9][0-9][0-9])\s([0-1][0-9]|2[0-4]):([0-5][0-9]):([0-5][0-9])$/i);
				
				if(length < 8){
					$("#startTime_error").html("start time field cannot be empty!");
					$("#startTime_error").show();
					error_startTime = true;
				}
				else{
					if(!pattern.test($("#startTime").val())){
						$("#startTime_error").html("Enter start time in 'dd-MM-yyyy HH:mm:ss' format only!");
						$("#startTime_error").show();
						error_startTime = true;
					}
					else{
						$("#startTime_error").hide();
					}
				}
			}
			
			function check_endTime(){
				var length = $("#endTime").val().length;
				var pattern = new RegExp(/^(0[1-9]|1[0-9]|2[0-9]|3[01])-(0[1-9]|1[012])-([0-2][0-9][0-9][0-9])\s([0-1][0-9]|2[0-4]):([0-5][0-9]):([0-5][0-9])$/i);
				
				if(length < 8){
					$("#endTime_error").html("end time field cannot be empty!");
					$("#endTime_error").show();
					error_endTime = true;
				}
				else{
					if(!pattern.test($("#endTime").val())){
						$("#endTime_error").html("Enter end time in 'dd-MM-yyyy HH:mm:ss' format only!");
						$("#endTime_error").show();
						error_endTime = true;
					}
					else{
						$("#endTime_error").hide();
					}
				}
			}
			
			$("#testform").submit(function () {
				error_name = false;
				error_duration = false;
				error_startTime = false;
				error_endTime = false;
				
				check_name();
				check_duration();
				check_startTime();
				check_endTime();
				
				if(error_name==false && error_duration==false && error_startTime==false && error_endTime==false){
					return true;
				}
				else{
					return false;
				}
			});
		})
	</script>
</body>
</html>