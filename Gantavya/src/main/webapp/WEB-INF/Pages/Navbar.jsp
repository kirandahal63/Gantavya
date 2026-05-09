<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // This is a placeholder for your actual session check logic
    boolean isLoggedIn = (session.getAttribute("user") != null);
%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Navigation.css"> 
<nav class="gantavya-nav">
    <div class="nav-container">
        <!-- Left: Logo -->
        <a href="${pageContext.request.contextPath}/home" class="logo-wrapper">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Gantavya Logo" class="nav-logo">
            <span class="logo-text">GANTAVYA</span>
        </a> 
        
        <input type="checkbox" id="nav-check">
        <label for="nav-check" class="nav-btn">
            <span></span>
            <span></span>
            <span></span>
        </label>

        <!-- Right: Links & Auth -->
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/home" class="active">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/search">Booking</a></li>
            <li><a href="${pageContext.request.contextPath}/booking">Test</a></li><!-- Remove it later -->
            
            <% if (isLoggedIn) { %>
                <li><a href="my-bookings.jsp">My Bookings</a></li>
            <% } %>
            
            <li><a href="${pageContext.request.contextPath}/about">About</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>

            <li class="auth-item">
                <% if (!isLoggedIn) { %>
                    <a href="${pageContext.request.contextPath}/login" class="login-btn">Login</a>
                <% } else { %>
                    <div class="user-profile">
                        <i class="fas fa-user-circle profile-icon"></i>
                        <a href="logout.jsp" class="logout-link">Logout</a>
                    </div>
                <% } %>
            </li>
        </ul>
    </div>
</nav>