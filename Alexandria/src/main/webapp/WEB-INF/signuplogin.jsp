<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>Log In</title>
<jsp:include page="bootstrapHead.jsp" />

</head>

	<link rel="icon" type="image/x-icon" href="/resources/logo.png">
<body>
<jsp:include page="navbar.jsp" />
	<%--Edit the file nav.jsp to change nav links --%>
	<%-- <%@ include file="nav.jsp"%> --%>

	<h2>Log In</h2>

	<form action="login.do" method="POST">
		<input type="text" name="username"> <input type="password"
			name="password" /> <input type="submit" value="Log In">
	</form>
	
<jsp:include page="bootstrapFoot.jsp" />	
</body>
</html>


