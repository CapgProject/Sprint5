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
            </ul>
          </li>
          <li class="menu-has-children"><a href="#">Question</a>
            <ul>
              <li><a href="addquestion">Add Question</a></li>
              <li><a href="updatequestion">Update Question</a></li>
              <li><a href="removequestion">Remove Question</a></li>
              <li><a href="listquestion">List Question</a></li>
            </ul>
          </li>
          <li><a href="showallusers">List Users</a></li>
          <li><a href="updateuser">Update Profile</a></li>
        </ul>  
        <ul class="nav nav-menu nav-navbar nav-right">
          <li><a class="button" href="logout"><i class="fa fa-sign-in"></i>&nbsp;Logout</a></li>          
        </ul>      
      </nav>
    </div>
  </header>


  <main id="main">
  <br>
    <section id="portfolio">
      <div class="container wow fadeInUp">
      <div class="section-header">
      <h3 class="section-title">Assign Test</h3>
      <p class="section-description">You can use the below form to assign an existing test to a user</p>
      </div>
      <form id="assigntest" action="assigntestsubmit" method="post">
        <div class = "row">
          <div class="text-center col-md-6 col-lg-6">
            Enter the Test Id:
          </div>
          <div class="col-md-4 col-lg-4">
            <input type="text" id="test_id" name="testid" placeholder="Enter Test Id" class="form-control" >
             <span class="error" id="testid_error_message" style="color:red"></span>
             <span style="color:red">${error}</span>
          </div>
        </div>
        <div class = "row">
          <div class="text-center col-md-6 col-lg-6">
            Enter the User Id:
          </div>
          <div class="col-md-4 col-lg-4">
            <input type="text" id="user_id" name="userid" placeholder="Enter User Id" class="form-control" >
            <span class="error" id="userid_error_message" style="color:red"></span>
            <span style="color:red">${error}</span>
          </div>
        </div>
        <div class = "row">
          <div class="text-center col-md-6 col-lg-6">
          </div>
          <div class="col-md-4 col-lg-4">
            <button type="submit" class = "btn btn-primary">Assign Test</button>
          </div>
        </div>
        <br>
        </form>   
    </div>
    </section>

  </main>


  <!--==========================
    Footer
  ============================-->
  <footer id="footer" style="position: fixed;bottom: 0px; width: 100%;">
    <div class="footer-top">
      <div class="container">

      </div>
    </div>
  </footer><!-- #footer -->

  <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

 <script src='<c:url value = "/webjars/lib/jquery/jquery.min.js"/>' ></script>
  <script src='<c:url value = "/webjars/lib/jquery/jquery-migrate.min.js"/>' ></script>
  <script src='<c:url value = "/webjars/lib/bootstrap/js/bootstrap.bundle.min.js"/>' ></script>
  <script src='<c:url value = "/webjars/lib/easing/easing.min.js"/>' ></script>
  <script src='<c:url value = "/webjars/lib/wow/wow.min.js"/>' ></script>
  <script src='<c:url value = "/webjars/lib/waypoints/waypoints.min.js"/>' ></script>
  <script src='<c:url value = "/webjars/lib/counterup/counterup.min.js"/>' ></script>
  <script src='<c:url value = "/webjars/lib/superfish/hoverIntent.js"/>' ></script>
  <script src='<c:url value = "/webjars/lib/superfish/superfish.min.js"/>' ></script>

  <!-- Contact Form JavaScript File -->
  <script src='<c:url value = "/webjars/contactform/contactform.js" />' ></script>

  <!-- Template Main Javascript File -->
  <script src='<c:url value = "/webjars/js/main.js" />'></script>


<script type="text/javascript">
$(function(){
	
	$("#testid_error_message").hide();
	$("#userid_error_message").hide();
	var error_testid=false;
	var error_userid=false;
	
	$("#test_id").focusout(function(){
		
		check_testid();
	});
	$("#user_id").focusout(function(){
		
		check_userid();
	});
	function check_testid(){
		var length = $("#test_id").val().length;
		var pattern = new RegExp(/^[0-9]+$/i);
		
		if($("#test_id").val()==''){
			$("#testid_error_message").html("Should not be Empty");
			$("#testid_error_message").show();
			error_testid=true;
		}else if(!pattern.test($("#test_id").val())){
			$("#testid_error_message").html("Only numbers are allowed.!");
			$("#testid_error_message").show();
			error_testid = true;
		}
		else{
			$("#testid_error_message").hide();
		}
	}
	
	function check_userid(){
		var length = $("#user_id").val().length;
		var pattern = new RegExp(/^[0-9]+$/i);
		if($("#user_id").val()==''){
			$("#userid_error_message").html("Should not be Empty");
			$("#userid_error_message").show();
			error_name=true;
		}else if(!pattern.test($("#user_id").val())){
			$("#userid_error_message").html("Only numbers are allowed.!");
			$("#userid_error_message").show();
			error_userid = true;
		}
		else{
			$("#userid_error_message").hide();
		}
	}
	$("#assigntest").submit(function(){
		error_testid = false;
		error_userid = false;
		check_testid();
		check_userid();
		if(error_testid == false && error_userid == false){
			return true;
		}
		else{
			return false;
		}
	});
});
</script>

</body>

</html>