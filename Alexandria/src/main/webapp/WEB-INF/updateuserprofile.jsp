<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update User Profile</title>
<jsp:include page="bootstrapHead.jsp" />

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
				<label for="name">User Name</label> <input type="text" name="username" value="${update.username}"/>
				<label for="name">Password</label> <input type="password" name="password" value="${update.password}"/>
				<label for="name"></label> <input type="text" name="firstName" placeholder="First Name"/>
				<label for="name"></label> <input type="text" name="lastName" placeholder="Last Name"/>
				<label for="name"></label> <input type="text" name="aboutMe" placeholder="About Me"/>
				<label for="name">Profile Picture</label> <input type="text" name="imageUrl" placeholder="Image URL"/>	
				<label for="image">Upload Profile Picture:</label> <input type="file" name="image" id="Upload Image">
				<input type="submit" value="Upload">
				<input class="btn btn-dark" type="submit" value="Submit"/>
			</form>
		</div>
	</div>
	
	<br>
</body>
</html>
