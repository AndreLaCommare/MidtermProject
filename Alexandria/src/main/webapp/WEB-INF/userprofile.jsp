<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<jsp:include page="bootstrapHead.jsp" />
<link rel="icon" type="image/x-icon" href="/resources/logo.png">

</head>

<style>
  body {
    padding-top: 20px;
    padding-left: 20px;
  }
  
  form {
    margin-bottom: 10px;
  }
</style>

<body>

  <div class="navbar">
    <a href="home.do">Home</a>
  </div>
  
	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<h2>Your Account Details</h2>
			<h3>User name: ${sessionScope.loggedInUser.username} (id: ${loggedInUser.id})</h3>
			<br>

			<h4>${loggedInUser.firstName} ${loggedInUser.lastName}</h4>
			<img src="${sessionScope.loggedInUser.imageUrl}" alt="Profile Picture" width="200">
			<br>
			<h6>About Me:</h6>
			<p>${sessionScope.loggedInUser.aboutMe}</p>
	
		</c:when>
			<c:otherwise>
				<h2>Not Logged In</h2>
			</c:otherwise>
	</c:choose>

	<c:choose>
	<c:when test="${not empty sessionScope.loggedInUser and not empty loggedInUser.favoriteBooks }">
	<h4>Your Favorites</h4>
	<c:forEach var="favorite" items="${loggedInUser.favoriteBooks}">
	<div>
				<ul>
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

	<form action="searchpage.do" method="GET">
		 <input type="submit" value="Search">
	</form>
	
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
	
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>