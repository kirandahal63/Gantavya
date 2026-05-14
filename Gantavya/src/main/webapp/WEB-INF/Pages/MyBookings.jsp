<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Index.css">
     <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/MyBookings.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="Navbar.jsp" />

    <div class="bookings-container">
        <h1 class="page-title">My Bookings</h1>

        <c:if test="${empty bookings}">
            <div class="empty-state">
                <i class="fas fa-ticket-alt empty-icon"></i>
                <h2>No bookings found</h2>
                <p>You haven't booked any trips yet.</p>
                <a href="${pageContext.request.contextPath}/home" class="view-btn action-btn" style="display:inline-flex; margin-top:20px;">Search Trips</a>
            </div>
        </c:if>

        <c:forEach var="booking" items="${bookings}">
            <div class="booking-card">
                <div class="card-header">
                    <span class="booking-id">BOOKING ID: ${booking.bookingId}</span>
                    <span class="booking-date">Booked on: <fmt:formatDate value="${booking.bookingDate}" pattern="MMM dd, yyyy HH:mm"/></span>
                </div>
                <div class="card-body">
                    <div class="trip-info">
                        <div class="path-viz">
                            <div class="point">
                                <i class="fa-regular fa-circle-dot"></i>
                                <span>
                                    <strong>${booking.trip.departureDate}</strong>
                                    ${booking.trip.source}
                                </span>
                            </div>
                            <div class="line"></div>
                            <div class="point">
                                <i class="fa-solid fa-location-dot arrival-icon"></i>
                                <span>
                                    <strong>${booking.trip.arrivalDate}</strong>
                                    ${booking.trip.destination}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="passenger-info">
                        <span class="info-label">Ticket ID</span>
                        <span class="info-value">${booking.ticketId}</span>
                        
                        <span class="info-label">Seat Number</span>
                        <span class="info-value">${booking.seatNumber}</span>

                        <span class="info-label">Bus Type</span>
                        <span class="info-value">${booking.trip.busType}</span>
                    </div>
                </div>
                <div class="card-actions">
                    <a href="success?bookingId=${booking.bookingId}" class="action-btn view-btn">
                        <i class="fas fa-eye"></i> View Ticket
                    </a>
                    <a href="success?bookingId=${booking.bookingId}&download=true" class="action-btn download-btn">
                        <i class="fas fa-download"></i> Download
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>

    <jsp:include page="Footer.jsp" />
</body>
</html>
