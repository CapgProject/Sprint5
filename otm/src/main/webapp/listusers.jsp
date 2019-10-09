<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyConnect</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<jsp:include page="include_script.jsp"></jsp:include>
<style>
table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #64F5E8;
}

th {
	background-color: #0E56A9;
	font: red;
}
</style>
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
				<h3 class="section-title">Users</h3>
				<p class="section-description">Here is a list of all users</p>
			</div>
			<table id="list" align="justify-content-center"
				style="margin-left: auto; margin-right: auto; width: 50%;">
				<tr>
					<th>User Id</th>
					<th>UserName</th>
					<th>Assigned Test Name</th>
				</tr>
				<tr>
					<td>Peter</td>
					<td>Griffin</td>
					<td>$100</td>
				</tr>
				<tr>
					<td>Lois</td>
					<td>Griffin</td>
					<td>$150</td>
				</tr>
				<tr>
					<td>Joe</td>
					<td>Swanson</td>
					<td>$300</td>
				</tr>
				<tr>
					<td>Cleveland</td>
					<td>Brown</td>
					<td>$250</td>
				</tr>
			</table>
		</div>
	</section>

	<section id="contact">
		<div class="container wow fadeInUp">
			<div class="section-header">
				<h3 class="section-title">Contact</h3>
				<p class="section-description">Sed ut perspiciatis unde omnis
					iste natus error sit voluptatem accusantium doloremque</p>
			</div>
		</div>

		<div class="container wow fadeInUp mt-5">
			<div class="row justify-content-center">

				<div class="col-lg-3 col-md-4">

					<div class="info">
						<div>
							<i class="fa fa-map-marker"></i>
							<p>
								A108 Adam Street<br>New York, NY 535022
							</p>
						</div>

						<div>
							<i class="fa fa-envelope"></i>
							<p>info@example.com</p>
						</div>

						<div>
							<i class="fa fa-phone"></i>
							<p>+1 5589 55488 55s</p>
						</div>
					</div>

					<div class="social-links">
						<a href="#" class="twitter"><i class="fa fa-twitter"></i></a> <a
							href="#" class="facebook"><i class="fa fa-facebook"></i></a> <a
							href="#" class="instagram"><i class="fa fa-instagram"></i></a> <a
							href="#" class="google-plus"><i class="fa fa-google-plus"></i></a>
						<a href="#" class="linkedin"><i class="fa fa-linkedin"></i></a>
					</div>

				</div>
			</div>

		</div>
	</section>
	<!-- #contact --> </main>


	<!--==========================
    Footer
  ============================-->
	<footer id="footer">
		<div class="footer-top">
			<div class="container"></div>
		</div>
	</footer>
	<!-- #footer -->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

	<!-- JavaScript Libraries -->
	<script src="lib/jquery/jquery.min.js"></script>
	<script src="lib/jquery/jquery-migrate.min.js"></script>
	<script src="lib/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="lib/easing/easing.min.js"></script>
	<script src="lib/wow/wow.min.js"></script>
	<script src="lib/waypoints/waypoints.min.js"></script>
	<script src="lib/counterup/counterup.min.js"></script>
	<script src="lib/superfish/hoverIntent.js"></script>
	<script src="lib/superfish/superfish.min.js"></script>

	<!-- Contact Form JavaScript File -->
	<script src="contactform/contactform.js"></script>

	<!-- Template Main Javascript File -->
	<script src="js/main.js"></script>


</body>
</html>
