<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Sidenav.css">
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Gantavya Logo" class="brand-logo-img">
        </div>
        <span class="brand-name">Gantavya</span>
    </div>

    <nav class="sidebar-nav">
        <%-- We use a simple logic to check which page is active --%>
        <a href = "${pageContext.request.contextPath}/admin" class="nav-item ${pageName == 'dashboard' ? 'active' : ''}">
            <i class="fa-solid fa-gauge-high"></i>
            <span>Dashboard</span>
        </a>
        <a href = "${pageContext.request.contextPath}/trip" class="nav-item ${pageName == 'bookings' ? 'active' : ''}">
            <i class="fa-solid fa-ticket"></i>
            <span>Schedule Trip</span>
        </a>
        <a href = "${pageContext.request.contextPath}/bus" class="nav-item  ${pageName == 'buses' ? 'active' : ''}">
            <i class="fa-solid fa-bus-simple"></i>
            <span>Buses </span>
        </a>
        <a href ="${pageContext.request.contextPath}/route"  class="nav-item ${pageName == 'passengers' ? 'active' : ''}">
            <i class="fa-solid fa-route"></i>
            <span>Route</span>
        </a>
        <a href = "${pageContext.request.contextPath}/staff" class="nav-item ${pageName == 'reports' ? 'active' : ''}">
            <i class="fa-solid fa-chart-bar"></i>
            <span>Staff</span>
        </a>
        <a href="payments" class="nav-item ${pageName == 'payments' ? 'active' : ''}">
            <i class="fa-solid fa-credit-card"></i>
            <span>Payments</span>
        </a>
        <a href="settings" class="nav-item ${pageName == 'settings' ? 'active' : ''}">
            <i class="fa-solid fa-gear"></i>
            <span>Settings</span>
        </a>
    </nav>

    <div class="sidebarImage">
        <img src="${pageContext.request.contextPath}/images/footer.png" alt="Gantavya Hub Scene" class="vector-stop-img">
    </div>
</aside>

</body>
</html>