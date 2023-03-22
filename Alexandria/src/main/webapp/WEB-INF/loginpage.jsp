<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log In</title>
 <link rel="icon" type="image/x-icon" href="resources/logo.png">
    <link rel="stylesheet" href="resources/styles.css"/>
    <jsp:include page="navbar.jsp"/>
</head>
<body>

<div class="login-bkgrnd"></div>
	<div class="login-container">
	<h2 class="login-title">Log In</h2>
	<form action="login.do" method="POST">
	<input type="text" placeholder="Username" name ="username" class="login-input-user">
	<input type="password" placeholder="Password" name ="password" class="login-input-password">
	<button type="submit" role="button" class="login-btn-submit"><img src="resources/loginicon.svg" class="login-btn-icon"></button>
	</form>
	</div>
</body>
</html>