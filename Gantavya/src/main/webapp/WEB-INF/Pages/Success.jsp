<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation | Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Navigation.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <style>
        :root {
            --ticket-blue: #1e6bad;
            --ticket-light: #f0f7ff;
            --ticket-dark: #1a2e4a;
        }
        body {
            background-color: #f5f7fa;
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .success-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .success-icon {
            font-size: 60px;
            color: #5db712;
            margin-bottom: 15px;
        }
        .success-header h1 {
            color: var(--ticket-dark);
            margin: 0;
            font-size: 32px;
        }
        .success-header p {
            color: #666;
            margin-top: 10px;
        }

        /* Ticket Design */
        .ticket-wrapper {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }
        .bus-ticket {
            display: flex;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border: 1px solid #ddd;
            width: 100%;
            min-height: 380px;
        }
        .ticket-main {
            flex: 2.5;
            padding: 0;
            position: relative;
            border-right: 2px dashed #ccc;
        }
        .ticket-stub {
            flex: 1;
            padding: 25px;
            background: #fafafa;
        }
        
        .ticket-top {
		    background: var(--ticket-dark);
		    color: white;
		    padding: 20px 30px;
		    display: flex;
		    justify-content: start;
		    align-items: center;
		    width: 300px;
		    border-radius: 0 15px 15px 0;
		}
        .ticket-top h2 {
            margin: 0;
            font-size: 24px;
            letter-spacing: 2px;
            font-weight: 800;
            padding-left: 15px;
        }
        .brand-section {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 30px;
        }
        .bus-icon-circle {
            width: 80px;
            height: 80px;
            background: var(--ticket-dark);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--ticket-blue);
            font-size: 40px;
        }
        .brand-name {
		    font-size: 24px;
		    font-weight: 600;
		    color: var(--ticket-dark);
		    letter-spacing: -1px;
		}
        
        .ticket-content {
		    padding: 0 40px;
		    display: grid;
		    grid-template-columns: 1fr 1fr;
		    gap: 10px 20px;
		    padding-top: 40px;
        }
        .info-group {
            margin-bottom: 20px;
        }
        .label {
            font-size: 12px;
            color: #888;
            text-transform: uppercase;
            font-weight: 700;
            display: block;
            margin-bottom: 4px;
        }
        .value {
            font-size: 18px;
            color: var(--ticket-dark);
            font-weight: 700;
            display: block;
        }
        
        .ticket-footer-img {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 80px;
            object-fit: cover;
            opacity: 0.6;
            z-index: 0;
        }
        
        /* Stub Styles */
        .stub-title {
            font-size: 14px;
            font-weight: 800;
            color: #333;
            margin-bottom: 20px;
            display: block;
            text-align: center;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        .barcode {
            height: 60px;
            background: repeating-linear-gradient(90deg, #000, #000 2px, #fff 2px, #fff 4px);
            margin: 20px 0;
            width: 100%;
        }
        .stub-info {
            font-size: 12px;
            margin-bottom: 10px;
        }
        .stub-info b { display: block; color: #888; margin-bottom: 2px; }
        .date-value {
		    color:var(--ticket-dark);
		    font-weight: 800; 
		}
        .actions {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            transition: 0.3s;
            cursor: pointer;
            border: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .btn-download {
            background: var(--ticket-blue);
            color: white;
        }
        .btn-download:hover {
            background: var(--ticket-dark);
            transform: translateY(-2px);
        }
        .btn-home {
            background: #eee;
            color: var(--ticket-dark);
        }
        .btn-home:hover {
            background: #ddd;
        }

        @media (max-width: 768px) {
            .bus-ticket { flex-direction: column; }
            .ticket-main { border-right: none; border-bottom: 2px dashed #ccc; }
            .ticket-stub { border-left: none; }
        }
    </style>
</head>
<body>
    <jsp:include page="Navbar.jsp" />

    <div class="container">
        <div class="success-header">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h1>Booking Confirmed!</h1>
            <p>Thank you for choosing Gantavya. Your trip is scheduled and your ticket is ready.</p>
        </div>

        <div class="ticket-wrapper">
            <div id="capture-area">
                <div class="bus-ticket">
                    <div class="ticket-main">
                    	<div class="ticket-top">
                    		<img src="${pageContext.request.contextPath}/images/logo.png" alt="Gantavya Logo" class="nav-logo">
                            <h2>GANTAVYA</h2>
                        </div>
                        
                        

                        <div class="ticket-content">
                        	<div class="info-group">
                                <span class="label">Ticket No</span>
                                <span class="value">${booking.ticketId}</span>
                            </div>
                            <div class="info-group">
                                <span class="label"></span>
                                <span class="value"></span>
                            </div>
                            <div class="info-group">
                                <span class="label">Passenger</span>
                                <span class="value">${sessionScope.passengerName}</span>
                            </div>
                            <div class="info-group">
                                <span class="label">Booking Date</span>
                                <span class="value">${booking.bookingDate}</span>
                            </div>
                            <div class="info-group">
                                <span class="label">Bus No</span>
                                <span class="value">${booking.trip.busId}</span>
                            </div>
                            <div class="info-group">
                                <span class="label">Seat No</span>
                                <span class="value">${booking.seatNumber}</span>
                            </div>
                        </div>

                        <img src="${pageContext.request.contextPath}/images/contactus.png" class="ticket-footer-img" alt="skyline">
                    </div>

                    <div class="ticket-stub">
                        <span class="stub-title">TICKET DETAILS</span>
                        <div class="barcode"></div>
                        
                        <div class="stub-info">
                            <b>FROM</b><span class="date-value">${booking.trip.source}</span> 
                        </div>
                        <div class="stub-info">
                            <b>TO</b><span class="date-value">${booking.trip.destination}</span> 
                        </div>
                        <div class="stub-info">
                            <b> DEPARTURE DATE</b><span class="date-value">${booking.trip.departureDate}</span> 
                        </div>
                        <div class="stub-info">
                            <b>ARRIVAL DATE</b><span class="date-value">${booking.trip.arrivalDate}</span> 
                        </div>
                        <div class="stub-info">
                            <b>PAYMENT</b><span class="date-value">Completed</span> 
                        </div>
                    </div>
                </div>
            </div>

            <div class="actions">
                <button onclick="downloadTicket()" class="btn btn-download">
                    <i class="fas fa-download"></i> Download Ticket
                </button>
                <a href="${pageContext.request.contextPath}/my-bookings" class="btn btn-home">View Bookings</a>
            </div>
        </div>
    </div>

    <jsp:include page="Footer.jsp" />

    <script>
        function downloadTicket() {
            const area = document.getElementById('capture-area');
            html2canvas(area, {
                scale: 2,
                backgroundColor: null,
                logging: false,
                useCORS: true
            }).then(canvas => {
                const link = document.createElement('a');
                link.download = 'Gantavya-Ticket-${booking.ticketId}.png';
                link.href = canvas.toDataURL('image/png');
                link.click();
            });
        }

        // Auto-download if parameter is set
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('download') === 'true') {
                setTimeout(downloadTicket, 1000);
            }
        };
    </script>
</body>
</html>
