<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Login.css">
</head>
<body>


<nav class="navbar">
    <div class="navbar-brand">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Gantavya Logo" class="nav-logo">
    </div>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/">Plan Your Journey ▾</a></li>
        <li><a href="${pageContext.request.contextPath}/services">Service ▾</a></li>
        <li><a href="${pageContext.request.contextPath}/manage-booking">Manage My Booking</a></li>
        <li><a href="${pageContext.request.contextPath}/trip-tracker">Trip Tracker</a></li>
        <li><a href="${pageContext.request.contextPath}/help">Help</a></li>
    </ul>
</nav>

<main class="login-page">

    <section class="hero-panel">
        
        <img
            src="${pageContext.request.contextPath}/images/duplicate.png"
            alt="login hero image"
            class="hero-image"
        >

       
        
    </section>

    <!-- ── Right Panel: Login Form ──────────────────────────────── -->
    <section class="form-panel">
        <div class="form-container">

            <h2 class="form-title">LOGIN</h2>
            <p class="form-subtitle">Welcome to Gantavya.</p>

            <!-- Handling error message using getAttribute -->
	        <% String error = (String) request.getAttribute("error"); 
	           if (error != null) { %>
	            <p style="color: red;"><%= error %></p>
	        <% } %>
	
	        <% String success = request.getParameter("success"); 
	           if (success != null) { %>
	            <p style="color: green;">Registration successful. Please login.</p>
	        <% } %>
        
            <form action="${pageContext.request.contextPath}/login" method="post" >

                <!-- Email Field -->
                <div class="form-group">
		        <label for="email" class="form-label">Email</label>
		        <input
		            type="text"
		            id="email"
		            name="email"
		            class="form-input"
		            placeholder="Enter email address"
		            value="${emailValue}"
		            required>
		            <c:if test="${not empty emailError}">
			            <span style="color: red; font-size: 0.85rem; margin-top: 5px; display: block;">
			                ${emailError}
			            </span>
			        </c:if>
		        </div>
                <!-- Password field -->
				<div class="form-group">
			        <label for="password" class="form-label">Password</label>
			        <div class="password-wrapper">
			            <input
			                type="text"
			                id="password"
			                name="password"
			                class="form-input"
			                placeholder="••••••••"
			                required
			            >
			            <button type="button" class="toggle-password" onclick="togglePassword()">
			                <span id="eye-icon">👁</span>
			            </button>
			            <c:if test="${not empty passError}">
				            <span style="color: red; font-size: 0.85rem; margin-top: 5px; display: block;">
				                ${passError}
				            </span>
				        </c:if>
			        </div>
			    </div>
                

                <!-- Remember Me + Forgot Password row -->
                <div class="form-extras">
                    <label class="remember-label">
                        <input type="checkbox" name="rememberMe" id="rememberMe">
                        <span>Remember me</span>
                    </label>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-link">
                        Forgot Password?
                    </a>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-login">Login</button>

            </form>

            <!-- ── Divider ────────────────────────────────────── -->
            <div class="divider">
                <span class="divider-text">OR EMAIL</span>
            </div>

            <!-- ── Google Sign-In Button ─────────────────────── -->
            <!--
                This is a simple anchor that triggers our GoogleAuthServlet.
                GoogleAuthServlet redirects to Google's consent screen.
                After Google login, Google calls back /auth/google/callback.
            -->
            <a href="${pageContext.request.contextPath}/auth/google" class="btn-google">
                <svg class="google-icon" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                    <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                    <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" fill="#FBBC05"/>
                    <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                </svg>
                Sign in with Google
            </a>

            <!-- ── Register Link ──────────────────────────────── -->
            <p class="register-prompt">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/register" class="register-link">Sign Up</a>
            </p>

        </div><!-- /form-container -->
    </section><!-- /form-panel -->

</main><!-- /login-page -->

<!-- ═══════════════════════════════════════════════════════════════
     MINIMAL JS – UI enhancement only, NO business logic
════════════════════════════════════════════════════════════════ -->
<script>
    /** Toggle password field visibility – pure UI, no server interaction */
    function togglePassword() {
        const input   = document.getElementById('password');
        const icon    = document.getElementById('eye-icon');
        const isHidden = input.type === 'password';
        input.type = isHidden ? 'text' : 'password';
        icon.textContent = isHidden ? '🙈' : '👁';
    }
</script>

</body>
</html>
