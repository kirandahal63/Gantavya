<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking - Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

    <nav class="navbar">
        <div class="container nav-flex">
            <div class="logo" onclick="window.location.href='home'" style="cursor:pointer">gantavya</div>
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

    <div class="booking-header" style="background: #f8f9fa; padding: 40px 0;">
        <div class="container">
            <div class="search-card">
                <div class="trip-type">
                    <label><input type="radio" name="type" checked> <span></span> One Way</label>
                    <label><input type="radio" name="type"> <span></span> Round Trip</label>
                </div>
                <div class="input-grid" style="grid-template-columns: 1fr 1fr 1fr 1fr;">
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
                        <div class="inner-input" onclick="openCalendar()" style="cursor: pointer;">
                            <i class="fa-regular fa-calendar"></i>
                            <input type="text" id="display-date" value="${searchDate}" readonly style="cursor: pointer;">
                            <input type="date" id="hidden-date-picker" style="position:absolute; visibility:hidden; width:0; height:0;" onchange="handleCalendarSelection(this.value)">
                        </div>
                    </div>
                    <div class="box">
                        <div class="box">
                                <label>Passengers</label>
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
                    </div>
                </div>
            </div>

            <!-- Horizontal Date Picker (Always visible on booking page context) -->
            <div class="date-selector-container" style="display: block; margin-top: 30px;">
                <div class="date-bar" id="sliding-date-bar">
                    <!-- Dates will be injected here by JS -->
                </div>
            </div>
        </div>
    </div>

    <style>
    /*
        .search-result-card {
            background: white;         
            border-radius: 30px;
            padding: 20px;
            margin-bottom: 25px;
            display: grid;
            grid-template-columns: 1fr 200px;
            gap: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            transition: transform 0.2s, box-shadow 0.2s;
        }*/
        .search-result-card:hover {
        	border-top: 3px solid #1a2e4a; /* Blue line above card */
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.07);
        }
        .trip-details-new {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-grow: 1;
        }
        .time-column {
            display: flex;
            flex-direction: column;
            gap: 2px;
            min-width: 120px;
        }
        .time-column .label {
            font-size: 11px;
            color: #888;
            text-transform: uppercase;
            font-weight: 600;
        }
        .time-column .time {
            font-size: 22px;
            font-weight: 800;
            color: #1a1a1a;
        }
        .time-column .date {
            font-size: 13px;
            color: #666;
            margin-bottom: 5px;
        }
        .time-column .location {
            font-size: 15px;
            font-weight: 600;
            color: #333;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .time-column .location i {
            color: #666;
            font-size: 14px;
        }
        
        .duration-connector {
            flex-grow: 1;
            margin: 0 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        .dotted-line {
            width: 100%;
            height: 0;
            border-top: 2px dotted #ccc;
        }

        .price-section {
       		min-width: 120px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-end;
            border-left: 1px solid #f0f0f0;
            padding-left: 20px;
        }
        .price {
            font-size: 20px;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 15px;
        }
        .book-btn {
            background: #1a2e4aeb;/* Blue button from image */
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 15px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
            width: 100%;
            justify-content: center;
            transition: background 0.3s;
            box-shadow: 0 4px 10px rgba(30, 101, 167, 0.2);
        }
        .book-btn:hover { background: #154d82; }

        .brand-badge {
            background: #274d8291; 
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: 800;
            font-size: 11px;
            text-transform: uppercase;
            width: fit-content;
            margin-bottom: 15px;
        }
        .seats-left {
            font-size: 12px;
            color: #d9534f;
            font-weight: 700;
            padding:20px 0px;
            display: flex;
            align-items: center;
            gap: 4px;
        }
    </style>

    <main class="container" style="margin-top: 40px;">
        <div class="booking-results">
            <div class="results-count">
                <button class="filter-btn"><i class="fa-solid fa-sliders"></i> Filters</button>
                <span style="color: #666; font-size: 14px;">${trips.size()} buses found</span>
            </div>

            <c:if test="${empty trips}">
                <div style="text-align: center; padding: 50px; background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
                    <i class="fa-solid fa-bus-simple" style="font-size: 48px; color: #ddd; margin-bottom: 20px;"></i>
                    <h3 style="color: #333;">No buses found</h3>
                    <p style="color: #666;">Try searching for a different route or date.</p>
                </div>
            </c:if>

            <c:forEach items="${trips}" var="trip">
                <div class="search-result-card">
                    <div class="result-main">
                        <div class="brand-badge">${trip.busType}</div>
                        <div class="trip-details-new">
                            <div class="time-column">
                                <span class="label">Departure</span>
                                <span class="time">${trip.departureDate.length() > 16 ? trip.departureDate.substring(11, 16) : '23:17'}</span>
                                <span class="date">${trip.departureDate.length() >= 10 ? trip.departureDate.substring(0, 10) : trip.departureDate}</span>
                                <span class="location"><i class="fa-solid fa-location-dot"></i> ${trip.source}</span>
                            </div>
                            
                            <div class="duration-connector">
                                <div class="dotted-line"></div>                                
                            </div>

                            <div class="time-column">
                                <span class="label">Arrival</span>
                                <span class="time">${trip.arrivalDate.length() > 16 ? trip.arrivalDate.substring(11, 16) : '10:14'}</span>
                                <span class="date">${trip.arrivalDate.length() >= 10 ? trip.arrivalDate.substring(0, 10) : trip.arrivalDate}</span>
                                <span class="location"><i class="fa-solid fa-location-dot"></i> ${trip.destination}</span>
                            </div>
                        </div>
                    </div>
                    <div class="price-section">
                        <div class="price">Rs. ${trip.fare}</div>
                        <button class="book-btn" onclick="window.location.href='book?tripId=${trip.tripId}'">
                            Book Now <i class="fa fa-chevron-right"></i>
                        </button>
                        <div class="seats-left"> ${trip.availableSeats} Seats available</div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <script>
        const today = new Date();
        today.setHours(0,0,0,0);
        
        let centerDate = parseDateString("${searchDate}");
        if (isNaN(centerDate.getTime())) centerDate = new Date(today);

        function parseDateString(str) {
            if (!str) return new Date();
            // Handle YYYY-MM-DD
            if (/^\d{4}-\d{2}-\d{2}$/.test(str)) {
                const [y, m, d] = str.split('-').map(Number);
                return new Date(y, m - 1, d);
            }
            
            // Handle "Today, May 5" or "May 21, 2026"
            if (str.includes("Today, ")) str = str.replace("Today, ", "");
            const d = new Date(str);
            if (!isNaN(d.getTime())) return d;

            return new Date();
        }

        function formatDate(date) {
            const today = new Date();
            today.setHours(0,0,0,0);
            const d = new Date(date);
            d.setHours(0,0,0,0);

            if (d.getTime() === today.getTime()) {
                return "Today, " + d.toLocaleDateString('en-US', { month: 'long', day: 'numeric' });
            }
            return d.toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' });
        }

        function renderDateBar() {
            const bar = document.getElementById('sliding-date-bar');
            if (!bar) return;
            bar.innerHTML = '';

            const dates = [
                new Date(centerDate.getTime() - 86400000), // Left
                new Date(centerDate.getTime()),            // Middle (Active)
                new Date(centerDate.getTime() + 86400000)  // Right
            ];



            dates.forEach((d, index) => {
                const item = document.createElement('div');
                item.className = 'date-item';
                if (index === 1) item.classList.add('active');
                
                item.innerText = d.toLocaleDateString('en-US', { weekday: 'short', day: 'numeric', month: 'short' });
                
                const dCopy = new Date(d);
                dCopy.setHours(0,0,0,0);
                
                if (dCopy < today) {
                    item.style.opacity = '0.3';
                    item.style.cursor = 'not-allowed';
                    item.style.pointerEvents = 'none';
                } else {
                    item.onclick = () => {
                        centerDate = new Date(d.getTime());
                        updateSelectedDate();
                        renderDateBar();
                    };
                }
                
                bar.appendChild(item);
            });
        }

        function updateSelectedDate() {
            document.getElementById('display-date').value = formatDate(centerDate);
            console.log("Searching for:", centerDate.toISOString().split('T')[0]);
        }

        function openCalendar() {
            document.getElementById('hidden-date-picker').showPicker();
        }

        function handleCalendarSelection(val) {
            if (!val) return;
            const newDate = new Date(val);
            if (newDate < today) {
                alert("Please select a future date.");
                return;
            }
            centerDate = newDate;
            updateSelectedDate();
            renderDateBar();
        }

        // Set initial display
        document.getElementById('display-date').value = formatDate(centerDate);

        // Initialize
        renderDateBar();
    </script>
</body>
</html>
