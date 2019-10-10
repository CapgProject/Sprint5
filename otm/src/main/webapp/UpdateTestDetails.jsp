<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js">
	
</script>
</head>
<body>
	<form action="updatetestsubmit" method="post" id="formsubmit">
		<div class="row">
			<div class="text-center col-md-6 col-lg-6">Test Id:</div>
			<div class="col-md-4 col-lg-4">
				<input class="form-control" type="text" name="testId"
					value="${Update.testId}" readonly />
			</div>
		</div>
		<div class = "row">
          <div class="text-center col-md-6 col-lg-6">
            Test Name:
          </div>
          <div class="col-md-4 col-lg-4">
            <input class = "form-control" type="text" name="testName" id="name"
					value="${Update.testName}" />
					<span id="name_error" style="color: red"></span> 
					<span style="color: red">${errorsubmit}</span>
          </div>
        </div>
        <div class = "row">
          <div class="text-center col-md-6 col-lg-6">
            Test Duration:
          </div>
          <div class="col-md-4 col-lg-4">
            <input class = "form-control" type="text" name="testDuration" id="duration"
					value="${Update.testDuration}" />
					<span id="duration_error" style="color: red"></span>
          </div>
        </div>
        <div class = "row">
          <div class="text-center col-md-6 col-lg-6">
            Test Start time:
          </div>
          <div class="col-md-4 col-lg-4">
            <input class = "form-control" type="text" name="startTime" id="startTime"
					value="${Update.startTime}" />
					<span id="startTime_error" style="color: red"></span>
          </div>
        </div>
        <div class = "row">
          <div class="text-center col-md-6 col-lg-6">
            Test End time:
          </div>
          <div class="col-md-4 col-lg-4">
            <input class = "form-control" type="text" name="endTime" id="endTime"
					value="${Update.endTime}" />
					<span id="endTime_error" style="color: red"></span>
          </div>
        </div>
        <div class = "row">
          <div class="text-center col-md-6 col-lg-6">
            
          </div>
          <div class="col-md-4 col-lg-4">
            <button type = "submit" class = "btn btn-primary">Update</button>
          </div>
        </div>
	</form>
	
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

			function check_startTime() {
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

			function check_endTime() {
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

			$("#formsubmit").submit(
					function() {
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
		});
	</script>
</body>
</html>