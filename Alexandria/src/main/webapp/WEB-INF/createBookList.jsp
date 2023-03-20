<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create a Book List</title>
</head>
<body>

<h1>Create a Book List</h1>
<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser }">

<form action="createdBookList.do" method="POST"><br>

Book List Name: <input type="text" name="name" /><br>
Book List Pic(Image URL)<input type="text" name="imageUrl" /><br>
Book List Description: <input type="text" name="description" /><br>
 <input type="hidden" name="user.id" value = "${loggedInUser.id }"/><br>


<input type="submit"
			value="Create Book List" />
</form>

</c:when>
		<c:otherwise>
			<h2>Log In To Create a Book List</h2>
			<form action="home.do" method="GET">
		 <input type="submit" value="Go to Home">
	</form>
		</c:otherwise>
	</c:choose>

</body>
</html>