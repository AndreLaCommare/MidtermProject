<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<link rel="icon" type="image/x-icon" href="/resources/logo.png">
<link rel="stylesheet" href="resources/styles.css"/>
<jsp:include page="navbar.jsp"/>
</head>
<body>

	<c:choose>
		<c:when test="${not empty user}">
			<h2>Account Details</h2>
			<h3>User name: ${user.username} (id: ${user.id})</h3>
			<br>

			<h4>${user.firstName} ${user.lastName}</h4>
			<img src="${user.imageUrl}" alt="Profile Picture" width="200">
			<br>
			<h6>About Me:</h6>
			<p>${user.aboutMe}</p>
	
		</c:when>
			<c:otherwise>
				<h2>User Not Found</h2>
			</c:otherwise>
	</c:choose>

	<c:choose>
	<c:when test="${not empty user and not empty user.favoriteBooks }">
	<h4>Your Favorites</h4>
	<c:forEach var="favorite" items="${user.favoriteBooks}">
	<div>
				<ul>
					<li>Title: ${favorite.title}</li>
				</ul>
				<a href="showById.do?id=${favorite.id}"><img src="${favorite.coverUrl}" width="150"></a>
				
				</div>
	</c:forEach>
	</c:when>
	</c:choose>

	<form action="searchPage.do" method="GET">
		 <input type="submit" value="Search">
	</form>
	
<style>
  form {
    margin-bottom: 10px;
  }
</style>

</body>
</html>