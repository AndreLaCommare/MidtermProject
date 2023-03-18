<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logged Out</title>


</head>
<body>

  <p><a href="mainPage.do">Main Page</a></p>
  <h2>Username: <c:out value="${loggedInUser.username}"/></h2>
  <h4>Login time: <c:out value="${loginTime}"/></h4>

</body>
</html>