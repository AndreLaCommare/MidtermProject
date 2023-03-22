<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book List</title>
<link rel="icon" type="image/x-icon" href="/resources/logo.png">
<jsp:include page="navbar.jsp"/>
<link rel="stylesheet" href="resources/styles.css"/>
</head>
<body>
<c:choose>
    <c:when test="${empty bookList}">
       No Book List Found.<br>
       <a href="home.do">Return to Menu</a>
    </c:when>
    <c:otherwise>
        <div>
  
  
  <h2>${bookList.name}</h2>
  <p>Book List ID: ${bookList.id }</p>
  <p>Book List Description: ${bookList.description}</p>
  <img src="${bookList.imageUrl }" width="150" height="150"><br>

 <a href="DeleteBookList.do?id=${bookList.id }">Delete Current Book List</a> <br>
  <a href="UpdateBookList.do?id=${bookList.id }">Update Current Book List</a> <br>
 
 
 
 
 
 
  <a href="userprofile.do">Return to Menu</a>
</div>
    </c:otherwise>
</c:choose>



</body>
</html>