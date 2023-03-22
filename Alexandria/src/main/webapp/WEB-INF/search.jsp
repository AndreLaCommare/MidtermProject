<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search</title>
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

<div id=searchimg>
<div id="search-blk">


	<form action="bookByTitle.do" method="GET">
	<input type="text" placeholder="Title" name="title" class="search-input">
	<button type="submit" role="button" class="search-btn-submit"><img src="resources/search.svg"></button>
	</form>
	<br>
	<form action="bookByAuthor.do" method="GET">
	<input type="text" placeholder="Author" name="author" class="search-input">
	<button type="submit" role="button" class="search-btn-submit"><img src="resources/search.svg"></button>
	</form>
	<br>
	<form action="bookByLanguage.do" method="GET">
	<input type="text" placeholder="Language" name="language" class="search-input">
	<button type="submit" role="button" class="search-btn-submit"><img src="resources/search.svg"></button>
	</form>
	<br>
	<form action="bookByDescription.do" method="GET">
	<input type="text" placeholder="Description" name="description" class="search-input">
	<button type="submit" role="button" class="search-btn-submit"><img src="resources/search.svg"></button>
	</form>
	<br>
	<!-- <form action="bookbygenre.do" method="GET">
	<input type="text" placeholder="Genre" name="genre" class="search-input">
	<button type="submit" role="button" class="search-btn-submit"><img src="resources/search.svg"></button>
	</form>
	<br> -->
	<form action="bookByIsbn.do" method="GET">
	<input type="text" placeholder="ISBN" name="isbn"  class="search-input">
	<button type="submit" role="button" class="search-btn-submit"><img src="resources/search.svg"></button>
	</form>
	<br>
	
	<h4 class="book-club-search-title">Book Club Search</h4>
	<form action="findClubById.do" method="GET">
	<input type="text" placeholder="Club ID" name="clubId" class="search-input">
	<button type="submit" role="button" class="search-btn-submit"><img src="resources/search.svg"></button>
	</form>
</div>
</div>
</body>
</html>