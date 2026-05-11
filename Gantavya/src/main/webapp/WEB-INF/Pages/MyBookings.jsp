<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .bookings-container {
            padding: 40px 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .page-title {
            margin-bottom: 30px;
            color: #1a2e4a;
            font-size: 28px;
            font-weight: 700;
        }
        .booking-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            overflow: hidden;
            border: 1px solid #eee;
            transition: transform 0.3s ease;
        }
        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }
        .card-header {
            background: #f8fbff;
            padding: 15px 25px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .booking-id {
            color: #1e6bad;
            font-weight: 700;
            font-size: 14px;
        }
        .booking-date {
            color: #666;
            font-size: 13px;
        }
        .card-body {
            padding: 25px;
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
        }
        .trip-info {
            flex: 2;
            min-width: 300px;
        }
        .passenger-info {
            flex: 1;
            min-width: 200px;
            padding-left: 30px;
            border-left: 1px solid #eee;
        }
        .info-label {
            display: block;
            font-size: 12px;
            color: #999;
            text-transform: uppercase;
            margin-bottom: 5px;
        }
        .info-value {
            display: block;
            font-size: 16px;
            color: #1a2e4a;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .card-actions {
            background: #fff;
            padding: 15px 25px;
            border-top: 1px solid #eee;
            display: flex;
            gap: 15px;
        }
        .action-btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: 0.3s;
        }
        .view-btn {
            background: #f0f7ff;
            color: #1e6bad;
            border: 1px solid #d0e4ff;
        }
        .view-btn:hover {
            background: #1e6bad;
            color: white;
        }
        .download-btn {
            background: #1a2e4a;
            color: white;
            border: 1px solid #1e6bad;
        }
        .download-btn:hover {
            background: #154d7e;
        }
        .empty-state {
            text-align: center;
            padding: 100px 20px;
        }
        .empty-icon {
            font-size: 60px;
            color: #ccc;
            margin-bottom: 20px;
        }
        @media (max-width: 768px) {
            .passenger-info {
                border-left: none;
                padding-left: 0;
                padding-top: 20px;
                border-top: 1px solid #eee;
            }
        }
    </style>
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
