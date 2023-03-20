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
				<c:choose>
    <c:when test="${not empty review }">
        <div>
        <p>Review: ${review.review	} </p>
        
        <form action="updatereview.do" method="GET">
		 <input type="hidden" name="book.id" value="${book.id}">
				<input type="hidden" name="user.id" value="${loggedInUser.id}">
				<input type="hidden" name="id.bookId" value="${book.id}">
				<input type="hidden" name="id.userId" value="${loggedInUser.id}">
				<label for="rating">Score out of 10:</label> <input type="number"
				 name="rating"value="${review.rating }" > <br> <label for="review"></label><br>
				<textarea id="review" name="review" rows="4" cols="50">${review.review }</textarea>
		 <input type="submit" value="Edit Review">
	</form>
        </div>
  
  
  
   </c:when>
					<c:when test="${not empty sessionScope.loggedInUser }">
  
  Write a Review:
  
  <form action="review.do" method="post">

							<label for="rating">Score out of 10:</label> <input type="number"
								name="rating" > <br> <label for="review"></label><br>


							<textarea id="review" name="review" rows="4" cols="50"></textarea>
							<br> <input type="hidden" name="book.id" value="${book.id}">
							<input type="hidden" name="user.id" value="${loggedInUser.id}">
							<input type="hidden" name="id.bookId" value="${book.id}">
							<input type="hidden" name="id.userId" value="${loggedInUser.id}">
							<input type="submit" value="Submit Review">

						</form>
					</c:when>
					<c:otherwise>
						<h4>Log In To Write A Review</h4>
					</c:otherwise>
				</c:choose>










			<form action="account.do" method="GET">
		 <input type="submit" value="Return to Profile">
	</form>
			
			</div>
		</c:otherwise>
	</c:choose>