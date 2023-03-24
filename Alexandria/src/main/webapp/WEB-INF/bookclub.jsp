<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Club</title>
<link rel="stylesheet" href="resources/styles.css" />
<link rel="icon" type="image/x-icon" href="/resources/logo.png">
<jsp:include page="navbar.jsp" />
</head>
<body>
	<c:choose>
		<c:when test="${empty bookClub}"></c:when>

		
		<c:otherwise>
			<div class="book-club-container">

			<h2 class ="book-club-name">${bookClub.name}</h2>
			<p class="book-club-id">Club ID: ${bookClub.id }</p>
			<img src="${bookClub.imageURL }" class="book-club-cover">
			<br>
			<p class="book-club-desc">About us: ${bookClub.description}</p>
			</div>
			
			<c:choose>
			<c:when test="${ empty bookClub.clubMembers and not empty sessionScope.loggedInUser  and  loggedInUser.id != bookClub.owner.id }">
				<form action="joinClub.do" method="POST">
					<input type="hidden" placeholder="Club ID" name="clubId" value="${bookClub.id}">
					<button type="submit" role="button" class="new-user-join-club-btn">Join<img src="resources/checkicon.svg" class="new-user-join-club-icon"></button>
					</form>
					
					
					
					
			</c:when>
			<c:otherwise>
			
					
			
			
			<c:choose>
				<c:when
					test="${ myClub != true} ">
					
					
					
					<form action="joinClub.do" method="POST">
					<input type="hidden" placeholder="Club ID" name="clubId" value="${bookClub.id}">
					<button type="submit" role="button" class="new-user-join-club-btn">Join<img src="resources/checkicon.svg" class="new-user-join-club-icon"></button>
					</form>
					
					
					

					

				</c:when>
			</c:choose>
			<form action="joinClub.do" method="POST">
					<input type="hidden" placeholder="Club ID" name="clubId" value="${bookClub.id}">
					<button type="submit" role="button" class="new-user-join-club-btn">Join<img src="resources/checkicon.svg" class="new-user-join-club-icon"></button>
					</form>
			<form action="leaveClub.do" method="POST">
					<input type="hidden" placeholder="Club ID" name="clubId" value="${bookClub.id}">
					<button type="submit" role="button" class="user-leave-club-btn">Leave<img src="resources/removeicon.svg" class="club-leave-icon"></button>
					</form>
					
			
			
			
			</c:otherwise>
			</c:choose>
			
			<h3 class="club-owner-name">Club Owner:<a href="findByUsername.do?username=${bookClub.owner.username }">${bookClub.owner.username}</a></h3>
		<!-- BOOK CLUB DISPLAY FOR OWNER START -->
			<c:choose>
				<c:when test="${not empty sessionScope.loggedInUser and loggedInUser.id == bookClub.owner.id}">
			<div class="club-owner-functions-container">
				
					
					<h4 class="club-owner-options">Edit your club</h4>
						<form action="UpdateClub.do" method="POST">
							<input type="hidden" name="id" value="${bookClub.id}">
							<h4 class="club-owner-name-title">Club Name:</h4><input type="text" name="name" value="${bookClub.name}" class="club-owner-name-input">
							<h4 class="club-owner-about-title">About Club:</h4><input type="text" name="description" value="${bookClub.description}" class="club-owner-desc-input">
							<br>
							<h4 class="club-owner-pic-title">Club Cover URL:</h4><input type="text" name="imageURL" value="${bookClub.imageURL}" class="club-owner-pic-input">
							<br>
							<button type="submit" role="button" class="owner-update-club-btn"><p class="owner-update-club-title">Update</p><img src="resources/changeicon.svg" class="club-owner-update-icon"></button>
						</form>
					

				
						<form action="DeleteClub.do" method="POST">
							<input type="hidden" placeholder="Club ID" name="clubId" value="${bookClub.id}">
							<button type="submit" role="button" class="owner-delete-club-btn"><p class="owner-delete-club-title">Delete Club</p><img src="resources/removeicon.svg" class="owner-delete-club-icon"></button>
						</form>
				
		</div>
				</c:when>
			</c:choose>

			<!-- BOOK CLUB DISPLAY FOR ALL USERS -->
			<div class="club-right-side">
			
			<h4 class="club-member-favs">Picks for ${bookClub.name} members</h4>
			
			<div class="club-book-scroll-container">
			<c:forEach var="book" items="${bookClub.clubBooks}">
			<div class="club-book-scroll">
					<h5 class="club-book-title">${book.title}</h5>
					<a href="showById.do?id=${book.id}"><img src="${book.coverUrl}" class="club-book-cover"></a>
					<c:if test="${sessionScope.loggedInUser.id == bookClub.owner.id }">
					<form action="deleteFavoriteBook.do" method="POST">
					<input type="hidden" value="${book.id}" name="bookId">
					<button type="submit" role="button" class="club-remove-book-btn"><img src="resources/removeicon.svg" class="club-owner-remove-book-icon"></button>
					</form>
					</c:if>
			</div>
			</c:forEach>
			</div>

			<h3 class="club-members-title">Club Members:</h3>
			<div class="club-members-scroll">
			
			<div class="club-members-names">
			<c:forEach var="member" items="${bookClub.clubMembers}">
				<ul class="club-members-list">
					<li class="club-members-member"><a href="findByUsername.do?username=${member.username }">${member.username}</a></li>
				</ul>
			</c:forEach>
			</div>
			</div>
			
			
			<c:if test ="${empty sessionScope.loggedInUser }">
			
			Log In or Sign Up to Join a Club!
			</c:if>
			
			
					
			
		</div>
		</c:otherwise>
	</c:choose>
</body>
</html>