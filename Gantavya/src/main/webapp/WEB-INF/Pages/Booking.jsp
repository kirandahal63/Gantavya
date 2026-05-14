<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <form action="booking" method="POST">
            <input type="hidden" name="tripId" value="${trip.tripId}">
            <div class="booking-grid">
                
                <!-- COLUMN 1: Seat Selection -->
                <section class="booking-card seat-section">
                    <div class="step-header">
                        <div style="display: flex; flex-direction: column; width: 100%;">
                            <c:if test="${param.error == 'seat_taken'}">
                                <div style="color: #d9534f; background: #f2dede; padding: 10px; border-radius: 4px; margin-bottom: 10px; font-weight: bold; font-size: 14px;">
                                    <i class="fas fa-exclamation-circle"></i> Some seats were already booked. Please select available ones.
                                </div>
                            </c:if>
                            <c:if test="${param.error == 'limit_exceeded'}">
                                <div style="color: #d9534f; background: #f2dede; padding: 10px; border-radius: 4px; margin-bottom: 10px; font-weight: bold; font-size: 14px;">
                                    <i class="fas fa-exclamation-circle"></i> You can only book up to 5 seats at once.
                                </div>
                            </c:if>
                            <div class="step-header" style="margin-bottom: 0;">
                                <span class="step-num">1</span>
                                <h2>Select Seats</h2>
                            </div>
                            <div style="margin-left: 45px; color: #666; font-weight: 500; margin-top: -5px;">
                                ${trip.busType} - ${trip.capacity} Seats
                            </div>
                            <div id="selectedSeatsList" style="margin-left: 45px; margin-top: 5px; font-size: 14px; color: #1a2e4a; font-weight: bold;">
                                Selected: None
                            </div>
                        </div>
                    </div>
                    <div class="bus-container">
                        <div class="bus-front">Driver</div>
                        <div class="seat-grid" id="seatGrid">
                            <% 
                               com.gantavya.model.TripModel trip = (com.gantavya.model.TripModel) request.getAttribute("trip");
                               int capacity = (trip != null) ? trip.getCapacity() : 0;
                               if (capacity == 0) capacity = 23; // Fallback
                               
                               java.util.List<?> bookedSeats = (java.util.List<?>) request.getAttribute("bookedSeats");
                               
                               char[] rows = {'A','B','C','D','E','F','G','H','I','J','K','L','M'};
                               int seatsGenerated = 0;
                               for(char row : rows) {
                                   if (seatsGenerated >= capacity) break;
                                   for(int i=1; i<=4; i++) {
                                       if (seatsGenerated >= capacity) break;
                                       String id = row + "" + i;
                                       seatsGenerated++;
                                       boolean isBooked = (bookedSeats != null && bookedSeats.contains(id));
                            %>
                                <div class="seat <%= isBooked ? "booked" : "" %>" data-seat="<%=id%>"><%=id%></div>
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
                        <div class="passenger-inputs" id="passengerInputs">
                            <!-- Populated dynamically by script -->
                        </div>
                        <input type="hidden" name="email" value="${sessionScope.userEmail}">
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
						        <input type="radio" name="paymentMethod" value="esewa" checked>
						        <img src="${pageContext.request.contextPath}/images/eSewa.png" alt="eSewa">
						        <span>eSewa</span>
						    </label>
						
						    <label class="pay-item">
						        <input type="radio" name="paymentMethod" value="khalti">
						        <img src="${pageContext.request.contextPath}/images/khalti.png" alt="Khalti">
						        <span>Khalti</span>
						    </label>
						</div>
                    </section>
                </div> <!-- End of Center Column -->

                <!-- COLUMN 3: Summary -->
                <aside class="summary-column">
                    <div class="summary-container">
                        <div class="summary-header">
                            <h3>Your Booking</h3>
                        </div>

                        <div class="trip-details card-inner">
                            <div class="date-badge" style="font-weight: bold; margin-bottom: 10px;">${trip.departureDate}</div>
                            <div class="route-visual">
                                <div class="dot"></div>
                                <div class="line"></div>
                                <div class="dot"></div>
                            </div>
                            <div class="route-text">
                                <p style="margin-bottom: 15px;"><strong>${trip.source}</strong> <span style="float:right;">${trip.departureDate.length() > 16 ? trip.departureDate.substring(11, 16) : ''}</span></p>
                                <p><strong>${trip.destination}</strong> <span style="float:right;">${trip.arrivalDate.length() > 16 ? trip.arrivalDate.substring(11, 16) : ''}</span></p>
                            </div>
                            <div class="direct-tag" style="color: #1a2e4a; font-size: 12px; font-weight: bold; margin-top: 15px;">DIRECT TRIP</div>
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
        const passengerInputs = document.getElementById('passengerInputs');
        const luggageQty = document.getElementById('luggageQty');
        const selectedSeatsList = document.getElementById('selectedSeatsList');
        
        let selected = [];
        const TICKET_PRICE = ${trip.fare};
        const LUGGAGE_PRICE = 500;
        const SERVICE_FEE = 50;
        const CURRENT_USER_NAME = "${sessionScope.passengerName != null ? sessionScope.passengerName : ''}";

        function updateUI() {
            // 1. Update Hidden Input and Text List
            selectedInput.value = selected.join(',');
            selectedSeatsList.innerText = selected.length > 0 ? "Selected: " + selected.join(', ') : "Selected: None";
            
            // 2. Update Passenger Fields
            passengerInputs.innerHTML = '';
            
            // Always show first passenger (Readonly)
            const p1Div = document.createElement('div');
            p1Div.className = 'form-group';
            p1Div.style.marginBottom = "15px";
            const p1Label = document.createElement('label');
            p1Label.className = 'form-label';
            p1Label.innerText = "Passenger 1 ";
            const p1Input = document.createElement('input');
            p1Input.type = 'text';
            p1Input.name = 'passengerName_0';
            p1Input.className = 'full-input';
            p1Input.value = CURRENT_USER_NAME;
            p1Input.readOnly = true;
            p1Input.style.backgroundColor = "#f9f9f9"; // Subtle hint that it's uneditable
            p1Div.appendChild(p1Label);
            p1Div.appendChild(p1Input);
            passengerInputs.appendChild(p1Div);

            // Show additional fields if more than 1 seat is selected
            if (selected.length > 1) {
                for (let i = 1; i < selected.length; i++) {
                    const div = document.createElement('div');
                    div.className = 'form-group';
                    div.style.marginBottom = "15px";
                    
                    const label = document.createElement('label');
                    label.className = 'form-label';
                    label.innerText = "Passenger " + (i + 1) + "  (Seat " + selected[i] + ")";
                    
                    const input = document.createElement('input');
                    input.type = 'text';
                    input.name = 'passengerName_' + i;
                    input.className = 'full-input';
                    input.required = true;
                    input.placeholder = "Full Name *";
                    
                    div.appendChild(label);
                    div.appendChild(input);
                    passengerInputs.appendChild(div);
                }
            }

            // 3. Update Summary Prices
            let calcPassengers = selected.length * TICKET_PRICE;
            let calcLuggage = parseInt(luggageQty.value) * LUGGAGE_PRICE;
            
            seatCountDisplay.innerText = selected.length;
            passengerPrice.innerText = 'Rs. ' + calcPassengers;
            
            let total = 0;
            if (selected.length > 0) {
                total = calcPassengers + calcLuggage + SERVICE_FEE;
            }
            totalDisplay.innerText = 'Rs. ' + total;
        }

        seats.forEach(seat => {
            seat.addEventListener('click', () => {
                const id = seat.dataset.seat;
                if(selected.includes(id)) {
                    selected = selected.filter(s => s !== id);
                    seat.classList.remove('selected');
                } else {
                    if (selected.length >= 5) {
                        alert("You can only book up to 5 seats at once.");
                        return;
                    }
                    selected.push(id);
                    seat.classList.add('selected');
                }
                updateUI();
            });
        });

        function changeQty(val) {
            let newVal = parseInt(luggageQty.value) + val;
            if(newVal >= 0) {
                luggageQty.value = newVal;
                updateUI();
            }
        }

        // Form Validation
        document.querySelector('form').onsubmit = function(e) {
            if (selected.length === 0) {
                alert("Please select at least one seat to proceed.");
                e.preventDefault();
                return false;
            }
            return true;
        };

        // Initialize empty UI
        updateUI();
    </script>
</body>
</html>