<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Login.css">
    <style>
        .error-text { color: red; font-size: 0.85rem; display: block; margin-top: 5px; font-weight: bold; }
    </style>
</head>
<jsp:include page="Navbar.jsp" />
<body>
<main class="login-page" style="background-image: url('${pageContext.request.contextPath}/images/background.png');">
    <section class="hero-panel"></section>

    <section class="form-panel">
        <div class="form-container">
            <h2 class="form-title">SIGN UP</h2>
            <p class="form-subtitle">Create your account.</p>

            <%-- General Database/Server Error --%>
            <% if (request.getAttribute("error") != null) { %>
                <p style="color: red; text-align: center;"><%= request.getAttribute("error") %></p>
            <% } %>

            <form action="${pageContext.request.contextPath}/Register" method="post">

                <div class="form-group">
                    <label for="passengerName" class="form-label">Full Name</label>
                    <input type="text" id="passengerName" name="passengerName" class="form-input" 
                        value="<%= request.getAttribute("passengerNameValue") != null ? request.getAttribute("passengerNameValue") : (request.getParameter("name") != null ? request.getParameter("name") : "") %>" required>
                    <% if (request.getAttribute("nameError") != null) { %>
                        <span class="error-text"><%= request.getAttribute("nameError") %></span>
                    <% } %>
                </div>

                <div class="form-group">
                    <label for="email" class="form-label">Email</label>
                    <input type="text" id="email" name="email" class="form-input" 
                        value="<%= request.getAttribute("emailValue") != null ? request.getAttribute("emailValue") : (request.getParameter("email") != null ? request.getParameter("email") : "") %>" required>
                    <% if (request.getAttribute("emailError") != null) { %>
                        <span class="error-text"><%= request.getAttribute("emailError") %></span>
                    <% } %>
                </div>

                <div class="form-group">
				    <label for="dateOfBirth" class="form-label">Date of Birth</label>
				    <input type="text" id="dateOfBirth" name="dateOfBirth" class="form-input" 
				        value="<%= request.getAttribute("dateOfBirthValue") != null ? request.getAttribute("dateOfBirthValue") : "" %>"  placeholder="dd-mm-yyyy" onfocus="(this.type='date')"
				        onblur="if(!this.value) this.type='text'" required>
				    <% if (request.getAttribute("dobError") != null) { %>
				        <span class="error-text"><%= request.getAttribute("dobError") %></span>
				    <% } %>
				</div>

                <div class="form-group">
                    <label for="gender" class="form-label">Gender</label>
                    <select id="gender" name="gender" class="form-input" required>
                        <option value="" disabled <%= (request.getAttribute("genderValue") == null) ? "selected" : "" %>>Select gender</option>
                        <option value="Male" <%= "Male".equals(request.getAttribute("genderValue")) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(request.getAttribute("genderValue")) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equals(request.getAttribute("genderValue")) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                
				<div class="form-group">
                    <label for="contactNumber" class="form-label">Contact Number</label>
                    <input type="tel" id="contactNumber" name="contactNumber" class="form-input" 
                        value="<%= request.getAttribute("contactNumberValue") != null ? request.getAttribute("contactNumberValue") : "" %>" required>
                    <% if (request.getAttribute("phoneError") != null) { %>
                        <span class="error-text"><%= request.getAttribute("phoneError") %></span>
                    <% } %>
                </div>

               <div class="form-group">
                    <label for="password" class="form-label">Password</label>
                    <div class="password-wrapper">
                        <div style="position: relative;">
                            <input type="password" id="password" name="password" class="form-input" placeholder="••••••••" 
                            value="<%= request.getAttribute("passwordValue") != null ? request.getAttribute("passwordValue") : "" %>"  required>
                            <button type="button" class="toggle-password" onclick="togglePassword()">
                                <span id="eye-icon">SHOW</span>
                            </button>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-login">Create Account</button>
            </form>

            <p class="register-prompt">
                Already have an account? <a href="${pageContext.request.contextPath}/login" class="register-link">Log In</a>
            </p>
        </div>
    </section>
</main>

<script>
    function togglePassword() {
        const input = document.getElementById('password');
        const icon = document.getElementById('eye-icon');
        const isHidden = input.type === 'password';
        input.type = isHidden ? 'text' : 'password';
        icon.textContent = isHidden ? 'HIDE' : 'SHOW';
    }
</script>
</body>
</html>