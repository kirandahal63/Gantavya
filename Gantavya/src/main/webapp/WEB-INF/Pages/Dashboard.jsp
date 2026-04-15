<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gantavya - Dashboard</title>
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
    <div class="app-shell">

        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-brand">
                <div class="brand-icon"><i class="fa-solid fa-bus"></i></div>
                <span class="brand-name">Gantavya</span>
            </div>

            <nav class="sidebar-nav">
                <a href="dashboard" class="nav-item active">
                    <i class="fa-solid fa-gauge-high"></i>
                    <span>Dashboard</span>
                </a>
                <a href="bookings" class="nav-item">
                    <i class="fa-solid fa-ticket"></i>
                    <span>Bookings</span>
                </a>
                <a href="buses" class="nav-item">
                    <i class="fa-solid fa-bus-simple"></i>
                    <span>Buses &amp; Routes</span>
                </a>
                <a href="passengers" class="nav-item">
                    <i class="fa-solid fa-users"></i>
                    <span>Passengers</span>
                </a>
                <a href="reports" class="nav-item">
                    <i class="fa-solid fa-chart-bar"></i>
                    <span>Reports</span>
                </a>
                <a href="payments" class="nav-item">
                    <i class="fa-solid fa-credit-card"></i>
                    <span>Payments</span>
                </a>
                <a href="settings" class="nav-item">
                    <i class="fa-solid fa-gear"></i>
                    <span>Settings</span>
                </a>
            </nav>

            <div class="sidebar-user">
                <div class="user-avatar">
                    <img src="images/admin-avatar.png" alt="Admin" onerror="this.style.display='none';this.parentElement.classList.add('avatar-fallback')">
                    <i class="fa-solid fa-user avatar-icon"></i>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header class="topbar">
                <h1 class="page-title">Dashboard</h1>
                <div class="topbar-actions">
                    <div class="dot dot-gray"></div>
                    <div class="dot dot-gray"></div>
                    <div class="dot dot-light"></div>
                </div>
            </header>

            <div class="content-area">

                <!-- Hero Banner -->
                <div class="hero-banner">
                    <div class="hero-text">
                        <h2>Hello Admin!</h2>
                        <p>Today you have <strong>${totalNewBookings != null ? totalNewBookings : '150'}</strong> new ticket bookings. Please review the 'Routes and Fleet' section for pending bus maintenance schedules.</p>
                    </div>
                    <div class="hero-graphic">
                        <div class="hero-bus-icon">
                            <i class="fa-solid fa-bus-simple"></i>
                        </div>
                    </div>
                </div>

                <!-- Stats Grid -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-bus"></i></div>
                        <div class="stat-info">
                            <span class="stat-label">Total Buses</span>
                            <span class="stat-value">${totalBuses != null ? totalBuses : '45'}</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-route"></i></div>
                        <div class="stat-info">
                            <span class="stat-label">Total Trips</span>
                            <span class="stat-value">${totalTrips != null ? totalTrips : '1,230'}</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-map-location-dot"></i></div>
                        <div class="stat-info">
                            <span class="stat-label">Total Routes</span>
                            <span class="stat-value">${totalRoutes != null ? totalRoutes : '18'}</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-road"></i></div>
                        <div class="stat-info">
                            <span class="stat-label">Active Routes</span>
                            <span class="stat-value">${activeRoutes != null ? activeRoutes : '18'}</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
                        <div class="stat-info">
                            <span class="stat-label">Total Passengers</span>
                            <span class="stat-value">${totalPassengers != null ? totalPassengers : '78,450'}</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-ticket"></i></div>
                        <div class="stat-info">
                            <span class="stat-label">Total Bookings</span>
                            <span class="stat-value">${totalBookings != null ? totalBookings : '5,600'}</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-dollar-sign"></i></div>
                        <div class="stat-info">
                            <span class="stat-label">Total Revenue</span>
                            <span class="stat-value">${totalRevenue != null ? totalRevenue : '$345,000'}</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-map-pin"></i></div>
                        <div class="stat-info">
                            <span class="stat-label">Total Stops</span>
                            <span class="stat-value">${totalStops != null ? totalStops : '18'}</span>
                        </div>
                    </div>
                </div>

                <!-- Bottom Panels -->
                <div class="panels-row">

                    <!-- Upcoming Trips -->
                    <div class="panel">
                        <div class="panel-header">
                            <div class="panel-title">
                                <span class="status-dot active"></span>
                                <h3>Upcoming Trips</h3>
                            </div>
                            <span class="alert-dot"></span>
                        </div>
                        <div class="panel-body">
                            <c:choose>
                                <c:when test="${not empty upcomingTrips}">
                                    <c:forEach var="trip" items="${upcomingTrips}">
                                        <div class="trip-item">
                                            <div class="trip-info">
                                                <span class="trip-bus-id">${trip.busId}</span>
                                                <span class="trip-time">${trip.departureTime}</span>
                                                <span class="trip-status ${trip.status == 'completed' ? 'status-completed' : 'status-pending'}">${trip.status}</span>
                                            </div>
                                            <div class="trip-note">${trip.note}</div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <!-- Static fallback data -->
                                    <div class="trip-item">
                                        <div class="trip-left">
                                            <span class="trip-dot dot-green"></span>
                                            <div>
                                                <div class="trip-bus-id">BUSID 3368GA</div>
                                                <div class="trip-time">Departing in: 30 minutes</div>
                                                <div class="trip-status status-completed">Inspection: completed</div>
                                            </div>
                                        </div>
                                        <div class="trip-note">Review Q4 Marketing Plan</div>
                                    </div>
                                    <div class="trip-item">
                                        <div class="trip-left">
                                            <span class="trip-dot dot-green"></span>
                                            <div>
                                                <div class="trip-bus-id">BUSID 3268GA</div>
                                                <div class="trip-time">2 minutes ago</div>
                                                <div class="trip-status status-completed">completed</div>
                                            </div>
                                        </div>
                                        <div class="trip-note">Design new landing page</div>
                                    </div>
                                    <div class="trip-item">
                                        <div class="trip-left">
                                            <span class="trip-dot dot-purple"></span>
                                            <div>
                                                <div class="trip-bus-id">Sarah Johnson</div>
                                                <div class="trip-time">2 minutes ago</div>
                                                <div class="trip-status status-completed">completed</div>
                                            </div>
                                        </div>
                                        <div class="trip-note">Team standup meeting</div>
                                    </div>
                                    <div class="trip-item">
                                        <div class="trip-left">
                                            <span class="trip-dot dot-purple"></span>
                                            <div>
                                                <div class="trip-bus-id">Sarah Johnson</div>
                                                <div class="trip-time">2 minutes ago</div>
                                                <div class="trip-status status-completed">completed</div>
                                            </div>
                                        </div>
                                        <div class="trip-note">Product roadmap Q1 2025</div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Route Condition -->
                    <div class="panel">
                        <div class="panel-header">
                            <div class="panel-title">
                                <span class="status-dot active"></span>
                                <h3>Route Condition</h3>
                            </div>
                        </div>
                        <div class="panel-body">
                            <c:choose>
                                <c:when test="${not empty routeConditions}">
                                    <c:forEach var="route" items="${routeConditions}">
                                        <div class="route-item">
                                            <div class="route-avatar"></div>
                                            <div class="route-info">
                                                <div class="route-name">${route.name}</div>
                                                <div class="route-path">${route.path}</div>
                                                <div class="route-progress">
                                                    <div class="progress-bar" style="width: ${route.progress}%"></div>
                                                </div>
                                            </div>
                                            <div class="route-right">
                                                <span class="route-status ${route.status == 'Open' ? 'status-open' : 'status-closed'}">${route.status}</span>
                                                <span class="route-count">${route.count}</span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="route-item">
                                        <div class="route-avatar route-avatar-blue"></div>
                                        <div class="route-info">
                                            <div class="route-name">Route 2</div>
                                            <div class="route-path">KTM-PKR</div>
                                            <div class="route-progress">
                                                <div class="progress-bar" style="width: 65%"></div>
                                            </div>
                                        </div>
                                        <div class="route-right">
                                            <span class="route-status status-open">● Open</span>
                                            <span class="route-count">4</span>
                                        </div>
                                    </div>
                                    <div class="route-item">
                                        <div class="route-avatar route-avatar-gray"></div>
                                        <div class="route-info">
                                            <div class="route-name">James Wilson</div>
                                            <div class="route-sub">2h 15m</div>
                                            <div class="route-sub">Tasks completed</div>
                                        </div>
                                        <div class="route-right">
                                            <span class="route-status status-closed">● Closed</span>
                                            <span class="route-count">3</span>
                                        </div>
                                    </div>
                                    <div class="route-item">
                                        <div class="route-avatar route-avatar-gray"></div>
                                        <div class="route-info">
                                            <div class="route-name">James Wilson</div>
                                            <div class="route-sub">2h 15m</div>
                                            <div class="route-sub">Tasks completed</div>
                                        </div>
                                        <div class="route-right">
                                            <span class="route-status status-closed">● Closed</span>
                                            <span class="route-count">3</span>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                </div>
            </div>
        </main>
    </div>

    <script src="js/dashboard.js"></script>
</body>
</html>
