<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile - Gantavya</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Profile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
    <jsp:include page="Navbar.jsp" />

    <div class="profile-container">
        <aside class="profile-sidebar">
            <h2 class="sidebar-title">My Profile</h2>
            <nav class="sidebar-nav">
                <button class="nav-item active" onclick="showSection('basic-info', this)">
                    <i class="fas fa-user"></i> Profile Settings
                </button>
                <button class="nav-item" onclick="showSection('password-section', this)">
                    <i class="fas fa-lock"></i> Password
                </button>
            </nav>
        </aside>

        <main class="profile-content">
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <!-- Basic Information Section -->
            <section id="basic-info" class="content-section active">
                <div class="section-header">
				    <div class="header-visual">
				        <img src="${pageContext.request.contextPath}/images/profile.png" 
				             alt="Profile Picture" 
				             class="profile-avatar">
				    </div>
				    <div class="header-text">
				        <h2 class="section-title">Personal Information</h2>
				        <p class="section-subtitle">Manage your profile details and contact information.</p>
				    </div>
				</div>

                <form action="${pageContext.request.contextPath}/profile" method="post" class="profile-form">
                    <input type="hidden" name="action" value="updateDetails">
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Full Name <span class="required">*</span></label>
                            <input type="text" name="fullName" value="${passenger.fullName}" required>
                            <span class="error-text">${nameError}</span>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" value="${passenger.email}" required>
                        </div>
                        <div class="form-group">
                            <label>Mobile Number <span class="required">*</span></label>
                            <div class="phone-input">
                                <span class="country-code">🇳🇵 +977</span>
                                <input type="text" name="phone" value="${passenger.contactNumber}" required>
                            </div>
                            <span class="error-text">${phoneError}</span>
                        </div>
                        <div class="form-group">
                            <label>Date of Birth <span class="required">*</span></label>
                            <input type="date" name="dob" value="${passenger.dob}" required>
                            <span class="error-text">${dobError}</span>
                        </div>
                        <div class="form-group">
                            <label>Gender</label>
                            <div class="gender-options">
                                <label class="radio-label">
                                    <input type="radio" name="gender" value="Male" ${passenger.gender == 'Male' ? 'checked' : ''}>
                                    <span>Male</span>
                                </label>
                                <label class="radio-label">
                                    <input type="radio" name="gender" value="Female" ${passenger.gender == 'Female' ? 'checked' : ''}>
                                    <span>Female</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn-save">Save Changes</button>
                </form>
            </section>

            <!-- Password Section -->
            <section id="password-section" class="content-section">
                <h3 class="section-title">Change Password</h3>
                <p class="section-subtitle">Ensure your account is using a long, random password to stay secure.</p>
                
                <form action="${pageContext.request.contextPath}/profile" method="post" class="password-form">
                    <input type="hidden" name="action" value="changePassword">
                    
                    <div class="form-group">
                        <label>Current Password</label>
                        <div class="password-wrapper">
                            <input type="password" name="currentPassword" placeholder="Enter Current Password" required>
                            <button type="button" class="toggle-pass">SHOW</button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>New Password</label>
                        <div class="password-wrapper">
                            <input type="password" name="newPassword" placeholder="Enter New Password" required>
                            <button type="button" class="toggle-pass">SHOW</button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Confirm Password</label>
                        <div class="password-wrapper">
                            <input type="password" name="confirmPassword" placeholder="Re-enter New Password" required>
                            <button type="button" class="toggle-pass">SHOW</button>
                        </div>
                    </div>

                    <div class="info-box">
                        <p><strong>Please note:</strong> After you change your password, you will be automatically logged out of all devices for security reasons.</p>
                    </div>

                    <button type="submit" class="btn-save">Save Changes</button>
                </form>
            </section>
        </main>
    </div>

    <script>
        function showSection(sectionId, btn) {
            // Hide all sections
            document.querySelectorAll('.content-section').forEach(s => s.classList.remove('active'));
            // Remove active class from buttons
            document.querySelectorAll('.nav-item').forEach(b => b.classList.remove('active'));
            
            // Show target section
            document.getElementById(sectionId).classList.add('active');
            // Add active class to clicked button
            btn.classList.add('active');
        }

        // Keep section active after form submission if needed
        window.onload = function() {
            if ("${not empty passError}" === "true" || "${action}" === "changePassword") {
                showSection('password-section', document.querySelector('button[onclick*="password-section"]'));
            }
        };

        // Password Visibility Toggle
        document.querySelectorAll('.toggle-pass').forEach(btn => {
            btn.addEventListener('click', function() {
                const input = this.parentElement.querySelector('input');
                if (input.type === 'password') {
                    input.type = 'text';
                    this.textContent = 'HIDE';
                } else {
                    input.type = 'password';
                    this.textContent = 'SHOW';
                }
            });
        });
    </script>
</body>
</html>
