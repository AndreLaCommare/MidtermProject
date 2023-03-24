<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update User Profile</title>
<link rel="icon" type="image/x-icon" href="/resources/logo.png">
<link rel="stylesheet" href="resources/styles.css"/>
<jsp:include page="navbar.jsp"/>

</head>
<body>
	<div class="update-profile-form-container">
			<h1 class="update-profile-title">Edit profile</h1>
			<form action="updateduserprofile.do" method="POST">
				<input type="hidden" name="userId" value="${update.id}" />
				<input type="hidden" name="id" value="${update.id}" />
				
				<h4 class="update-username-title">Username:</h4> <input type="text" name="username" value="${update.username}" required class="update-username"/>
				
				<h4 class="update-password-title">Password:</h4><input type="password" name="password" value="${update.password}" required class="update-password"/>
			
				<h4 class="update-fname-title">First Name:</h4><input type="text" name="firstName" value="${update.firstName}" required class="update-fname"/>
			
				<h4 class="update-lname-title">Last Name:</h4><input type="text" name="lastName" value="${update.lastName}" required class="update-lname"/>
				
				<h4 class="update-about-title">About Me:</h4><input type="text" name="aboutMe" value="${update.aboutMe}" required class="update-about"/>
			
				<h4 class="update-pic-title">Profile Picture URL:</h4><input type="text" name="imageUrl" value="${update.imageUrl}" class="update-pic"/>	
				<br>
				<button type="submit" role="button" class="update-submit-btn"><img src="resources/checkicon.svg" class="update-submit-btn-icon"></button>
				
			</form>
		</div>
	
	<br>
</body>
</html>
