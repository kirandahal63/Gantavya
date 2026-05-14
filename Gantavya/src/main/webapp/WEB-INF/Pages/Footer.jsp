<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Footer.css">

<footer class="main-footer">
    <div class="container footer-content">
    
        <div class="footer-column branding">
		    <div class="logo-wrapper">
		        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo" class="footer-icon">
		        <div class="footer-logo">GANTAVYA</div>
		    </div>
		    <p class="slogan">Your Journey, Your Story.</p>
		</div>

        <div class="footer-column">
            <h3>Quick Links</h3>
            <ul>
            	<li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/search">Booking</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About US</a></li>
            </ul>
        </div>

        <div class="footer-column">
            <h3>Support</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a></li>
				<li><a href="${pageContext.request.contextPath}/terms">Terms & Conditions</a></li>
            </ul>
        </div>

        <div class="footer-column">
            <h3>Contact Us</h3>
            <p>01-5970012, 9801000400</p>
            <p>info@gantavya.com.np</p>
            <button class="enquire-btn" onclick="window.location.href='${pageContext.request.contextPath}/contact'"> ENQUIRE NOW </button>
        </div>
    </div>

    <div class="footer-bottom">
        <div class="social-icons">
        	<i class="fab fa-linkedin"></i>
            <i class="fab fa-facebook-f"></i>
            <i class="fab fa-twitter"></i>
            <i class="fab fa-instagram"></i>
            <i class="fab fa-whatsapp"></i>
            
        </div>
        <p>&copy; 2026 Gantavya. All rights reserved.</p>
    </div>
</footer>