<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Club</title>
<link rel="icon" type="image/x-icon" href="/resources/logo.png">
</head>
<body>
<c:choose>
    <c:when test="${empty bookClub}">
       No Club Found.<br>
       <a href="home.do">Return to Menu</a>
    </c:when>
    <c:otherwise>
        <div>

  
  
  <h2>${bookClub.name}</h2>
  <p>Club ID: ${bookClub.id }</p>
  <img src="${bookClub.imageURL }" width="150" height="150"><br>
  <p>Club Description: ${bookClub.description}</p>

 <c:choose>
 <c:when test="${not empty sessionScope.loggedInUser and loggedInUser.id == bookClub.owner.id}">
 
 
 
 
 								<div>
									

									<form action="UpdateClub.do" method="POST">
										<input type="hidden" name="id" value="${bookClub.id}">
										
		 
											 <input type="text" name="name" value="${bookClub.name }"> <br>
											 <input type="text" name="description" value="${bookClub.description }"> <br>
											 <input type="text" name="imageURL" value="${bookClub.imageURL }"> <br>
											  
										
										<input type="submit" value="Update Club">
									</form>
								</div>
  
 
<form action="DeleteClub.do" method="POST">
	<input type="hidden" placeholder="Club ID" name="clubId" class="search-input" value= "${bookClub.id}">
	<button type="submit" role="button" class="search-btn-submit">Delete Club</button>
	</form>
	
	<form action="UpdateClub.do" method="POST">
	<input type="hidden" placeholder="Club ID" name="clubId" class="search-input" value= "${bookClub.id}">
	<button type="submit" role="button" class="search-btn-submit">Update Club</button>
	</form>
 
  
 
 </c:when>
 </c:choose>
 
 
 
 
 
 
 

 
---------------------------------------------
	<c:choose>
	<c:when test="${not empty sessionScope.loggedInUser and not empty loggedInUser.favoriteBooks and myClub == true}">
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
------------------------------------------------






 <c:choose>
 <c:when test="${not empty sessionScope.loggedInUser and loggedInUser.id != bookClub.owner.id}">
 	<form action="JoinClub.do" method="POST">
	<input type="hidden" placeholder="Club ID" name="clubId" class="search-input" value= "${bookClub.id}">
	<button type="submit" role="button" class="search-btn-submit">Join Club!</button>
	</form>
 
  </c:when>
 </c:choose>
 
 <form action="home.do" method="GET">
 <button type="submit" role="button" class="search-btn-submit">Return Home</button>
	</form>
 
</div>
    </c:otherwise>
</c:choose>



</body>
</html>