<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // This is a placeholder for your actual session check logic
    boolean isLoggedIn = (session.getAttribute("user") != null);
    
    // Get the current page URI to determine the active link
    String uri = request.getRequestURI();
%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Navigation.css"> 
<nav class="gantavya-nav">
    <div class="nav-container">
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

        <ul class="nav-links">
            <li>
                <a href="${pageContext.request.contextPath}/home" 
                   class="<%= uri.endsWith("home") || uri.endsWith("Index.jsp") ? "active" : "" %>">Home</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/search" 
                   class="<%= uri.contains("/search") || uri.contains("Booking.jsp") ? "active" : "" %>">Booking</a>
            </li>
            
            <% if (isLoggedIn) { %>
                <li>
                    <a href="my-bookings.jsp" 
                       class="<%= uri.endsWith("MyBookings.jsp") ? "active" : "" %>">My Bookings</a>
                </li>
            <% } %>
            
            <li>
                <a href="${pageContext.request.contextPath}/about" 
                   class="<%= uri.endsWith("about") ? "active" : "" %>">About</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/contact" 
                   class="<%= uri.endsWith("contact") ? "active" : "" %>">Contact</a>
            </li>

            <li class="auth-item">
                <% if (!isLoggedIn) { %>
                    <a href="${pageContext.request.contextPath}/login" 
                       class="login-btn <%= uri.endsWith("login") ? "active-btn" : "" %>">Login</a>
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