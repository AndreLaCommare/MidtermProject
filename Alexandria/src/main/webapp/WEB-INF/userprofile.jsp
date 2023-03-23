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
</head>
<body>
<jsp:include page="navbar.jsp"/>

	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
		<div class="profile-name-username-container">
			<h2 class="profile-name">${loggedInUser.firstName} ${loggedInUser.lastName}</h2>
			<p class="profile-username">"${sessionScope.loggedInUser.username}" "#Id: ${loggedInUser.id}"</p>
	<div class=user-functions-container>
	<form action="createClub.do" method="GET" class="create-club-form">
	<button type="submit" role="button" class="create-club-btn"><p class="create-text">Create Club</p><img src="resources/createclubicon.svg"></button>
	</form>
	
	<form action="updateuserprofile.do" method="GET" class="profile-update-form">
	<button type="submit" role="button" class="update-profile-btn"><p class="update-text">Update Profile</p><img src="resources/changeicon.svg"></button>
	<input type="hidden" name="userId" value="${loggedInUser.id}"/>
	</form>
	</div>
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

	<div class="fav-scroll">
	<h4 class="profile-fav-title">${loggedInUser.firstName}'s Picks</h4>
	<c:choose>
	<c:when test="${not empty sessionScope.loggedInUser and not empty loggedInUser.favoriteBooks }">
	<c:forEach var="favorite" items="${loggedInUser.favoriteBooks}">
	<div class="fav-list-container">
				<ul class="fav-list">
				<li class="profile-fav-book-title">${favorite.title}</li>
				</ul>
				<a href="showById.do?id=${favorite.id}"><img src="${favorite.coverUrl}" class="fav-cover"></a>
				<form action="deleteFavoriteBook.do" method="POST">
				<input type="hidden" value="${favorite.id}" name="bookId">
				<input type="submit" value="Remove From Favorites">
				</form>
	</div>
	</c:forEach>
	</c:when>
	</c:choose>
	</div>
</body>
</html>