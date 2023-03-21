<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<jsp:include page="bootstrapHead.jsp" />
<link rel="icon" type="image/x-icon" href="/resources/logo.png">

</head>
<body>

	<%--Edit the file nav.jsp to change nav links --%>
	<%-- <%@ include file="nav.jsp"%> --%>



	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser }">
			<h2>Your Account Details</h2>
			<h3>User Name: ${sessionScope.loggedInUser.username } (id:
				${loggedInUser.id })</h3>
			<br>
			<h4>${loggedInUser.firstName }${ loggedInUser.lastName}</h4>

		</c:when>
		<c:otherwise>
			<h2>Not Logged In</h2>
		</c:otherwise>
	</c:choose>



	
	<form action="searchpage.do" method="GET">
		 <input type="submit" value="Search">
	</form>
	

	<form action="logout.do" method="GET">
		<input type="submit" value="Log out">
	</form>

	<form action="createClub.do" method="GET">
		<input type="submit" value="Create A Book Club!">
	</form>
<<<<<<< HEAD
	
	<form action="createbooklist.do" method="GET">
		 <input type="submit" value="Create a Book List">
	</form>
<!-- 	<form action="getbooklist.do" method="GET">
		 <input type="submit" value="See Your Favorites">
	</form> -->

	
=======
>>>>>>> 10fd887b7bb87a056b719f3cadfe23f838faef66

	<form action="updateuserprofile.do" method="GET">
		<input type="hidden" name="userId" value="${loggedInUser.id}" />
		<input type="submit" value="Update Profile">
	</form>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>