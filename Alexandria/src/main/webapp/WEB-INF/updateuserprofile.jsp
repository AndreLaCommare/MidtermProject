<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update User Profile</title>
<jsp:include page="navbar.jsp"/>
<link rel="icon" type="image/x-icon" href="/resources/logo.png">
<link rel="stylesheet" href="resources/styles.css"/>

<style>
    .vertical-form {
        display: block;
    }
    
    form label,
    form input[type="text"],
    form input[type="password"],
    form input[type="file"],
    form input[type="submit"] {
      display: block;
      margin-bottom: 10px;
    }
</style>

</head>
<body>
	<div class="container-fluid">
		<div>
			<h1>Update Forms</h1>
			<form action="updateduserprofile.do" method="POST">
				<input type="hidden" name="userId" value="${update.id}" />
				<input type="hidden" name="id" value="${update.id}" />
				<label for="name">User Name</label> <input type="text" name="username" value="${update.username}" required/>
				<label for="name">Password</label> <input type="password" name="password" value="${update.password}" required/>
				<label for="name">First Name</label> <input type="text" name="firstName" value="${update.firstName}" required/>
				<label for="name">Last Name</label> <input type="text" name="lastName" value="${update.lastName}" required/>
				<label for="name">About Me</label> <input type="text" name="aboutMe" value="${update.aboutMe}" required/>
				<c:if test="${not empty update.imageUrl}">
				Profile Pic Image URL: <input type="text" name="imageUrl" value="${update.imageUrl}"/>	
				<c:otherwise>
				Profile Pic Image URL: <input type="text" name="imageUrl"  value =""/>	
				</c:otherwise>
				</c:if>
				<label for="image">Upload From Local Files:</label> <input type="file" name="image" id="Upload Image">
				<input type="submit" value="Upload">
				<input class="btn btn-dark" type="submit" value="Submit"/>
			</form>
		</div>
	</div>
	
	<br>
</body>
</html>
