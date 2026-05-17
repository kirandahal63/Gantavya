<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>Gantavya - Dashboard</title>
			<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Sidenav.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Dashboard.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

		</head>

		<body>
			<div class="app-shell">
				<jsp:include page="/WEB-INF/Pages/SideNav.jsp" />

				<!-- Main Content -->
				<main class="main-content">
					<header class="topbar">
						<h1 class="page-title">Dashboard</h1>
					</header>

					<div class="content-area">
						<div class="dashboard-layout">

							<div class="main-column">

								<div class="hero-banner">
									<div class="hero-text">
										<h2>Hello Admin!</h2>
										
										<p>Manage buses, routes, schedules, and passenger activities seamlessly from one centralized system.</p>
										<a href="#" class="read-more">Explore</a>
									</div>
									<div class="hero-visuals">
										<img src="${pageContext.request.contextPath}/images/backgroundbus.png" alt=""
											class="hero-wave">
										<img src="${pageContext.request.contextPath}/images/busimage.png" alt="Bus"
											class="parallax-bus" id="heroBus">
									</div>
								</div>

								<div class="stats-grid">
									<div class="stat-card">
										<div class="stat-icon"><i class="fa-solid fa-bus"></i></div>
										<div class="stat-info">
											<span class="stat-label">Total Buses</span>
											<span class="stat-value">${totalBuses}</span>
										</div>
									</div>
									<div class="stat-card">
										<div class="stat-icon"><i class="fa-solid fa-route"></i></div>
										<div class="stat-info">
											<span class="stat-label">Total Trips</span>
											<span class="stat-value">${totalTrips}</span>
										</div>
									</div>
									<div class="stat-card">
										<div class="stat-icon"><i class="fa-solid fa-map-location-dot"></i></div>
										<div class="stat-info">
											<span class="stat-label">Total Routes</span>
											<span class="stat-value">${totalRoutes}</span>
										</div>
									</div>
									<div class="stat-card">
										<div class="stat-icon"><i class="fa-solid fa-road"></i></div>
										<div class="stat-info">
											<span class="stat-label">Active Routes</span>
											<span class="stat-value">${activeRoutes}</span>
										</div>
									</div>

									<div class="stat-card">
										<div class="stat-icon"><i class="fa-solid fa-users"></i></div>
										<div class="stat-info">
											<span class="stat-label">Total Passengers</span>
											<span class="stat-value">${totalPassengers}</span>
										</div>
									</div>
									<div class="stat-card">
										<div class="stat-icon"><i class="fa-solid fa-ticket"></i></div>
										<div class="stat-info">
											<span class="stat-label">Total Bookings</span>
											<span class="stat-value">${totalBookings}</span>
										</div>
									</div>
									<div class="stat-card">
										<div class="stat-icon"><i class="fa-solid fa-money-bill-wave"></i></div>
										<div class="stat-info">
											<span class="stat-label">Total Revenue</span>
											<span class="stat-value">Rs. ${totalRevenueFormatted}</span>
										</div>
									</div>
									<div class="stat-card">
										<div class="stat-icon"><i class="fa-solid fa-user-tie"></i></div>
										<div class="stat-info">
											<span class="stat-label">Total Staffs</span>
											<span class="stat-value">${totalStaff}</span>
										</div>
									</div>
								</div>

								<div class="card-container">
									<div class="card-header">
										<h3>Route Condition</h3>
									</div>
									<table class="progress-table">
										<thead>
											<tr>
												<th>Route Name</th>
												<th>Designation</th>
												<th>Status</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="route-cell">
													<div class="avatar-initial" style="background: #4299e1;">K</div>
													<div>KTM-PKR </div>
												</td>
												<td>Intercity Express</td>
												<td><span class="status-pill open">Open</span></td>
											</tr>
											<tr>
												<td class="route-cell">
													<div class="avatar-initial" style="background: #a0aec0;">B</div>
													<div>BTP-NGK</div>
												</td>
												<td>Local Route</td>
												<td><span class="status-pill closed">Closed</span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>

							<div class="right-sidebar-box">

								<div class="side-card">
									<div class="calendar-header">
										<h4>Calendar</h4>

										<div class="calendar-nav">
											<button id="prevMonth" class="calendar-btn">
												<i class="fa-solid fa-chevron-left"></i>
											</button>

											<span id="monthYear" class="calendar-month-year"></span>

											<button id="nextMonth" class="calendar-btn">
												<i class="fa-solid fa-chevron-right"></i>
											</button>
										</div>
									</div>
									<div class="calendar-days-grid">
										<div class="day-name">Sun</div>
										<div class="day-name">Mon</div>
										<div class="day-name">Tue</div>
										<div class="day-name">Wed</div>
										<div class="day-name">Thu</div>
										<div class="day-name">Fri</div>
										<div class="day-name">Sat</div>
									</div>

									<div id="calendarDays" class="calendar-days-grid"></div>
								</div>

								<div class="side-card">
									<h4>Upcoming Trips</h4>
									<div class="mini-list">
										<c:forEach var="trip" items="${upcomingTrips}">
											<div class="mini-item">
												<div class="icon-box"><i class="fa-solid fa-bus"></i></div>
												<div class="item-info">
													<strong>${trip.tripId} | ${trip.source} - ${trip.destination}</strong>
													<span>Departs: ${trip.departureDate}</span>
												</div>
											</div>
										</c:forEach>
										<c:if test="${empty upcomingTrips}">
											<p class="empty-text">No upcoming trips found.</p>
										</c:if>
									</div>
								</div>

							</div>
						</div>
					</div>
				</main>
			</div>

			<script>
				let currentDate = new Date();
				const realToday = new Date();
				realToday.setHours(0,0,0,0);

				function generateCalendar(date) {
					const calendarDays = document.getElementById('calendarDays');
					const monthYearText = document.getElementById('monthYear');
					const prevBtn = document.getElementById('prevMonth');

					const month = date.getMonth();
					const year = date.getFullYear();

					const monthNames = [
						"January", "February", "March", "April",
						"May", "June", "July", "August",
						"September", "October", "November", "December"
					];

					monthYearText.innerText = monthNames[month] + " " + year;

					// Navigation buttons visibility 
					if (year < realToday.getFullYear() || (year === realToday.getFullYear() && month <= realToday.getMonth())) {
						prevBtn.style.visibility = "hidden";
					} else {
						prevBtn.style.visibility = "visible";
					}

					const firstDay = new Date(year, month, 1).getDay();
					const daysInMonth = new Date(year, month + 1, 0).getDate();

					const urlParams = new URLSearchParams(window.location.search);
					const selectedDateParam = urlParams.get('selectedDate');

					let html = "";
					let cellCount = 0;

					// 1. Empty slots
					for (let i = 0; i < firstDay; i++) {
						html += '<div class="empty-day"></div>';
						cellCount++;
					}

					for (let day = 1; day <= daysInMonth; day++) {
						const dateObj = new Date(year, month, day);
						const dateStr = year + "-" + String(month + 1).padStart(2, '0') + "-" + String(day).padStart(2, '0');
						
						const isToday = (dateObj.getTime() === realToday.getTime()) ? "today" : "";
						const isSelected = (selectedDateParam === dateStr) ? "selected" : "";
						const isPast = dateObj < realToday;
						
						const stateClass = isPast ? "disabled-day" : "selectable-day";
						const clickAction = isPast ? "" : "onclick=\"selectDate('" + dateStr + "')\"";

						html += '<div class="day-number ' + isToday + ' ' + isSelected + ' ' + stateClass + '" ' + clickAction + '>' + day + '</div>';
						cellCount++;
					}

					// 3. Force 42 cells (6 rows) for consistent height
					while (cellCount < 42) {
						html += '<div class="empty-day"></div>';
						cellCount++;
					}

					calendarDays.innerHTML = html;
				}

				function selectDate(dateStr) {
					window.location.href = '${pageContext.request.contextPath}/admin?selectedDate=' + dateStr;
				}

				document.addEventListener('DOMContentLoaded', () => {

					generateCalendar(currentDate);

					// Previous Month
					document.getElementById('prevMonth')
						.addEventListener('click', () => {

							currentDate.setMonth(currentDate.getMonth() - 1);

							generateCalendar(currentDate);
						});

					// Next Month
					document.getElementById('nextMonth')
						.addEventListener('click', () => {

							currentDate.setMonth(currentDate.getMonth() + 1);

							generateCalendar(currentDate);
						});

					// Bus animation
					const bus = document.getElementById('heroBus');

					if (bus) {
						setTimeout(() => {
							bus.classList.add('slide-in');
						}, 300);
					}
				});
			</script>
		</body>

		</html>