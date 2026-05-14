<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Privacy Policy - Gantavya</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Rules.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/About.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
	<jsp:include page="/WEB-INF/Pages/Navbar.jsp" />

	<div class="main-wrapper">
		<section class="terms-section">
	    <div class="terms-content">
				<h1>Privacy Policy</h1>

				<p>At Gantavya, we are committed to protecting the privacy,
					confidentiality, and security of our users’ personal information.
					This Privacy Policy explains how information is collected, used,
					stored, and protected when users access and utilize the Gantavya
					online bus booking platform.</p>

				<h2>1. Information We Collect</h2>
				<p>Gantavya may collect personal and non-personal information
					from users during account registration, ticket booking, payment
					processing, and platform interaction. The information collected may
					include:</p>

				<ul>
					<li>Full name and contact information</li>
					<li>Email address and phone number</li>
					<li>Travel and booking details</li>
					<li>Payment transaction information</li>
					<li>Device, browser, and usage data</li>
				</ul>

				<h2>2. Purpose of Information Collection</h2>
				<p>The information collected by Gantavya is used for
					operational, administrative, and security purposes, including:</p>

				<ul>
					<li>Processing ticket bookings and payments</li>
					<li>Providing booking confirmations and notifications</li>
					<li>Improving platform functionality and user experience</li>
					<li>Preventing fraudulent or unauthorized activities</li>
					<li>Providing customer support and assistance</li>
				</ul>

				<h2>3. Data Protection and Security</h2>
				<p>Gantavya implements appropriate technical and organizational
					security measures to protect user information against unauthorized
					access, misuse, disclosure, alteration, or destruction. However,
					while we strive to maintain secure systems, no method of electronic
					storage or internet transmission is completely secure.</p>

				<h2>4. Sharing of Information</h2>
				<p>Gantavya does not sell, rent, or trade users’ personal
					information to third parties. Information may only be shared with
					authorized transport operators, payment service providers, or legal
					authorities when necessary for service delivery, payment
					verification, legal compliance, or security purposes.</p>

				<h2>5. Cookies and Tracking Technologies</h2>
				<p>The Gantavya platform may use cookies and similar tracking
					technologies to enhance user experience, maintain login sessions,
					analyze traffic, and improve website performance. Users may modify
					browser settings to disable cookies; however, certain platform
					features may not function properly as a result.</p>

				<h2>6. User Responsibilities</h2>
				<p>Users are responsible for providing accurate and updated
					information while using the platform. Gantavya shall not be
					responsible for any issues arising from incorrect, incomplete, or
					outdated user data.</p>

				<h2>7. Third-Party Services</h2>
				<p>The platform may contain links or integrations with
					third-party payment gateways and service providers such as eSewa,
					Khalti, and banking systems. Gantavya is not responsible for the
					privacy practices, policies, or security measures of external
					services.</p>

				<h2>8. Data Retention</h2>
				<p>User information may be retained for operational, legal,
					security, and administrative purposes for a reasonable period as
					required by applicable laws and business requirements.</p>

				<h2>9. Changes to Privacy Policy</h2>
				<p>Gantavya reserves the right to update or modify this Privacy
					Policy at any time without prior notice. Users are encouraged to
					review this page periodically to stay informed about how their
					information is protected and managed.</p>

				<h2>10. Contact Information</h2>
				<p>If you have any questions, concerns, or requests regarding
					this Privacy Policy or the handling of your personal information,
					please contact Gantavya through the official support channels
					available on the platform.</p>
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
