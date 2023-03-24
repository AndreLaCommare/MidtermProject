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
		<div class="profile-name-username-container">
			<h2 class="profile-name">${user.firstName} ${user.lastName}</h2>
			<p class="profile-username">"${user.username}" "#Id: ${user.id}"</p>
			<img src="${user.imageUrl}" alt="Profile Picture" class="other-profile-pic">
			<h6 class="other-profile-about-title">About Me:</h6>
			<p class="other-profile-about-desc">${user.aboutMe}</p>
			
			</div>
		</c:when>
			<c:otherwise>
				<h2 class="error-msg">User Not Found</h2>
			</c:otherwise>
	</c:choose>
	<div class="fav-scroll">
	<h4 class="profile-fav-title">${user.firstName}'s Picks</h4>
	<c:choose>
	<c:when test="${not empty user and not empty user.favoriteBooks }">
	<c:forEach var="favorite" items="${user.favoriteBooks}">
	<div class="fav-list-container">
				<ul class="fav-list">
				<li class="profile-fav-book-title">${favorite.title}</li>
				</ul>
				<a href="showById.do?id=${favorite.id}"><img src="${favorite.coverUrl}" class="fav-cover"></a>
				</div>
	</c:forEach>
	</c:when>
	</c:choose>
	</div>
	
	<div class="owned-scroll">
	<h4 class="profile-owned-title">${user.firstName}'s Clubs</h4>
	<c:choose>
	<c:when test="${not empty user and not empty user.ownedClubs }">
	<c:forEach var="ownedClub" items="${user.ownedClubs}">
	<div class="owned-list-container">
	<ul class="owned-list">
				<li class="profile-owned-club-name">${ownedClub.name}</li>
				</ul>
				<a href="findClubById.do?clubId=${ownedClub.id}"><img src="${ownedClub.imageURL}" class="club-cover"></a>
				
	
				
				
	
	</div>
	</c:forEach>
	</c:when>
	</c:choose>
</div>
</body>
</html>