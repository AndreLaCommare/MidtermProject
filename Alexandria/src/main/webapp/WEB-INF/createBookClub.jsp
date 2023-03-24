<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create a Book Club</title>
 <link rel="stylesheet" href="resources/styles.css"/>
 <link rel="icon" type="image/x-icon" href="resources/logo.png">
</head>
<body>
<jsp:include page="navbar.jsp"/>

<h1 class="create-book-club-title">Create a Book Club</h1>
<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser }">

<div class="create-club-container">
<form action="createBookClub.do" method="POST"><br>
<h3 class="club-name-title">Club Name:</h3><input type="text" name="name" required class="club-name-input"/>
<br>
<h3 class="club-pic-title">Club Picture URL</h3><input type="text" name="imageURL" class="club-pic-input"/>
<br>
<h3 class="club-description-title">Club Description:</h3><input type="text" name="description" class="club-desc-input"/>
<br>
<input type="hidden" name="owner.id" value = "${loggedInUser.id }"/><br>


<button role="button" type="submit" class="book-create-submit"><img src="resources/createclubicon.svg" class="book-create-submit-icon"></button>
</form>
</div>
</c:when>
		<c:otherwise>
			<h2>Log In To Create a Book Club</h2>
		</c:otherwise>
	</c:choose>

</body>
</html>