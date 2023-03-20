<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log In</title>
</head>
<body>
<form action="login.do" method="POST">
		Username <input type="text" name="username"> Password <input
			type="password" name="password" /> <input type="submit"
			value="Log In">

	</form>
	<form action="signuppage.do" method="GET">
		<input type="submit" value="Sign Up">
	</form>
</body>
</html>