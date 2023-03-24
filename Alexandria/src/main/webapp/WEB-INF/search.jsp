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
<jsp:include page="navbar.jsp"/>
</head>
<body>

<div id=searchimg>
<div id="search-blk">

<h4 class="book-club-search-title">Book Search</h4>
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
	<br>
	<h4 class="book-club-search-title">User Search</h4>
	<form action="findByUsername.do" method="GET">
	<input type="text" placeholder="Username" name="username" class="search-input">
	<button type="submit" role="button" class="search-btn-submit"><img src="resources/search.svg"></button>
	</form>
	
</div>
</div>
</body>
</html>