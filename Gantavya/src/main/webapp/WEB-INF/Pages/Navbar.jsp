<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // This is a placeholder for your actual session check logic
    boolean isLoggedIn = (session.getAttribute("user") != null);
    
    // Get the current servlet path. When using jsp:include, the original 
    // servlet path is stored in this request attribute.
    String currentPath = (String) request.getAttribute("jakarta.servlet.forward.servlet_path");
    if (currentPath == null) {
        currentPath = request.getServletPath();
    }
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
            <li>
                <a href="${pageContext.request.contextPath}/home" 
                   class="<%= "/home".equalsIgnoreCase(currentPath) || "/".equals(currentPath) ? "active" : "" %>">Home</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/search" 
                   class="<%= "/search".equalsIgnoreCase(currentPath) || "/booking".equalsIgnoreCase(currentPath) || "/payment".equalsIgnoreCase(currentPath) ? "active" : "" %>">Booking</a>
            </li>
            
            <% if (isLoggedIn) { %>
                <li>
                    <a href="${pageContext.request.contextPath}/my-bookings" 
                       class="<%= "/my-bookings".equalsIgnoreCase(currentPath) ? "active" : "" %>">My Bookings</a>
                </li>
            <% } %>
            
            <li>
                <a href="${pageContext.request.contextPath}/about" 
                   class="<%= "/about".equalsIgnoreCase(currentPath) ? "active" : "" %>">About</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/contact" 
                   class="<%= "/contact".equalsIgnoreCase(currentPath) ? "active" : "" %>">Contact</a>
            </li>

            <li class="auth-item">
                <% if (!isLoggedIn) { %>
                    <a href="${pageContext.request.contextPath}/login" 
                       class="login-btn <%= "/login".equalsIgnoreCase(currentPath) ? "active" : "" %>">Login</a>
                <% } else { %>
                    <div class="user-dropdown">
                        <div class="user-profile">
                            <span class="user-name"><%= session.getAttribute("passengerName") != null ? session.getAttribute("passengerName") : "User" %></span>
                            <i class="fas fa-user-circle profile-icon"></i>
                        </div>
                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
                            <li><a href="${pageContext.request.contextPath}/logout" class="logout-link"><i class="fa fa-sign-out" style="font-size:14px; padding-right:2px;"></i>Logout</a></li>
                        </ul>
                    </div>
                <% } %>
            </li>
        </ul>
    </div>
</nav>