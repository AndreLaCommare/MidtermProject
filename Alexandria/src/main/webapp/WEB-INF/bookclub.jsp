<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Club</title>
<link rel="icon" type="image/x-icon" href="/resources/logo.png">
</head>
<body>
<c:choose>
    <c:when test="${empty bookClub}">
       No Club Found.<br>
       <a href="home.do">Return to Menu</a>
    </c:when>
    <c:otherwise>
        <div>
  
  
  <h2>${bookClub.name}</h2>
  <img src="${bookClub.imageurl }" width="150" height="150"><br>
  <p>Club Description: ${bookClub.description}</p>

 <a href="DeleteClub.do?id=${bookClub.id }">Delete Current Fighter</a> <br>
  <a href="UpdateClub.do?id=${bookClub.id }">Update Current Fighter</a> <br>
 
 
 
 
 
 
  <a href="home.do">Return to Menu</a>
</div>
    </c:otherwise>
</c:choose>



</body>
</html>