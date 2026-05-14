<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings | Gantavya Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Sidenav.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Buses.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/ViewBookings.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <div class="app-shell">
        <jsp:include page="/WEB-INF/Pages/SideNav.jsp" />
        
        <div class="main-panel">
            <header class="header-nav">
                <div class="header-left">
                    <h1 class="page-title">Trip Bookings</h1>
                    <p class="breadcrumb">Admin / <span class="active-crumb">View Bookings</span></p>
                </div>
            </header>

            <div class="content-wrapper">
                <section class="glass-card trip-selection-card">
                    <div class="card-header">
                        <h3>Select Trip</h3>
                        <p>Choose a trip to view its passenger list and booking details.</p>
                    </div>
                    <form action="${pageContext.request.contextPath}/viewBookings" method="GET" class="premium-filter-form">
                        <div class="filter-row">
                            <div class="input-group" style="flex: 2;">
                                <label for="tripSelect">Select Trip</label>
                                <select name="tripId" id="tripSelect" class="premium-select" onchange="document.getElementsByName('searchTrip')[0].value=''; this.form.submit()">
                                    <option value="">-- Choose a Trip --</option>
                                    <c:forEach var="trip" items="${trips}">
                                        <option value="${trip.tripId}" ${trip.tripId == selectedTripId ? 'selected' : ''}>
                                             ${trip.source} to ${trip.destination} | ${trip.departureDate}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>                          
                            

                            <div class="input-group" style="flex: 1;">
                                <label for="sortSelect">Sort Bookings</label>
                                <select name="sort" id="sortSelect" class="premium-select" onchange="this.form.submit()">
                                    <option value="date" ${currentSort == 'date' ? 'selected' : ''}>Booking Date</option>
                                    <option value="fare" ${currentSort == 'fare' ? 'selected' : ''}>Total Fare</option>
                                </select>
                            </div>
                            <div class="input-group" style="flex: 1;">
                                <label>Quick Search</label>
                                <div style="display: flex; gap: 8px;">
                                    <input type="text" name="searchTrip" value="${param.searchTrip}" placeholder="Trip ID " class="premium-input">
                                    <button type="submit" class="btn-primary-small">
								    <i class="fas fa-search"></i>
								</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </section>

                <c:if test="${not empty selectedTripId}">
                    <div class="trip-info-summary">
                        <div class="info-card">
                            <i class="fas fa-bus"></i>
                            <div>
                                <span>Bus Type</span>
                                <strong>${selectedTrip.busType}</strong>
                            </div>
                        </div>
                        <div class="info-card">
                            <i class="fas fa-users"></i>
                            <div>
                                <span>Total Bookings</span>
                                <strong>${fn:length(bookings)}</strong>
                            </div>
                        </div>
                        <div class="info-card">
                            <i class="fas fa-user-friends"></i>
                            <div>
                                <span>Total Passengers</span>
                                <strong>${totalPassengers}</strong>
                            </div>
                        </div>
                        <div class="info-card">
                            <i class="fas fa-money-bill-wave"></i>
                            <div>
                                <span>Total Revenue</span>
                                <strong>Rs. ${totalRevenue}</strong>
                            </div>
                        </div>
                        <div class="info-card">
                            <i class="fas fa-ticket-alt"></i>
                            <div>
                                <span>Seats Occupied</span>
                                <strong>${totalPassengers} / ${selectedTrip.capacity}</strong>
                            </div>
                        </div>
                    </div>

                    <div class="table-card">
                        <div class="card-header">
                            <h3>Passenger List</h3>
                            <p>Detailed overview of all bookings for the selected trip.</p>
                        </div>
                        <div class="bookings-table-container">
                            <table class="bookings-table">
                                <thead>
                                    <tr>
                                        <th>Booking ID</th>
                                        <th>Passenger Name</th>
                                        <th>Seats</th>
                                        <th>Additional Info</th>
                                         <th>Booking Date</th>
                                        <th>Total Fare</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="booking" items="${bookings}">
                                        <tr>
                                            <td><span class="id-badge">${booking.bookingId}</span></td>
                                            <td><strong>${booking.passengerName}</strong></td>
                                            <td>
                                                <div class="seat-badges" style="justify-content: center;">
                                                    <c:forEach var="seat" items="${fn:split(booking.seatNumber, ',')}">
                                                        <span class="seat-badge">${seat}</span>
                                                    </c:forEach>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty booking.otherPassengers}">
                                                        <span class="other-passengers">${booking.otherPassengers}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="none-text">None</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${booking.bookingDate}</td>
                                            <td>
                                                <c:set var="numSeats" value="${fn:length(fn:split(booking.seatNumber, ','))}" />
                                                <strong>Rs. ${numSeats * selectedTrip.fare}</strong>
                                            </td>
                                            <td><span class="status-pill confirmed">Confirmed</span></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty bookings}">
                                        <tr>
                                            <td colspan="7" class="empty-state">
                                                <i class="fas fa-folder-open"></i>
                                                <p>No bookings found for this trip yet.</p>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${empty selectedTripId}">
                    <div class="glass-card empty-selection">
                        <i class="fas fa-search"></i>
                        <h2>Select a trip to view its bookings.</h2>
                        <p>Choose a trip from the dropdown above to see detailed passenger lists and seat allocations.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>
