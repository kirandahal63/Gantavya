<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Login.css">
    <script src="https://accounts.google.com/gsi/client" async defer></script>
</head>
<body>

<%
    String cookieEmail = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals("savedEmail")) {
                cookieEmail = c.getValue();
                break;
            }
        }
    }
%>
<jsp:include page="Navbar.jsp" />

<main class="login-page" style="background-image: url('${pageContext.request.contextPath}/images/background.png');">
 
    <section class="hero-panel"></section>

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
                <!-- Hidden field to preserve redirect target -->
                <% 
                   String tUrl = request.getParameter("targetUrl");
                   if (tUrl == null || tUrl.isEmpty()) tUrl = (String) request.getAttribute("targetUrl");
                   if (tUrl == null) tUrl = "";
                %>
                <%-- DEBUG: targetUrl being passed to form: <%= tUrl %> --%>
                <input type="hidden" name="targetUrl" value="<%= tUrl %>">

                <!-- Email Field -->
                	<%
				    // logic to determine what to show in the email field
				    String displayEmail = (String) request.getAttribute("emailValue");
				
				    if (displayEmail == null || displayEmail.trim().isEmpty()) {
				        Cookie[] allCookies = request.getCookies();
				        if (allCookies != null) {
				            for (Cookie c : allCookies) {
				                if ("savedEmail".equals(c.getName())) {
				                    displayEmail = c.getValue();
				                    break;
				                }
				            }
				        }
				    }
				    if (displayEmail == null) displayEmail = "";
				%>
                <div class="form-group">
		        <label for="email" class="form-label">Email</label>
		        <input
				    type="text"
				    id="email"
				    name="email"
				    class="form-input"
				    placeholder="Enter email address"
				    value="<%= displayEmail %>" 
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
                    <a href="javascript:void(0)" onclick="handleForgotPassword()" class="forgot-link">
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
            <div id="g_id_onload"
                 data-client_id="115373835417-ib6jmp0av49drs6hk42nojd8fdosg8gk.apps.googleusercontent.com"
                 data-context="signin"
                 data-ux_mode="popup"
                 data-callback="handleGoogleLogin"
                 data-auto_prompt="false">
            </div>
            <div class="g_id_signin"
                 data-type="standard"
                 data-shape="rectangular"
                 data-theme="outline"
                 data-text="signin_with"
                 data-size="large"
                 data-logo_alignment="left">
            </div>

            <!-- ── Register Link ──────────────────────────────── -->
            <p class="register-prompt">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/Register" class="register-link">Sign Up</a>
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

    function handleForgotPassword() {
        const email = document.getElementById('email').value.trim();
        if (!email) {
            alert('Please enter your email address in the Email field first.');
            return;
        }

        // Send AJAX request to /password-reset
        fetch('${pageContext.request.contextPath}/password-reset', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'action=generate&email=' + encodeURIComponent(email)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Redirect to the reset password page
                window.location.href = '${pageContext.request.contextPath}/password-reset';
            } else {
                alert(data.message || 'Error occurred while processing request.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Something went wrong. Please try again.');
        });
    }

    function decodeJwtResponse(token) {
        let base64Url = token.split('.')[1];
        let base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        let jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));
        return JSON.parse(jsonPayload);
    }

    function handleGoogleLogin(response) {
        const responsePayload = decodeJwtResponse(response.credential);
        const email = responsePayload.email;
        const name = responsePayload.name;
        
        const params = new URLSearchParams();
        params.append('email', email);
        params.append('name', name);

        fetch('${pageContext.request.contextPath}/auth/google', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: params.toString()
        })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'registered') {
                const targetUrl = document.querySelector('input[name="targetUrl"]').value;
                if (targetUrl && targetUrl !== "") {
                    window.location.href = targetUrl;
                } else {
                    window.location.href = '${pageContext.request.contextPath}/home';
                }
            } else if (data.status === 'not_registered') {
                window.location.href = '${pageContext.request.contextPath}/Register?email=' + encodeURIComponent(email) + '&name=' + encodeURIComponent(name);
            } else {
                alert('An error occurred during Google Login.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Something went wrong. Please try again.');
        });
    }
</script>

</body>
</html>
