<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Gantavya Admin</title>
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
                <h1 class="page-title">Fleet Management</h1>
                <p class="breadcrumb">Admin / <span class="active-crumb">Buses</span></p>
            </div>
        </header>

        <div class="content-wrapper">
    
    <%-- SECTION 1: ADD NEW BUS (Only shows if NOT editing) --%>
    <c:if test="${editableBus == null}">
        <div class="glass-card form-container">
            <div class="card-header">
                <h3>Add New Bus</h3>
            </div>
            <form action="bus" method="POST">
                <input type="hidden" name="action" value="add">
                <div class="input-grid">
                    <div class="input-group">
                        <label>Bus Number</label>
                        <input type="text" name="busNumber" placeholder="e.g. BA 2 K 4456" required>
                    </div>
                    <div class="input-group">
                        <label>Vehicle Type</label>
                        <select name="busType">
                            <option value="AC">AC Deluxe</option>
                            <option value="NON-AC">Non-AC Standard</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label>Total Capacity</label>
                        <input type="number" name="capacity" placeholder="40" required>
                    </div>
                    <div class="input-group">
                        <label>Status</label>
                        <select name="status">
                            <option value="OPERATIONAL">Operating</option>
                            <option value="MAINTENANCE">In Maintenance</option>
                        </select>
                    </div>
                    <div class="btn-group-row" style="display: flex; gap: 15px; align-items: flex-end;">
					    <button type="submit" class="btn-primary">Register Bus</button>
					    <button type="button" class="btn-secondary" onclick="window.location.href='bus'">Cancel</button>
					</div>
                
                </div>                
            </form>
        </div>
    </c:if>

    <%-- SECTION 2: EDIT MODAL (Pop-up style - Only shows when edit is clicked) --%>
    <c:if test="${editableBus != null}">
        <div class="modal-overlay">
            <div class="glass-card modal-content">
                <div class="card-header">
                    <h3>Update Vehicle Details</h3>
                    <p>Modifying details for Bus ID: #${editableBus.busId}</p>
                </div>
                <form action="bus" method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="busId" value="${editableBus.busId}">
                    
                    <div class="input-grid-modal">
                        <div class="input-group">
                            <label>Bus Number</label>
                            <input type="text" name="busNumber" value="${editableBus.busNumber}" required>
                        </div>
                        <div class="input-group">
                            <label>Vehicle Type</label>
                            <select name="busType">
                                <option value="AC" ${editableBus.busType == 'AC' ? 'selected' : ''}>AC Deluxe</option>
                                <option value="NON-AC" ${editableBus.busType == 'NON-AC' ? 'selected' : ''}>Non-AC Standard</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label>Total Capacity</label>
                            <input type="number" name="capacity" value="${editableBus.capacity}" required>
                        </div>
                        <div class="input-group">
                            <label>Status</label>
                            <select name="status">
                                <option value="OPERATIONAL" ${editableBus.status == 'OPERATIONAL' ? 'selected' : ''}>Operating</option>
                                <option value="MAINTENANCE" ${editableBus.status == 'MAINTENANCE' ? 'selected' : ''}>In Maintenance</option>
                            </select>
                        </div>
                    </div>
                    <div class="btn-group-modal" style="margin-top: 25px; display: flex; gap: 15px; justify-content: flex-end;">
                        <button type="button" class="btn-secondary" onclick="window.location.href='bus'">Cancel</button>
                        <button type="submit" class="btn-primary">Save</button>
                        
                    </div>
                </form>
            </div>
        </div>
    </c:if>

    <%-- SECTION 3: ACTIVE FLEET TABLE --%>
    <div class="table-card">
        <div class="table-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3>Active Fleet</h3>
            <form action="bus" method="GET" class="search-form" style="display: flex; gap: 10px;">
                <input type="text" name="search" placeholder="Search Bus Number..." class="search-input">
                <button type="submit" class="btn-primary">Search</button>
            </form>
        </div>

        <table class="gantavya-table">
            <thead>
                <tr>
                    <th>Bus ID</th>
                    <th>Bus Number</th>
                    <th>Vehicle Type</th>
                    <th>Capacity</th>
                    <th>Status</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bus" items="${busList}">
                    <tr>
                        <td><span class="id-badge">#${bus.busId}</span></td>
                        <td><strong>${bus.busNumber}</strong></td>
                        <td>${bus.busType}</td>
                        <td>${bus.capacity} Seats</td>
                        <td>
                            <span class="status-dot ${bus.status == 'OPERATIONAL' ? 'dot-green' : 'dot-orange'}">
                                ${bus.status}
                            </span>
                        </td>
                        <td style="text-align: right;">
                            <div class="action-icons edit-link" style="display: flex; justify-content: center; gap: 30px;">
		                        <a href="bus?action=edit&id=${bus.busId}" class="edit-link"><i class="fa-solid fa-pen"></i></a>
		                        <a href="bus?action=delete&id=${bus.busId}" class="delete-link" 
		                           onclick="return confirm('Remove vehicle ${bus.busNumber}?')">
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