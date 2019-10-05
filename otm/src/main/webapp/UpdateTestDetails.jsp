<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form action="updatetestsubmit" method="post">
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
            <input class = "form-control" type="text" name="testName"
					value="${Update.testName}" />
          </div>
        </div>
        <div class = "row">
          <div class="text-center col-md-6 col-lg-6">
            Test Duration:
          </div>
          <div class="col-md-4 col-lg-4">
            <input class = "form-control" type="text" name="testDuration"
					value="${Update.testDuration}" />
          </div>
        </div>
        <div class = "row">
          <div class="text-center col-md-6 col-lg-6">
            Test Start time:
          </div>
          <div class="col-md-4 col-lg-4">
            <input class = "form-control" type="text" name="startTime"
					value="${Update.startTime}" />
          </div>
        </div>
        <div class = "row">
          <div class="text-center col-md-6 col-lg-6">
            Test End time:
          </div>
          <div class="col-md-4 col-lg-4">
            <input class = "form-control" type="text" name="endTime"
					value="${Update.endTime}" />
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
</body>
</html>