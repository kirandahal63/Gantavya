<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Gantavya Admin - Routes</title>
    <!-- Linking to your existing CSS files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Sidenav.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Buses.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<div class="app-shell">
    <jsp:include page="/WEB-INF/Pages/SideNav.jsp" />

    <div class="main-panel">
        <header class="header-nav">
            <div class="header-left">
                <h1 class="page-title">Route Management</h1>
                <p class="breadcrumb">Admin / <span class="active-crumb">Routes</span></p>
            </div>
        </header>

        <div class="content-wrapper">
    
            <%-- SECTION 1: ADD NEW ROUTE (Single Row Layout) --%>
            <c:if test="${editableRoute == null}">
                <div class="glass-card form-container">
                    <div class="card-header">
                        <h3>Add New Route</h3>
                    </div>
                    <form action="route" method="POST">
                        <input type="hidden" name="action" value="add">
                        <div class="input-grid">
                            <div class="input-group">
                                <label>Route Name</label>
                                <input type="text" name="routeName" placeholder="e.g. KTM-PKR-01" required>
                            </div>
                            <div class="input-group">
                                <label>Origin</label>
                                <input type="text" name="origin" placeholder="Kathmandu" required>
                            </div>
                            <div class="input-group">
                                <label>Destination</label>
                                <input type="text" name="destination" placeholder="Pokhara" required>
                            </div>
                            <div class="input-group">
                                <label>Distance (KM)</label>
                                <input type="number" name="distance" placeholder="200" required>
                            </div>
                            
                            <div class="btn-group-row" style="display: flex; gap: 15px;">
							    <button type="submit" class="btn-primary">Add Route</button>
							    <button type="button" class="btn-secondary" onclick="window.location.href='route'">Cancel</button>
							</div>
		                
		                
		                
                        </div>
                    </form>
                </div>
            </c:if>

            <%-- SECTION 2: EDIT MODAL (2-Column Grid Layout) --%>
<c:if test="${editableRoute != null}">
    <div class="modal-overlay">
        <!-- Reduced max-width to make it look more like the Vehicle modal -->
        <div class="glass-card modal-content" style="max-width: 650px;"> 
            <div class="card-header">
                <h3>Update Route Details</h3>
                <p>Modifying Route ID: ${editableRoute.routeId}</p>
            </div>
            <form action="route" method="POST">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="routeId" value="${editableRoute.routeId}">
                
                <!-- Use grid instead of flex for the 2-column look -->
                <div class="input-grid-modal">
                    <div class="input-group">
                        <label>Route Name</label>
                        <input type="text" name="routeName" value="${editableRoute.routeName}" required>
                    </div>
                    <div class="input-group">
                        <label>Origin</label>
                        <input type="text" name="origin" value="${editableRoute.origin}" required>
                    </div>
                    <div class="input-group">
                        <label>Destination</label>
                        <input type="text" name="destination" value="${editableRoute.destination}" required>
                    </div>
                    <div class="input-group">
                        <label>Distance</label>
                        <input type="number" name="distance" value="${editableRoute.distance}" required>
                    </div>
                </div>

                <!-- Action Buttons aligned to the bottom right -->
                <div class="btn-group-row" style="display: flex; gap: 10px; justify-content: flex-end; margin-top: 30px;">
                    <button type="button" class="btn-secondary" onclick="window.location.href='route'">Cancel</button>
                    <button type="submit" class="btn-primary">Save</button>
                </div>
            </form>
        </div>
    </div>
</c:if>

            <%-- SECTION 3: ACTIVE ROUTES TABLE --%>
            <div class="table-card">
                <div class="table-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h3>Available Routes</h3>         
                    <form action="route" method="GET" class="search-form" style="display: flex; gap: 10px;">
                        <input type="text" name="search" placeholder="Search Route Name..." class="search-input">
                        <button type="submit" class="btn-primary">Search</button>
                    </form>
                </div>

                <table class="gantavya-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Route Name</th>
                            <th>Origin</th>
                            <th>Destination</th>
                            <th>Distance</th>
                            <th>Manage</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="route" items="${routeList}">
                            <tr>
                                <td><span class="id-badge">#${route.routeId}</span></td>
                                <td><strong>${route.routeName}</strong></td>
                                <td>${route.origin}</td>
                                <td>${route.destination}</td>
                                <td>${route.distance} KM</td>
                                <td>
                                    <div class="action-icons">
                                        <a href="route?action=edit&id=${route.routeId}" class="edit-link"><i class="fa-solid fa-pen"></i></a>
                                        <a href="route?action=delete&id=${route.routeId}" class="delete-link" 
                                           onclick="return confirm('Delete route ${route.routeName}?')">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>