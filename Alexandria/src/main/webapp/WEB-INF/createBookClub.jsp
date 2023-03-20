<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create a Book Club</title>
</head>
<body>

<h1>Create a Book Club!</h1>
<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser }">

<form action="createBookClub.do" method="POST"><br>

Club Name: <input type="text" name="name" /><br>
Club Profile Pic(Image URL)<input type="text" name="imageURL" /><br>
Club Description: <input type="text" name="description" /><br>
 <input type="hidden" name="owner.id" value = "${loggedInUser.id }"/><br>


<input type="submit"
			value="Create Book Club!" />
</form>

</c:when>
		<c:otherwise>
			<h2>Log In To Create a Book Club</h2>
		</c:otherwise>
	</c:choose>

</body>
</html>