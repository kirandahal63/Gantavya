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

            <!-- Navbar precisely like image_ff7fbf.jpg -->
            <nav class="navbar">
                <div class="container nav-flex">
                    <div class="logo">gantavya</div>
                    <div class="menu">
                        <a href="#">Plan Your Journey <i class="fa fa-chevron-down"></i></a>
                        <a href="#">Service <i class="fa fa-chevron-down"></i></a>
                        <a href="#">Manage My Booking</a>
                        <a href="#">Trip Tracker</a>
                        <a href="${pageContext.request.contextPath}/login">Login</a>
                    </div>
                    <div class="lang"><i class="fa fa-globe"></i> English</div>
                </div>
            </nav>

            <header class="hero">

                <div class="search-overlay container">
                    <div class="search-card">
                        <div class="trip-type">
                            <label><input type="radio" name="type" checked> <span></span> One Way</label>
                            <label><input type="radio" name="type"> <span></span> Round Trip</label>
                        </div>
                        <div class="input-grid">
                            <div class="box">
                                <label>From</label>
                                <div class="inner-input">
                                    <i class="fa-solid fa-location-dot"></i>
                                    <input type="text" placeholder="Kathmandu">
                                    <i class="fa-solid fa-arrows-left-right-to-line swap"></i>
                                </div>
                            </div>
                            <div class="box">
                                <label>To</label>
                                <div class="inner-input">
                                    <i class="fa-solid fa-location-dot"></i>
                                    <input type="text" placeholder="Pokhara">
                                </div>
                            </div>
                            <div class="box">
                                <label>Departure</label>
                                <div class="inner-input">
                                    <i class="fa-regular fa-calendar"></i>
                                    <input type="text" placeholder="Today, 10 Apr">
                                </div>
                            </div>
                            <div class="box">
                                <label>Passengers / Bikes</label>
                                <div class="inner-input">
                                    <i class="fa-solid fa-user-group"></i>
                                    <select>
                                        <option>1 Adult</option>
                                    </select>
                                </div>
                            </div>
                            <button class="search-btn">Search</button>
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
                                <a href="book?id=${trip.tripId}">BOOK JOURNEY</a>
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

        </body>

        </html>