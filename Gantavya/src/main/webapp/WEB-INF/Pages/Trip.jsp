<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Gantavya Admin - Schedule Trip</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Sidenav.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Buses.css">
            <link
                href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        </head>

        <body>

            <div class="app-shell">
                <jsp:include page="/WEB-INF/Pages/SideNav.jsp" />

                <div class="main-panel">
                    <header class="header-nav">
                        <div class="header-left">
                            <h1 class="page-title">Trip Management</h1>
                            <p class="breadcrumb">Admin / <span class="active-crumb">Schedule Trip</span></p>
                        </div>
                    </header>

                    <div class="content-wrapper">

                        <%-- SECTION 1: ADD NEW TRIP (Only shows if NOT editing) --%>
                            <c:if test="${editableTrip == null}">
                                <div class="glass-card form-container">
                                    <div class="card-header">
                                        <h3>Schedule New Trip</h3>
                                    </div>
                                    <form action="trip" method="POST">
                                        <input type="hidden" name="action" value="add">
                                        <div class="input-grid">
                                            <div class="input-group">
                                                <label>Departure Date & Time</label>
                                                <input type="text" name="departureDate" placeholder="dd-mm-yyyy HH:MM"
                                                    onfocus="(this.type='datetime-local')"
                                                    onblur="if(!this.value) this.type='text'" required>
                                            </div>
                                            <div class="input-group">
                                                <label>Arrival Date & Time</label>
                                                <input type="text" name="arrivalDate" placeholder="dd-mm-yyyy HH:MM"
                                                    onfocus="(this.type='datetime-local')"
                                                    onblur="if(!this.value) this.type='text'" required>
                                            </div>
                                            <div class="input-group">
                                                <label>Fare Amount</label>
                                                <input type="number" name="fare" placeholder="e.g. 1500" required>
                                            </div>
                                            <div class="input-group">
                                                <label>Trip Status</label>
                                                <select name="tripStatus">
                                                    <option value="SCHEDULED">Scheduled</option>
                                                    <option value="ONGOING">Ongoing</option>
                                                    <option value="COMPLETED">Completed</option>
                                                    <option value="CANCELLED">Cancelled</option>
                                                </select>
                                            </div>
                                            <div class="input-group">
                                                <label>Select Route</label>
                                                <select name="routeId" required>
                                                    <option value="" disabled selected>-- Select Route --</option>
                                                    <c:forEach var="route" items="${routeList}">
                                                        <option value="${route.routeId}">${route.routeName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="input-group">
                                                <label>Assign Bus (Operational Only)</label>
                                                <select name="busId" required>
                                                    <option value="" disabled selected>-- Select Bus --</option>
                                                    <c:forEach var="bus" items="${busList}">
                                                        <option value="${bus.busId}">${bus.busNumber} (${bus.busType})
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="input-group">
                                                <label>Assign Staff</label>
                                                <select name="staffId" required>
                                                    <option value="" disabled selected>-- Select Staff --</option>
                                                    <c:forEach var="staff" items="${staffList}">
                                                        <option value="${staff.staffId}">${staff.staffName}
                                                            (${staff.memberType})</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="btn-group-row"
                                                style="display: flex; gap: 15px; align-items: flex-end;">
                                                <button type="submit" class="btn-primary">Schedule Trip</button>
                                                <button type="button" class="btn-secondary"
                                                    onclick="window.location.href='trip'">Cancel</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </c:if>

                            <%-- SECTION 2: EDIT MODAL (Pop-up style - Only shows when edit is clicked) --%>
                                <c:if test="${editableTrip != null}">
                                    <div class="modal-overlay">
                                        <div class="glass-card modal-content"
                                            style="max-height: 90vh; overflow-y: auto;">
                                            <div class="card-header">
                                                <h3>Update Trip Details</h3>
                                                <p>Modifying details for Trip ID: #${editableTrip.tripId}</p>
                                            </div>
                                            <form action="trip" method="POST">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="tripId" value="${editableTrip.tripId}">

                                                <div class="input-grid-modal">
                                                    <div class="input-group">
                                                        <label>Departure Date & Time</label>
                                                        <input type="datetime-local" name="departureDate"
                                                            value="${editableTrip.departureDate}" required>
                                                    </div>
                                                    <div class="input-group">
                                                        <label>Arrival Date & Time</label>
                                                        <input type="datetime-local" name="arrivalDate"
                                                            value="${editableTrip.arrivalDate}" required>
                                                    </div>
                                                    <div class="input-group">
                                                        <label>Fare Amount</label>
                                                        <input type="number" name="fare" value="${editableTrip.fare}"
                                                            required>
                                                    </div>
                                                    <div class="input-group">
                                                        <label>Trip Status</label>
                                                        <select name="tripStatus">
                                                            <option value="SCHEDULED"
                                                                ${editableTrip.tripStatus=='SCHEDULED' ? 'selected' : ''
                                                                }>Scheduled</option>
                                                            <option value="ONGOING" ${editableTrip.tripStatus=='ONGOING'
                                                                ? 'selected' : '' }>Ongoing</option>
                                                            <option value="COMPLETED"
                                                                ${editableTrip.tripStatus=='COMPLETED' ? 'selected' : ''
                                                                }>Completed</option>
                                                            <option value="CANCELLED"
                                                                ${editableTrip.tripStatus=='CANCELLED' ? 'selected' : ''
                                                                }>Cancelled</option>
                                                        </select>
                                                    </div>
                                                    <div class="input-group">
                                                        <label>Select Route</label>
                                                        <select name="routeId" required>
                                                            <c:forEach var="route" items="${routeList}">
                                                                <option value="${route.routeId}"
                                                                    ${editableTrip.routeId==route.routeId ? 'selected'
                                                                    : '' }>${route.routeName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="input-group">
                                                        <label>Assign Bus (Operational Only)</label>
                                                        <select name="busId" required>
                                                            <c:forEach var="bus" items="${busList}">
                                                                <option value="${bus.busId}"
                                                                    ${editableTrip.busId==bus.busId ? 'selected' : '' }>
                                                                    ${bus.busNumber} (${bus.busType})</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="input-group">
                                                        <label>Assign Staff</label>
                                                        <select name="staffId" required>
                                                            <c:forEach var="staff" items="${staffList}">
                                                                <option value="${staff.staffId}"
                                                                    ${editableTrip.staffId==staff.staffId ? 'selected'
                                                                    : '' }>${staff.staffName} (${staff.memberType})
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="btn-group-modal"
                                                    style="margin-top: 25px; display: flex; gap: 15px; justify-content: flex-end;">
                                                    <button type="button" class="btn-secondary"
                                                        onclick="window.location.href='trip'">Cancel</button>
                                                    <button type="submit" class="btn-primary">Save</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </c:if>

                                <%-- SECTION 3: ALL TRIPS TABLE --%>
                                    <div class="table-card">
                                        <div class="table-header"
                                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                                            <h3>Scheduled Trips</h3>
                                            <form action="trip" method="GET" class="search-form"
                                                style="display: flex; gap: 10px;">
                                                <input type="text" name="search" placeholder="Search Trips..."
                                                    class="search-input">
                                                <button type="submit" class="btn-primary">Search</button>
                                            </form>
                                        </div>

                                        <table class="gantavya-table">
                                            <thead>
                                                <tr>
                                                    <th>Trip ID</th>
                                                    <th>Bus / Route</th>
                                                    <th>Departure / Arrival</th>
                                                    <th>Fare</th>
                                                    <th>Status</th>
                                                    <th>Manage</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="trip" items="${tripList}">
                                                    <tr>
                                                        <td><span class="id-badge">#${trip.tripId}</span></td>
                                                        <td>
                                                            <strong>${trip.busId}</strong><br>
                                                            <small>${trip.routeId}</small>
                                                        </td>
                                                        <td>
                                                            <small>Dep: ${trip.departureDate}</small><br>
                                                            <small>Arr: ${trip.arrivalDate}</small>
                                                        </td>
                                                        <td>Rs. ${trip.fare}</td>
                                                        <td>
                                                            <span
                                                                class="status-dot ${trip.tripStatus == 'SCHEDULED' ? 'dot-orange' : (trip.tripStatus == 'ONGOING' ? 'dot-green' : 'dot-red')}">
                                                                ${trip.tripStatus}
                                                            </span>
                                                        </td>
                                                        <td style="text-align: right;">
                                                            <div class="action-icons edit-link"
                                                                style="display: flex; justify-content: center; gap: 30px;">
                                                                <a href="trip?action=edit&id=${trip.tripId}"
                                                                    class="edit-link"><i
                                                                        class="fa-solid fa-pen"></i></a>
                                                                <a href="trip?action=delete&id=${trip.tripId}"
                                                                    class="delete-link"
                                                                    onclick="return confirm('Cancel/Delete Trip ${trip.tripId}?')">
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