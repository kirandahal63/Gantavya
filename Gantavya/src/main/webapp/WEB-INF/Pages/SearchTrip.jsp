<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Booking - Gantavya</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/Index.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body>

	<jsp:include page="Navbar.jsp" />

	<div class="booking-header"
		style="background: #f8f9fa; padding: 40px 0;">
		<div class="container">
			<div class="search-card">
				<div class="trip-type">
					<label><input type="radio" name="type" checked> <span></span>
						One Way</label>
				</div>
				<div class="input-grid"
					style="grid-template-columns: 1fr 1fr 1fr 1fr;">
					<div class="box">
						<label>From</label>
						<div class="inner-input">
							<i class="fa-solid fa-location-dot"></i> <input type="text"
								id="from-location" placeholder="Kathmandu" value="${searchFrom}">
						</div>
					</div>


					<div class="box">
						<label>To</label>
						<div class="inner-input">
							<i class="fa-solid fa-location-dot"></i> <input type="text"
								id="to-location" placeholder="Pokhara" value="${searchTo}">
						</div>
					</div>


					<div class="box">
						<label>Departure</label>
						<div class="inner-input" onclick="openCalendar()"
							style="cursor: pointer;">
							<i class="fa-regular fa-calendar"></i> <input type="text"
								id="display-date" value="${searchDate}" readonly
								style="cursor: pointer;"> <input type="date"
								id="hidden-date-picker"
								style="position: absolute; visibility: hidden; width: 0; height: 0;"
								onchange="handleCalendarSelection(this.value)">
						</div>
					</div>
					<div class="box">
						<div class="box">
							<label>Passengers</label>
							<div class="inner-input">
								<i class="fa-solid fa-user-group"></i> <select id="passengers">
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
			<div class="date-selector-container"
				style="display: block; margin-top: 30px;">
				<div class="date-bar" id="sliding-date-bar">
					<!-- Dates will be injected here by JS -->
				</div>
			</div>
		</div>
	</div>

	<style>
		.search-result-card:hover {
			border-top: 3px solid #1a2e4a;
			/* Blue line above card */
			transform: translateY(-2px);
			box-shadow: 0 8px 25px rgba(0, 0, 0, 0.07);
		}
		
		.trip-details-new {
			display: flex;
			align-items: center;
			justify-content: space-between;
			flex-grow: 1;
			padding-left: 60px;
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
			background: #1a2e4aeb;
			/* Blue button from image */
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
		
		.book-btn:hover {
			background: #154d82;
		}
		
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
			margin-left: 60px;
		}
		
		.seats-left {
			font-size: 12px;
			color: #e62222;
			font-weight: 700;
			padding: 20px 0px;
			display: flex;
			align-items: center;
			gap: 4px;
		}
	</style>

	<main class="container" style="margin-top: 40px; margin-bottom: 80px;">
		<div class="booking-results">
			<div class="results-count">
				<button class="filter-btn">
					<i class="fa-solid fa-sliders"></i> Filters
				</button>
				<span id="buses-found-count" style="color: #666; font-size: 14px;">
					<c:choose>
						<c:when test="${isFallback}">
							<span style="color: #e62222; font-weight: 600;"><i
								class="fa-solid fa-circle-exclamation"></i> ${fallbackMessage}</span>
						</c:when>
						<c:otherwise>
                                    ${trips.size()} buses found
                                </c:otherwise>
					</c:choose>
				</span>
			</div>

			<div id="no-buses-msg"
				style="${empty trips ? 'display: block;' : 'display: none;'} text-align: center; padding: 50px; background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
				<i class="fa-solid fa-bus-simple"
					style="font-size: 48px; color: #ddd; margin-bottom: 20px;"></i>
				<h3 style="color: #333;">No buses found</h3>
				<p style="color: #666;">Try searching for a different route or
					date.</p>
			</div>

			<div id="trips-list-container">
				<c:forEach items="${trips}" var="trip">
					<div class="search-result-card">
						<div class="result-main">
							<div class="brand-badge">${trip.busType}</div>
							<div class="trip-details-new">
								<div class="time-column">
									<span class="label">Departure</span> <span class="time">${trip.departureDate.length() > 16 ? trip.departureDate.substring(11, 16) : '23:17'}</span>
									<span class="date">${trip.departureDate.length() >= 10 ? trip.departureDate.substring(0, 10) : trip.departureDate}</span>
									<span class="location"><i
										class="fa-solid fa-location-dot"></i> ${trip.source}</span>
								</div>

								<div class="duration-connector">
									<div class="dotted-line"></div>
								</div>

								<div class="time-column">
									<span class="label">Arrival</span> <span class="time">${trip.arrivalDate.length() > 16 ? trip.arrivalDate.substring(11, 16) : '10:14'}</span>
									<span class="date">${trip.arrivalDate.length() >= 10 ? trip.arrivalDate.substring(0, 10) : trip.arrivalDate}</span>
									<span class="location"><i
										class="fa-solid fa-location-dot"></i> ${trip.destination}</span>
								</div>
							</div>
						</div>
						<div class="price-section">
							<div class="price">Rs. ${trip.fare}</div>
							<button class="book-btn"
								onclick="window.location.href='booking?tripId=${trip.tripId}'">
								Book Now <i class="fa fa-chevron-right"></i>
							</button>
							<div class="seats-left">${trip.availableSeats} Seats
								available</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</main>

	<jsp:include page="Footer.jsp" />

	<script>
                const today = new Date();
                today.setHours(0, 0, 0, 0);

                let centerDate = parseDateString("${searchDate}");
                if (isNaN(centerDate.getTime())) centerDate = new Date(today);

                function getLocalDateString(date) {
                    const y = date.getFullYear();
                    const m = String(date.getMonth() + 1).padStart(2, '0');
                    const d = String(date.getDate()).padStart(2, '0');
                    return y + '-' + m + '-' + d;
                }

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
                    today.setHours(0, 0, 0, 0);
                    const d = new Date(date);
                    d.setHours(0, 0, 0, 0);

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
                        new Date(centerDate.getTime() - 86400000), 
                        new Date(centerDate.getTime()),            
                        new Date(centerDate.getTime() + 86400000)  
                    ];



                    dates.forEach((d, index) => {
                        const item = document.createElement('div');
                        item.className = 'date-item';
                        if (index === 1) item.classList.add('active');

                        item.innerText = d.toLocaleDateString('en-US', { weekday: 'short', day: 'numeric', month: 'short' });

                        const dCopy = new Date(d);
                        dCopy.setHours(0, 0, 0, 0);

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
                    console.log("Searching for:", getLocalDateString(centerDate));
                }

                function openCalendar() {
                    document.getElementById('hidden-date-picker').showPicker();
                }

                // Pre-fill from URL parameters
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.has('from')) document.getElementById('from-location').value = urlParams.get('from');
                if (urlParams.has('to')) document.getElementById('to-location').value = urlParams.get('to');
                if (urlParams.has('passengers')) document.getElementById('passengers').value = urlParams.get('passengers');
                if (urlParams.has('date')) {
                    const urlDate = parseDateString(urlParams.get('date'));
                    if (!isNaN(urlDate.getTime())) {
                        centerDate = urlDate;
                    }
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

                async function liveFilter() {
                    const from = document.getElementById('from-location').value;
                    const to = document.getElementById('to-location').value;
                    const date = getLocalDateString(centerDate);
                    const passengers = document.getElementById('passengers').value;

                    const url = '<%=request.getContextPath()%>/search?ajax=true&from=' + encodeURIComponent(from) + '&to=' + encodeURIComponent(to) + '&date=' + date + '&passengers=' + passengers;

                    try {
                        const response = await fetch(url);
                        const data = await response.json();
                        renderTrips(data.trips, data.message);
                    } catch (error) {
                        console.error('Error fetching trips:', error);
                    }
                }

                function renderTrips(trips, fallbackMsg) {
                    const container = document.getElementById('trips-list-container');
                    const countEl = document.getElementById('buses-found-count');
                    const noMsg = document.getElementById('no-buses-msg');
                    
                    // Clear and update
                    container.innerHTML = '';
                    
                    if (fallbackMsg) {
                        countEl.innerHTML = '<span style="color: #e62222; font-weight: 600;"><i class="fa-solid fa-circle-exclamation"></i> ' + fallbackMsg + '</span>';
                    } else {
                        countEl.innerText = trips.length + " buses found";
                    }

                    noMsg.style.display = trips.length === 0 ? 'block' : 'none';

                    trips.forEach(trip => {
                        const depTime = trip.departureDate.length > 16 ? trip.departureDate.substring(11, 16) : '23:17';
                        const depDate = trip.departureDate.length >= 10 ? trip.departureDate.substring(0, 10) : trip.departureDate;
                        const arrTime = trip.arrivalDate.length > 16 ? trip.arrivalDate.substring(11, 16) : '10:14';
                        const arrDate = trip.arrivalDate.length >= 10 ? trip.arrivalDate.substring(0, 10) : trip.arrivalDate;

                        const card = 
                            '<div class="search-result-card">' +
                                '<div class="result-main">' +
                                    '<div class="brand-badge">' + trip.busType + '</div>' +
                                    '<div class="trip-details-new">' +
                                        '<div class="time-column">' +
                                            '<span class="label">Departure</span>' +
                                            '<span class="time">' + depTime + '</span>' +
                                            '<span class="date">' + depDate + '</span>' +
                                            '<span class="location"><i class="fa-solid fa-location-dot"></i> ' + trip.source + '</span>' +
                                        '</div>' +
                                        '<div class="duration-connector">' +
                                            '<div class="dotted-line"></div>' +
                                        '</div>' +
                                        '<div class="time-column">' +
                                            '<span class="label">Arrival</span>' +
                                            '<span class="time">' + arrTime + '</span>' +
                                            '<span class="date">' + arrDate + '</span>' +
                                            '<span class="location"><i class="fa-solid fa-location-dot"></i> ' + trip.destination + '</span>' +
                                        '</div>' +
                                    '</div>' +
                                '</div>' +
                                '<div class="price-section">' +
                                    '<div class="price">Rs. ' + trip.fare + '</div>' +
                                    '<button class="book-btn" onclick="window.location.href=\'booking?tripId=' + trip.tripId + '\'">' +
                                        'Book Now <i class="fa fa-chevron-right"></i>' +
                                    '</button>' +
                                    '<div class="seats-left"> ' + trip.availableSeats + ' Seats available</div>' +
                                '</div>' +
                            '</div>';
                        container.insertAdjacentHTML('beforeend', card);
                    });
                }

                // Attach listeners for live filtering
                document.getElementById('from-location').addEventListener('input', liveFilter);
                document.getElementById('to-location').addEventListener('input', liveFilter);
                document.getElementById('passengers').addEventListener('change', liveFilter);

                // Wrap existing functions to trigger live filtering
                const originalUpdateSelectedDate = updateSelectedDate;
                updateSelectedDate = function () {
                    originalUpdateSelectedDate();
                    liveFilter();
                };

                const originalHandleCalendarSelection = handleCalendarSelection;
                handleCalendarSelection = function (val) {
                    originalHandleCalendarSelection(val);
                    liveFilter();
                };

                // Set initial display
                document.getElementById('display-date').value = formatDate(centerDate);

                // Initialize
                renderDateBar();
                liveFilter();
            </script>
</body>

</html>