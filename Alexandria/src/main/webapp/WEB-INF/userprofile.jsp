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
		<c:when test="${not empty sessionScope.loggedInUser}">
		<div class="profile-name-username-container">
			<h2 class="profile-name">${loggedInUser.firstName} ${loggedInUser.lastName}</h2>
			<p class="profile-username">"${sessionScope.loggedInUser.username}" "#Id: ${loggedInUser.id}"</p>
			</div>
			<br>
			
			<img src="${sessionScope.loggedInUser.imageUrl}" alt="Profile Picture" class="profile-pic">
			<br>
			<h6 class="profile-about-title">About Me:</h6>
			<p class="profile-about-desc">${sessionScope.loggedInUser.aboutMe}</p>
	
		</c:when>
			<c:otherwise>
				<h2 class="profile-nonuser">Not Logged In</h2>
			</c:otherwise>
	</c:choose>

	<c:choose>
	<c:when test="${not empty sessionScope.loggedInUser and not empty loggedInUser.favoriteBooks }">
	<h4 class="profile-fav-title">Your Favorites</h4>
	<c:forEach var="favorite" items="${loggedInUser.favoriteBooks}">
	<div>
				<ul class="fav-list">
				<li>Title: ${favorite.title}</li>
				</ul>
				<a href="showById.do?id=${favorite.id}"><img src="${favorite.coverUrl}" width="150"></a>
				<form action="deleteFavoriteBook.do" method="POST">
				<input type="hidden" value="${favorite.id}" name="bookId">
				<input type="submit" value="Remove From Favorites">
				</form>
	</div>
	</c:forEach>
	</c:when>
	</c:choose>
	
	<form action="createClub.do" method="GET">
		<input type="submit" value="Create A Book Club!">
	</form>

	<form action="updateuserprofile.do" method="GET">
		<input type="hidden" name="userId" value="${loggedInUser.id}" />
		<input type="submit" value="Update Profile">
	</form>

	<form action="logout.do" method="GET">
		<input type="submit" value="Log out">
	</form>

</body>
</html>