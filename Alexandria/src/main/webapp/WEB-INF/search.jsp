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
	
	<form action="bookbylanguage.do" method="GET">
	<input type="text" name="language">
		 <input type="submit" value="Find Books by Language">
	</form>
	
	<form action="bookbydescription.do" method="GET">
	<input type="text" name="description">
		 <input type="submit" value="Find Books by Description">
	</form>
	
	<form action="bookbygenre.do" method="GET">
	<input type="text" name="genre">
		 <input type="submit" value="Find Books by Genre">
	</form>
	
	<form action="bookbyisbn.do" method="GET">
	<input type="text" name="isbn">
		 <input type="submit" value="Find Book by ISBN">
	</form>
	
	<form action="findClubById.do" method="GET">
	<input type="text" name="clubId">
		 <input type="submit" value="Find Club">
	</form>

</body>
</html>