<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log In</title>
 <link rel="icon" type="image/x-icon" href="resources/logo.png">
    <link rel="stylesheet" href="resources/styles.css"/>
</head>
<body>
<div id = "header">
    <a href="home.do" style="padding: 0; margin: 0;"><img class=logo src="resources/logo.png"></a><h2 class="sitename"><strong>Alexandria</strong></h2>
    <a class="login-btn" href="loginpage.do" role="button">Log In</a>
    <a class="signin-btn" href="signuppage.do" role="button">Sign Up</a>
    <a class="trending-btn">Trending</a>
    <a class="search-btn" href="searchpage.do">Search</a>
</div>

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