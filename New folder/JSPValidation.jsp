<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title> Update User Validation</title>
	<link rel="stylesheet" type="text/css" href="style.css">
	<link rel="stylesheet" type="text/js" href="UpdateUser.js">
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
</head>
<body>
	<div class="container">
		<h1>Update Profile</h1>
		<form id="update_form">
			<div>
				<input type="text" id="form_username" name="" required="">
				<span class="error_form" id="username_error_message"></span>
				<label>
					User Name
				</label>	
			</div>
			
			<div>
				<input type="password" id="form_password" name="" required="">
				<span class="error_form" id="password_error_message"></span>
				<label>Password</label>	
			</div>
			
			<input type="submit" value="Update Profile" name="">
		</form>
	</div>
	</body>
	</html>