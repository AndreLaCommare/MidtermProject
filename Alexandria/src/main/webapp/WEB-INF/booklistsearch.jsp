<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
 <link rel="icon" type="image/x-icon" href="resources/logo.png">
 <link rel="stylesheet" href="resources/styles.css"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>
	<div class="booklist-container">
	<c:choose>

		<c:when test="${empty books}">
			<h1>No Books Found</h1>
		</c:when>

		<c:otherwise>
			<c:forEach var="book" items="${books}">
			
				<div class="book-details" id="book-details">
				<ul>
					<li class="booklist-title">Title: ${book.title}</li>
					<br>
					<li class="booklist-author">Author: ${book.author}</li>
				</ul>
				<a href="showById.do?id=${book.id}"><img src="${book.coverUrl}" class="booklist-cover"></a>
				</div>
			</c:forEach>
		</c:otherwise>

	</c:choose>
	</div>
</body>
</html>