<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Details</title>
</head>
<body>


	<c:choose>
		<c:when test="${empty book}">
       No Book Found.<br>
			<a href="home.do">Return Home</a>
		</c:when>
		<c:otherwise>
			<div>
				<h2>${book.title}</h2>

				<img src="${book.coverUrl }" width="150" height="150"><br>
				<p>Description: ${book.description	}</p>
				<p>Page Count: ${book.pages }</p>
				<p>Publication Year: ${book.publishedYear }</p>
				<p>Price: ${book.price}</p>
				<p>Language ${book.language}</p>
				<p>Written By: ${book.author}</p>
				<br>

				<c:if test="${not empty book.bookComments }">

					<div>
						Comments:
						<div class="commentList">
							<c:forEach var="bookComment" items="${book.bookComments }">


								<div class ="bookComment">
								<p class ="commentInfo"> Comment ID: ${bookComment.id} User: ${bookComment.user.username} Posted On: ${bookComment.commentDate}
								
								<c:if test="${not empty bookComment.parentComment }">
								
								
								In Reply To: ${bookComment.parentComment.id }
								</c:if>
								</p>
								<p>${bookComment.bookComment } </p>
								
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

					<c:otherwise>
						<h4>Log In To Write A Review</h4>
						<form action="home.do" method="GET">
							<input type="submit" value="Go to Home">
						</form>

					</c:otherwise>
				</c:choose>


				<c:choose>

					<c:when test="${not empty sessionScope.loggedInUser }">

				Leave a Comment:

				<form action="comment.do" method="post">

							<input type="text" id="bookComment" name="bookComment"> <br>

							<input type="hidden" name="book.id" value="${book.id}"> <input
								type="submit" value="Publish Comment">
						</form>
						<form action="addBookToFavorites.do" method="POST">
							<input type="hidden" name="bookId" value="${book.id}"> <input
								type="submit" value="Add to Favorites">
						</form>
					</c:when>
					<c:otherwise>
						<h4>Log In To Write A Review and Leave a Comment</h4>

						<form action="account.do" method="GET">
							<input type="submit" value="Return to Profile">
						</form>



					</c:otherwise>
				</c:choose>


				<form action="account.do" method="GET">
					<input type="submit" value="Return to Profile">
				</form>


			</div>

		</c:otherwise>
	</c:choose>