<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
</head>
<body>
	<h1>IN BOOKLISTSEARCH</h1>
	<c:choose>

		<c:when test="${empty books}">
			<h1>No Books Found</h1>
		</c:when>

		<c:otherwise>
			<c:forEach var="book" items="${books}">
			
				<div>
				<ul>
					<li>Title: ${book.title}</li>
				</ul>
				<a href="showById.do?id=${book.id}"><img src="${book.coverUrl}" width="150"></a>
				</div>

			</c:forEach>
		</c:otherwise>

	</c:choose>
</body>
</html>