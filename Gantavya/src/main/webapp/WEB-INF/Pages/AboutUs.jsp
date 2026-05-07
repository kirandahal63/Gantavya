<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us - Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/About.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
</head>
<body>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container hero-flex">
            <div class="hero-text">
                <h1>ABOUT US</h1>
                <hr class="title-line">
                <p>At Gantavya, we believe that every journey should be as remarkable as the destination itself. As a modern intercity bus travel company based in Nepal, we are dedicated to bridging the gap between comfort, reliability, and our rich cultural heritage.</p>
                <button class="btn-learn">Learn More</button>
            </div>
            <div class="hero-image">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Gantavya Bus">
            </div>
        </div>
    </section>

    <!-- Stats Bar -->
    <section class="stats-bar">
        <div class="container stats-flex">
            <div class="stat-item"><h2>10+</h2><p>Years Experience</p></div>
            <div class="stat-item"><h2>99%</h2><p>Accuracy Rate</p></div>
            <div class="stat-item"><h2>500+</h2><p>Positive Reviews</p></div>
            <div class="stat-item"><h2>600+</h2><p>Trusted Partners</p></div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="team-section">
        <div class="container">
            <div class="team-header">
                <h2>Let's Meet Our Team</h2>
                <p>Get the proper travel consultation from our experts. We are here to consult you as per your needs.</p>
            </div>
            <div class="team-grid">
                <div class="team-card">
                    <div class="img-circle"><img src="images/wade.jpg" alt="Wade"></div>
                    <h3>Wade Warren</h3>
                    <p>Executive</p>
                </div>
                <div class="team-card">
                    <div class="img-circle"><img src="images/jerome.jpg" alt="Jerome"></div>
                    <h3>Jerome Bell</h3>
                    <p>Manager</p>
                </div>
                <div class="team-card">
                    <div class="img-circle"><img src="images/arlene.jpg" alt="Arlene"></div>
                    <h3>Arlene McCoy</h3>
                    <p>Operations</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Mission Section -->
    <section class="mission-section">
        <div class="container">
            <h2>A Mission Rooted in Community</h2>
            <p class="mission-subtext">We started with a simple goal: to make transit feel less like a chore and more like a service that respects your time and your journey.</p>
            
            <div class="mission-grid">
                <div class="mission-card">
                    <div class="icon">🌐</div>
                    <h3>Connected Routes</h3>
                    <p>Smarter mapping that links communities together without the friction of traditional travel.</p>
                </div>
                <div class="mission-card">
                    <div class="icon">🛡️</div>
                    <h3>Safety Standards</h3>
                    <p>Exceeding industry benchmarks with a fleet maintained to meticulous perfection.</p>
                </div>
                <div class="mission-card">
                    <div class="icon">👥</div>
                    <h3>People First</h3>
                    <p>Training our team to provide a travel experience that is as warm as it is efficient.</p>
                </div>
                <div class="mission-card">
                    <div class="icon">🍃</div>
                    <h3>Sustainability</h3>
                    <p>Investing in low-emission technology to keep our world moving without harming it.</p>
                </div>
            </div>
        </div>
    </section>

</body>
</html>