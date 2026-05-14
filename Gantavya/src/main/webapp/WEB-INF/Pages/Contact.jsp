<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Contact.css">    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/About.css">    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>    
	<jsp:include page="Navbar.jsp" />
    <div class="main-wrapper">
    <section class="contact-container">
        <div class="contact-header"><h1>Contact Us</h1></div>

        <div class="contact-content">
            <div class="form-container">
                <%-- Error Message --%>
                <c:if test="${not empty error}">
                    <div class="alert error-alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <%-- Success Message --%>
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert success-alert">
                        <i class="fas fa-check-circle"></i> ${sessionScope.success}
                    </div>
                    <% session.removeAttribute("success"); %>
                </c:if>

                <form action="${pageContext.request.contextPath}/contact" method="POST" class="contact-form">
                    <div class="input-row">
                        <input type="text" name="firstName" placeholder="First Name *" value="${param.firstName}">
                        <input type="text" name="lastName" placeholder="Last Name *" value="${param.lastName}">
                    </div>
                    <div class="input-row">
                        <input type="email" name="email" placeholder="Email *" value="${param.email}">
                        <input type="text" name="phone" placeholder="Phone Number *" value="${param.phone}">
                    </div>
                    <input type="text" name="subject" placeholder="Subject *" value="${param.subject}">
                    <textarea name="message" placeholder="Message *" rows="6">${param.message}</textarea>
                    
                    <button type="submit" class="send-btn">Send Message </i></button>
                </form>
            </div>

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
                    <p>Monday - Friday: 10:00 AM - 05:00 PM</p>
                </div>
            </div>
        </div>
        
    </section>
    <div class="contact-footer-image">
			<img src="${pageContext.request.contextPath}/images/contactus.png" alt="Travel Illustration">
		</div>
		
		
    </div>
    <jsp:include page="Footer.jsp" />
</body>
</html>