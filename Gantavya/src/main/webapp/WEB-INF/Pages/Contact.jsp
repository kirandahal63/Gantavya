<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us - Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/About.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Contact.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
</head>
<body>    
    
    <div class="main-wrapper">
    <section class="contact-container">
        <div class="contact-header">
            <h1>Contact Us</h1>
        </div>

        <div class="contact-content">
            <form action="ContactServlet" method="POST" class="contact-form">
                <div class="input-row">
                    <input type="text" name="firstName" placeholder="First Name *" required>
                    <input type="text" name="lastName" placeholder="Last Name *" required>
                </div>
                <div class="input-row">
                    <input type="email" name="email" placeholder="Email *" required>
                    <input type="text" name="phone" placeholder="Phone Number *" required>
                </div>
                <input type="text" name="subject" placeholder="Subject *" required>
                <textarea name="message" placeholder="Message *" rows="6" required></textarea>
                
                <button type="submit" class="send-btn">Send Message</button>
            </form>

            <div class="info-box">
                <div class="info-section">
                    <h3>Address</h3>
                    <p>Hattiban, Lalitpur - 15,<br>Bagmati Province, Nepal</p>
                </div>
                <div class="info-section">
                    <h3>Contact</h3>
                    <p>Phone: 01-5970012, 9801000400</p>
                    <p>Email: info@gantavya.com.np</p>
                </div>
                <div class="info-section">
                    <h3>Support Hours</h3>
                    <p>Monday - Friday: 10:00 AM - 50:00 PM</p>
                </div>
                
            </div>
        </div>
        <div class="contact-footer-image">
		<img src="${pageContext.request.contextPath}/images/contactus.png" alt="Travel Illustration">
	</div> 
    </section>
    
</div>
    <jsp:include page="Footer.jsp" />

</body>
</html>