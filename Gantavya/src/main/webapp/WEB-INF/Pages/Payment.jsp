<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Payment | Gantavya</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Booking.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <style>
                .payment-container {
                    max-width: 500px;
                    margin: 50px auto;
                    background: white;
                    padding: 30px;
                    border-radius: 15px;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                    text-align: center;
                }

                .qr-code {
                    width: 250px;
                    height: 250px;
                    margin: 20px auto;
                    border: 1px solid #eee;
                    padding: 10px;
                    border-radius: 10px;
                }

                .amount-highlight {
                    font-size: 24px;
                    font-weight: bold;
                    color: #2c3e50;
                    margin: 15px 0;
                }

                .pay-confirm-btn {
                    background: #1a2e4a;
                    color: white;
                    border: none;
                    padding: 15px 40px;
                    font-size: 18px;
                    border-radius: 30px;
                    cursor: pointer;
                    width: 100%;
                    transition: all 0.3s;
                    font-weight: bold;
                    margin-top: 20px;
                }

                .pay-confirm-btn:hover {
                    background: #2980b9;
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
                }

                .payment-info {
                    text-align: left;
                    margin-top: 20px;
                    padding: 15px;
                    background: #f8f9fa;
                    border-radius: 10px;
                    font-size: 14px;
                }

                .payment-info p {
                    margin: 5px 0;
                    display: flex;
                    justify-content: space-between;
                }
            </style>
        </head>

        <body>
            <jsp:include page="Navbar.jsp" />

            <div class="payment-container">
                <h2>Complete Your Payment</h2>
                <p style="color: #666;">
                    <c:choose>
                        <c:when test="${sessionScope.pending_paymentMethod == 'khalti'}">Scan the QR code below using your Khalti app.</c:when>
                        <c:when test="${sessionScope.pending_paymentMethod == 'esewa'}">Scan the QR code below using your eSewa app.</c:when>
                        <c:otherwise>Scan the QR to pay.</c:otherwise>
                    </c:choose>
                </p>

                <div class="qr-code">
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=GantavyaPayment_Amount_${sessionScope.pending_total}_Trip_${sessionScope.pending_tripId}"
                        alt="Payment QR Code" style="width:100%; height:100%;">
                </div>

                <div class="amount-highlight">
                    Total Amount: Rs. ${sessionScope.pending_total}
                </div>

                <div class="payment-info">
                    <p><span>Trip ID:</span> <strong>${sessionScope.pending_tripId}</strong></p>
                    <p><span>Seats:</span> <strong>${sessionScope.pending_seats}</strong></p>
                    <p><span>Route:</span> <strong>${trip.source} to ${trip.destination}</strong></p>
                </div>

                <c:if test="${not empty error}">
                    <div style="color: #e74c3c; margin-top: 15px; font-weight: bold;">${error}</div>
                </c:if>

                <form action="payment" method="POST">
                    <button type="submit" class="pay-confirm-btn">Confirm & Pay</button>
                </form>
            </div>
        </body>

        </html>