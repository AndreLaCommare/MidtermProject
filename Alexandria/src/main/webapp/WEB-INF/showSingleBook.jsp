<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
  <p>Description: ${book.description	} </p>
  <p>Page Count: ${book.pages }</p>
  <p>Publication Year: ${book.publishedYear }</p>
  <p>Price: ${book.price}</p>
  <p>Language ${book.language}</p>
  <p>Written By: ${book.author}</p>
 
  <a href="home.do">Return Home</a>
</div>
    </c:otherwise>
</c:choose>
