<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Alexandria | Find your next read</title>
<jsp:include page="bootstrapHead.jsp" />
  <link rel="icon" type="image/x-icon" href="/resources/logo.png">
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class = "header">
<h2>Alexandria</h2>

</div>
	<h1>Welcome to Alexandria</h1>
	
	<h2> User: ${SMOKETEST}</h2> <!-- DEBUG -->
	
<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>