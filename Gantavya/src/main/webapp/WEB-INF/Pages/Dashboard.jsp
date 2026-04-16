<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gantavya - Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
    <div class="app-shell">

        <!-- Sidebar -->
        <aside class="sidebar">
        
            <div class="sidebar-brand">
			    <div class="brand-icon">
			        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Gantavya Logo" class="brand-logo-img">
			    </div>
			    <span class="brand-name">Gantavya</span>
			</div>

            <nav class="sidebar-nav">
                <a href="dashboard" class="nav-item active">
                    <i class="fa-solid fa-gauge-high"></i>
                    <span>Dashboard</span>
                </a>
                <a href="bookings" class="nav-item">
                    <i class="fa-solid fa-ticket"></i>
                    <span>Bookings</span>
                </a>
                <a href="buses" class="nav-item">
                    <i class="fa-solid fa-bus-simple"></i>
                    <span>Buses &amp; Routes</span>
                </a>
                <a href="passengers" class="nav-item">
                    <i class="fa-solid fa-users"></i>
                    <span>Passengers</span>
                </a>
                <a href="reports" class="nav-item">
                    <i class="fa-solid fa-chart-bar"></i>
                    <span>Reports</span>
                </a>
                <a href="payments" class="nav-item">
                    <i class="fa-solid fa-credit-card"></i>
                    <span>Payments</span>
                </a>
                <a href="settings" class="nav-item">
                    <i class="fa-solid fa-gear"></i>
                    <span>Settings</span>
                </a>
            </nav>

            <div class="sidebarImage">
		        <img src="${pageContext.request.contextPath}/images/footers.png"  alt="Gantavya Hub Scene" class="vector-stop-img">
		    </div>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header class="topbar">
                <h1 class="page-title">Dashboard</h1>
                <div class="topbar-actions">
                    <div class="dot dot-gray"></div>
                    <div class="dot dot-gray"></div>
                    <div class="dot dot-light"></div>
                </div>
            </header>

            <div class="content-area">
    <div class="dashboard-layout">
        
        <div class="main-column">
            
            <div class="hero-banner">
                <div class="hero-text">
                    <h2>Hello Admin!</h2>
                    <p>Today you have <strong>${totalNewBookings != null ? totalNewBookings : '150'}</strong> new ticket bookings. Review the latest fleet maintenance schedules.</p>
                    <a href="#" class="read-more">Read more</a>
                </div>
                <div class="hero-visuals">
			        <img src="${pageContext.request.contextPath}/images/backgroundbus.png" alt="" class="hero-wave">			        
			        <img src="${pageContext.request.contextPath}/images/busimage.png" alt="Bus" class="parallax-bus" id="heroBus">
			    </div>
            </div>

            <div class="stats-grid">
			    <div class="stat-card">
			        <div class="stat-icon"><i class="fa-solid fa-bus"></i></div>
			        <div class="stat-info">
			            <span class="stat-label">Total Buses</span>
			            <span class="stat-value">45</span>
			        </div>
			    </div>
			    <div class="stat-card">
			        <div class="stat-icon"><i class="fa-solid fa-route"></i></div>
			        <div class="stat-info">
			            <span class="stat-label">Total Trips</span>
			            <span class="stat-value">1,230</span>
			        </div>
			    </div>
			    <div class="stat-card">
			        <div class="stat-icon"><i class="fa-solid fa-map-location-dot"></i></div>
			        <div class="stat-info">
			            <span class="stat-label">Total Routes</span>
			            <span class="stat-value">18</span>
			        </div>
			    </div>
			    <div class="stat-card">
			        <div class="stat-icon"><i class="fa-solid fa-road"></i></div>
			        <div class="stat-info">
			            <span class="stat-label">Active Routes</span>
			            <span class="stat-value">18</span>
			        </div>
			    </div>
			
			    <div class="stat-card">
			        <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
			        <div class="stat-info">
			            <span class="stat-label">Total Passengers</span>
			            <span class="stat-value">78,450</span>
			        </div>
			    </div>
			    <div class="stat-card">
			        <div class="stat-icon"><i class="fa-solid fa-ticket"></i></div>
			        <div class="stat-info">
			            <span class="stat-label">Total Bookings</span>
			            <span class="stat-value">5,600</span>
			        </div>
			    </div>
			    <div class="stat-card">
			        <div class="stat-icon"><i class="fa-solid fa-dollar-sign"></i></div>
			        <div class="stat-info">
			            <span class="stat-label">Total Revenue</span>
			            <span class="stat-value">$345,000</span>
			        </div>
			    </div>
			    <div class="stat-card">
			        <div class="stat-icon"><i class="fa-solid fa-map-pin"></i></div>
			        <div class="stat-info">
			            <span class="stat-label">Total Stops</span>
			            <span class="stat-value">18</span>
			        </div>
			    </div>
			</div>

            <div class="card-container">
                <div class="card-header">
                    <h3>Route Condition</h3>
                    <button class="view-all-btn">View All</button>
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
                                <div>KTM-PKR (Route 2)</div>
                            </td>
                            <td>Intercity Express</td>
                            <td><span class="status-pill open">Open</span></td>
                        </tr>
                        <tr>
                            <td class="route-cell">
                                <div class="avatar-initial" style="background: #a0aec0;">B</div>
                                <div>BTP-KTM</div>
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
			        <span id="monthYear" class="calendar-month-year"></span>
			    </div>
			    <div class="calendar-container">
			        <div class="calendar-days-grid">
					    <div class="day-name">Sun</div>
					    <div class="day-name">Mon</div>
					    <div class="day-name">Tue</div>
					    <div class="day-name">Wed</div>
					    <div class="day-name">Thu</div>
					    <div class="day-name">Fri</div>
					    <div class="day-name">Sat</div>
					    
					    <div id="calendarDays" class="calendar-days-grid-content" style="display: contents;"></div>
					</div>
			    </div>
			</div>

            <div class="side-card">
                <h4>Upcoming Trips</h4>
                <div class="mini-list">
                    <div class="mini-item">
                        <div class="icon-box"><i class="fa-solid fa-clock"></i></div>
                        <div class="item-info">
                            <strong>BUSID 3368GA</strong>
                            <span>Departing in 30 mins</span>
                        </div>
                    </div>
                </div>
            </div>

        </div> </div> </div>
        </main>
    </div>

    <script>
	    function generateCalendar() {
	        const calendarDays = document.getElementById('calendarDays');
	        const monthYearText = document.getElementById('monthYear');
	        
	        if (!calendarDays || !monthYearText) return;
	
	        const now = new Date();
	        const today = now.getDate();
	        const month = now.getMonth();
	        const year = now.getFullYear();
	
	        const monthNames = ["January", "February", "March", "April", "May", "June",
	            "July", "August", "September", "October", "November", "December"];
	
	        monthYearText.innerText = monthNames[month] + " " + year;
	
	        // Get first day of month (0=Sun, 1=Mon, etc.)
	        const firstDay = new Date(year, month, 1).getDay();
	        const daysInMonth = new Date(year, month + 1, 0).getDate();
	
	        let html = "";
	
	        // 1. Fill empty slots for previous month (Starts from 0 for Sunday)
	        for (let i = 0; i < firstDay; i++) {
	            html += '<div class="empty-day"></div>';
	        }
	
	        // 2. Fill actual days and highlight today
	        for (let day = 1; day <= daysInMonth; day++) {
	            const isToday = (day === today) ? "today" : "";
	            html += '<div class="day-number ' + isToday + '">' + day + '</div>';
	        }
	
	        calendarDays.innerHTML = html;
	    }
	
	    document.addEventListener('DOMContentLoaded', () => {
	        // 1. Initialize the calendar
	        generateCalendar();

	        // 2. Trigger the Bus Animation only
	        const bus = document.getElementById('heroBus');

	        if (bus) {
	            setTimeout(() => {
	                // Only the bus drives in
	                bus.classList.add('slide-in');
	            }, 300);
	        }
	    });
	</script>
</body>
</html>
