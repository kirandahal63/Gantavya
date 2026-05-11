<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Gantavya - Travel</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Index.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        </head>

        <body>
			<jsp:include page="Navbar.jsp" />
            <header class="hero">

                <div class="search-overlay container">
                    <div class="search-card">
                        <div class="trip-type">
                            <label><input type="radio" name="type" checked> <span></span> One Way</label>
                        </div>
                        <div class="input-grid">
                            <div class="box">
                                <label>From</label>
                                <div class="inner-input">
                                    <i class="fa-solid fa-location-dot"></i>
                                    <input type="text" id="from-location" placeholder="Kathmandu">
                                    <i class="fa-solid fa-arrows-left-right-to-line swap"></i>
                                </div>
                            </div>
                            <div class="box">
                                <label>To</label>
                                <div class="inner-input">
                                    <i class="fa-solid fa-location-dot"></i>
                                    <input type="text" id="to-location" placeholder="Pokhara">
                                </div>
                            </div>
                            <div class="box">
                                <label>Departure</label>
                                <div class="inner-input" onclick="document.getElementById('real-date').showPicker()"
                                    style="cursor: pointer;">
                                    <i class="fa-regular fa-calendar"></i>
                                    <input type="text" id="departure-date" placeholder="Today, 5 May" readonly
                                        style="cursor: pointer;">
                                    <input type="date" id="real-date"
                                        style="position: absolute; opacity: 0; width: 0; height: 0;"
                                        onchange="handleDateSelection(this.value)">
                                </div>
                            </div>
                            <div class="box">
                                <label>Passengers / Bikes</label>
                                <div class="inner-input">
                                    <i class="fa-solid fa-user-group"></i>
                                    <select id="passengers">
                                        <option value="1">1 Adult</option>
                                        <option value="2">2 Adults</option>
                                        <option value="3">3 Adults</option>
                                        <option value="4">4 Adults</option>
                                        <option value="5">5 Adults</option>
                                    </select>
                                </div>
                            </div>
                            <button class="search-btn" onclick="performSearch()">Search</button>
                        </div>
                        <div class="accommodation">
                            <input type="checkbox" checked id="acc">
                            <label for="acc">Find my accommodation <i class="fa-solid fa-circle-info"></i></label>
                        </div>
                    </div>
                </div>
            </header>

            <main class="container">
                <!-- Header updated to "UPCOMING TRIPS" -->
                <!-- BOTTOM PROMO CARDS MOVED UP -->

                <!-- Header updated to "UPCOMING TRIPS" -->
                <div class="section-head">
                    <h2>UPCOMING TRIPS</h2>
                    <a href="#">View All Trips ></a>
                </div>

                <!-- UPCOMING TRIPS GRID -->
                <div class="route-grid">
                    <c:forEach var="trip" items="${trips}">
                        <div class="route-card">
                            <!-- Badge logic: can be dynamic based on trip status -->
                            <span class="badge">AVAILABLE NOW</span>

                            <div class="path-viz">
                                <!-- Departure Point -->
                                <div class="point">
                                    <i class="fa-regular fa-circle-dot"></i>
                                    <span>
                                        <strong>${trip.departureDate}</strong>
                                        ${trip.source}
                                    </span>
                                </div>

                                <!-- Vertical Dotted Line -->
                                <div class="line"></div>

                                <!-- Arrival Point -->
                                <div class="point">
                                    <i class="fa-solid fa-location-dot arrival-icon"></i>
                                    <span>
                                        <strong>${trip.arrivalDate}</strong>
                                        ${trip.destination}
                                    </span>
                                </div>
                            </div>

                            <div class="card-footer">
                                <span><i class="fa fa-bus"></i> ${trip.availableSeats} Seats Left</span>
                                <a href="booking?tripId=${trip.tripId}">BOOK JOURNEY</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="promo-flex" style="margin-bottom: 40px;">
                    <div class="promo-blue">
                        <h2>THE NEW STANDARD OF BUS TRAVEL.</h2>
                        <p>Every journey is engineered for comfort with high-speed Wi-Fi and ergonomic seating.</p>
                        <i class="fa fa-bus-simple water-icon"></i>
                    </div>
                    <div class="promo-eco">
                        <i class="fa-solid fa-leaf leaf"></i>
                        <h3>Sustainable Routes</h3>
                        <p>Join us in reducing CO2 emissions with our modern Euro 6 fleet.</p>
                    </div>
                </div>

            </main>
            
			<jsp:include page="Footer.jsp" />
			
            <script>
                function swapLocations() {
                    const from = document.getElementById('from-location');
                    const to = document.getElementById('to-location');
                    const temp = from.value || from.placeholder;
                    from.value = to.value || to.placeholder;
                    to.value = temp;
                }

                function performSearch() {
                    const from = document.getElementById('from-location').value || document.getElementById('from-location').placeholder;
                    const to = document.getElementById('to-location').value || document.getElementById('to-location').placeholder;
                    const date = document.getElementById('real-date').value;
                    const passengers = document.getElementById('passengers').value;

                    window.location.href = '<%= request.getContextPath() %>/search?from=' + encodeURIComponent(from) + '&to=' + encodeURIComponent(to) + '&date=' + encodeURIComponent(date) + '&passengers=' + encodeURIComponent(passengers);
                }

                function handleDateSelection(val) {
                    if (!val) return;
                    
                    // Safe parsing of YYYY-MM-DD to local date
                    const [y, m, d] = val.split('-').map(Number);
                    const selected = new Date(y, m - 1, d);
                    
                    const today = new Date();
                    today.setHours(0,0,0,0);
                    selected.setHours(0,0,0,0);

                    const options = { month: 'long', day: 'numeric', year: 'numeric' };
                    if (selected.getTime() === today.getTime()) {
                        document.getElementById('departure-date').value = "Today, " + selected.toLocaleDateString('en-US', { month: 'long', day: 'numeric' });
                    } else {
                        document.getElementById('departure-date').value = selected.toLocaleDateString('en-US', options);
                    }
                }

                // Initialize date dynamically
                const today = new Date();
                const formattedToday = today.toLocaleDateString('en-US', { month: 'long', day: 'numeric' });
                document.getElementById('departure-date').value = "Today, " + formattedToday;
                const yyyy = today.getFullYear();
                const mm = String(today.getMonth() + 1).padStart(2, '0');
                const dd = String(today.getDate()).padStart(2, '0');
                const todayStr = yyyy + '-' + mm + '-' + dd;
                document.getElementById('real-date').value = todayStr;
                document.getElementById('real-date').min = todayStr;
            </script>
        </body>

        </html>