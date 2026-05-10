<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Success | Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Booking.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .success-card {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            text-align: center;
        }
        .success-icon {
            font-size: 80px;
            color: #2ecc71;
            margin-bottom: 20px;
            animation: scaleIn 0.5s ease-out;
        }
        @keyframes scaleIn {
            0% { transform: scale(0); }
            100% { transform: scale(1); }
        }
        .ticket-box {
            background: #f1f8ff;
            border: 2px dashed #3498db;
            padding: 20px;
            border-radius: 10px;
            margin: 30px 0;
            text-align: left;
        }
        .ticket-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 5px;
            border-bottom: 1px solid #e0eef9;
        }
        .home-btn {
            background: #3498db;
            color: white;
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: bold;
            display: inline-block;
            margin-top: 20px;
            transition: 0.3s;
        }
        .home-btn:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <jsp:include page="Navbar.jsp" />

    <div class="success-card">
        <div class="success-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <h1>Booking Confirmed!</h1>
        <p>Thank you for choosing Gantavya. Your ticket has been generated successfully.</p>
        
        <div class="ticket-box">
            <div class="ticket-row">
                <span>Booking ID:</span>
                <strong>${booking.bookingId}</strong>
            </div>
            <div class="ticket-row">
                <span>Ticket Number:</span>
                <strong>${booking.ticketId}</strong>
            </div>
            <div class="ticket-row">
                <span>Seat(s):</span>
                <strong>${booking.seatNumber}</strong>
            </div>
            <div class="ticket-row">
                <span>Payment Status:</span>
                <strong style="color: #2ecc71;">PAID</strong>
            </div>
        </div>
        
        <p style="color: #666; font-size: 14px;">A confirmation email has been sent to your registered address.</p>
        
        <a href="${pageContext.request.contextPath}/home" class="home-btn">Return to Home</a>
    </div>
</body>
</html>
