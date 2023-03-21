<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>Sign Up</title>
<jsp:include page="bootstrapHead.jsp" />

</head>

	<link rel="icon" type="image/x-icon" href="/resources/logo.png">
<body>

	<h2>Sign Up</h2>

	<form action="signup.do" method="POST">
		First Name <input type="text" name="firstName"> 
		Last Name <input type="text" name="lastName" /> 
		Email <input type="text" name="email" /> 
		Username <input type="text" name="username" /> 
		Password <input type="password" name="password" /> 
		
			<input type="submit" value="Sign Up">
	</form>
	
<jsp:include page="bootstrapFoot.jsp" />	
</body>
</html>


