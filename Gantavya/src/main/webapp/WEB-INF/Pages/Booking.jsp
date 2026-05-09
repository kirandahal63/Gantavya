<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking | Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Booking.css"> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="Navbar.jsp" />

    <div class="booking-master-container">
        <form action="BookingServlet" method="POST">
            <div class="booking-grid">
                
                <!-- COLUMN 1: Seat Selection -->
                <section class="booking-card seat-section">
                    <div class="step-header">
                        <span class="step-num">1</span>
                        <h2>Select Seats</h2>
                    </div>
                    <div class="bus-container">
                        <div class="bus-front">Driver</div>
                        <div class="seat-grid" id="seatGrid">
                            <% 
                               char[] rows = {'A','B','C','D','E','F','G','H','I'};
                               for(char row : rows) {
                                   for(int i=1; i<=4; i++) {
                                       String id = row + "" + i;
                            %>
                                <div class="seat" data-seat="<%=id%>"><%=id%></div>
                            <% if(i==2) { %><div class="aisle"></div><% } %>
                            <% } } %>
                        </div>
                    </div>
                    <input type="hidden" name="selectedSeats" id="selectedSeatsInput">
                </section>

                <!-- COLUMN 2: Passengers & Extras -->
                <div class="center-column">
                    <section class="booking-card">
                        <div class="step-header">
                            <span class="step-num">2</span>
                            <h2>Passengers</h2>
                        </div>
                        <div class="passenger-inputs">
                            <input type="text" name="fName" placeholder="First Name *" class="full-input" required>
                            <input type="text" name="lName" placeholder="Last Name *" class="full-input" required>
                        </div>
                    </section>

                    <section class="booking-card extras-card">
                        <div class="step-header">
                            <span class="step-num">3</span>
                            <h2>Extras</h2>
                        </div>
                        <div class="extra-item included">
                            <i class="fas fa-suitcase"></i>
                            <div class="extra-text">
                                <strong>Included per person</strong>
                                <p>1 Small bag (7kg) + 1 Hold luggage (20kg)</p>
                            </div>
                        </div>
                        <div class="extra-item add-on">
                            <i class="fas fa-plus-circle"></i>
                            <div class="extra-text">
                                <strong>Additional luggage</strong>
                                <p>20 kg · 80×50×30 cm</p>
                            </div>
                            <div class="price-tag">+ Rs. 500</div>
                            <div class="counter">
                                <button type="button" onclick="changeQty(-1)">-</button>
                                <input type="number" name="extraLuggage" id="luggageQty" value="0" readonly>
                                <button type="button" onclick="changeQty(1)">+</button>
                            </div>
                        </div>
                    </section>

                    <section class="booking-card">
                        <div class="step-header">
                            <span class="step-num">4</span>
                            <h2>Payment Method</h2>
                        </div>
                        <div class="payment-options">
                            <label class="pay-item">
                                <input type="radio" name="payment" value="khalti" checked>
                                <img src="images/khalti.png" alt="Khalti" style="height:20px; vertical-align:middle;"> Khalti / FonePay
                            </label>
                            <label class="pay-item" style="margin-top:10px; display:block;">
                                <input type="radio" name="payment" value="card">
                                <i class="fa-solid fa-credit-card"></i> Credit / Debit Card
                            </label>
                        </div>
                    </section>
                </div> <!-- End of Center Column -->

                <!-- COLUMN 3: Summary -->
                <aside class="summary-column">
                    <div class="summary-container">
                        <div class="summary-header">
                            <h3>Your Booking</h3>
                            <div class="timer"><i class="far fa-clock"></i> 09:59</div>
                        </div>

                        <div class="trip-details card-inner">
                            <div class="date-badge" style="font-weight: bold; margin-bottom: 10px;">Sat, 9 May</div>
                            <div class="route-visual">
                                <div class="dot"></div>
                                <div class="line"></div>
                                <div class="dot"></div>
                            </div>
                            <div class="route-text">
                                <p style="margin-bottom: 15px;"><strong>Kathmandu</strong> <span style="float:right;">10:45</span></p>
                                <p><strong>Pokhara</strong> <span style="float:right;">13:50</span></p>
                            </div>
                            <div class="direct-tag" style="color: #2ecc71; font-size: 12px; font-weight: bold; margin-top: 15px;">DIRECT TRIP</div>
                        </div>

                        <div class="cost-details card-inner">
                            <div class="price-line total-line">
                                <strong>Total (incl. VAT)</strong>
                                <strong id="totalDisplay">Rs. 0</strong>
                            </div>
                            <div class="price-line sub">
                                <span>Passengers (<span id="seatCountDisplay">0</span>)</span>
                                <span id="passengerPrice">Rs. 0</span>
                            </div>
                            <div class="price-line sub">
                                <span>Service Fee</span>
                                <span>Rs. 50</span>
                            </div>
                        </div>

                        <div class="card-inner">
                            <label class="terms" style="font-size: 12px; display: flex; gap: 10px; align-items: flex-start;">
                                <input type="checkbox" required> 
                                <span>I declare to have read the Privacy Policy and I agree to the T&C of Booking.</span>
                            </label>
                        </div>

                        <button type="submit" class="pay-btn">Proceed to Payment</button>
                    </div>
                </aside>
            </div>
        </form>
    </div>

    <script>
        const seats = document.querySelectorAll('.seat');
        const selectedInput = document.getElementById('selectedSeatsInput');
        const totalDisplay = document.getElementById('totalDisplay');
        const passengerPrice = document.getElementById('passengerPrice');
        const seatCountDisplay = document.getElementById('seatCountDisplay');
        
        let selected = [];
        const TICKET_PRICE = 1200;
        const SERVICE_FEE = 50;

        seats.forEach(seat => {
            seat.addEventListener('click', () => {
                const id = seat.dataset.seat;
                if(selected.includes(id)) {
                    selected = selected.filter(s => s !== id);
                    seat.classList.remove('selected');
                } else {
                    selected.push(id);
                    seat.classList.add('selected');
                }
                
                // Update Hidden Input
                selectedInput.value = selected.join(',');
                
                // Update Summary
                let calcPassengers = selected.length * TICKET_PRICE;
                seatCountDisplay.innerText = selected.length;
                passengerPrice.innerText = 'Rs. ' + calcPassengers;
                totalDisplay.innerText = 'Rs. ' + (calcPassengers > 0 ? (calcPassengers + SERVICE_FEE) : 0);
            });
        });

        function changeQty(val) {
            let qty = document.getElementById('luggageQty');
            let newVal = parseInt(qty.value) + val;
            if(newVal >= 0) qty.value = newVal;
        }
    </script>
</body>
</html>