<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Book</title>
</head>
<body>
<c:choose>
	<c:when test="${empty book }">No Books Found.</c:when>
	<c:otherwise>
	<table class="table table-striped table-hover">
	
	<tr>
	<th>Title</th>
	
	</tr>
	
	<c:forEach var="books" items="${book }">
	<tr>
	<td>${books.title }</td>

	
	</tr>

	</c:forEach>

	</table>
	</c:otherwise>
	</c:choose>
</body>
</html>