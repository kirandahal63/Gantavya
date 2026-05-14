<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Terms & Conditions - Gantavya</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Rules.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/About.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
	<jsp:include page="/WEB-INF/Pages/Navbar.jsp" />

	<div class="main-wrapper">
		<section class="terms-section">
	    <div class="terms-content">
	        <h1>Terms and Conditions</h1>
	
	        <p>
	            Welcome to Gantavya. By accessing, browsing, or using our online
	            bus booking platform, you acknowledge that you have read,
	            understood, and agreed to comply with the following Terms and
	            Conditions. These terms govern the use of all services provided
	            through the Gantavya platform.
	        </p>
	
	        <h2>1. Acceptance of Terms</h2>
	        <p>
	            By using Gantavya, users agree to abide by all applicable laws,
	            regulations, and platform policies. If you do not agree with any
	            part of these terms, you must discontinue the use of our services
	            immediately.
	        </p>
	
	        <h2>2. User Registration and Account Responsibility</h2>
	        <p>
	            Users may be required to create an account to access certain
	            services, including ticket booking and reservation management.
	            Users are solely responsible for maintaining the confidentiality
	            of their account credentials and for all activities conducted
	            under their account.
	        </p>
	
	        <h2>3. Booking Confirmation and Payment</h2>
	        <p>
	            All ticket bookings are subject to seat availability and payment
	            verification. Payments must be completed through the authorized
	            payment methods integrated within the platform, including eSewa,
	            Khalti, and bank transfer services. Gantavya reserves the right
	            to cancel or reject any booking if payment authorization fails or
	            suspicious activity is detected.
	        </p>
	
	        <h2>4. Cancellation and Refund Policy</h2>
	        <p>
	            All confirmed bookings made through Gantavya are considered final.
	            Once a ticket has been successfully booked and payment has been
	            completed, the amount paid shall be non-refundable under any
	            circumstances, including but not limited to cancellation by the
	            passenger, missed departure, schedule misunderstanding, or failure
	            to appear at the boarding location.
	        </p>
	
	        <p>
	            Users are strongly advised to carefully review travel dates,
	            departure times, boarding locations, and passenger details before
	            confirming any booking transaction.
	        </p>
	
	        <h2>5. Passenger Responsibilities</h2>
	        <p>
	            Passengers are required to arrive at the designated boarding point
	            at least 30 minutes prior to departure. Gantavya shall not be
	            responsible for missed trips due to late arrival, incorrect
	            information provided by the user, or failure to carry valid
	            identification documents when required.
	        </p>
	
	        <h2>6. Service Availability and Delays</h2>
	        <p>
	            Gantavya acts solely as a digital booking facilitator between
	            passengers and bus operators. While we strive to provide accurate,
	            updated, and reliable information, we do not guarantee uninterrupted
	            service availability and shall not be held liable for delays,
	            cancellations, route changes, traffic conditions, weather impacts,
	            technical failures, or operational issues caused by third-party
	            transport operators.
	        </p>
	
	        <h2>7. Prohibited Activities</h2>
	        <p>
	            Users must not misuse the platform by attempting unauthorized
	            access, distributing malicious software, engaging in fraudulent
	            transactions, or violating any applicable cybersecurity or data
	            protection laws. Gantavya reserves the right to suspend or
	            permanently terminate accounts involved in suspicious or unlawful
	            activities.
	        </p>
	
	        <h2>8. Privacy and Data Protection</h2>
	        <p>
	            Gantavya respects user privacy and is committed to protecting
	            personal information collected during the booking and registration
	            process. User data shall only be used for operational,
	            communication, security, and service improvement purposes in
	            accordance with applicable privacy regulations.
	        </p>
	
	        <h2>9. Intellectual Property Rights</h2>
	        <p>
	            All content, branding, logos, graphics, design elements, and
	            system features available on the Gantavya platform are the
	            intellectual property of Gantavya and may not be copied,
	            reproduced, distributed, or used without prior written permission.
	        </p>
	
	        <h2>10. Modification of Terms</h2>
	        <p>
	            Gantavya reserves the right to revise, update, or modify these
	            Terms and Conditions at any time without prior notice. Continued
	            use of the platform after such modifications constitutes acceptance
	            of the updated terms.
	        </p>
	
	        <h2>11. Contact Information</h2>
	        <p>
	            For inquiries, support, or concerns regarding these Terms and
	            Conditions, users may contact the Gantavya support team through
	            the official communication channels provided on the platform.
	        </p>
	    </div>
	</section>

		<div class="contact-footer-image">
			<img src="${pageContext.request.contextPath}/images/contactus.png"
				alt="Travel Illustration">
		</div>
	</div>

	<jsp:include page="/WEB-INF/Pages/Footer.jsp" />
</body>
</html>
