<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update User Profile</title>
<jsp:include page="bootstrapHead.jsp" />

</head>
<body>

	<div class="container-fluid">
		<div>
			<h1>Update Forms</h1>
			<form action="updateduserprofile.do" method="POST">
				<input type="hidden" name="userId" value="${update.id}" />
				<input type="hidden" name="id" value="${update.id}" />
				<label for="name">First Name</label> <input type="text" name="firstName"/>
				<label for="name">Last Name</label> <input type="text" name="lastName"/>
				<label for="name">Profile Picture</label> <input type="text" name="imageUrl"/>
				<label for="name">About Me</label> <input type="text" name="aboutMe"/>
				<label for="name">User Name</label> <input type="text" name="username" value="${update.username}"/>
				<label for="name">Password</label> <input type="password" name="password" value="${update.password}"/>
				<input class="btn btn-dark" type="submit" value="Submit"/>
			</form>
		</div>
	</div>
	
	<br>
</body>
</html>