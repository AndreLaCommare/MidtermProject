<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search</title>
<link rel="icon" type="image/x-icon" href="/resources/logo.png">
</head>
<body>

	<form action="bookbytitle.do" method="GET">
	<input type="text" name="title">
		 <input type="submit" value="Find Title">
	</form>

	<form action="bookbyauthor.do" method="GET">
	<input type="text" name="author">
		 <input type="submit" value="Find Author">
	</form>
	
	<form action="clubByName.do" method="GET">
	<input type="text" name="club">
		 <input type="submit" value="Find Club">
	</form>

</body>
</html>