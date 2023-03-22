<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${book.title} Details</title>
<link rel="icon" type="image/x-icon" href="/resources/logo.png">
<link rel="stylesheet" href="resources/styles.css"/>
</head>
<body>
<div id = "header">
    <a href="home.do" style="padding: 0; margin: 0;"><img class=logo src="resources/logo.png"></a><h2 class="sitename"><strong>Alexandria</strong></h2>
    <a class="login-btn" href="loginpage.do" role="button">Log In</a>
    <a class="signin-btn" href="signuppage.do" role="button">Sign Up</a>
    <a class="trending-btn">Trending</a>
    <a class="search-btn" href="searchpage.do">Search</a>
</div>


	<c:choose>
		<c:when test="${empty book}">
       No Book Found.<br>
			<a href="home.do">Return Home</a>
		</c:when>
		<c:otherwise>
			<div>
				<h2 class="single-book-title">${book.title}</h2>
				
				<img src="${book.coverUrl }" class="single-book-cover">
				<ul class="single-book-container">
				<li class="single-book-desc">Description: ${book.description}</li><br>
				<li class="single-book-pages">Page Count: ${book.pages }</li><br>
				<li class="single-book-year">Publication Year: ${book.publishedYear }</li><br>
				<li class="single-book-lang">Language: ${book.language}</li><br>
				<li class="single-book-author">Author: ${book.author}</li>
				</ul>
				</div>
				<br>

				<c:if test="${not empty book.bookComments }">

						Comments:
						<div class="comment-list">
							<c:forEach var="bookComment" items="${book.bookComments }">


								<div class ="book-comment">
								<p class ="commentInfo"> Comment ID: ${bookComment.id} User: ${bookComment.user.username} Posted On: ${bookComment.commentDate}
								
								<c:if test="${not empty bookComment.parentComment }">
								
								
								In Reply To: ${bookComment.parentComment.id }
								</c:if>
								</p>
								<p class="book-comment-child">${bookComment.bookComment } </p>
								
								<c:if test="${not empty sessionScope.loggedInUser }">
										<form action="replyComment.do" method="GET">

											<input type="hidden" name="book.id" value="${book.id}">

											<input type="hidden" name="parentCommentId"
												value="${bookComment.id}"> <input type="text"
												id="bookComment" name="bookComment"> <input
												type="submit" value="Reply">

										</form>


									</c:if>
								</div>

							</c:forEach>
						</div>
				</c:if>
				<c:set var="haveReviewed" value="${false }"></c:set>

				<c:if test="${not empty book.reviews }">

					<h2>Reviews:</h2>
					<c:forEach var="review" items="${book.reviews }">

						<c:choose>
							<c:when test="${sessionScope.loggedInUser.id == review.user.id }">
								<c:set var="haveReviewed" value="${true }"></c:set>

								<div>
									<p>${review.review	}</p>

									<form action="updatereview.do" method="GET">
										<input type="hidden" name="book.id" value="${book.id}">
										<input type="hidden" name="user.id" value="${loggedInUser.id}">
										<input type="hidden" name="id.bookId" value="${book.id}">
										<input type="hidden" name="id.userId"
											value="${loggedInUser.id}"> <label for="rating">Score
											out of 10:</label> <input type="number" name="rating"
											value="${review.rating }"> <br> <label
											for="review"></label><br>
										<textarea id="review" name="review" rows="4" cols="50">${review.review }</textarea>
										<input type="submit" value="Edit Review">
									</form>
								</div>
							</c:when>



							<c:otherwise>
								<h3>Posted Review By: ${ review.user.username}</h3>

								<p>Rating: ${review.rating }</p>
								<blockquote>${review.review}</blockquote>


							</c:otherwise>
						</c:choose>

					</c:forEach>

				</c:if>


				<c:choose>
					<c:when
						test="${not empty sessionScope.loggedInUser and not haveReviewed}">
  
  Write a Review:
  
  <form action="review.do" method="post">

							<label for="rating">Score out of 10:</label> <input type="number"
								name="rating"> <br> <label for="review"></label><br>


							<textarea id="review" name="review" rows="4" cols="50"></textarea>
							<br> <input type="hidden" name="book.id" value="${book.id}">
							<br> <input type="hidden" name="id.bookId"
								value="${book.id}"> <input type="submit"
								value="Submit Review">

						</form>
					</c:when>

				</c:choose>


				<c:choose>

					<c:when test="${not empty sessionScope.loggedInUser }">

				Leave a Comment:

				<form action="comment.do" method="post">

							<input type="text" id="bookComment" name="bookComment">
							<br>
							<input type="hidden" name="book.id" value="${book.id}">
							<input type="submit" value="Publish Comment">
				</form>
				
						<form action="addbooktofavorites.do" method="POST">
						<input type="hidden" name="bookId" value="${book.id}">
						<input type="submit" value="Add to Favorites">


							<input type="text" id="bookComment" name="bookComment"> <br>

							<input type="hidden" name="book.id" value="${book.id}"> <input
								type="submit" value="Publish Comment">
						</form>
						
						
						<form action="addBookToFavorites.do" method="POST">
							<input type="hidden" name="bookId" value="${book.id}">
							 <input type="submit" value="Add to Favorites">
							 <select name="option">   
							 <option value="loggedInUser">My Favorites</option>
							 <c:forEach var="club" items="${sessionScope.loggedInUser.ownedClubs }">
							 <option value="${club.id }" >${club.name }</option>
							 
							 </c:forEach>
							 
							   </select>

						</form>
						
						
					</c:when>
					<c:otherwise>
					<div class="single-book-prompt-user-login">
						<h4>Log In to write a review or leave a comment</h4>

						<form action="signuppage.do" method="GET">
						<input type="submit" value="Sign Up" class="single-book-signup-btn">
						</form>
						</div>
							<!--USER IS NOT LOGGED IN FLOW END  -->
					</c:otherwise>
				</c:choose>

		</c:otherwise>
	</c:choose>