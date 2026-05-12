<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Bookings | Gantavya Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/ViewBookings.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="app-shell">
        <jsp:include page="/WEB-INF/Pages/SideNav.jsp" />
        
        <main class="main-content">
            <header class="content-header">
                <div class="header-title">
                    <h1>Trip Bookings</h1>
                    <p>View and manage passenger bookings for each trip</p>
                </div>
            </header>

            <section class="trip-selection-card">
                <form action="${pageContext.request.contextPath}/viewBookings" method="GET" class="filter-form">
                    <div class="form-group">
                        <label for="tripSelect">Select Trip</label>
                        <select name="tripId" id="tripSelect" onchange="this.form.submit()">
                            <option value="">-- Choose a Trip --</option>
                            <c:forEach var="trip" items="${trips}">
                                <option value="${trip.tripId}" ${trip.tripId == selectedTripId ? 'selected' : ''}>
                                    ${trip.tripId} | ${trip.source} to ${trip.destination} (${trip.departureDate})
                                </option>
                            </c:forEach>
                        </select>
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

                <div class="bookings-table-container">
                    <table class="bookings-table">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Passenger Name</th>
                                <th>Seats</th>
                                <th>Additional Passengers</th>
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
                                        <div class="seat-badges">
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
                                    <td colspan="6" class="empty-state">
                                        <i class="fas fa-folder-open"></i>
                                        <p>No bookings found for this trip yet.</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </c:if>
            
            <c:if test="${empty selectedTripId}">
                <div class="empty-selection">
                    <h2>Select a trip to view its bookings.</h2>
                    <p>Choose a trip from the dropdown above to see detailed passenger lists and seat allocations.</p>
                </div>
            </c:if>
        </main>
    </div>
</body>
</html>
