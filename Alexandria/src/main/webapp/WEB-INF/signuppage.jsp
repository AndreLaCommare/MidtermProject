<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>Sign Up</title>

</head>
	<link rel="icon" type="image/x-icon" href="/resources/logo.png">
	<link rel="stylesheet" href="resources/styles.css"/>
<body>
<div id = "header">
    <a href="home.do" style="padding: 0; margin: 0;"><img class=logo src="resources/logo.png"></a><h2 class="sitename"><strong>Alexandria</strong></h2>
    <a class="login-btn" href="loginpage.do" role="button">Log In</a>
    <a class="signin-btn" href="signuppage.do" role="button">Sign Up</a>
    <a class="trending-btn">Trending</a>
    <a class="search-btn" href="searchpage.do">Search</a>
</div>
	<div class="signup-bkgrnd"></div>
		<div class="signup-container">
		<h2 class="signup-title">Sign Up</h2>
		<form action="signup.do" method="POST">
		<input type="text" placeholder="First Name" name="firstName" class="signup-input-fname">
		<input type="text" placeholder="Last Name" name="lastName" class="signup-input-lname">
		<input type="email" placeholder="Email" name="email" class="signup-input-email">
		<input type="text" placeholder="Username" name="username" class="signup-input-username">
		<input type="password" placeholder="Password" name="password" class="signup-input-password">
		<button type="submit" role="button" class="signup-btn-submit"><img src="resources/loginicon.svg" class="login-btn-icon"></button>
		</form>
		</div>
</body>
</html>


