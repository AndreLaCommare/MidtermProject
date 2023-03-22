<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id = "header">
    <img class=logo src="resources/logo.png"><a class="sitename"><h2><strong>Alexandria</strong></h2></a>
    <c:if test="${empty sessionScope.loggedInUser}">
    <a class="login-btn" href="loginpage.do" role="button">Log In</a>
    <a class="signin-btn" href="signuppage.do" role="button">Sign Up</a> 
    <a class="trending-btn" href="" role="button">Trending</a>
    <a class="search-btn" href="searchPage.do" role="button">Search</a>
    </c:if>
    
     <c:if test="${not empty sessionScope.loggedInUser}">
    <a class="profile-btn" href="account.do" role="button">Profile</a>
    <a class="home-btn" href="home.do" role="button">Home</a>
    <a class="trending-btn" href="" role="button">Trending</a>
    <a class="search-btn" href="searchPage.do" role="button">Search</a>
    </c:if>
    
</div>