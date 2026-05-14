<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
        <a href = "${pageContext.request.contextPath}/trip" class="nav-item ${pageName == 'trips' ? 'active' : ''}">
            <i class="fas fa-calendar-check"></i>
            <span>Schedule Trip</span>
        </a>
        <a href = "${pageContext.request.contextPath}/bus" class="nav-item  ${pageName == 'buses' ? 'active' : ''}">
            <i class="fa-solid fa-bus-simple"></i>
            <span>Buses </span>
        </a>
        <a href ="${pageContext.request.contextPath}/route"  class="nav-item ${pageName == 'routes' ? 'active' : ''}">
            <i class="fa-solid fa-route"></i>
            <span>Route</span>
        </a>
        <a href = "${pageContext.request.contextPath}/staff" class="nav-item ${pageName == 'staff' ? 'active' : ''}">
            <i class="fa-solid fa-users-gear"></i>
            <span>Staff</span>
        </a>
        <a href="${pageContext.request.contextPath}/viewBookings"  class="nav-item ${pageName == 'viewBookings' ? 'active' : ''}">
            <i class="fas fa-book"></i>
            <span>View Bookings</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="nav-item">
            <i class="fa-solid fa-right-from-bracket"></i>
            <span>Logout</span>
        </a>
    </nav>

    <div class="sidebarImage">
        <img src="${pageContext.request.contextPath}/images/footer.png" alt="Gantavya Hub Scene" class="vector-stop-img">
    </div>
</aside>