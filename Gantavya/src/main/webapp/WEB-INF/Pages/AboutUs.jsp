<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us - Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/About.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!--  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">-->
</head>
<body>
	<jsp:include page="Navbar.jsp" />
    <!-- Hero Section -->
    <section class="hero">
	    <div class="container">
	        <div class="hero-text">
	            <h1>ABOUT US</h1>
	            <hr class="title-line">
	            <p>At Gantavya, we believe that every journey should be as remarkable as the destination itself. As a modern intercity bus travel company based in Nepal, we are dedicated to bridging the gap between comfort, reliability, and our rich cultural heritage.</p>

	        </div>
	    </div>
	</section>
   <!-- Stats Bar -->
    <section class="stats-bar">
        <div class="container stats-flex">
            <div class="stat-item"><h2>10+</h2><p>Years Experience</p></div>
            <div class="stat-item"><h2>4.7+</h2><p>Ratings</p></div>
            <div class="stat-item"><h2>500+</h2><p>Positive Reviews</p></div>
            <div class="stat-item"><h2>600+</h2><p>Trusted Partners</p></div>
        </div>
    </section> 
    <!-- Team Section -->
    <section class="team-section">
        <div class="container">
            <div class="team-header">
                <h2>Let's Meet Our Team</h2>
                <p>Behind every successful journey is a dedicated team of<br> logistics experts and hospitality professionals committed to your comfort.</p>
            </div>
            <div class="team-grid">
                <div class="team-card">
                    <div class="img-circle"><img src="${pageContext.request.contextPath}/images/foundert.png" alt="Founder"></div>
                    <h3>Ray Dahal</h3>
                    <p>Founder</p>
                </div>
                <div class="team-card">
                    <div class="img-circle"><img src="${pageContext.request.contextPath}/images/coo.png" alt="COO"></div>
                    <h3>Anil Shrestha</h3>
                    <p>Chief Operating Officer</p>
                </div>
                <div class="team-card">
                    <div class="img-circle"><img src="${pageContext.request.contextPath}/images/cordinator.png" alt="Cordinator"></div>
                    <h3>Suman Thapa</h3>
                    <p>Regional Coordinator</p>
                </div>
                
                <div class="team-card">
                    <div class="img-circle"><img src="${pageContext.request.contextPath}/images/ce.png" alt="CE"></div>
                    <h3>Prerana Joshi</h3>
                    <p>Experience Manager</p>
                </div>
                <div class="team-card">
                    <div class="img-circle"><img src="${pageContext.request.contextPath}/images/cto.png" alt="cto"></div>
                    <h3>Aditya Joshi</h3>
                    <p>Chief Technology Officer</p>
                </div>
            </div>
        </div>
    </section>
    
  	 

    <!-- Mission Section -->
    <section class="mission-section">
        <div class="container">
            <h2>A Mission Rooted in Community</h2>
            <p class="mission-subtext">We started with a simple goal, to make transit feel less like a chore and more <br>like a service that respects your time and your journey.</p>
            
            <div class="mission-grid">
                <div class="mission-card">
                    <h3>Connected Routes</h3>
                    <p>Strategically mapping the veins of Nepal from the vibrant streets of Kathmandu to the serene lakes of Pokhara and beyond.</p>
                </div>
                <div class="mission-card">
                    <h3>Safety Standards</h3>
                    <p>Exceeding industry benchmarks with a rigorously maintained bus and staffs trained for the demands of intercity travel.</p>
                </div>
                <div class="mission-card">
                    <h3>People First</h3>
                    <p>Every interaction is an opportunity to provide a travel experience that feels as warm as it is efficient.</p>
                </div>
                <div class="mission-card">
                    <h3>Sustainability</h3>
                    <p>Investing in low-emission technology to ensure that as we explore the beauty of Nepal, we also protect it for the next generation.</p>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="Footer.jsp" />

</body>
</html>