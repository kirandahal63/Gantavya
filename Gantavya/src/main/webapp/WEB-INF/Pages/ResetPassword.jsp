<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Login.css">
</head>
<body>
<jsp:include page="Navbar.jsp" />
<main class="login-page" style="background-image: url('${pageContext.request.contextPath}/images/background.png');">
    <section class="hero-panel"></section>

    <section class="form-panel">
        <div class="form-container">
            <h2 class="form-title">RESET PASSWORD</h2>
            <p class="form-subtitle">Verify your code to create a new password.</p>

            <div id="error-msg" style="color: red; margin-bottom: 15px; display: none;"></div>
            <div id="success-msg" style="color: green; margin-bottom: 15px; display: none;"></div>

            <!-- Verification Section -->
            <div id="verification-section">
                <div class="form-group">
                    <label for="code" class="form-label">Verification Code</label>
                    <input type="text" id="code" name="code" class="form-input" placeholder="Enter 6-digit code" required>
                </div>
                <div id="timer-container" style="margin-bottom: 15px; font-size: 0.9rem; color: #666;">
                    Code expires in: <span id="timer">60</span>s
                </div>
                <button type="button" class="btn-login" id="verify-btn" onclick="verifyCode()">Verify</button>
                <div id="resend-container" style="margin-top: 15px; display: none;">
                    Didn't receive code? <a href="javascript:void(0)" onclick="resendCode()" class="register-link">Resend Code</a>
                </div>
            </div>

            <!-- Reset Password Section -->
            <div id="reset-password-section" style="display: none;">
                <form id="reset-form" onsubmit="resetPassword(event)">
                    <div class="form-group">
                        <label for="newPassword" class="form-label">New Password</label>
                        <div class="password-wrapper">
                            <input type="password" id="newPassword" name="newPassword" class="form-input" placeholder="••••••••" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <div class="password-wrapper">
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" placeholder="••••••••" required>
                        </div>
                    </div>
                    <button type="submit" class="btn-login">Update Password</button>
                </form>
            </div>
            
            <p class="register-prompt" style="margin-top: 20px;">
                Remembered your password?
                <a href="${pageContext.request.contextPath}/Login" class="register-link">Login</a>
            </p>
        </div>
    </section>
</main>

<script>
    let timeLeft = 60;
    let timerId;

    function startTimer() {
        timeLeft = 60;
        document.getElementById('timer').innerText = timeLeft;
        document.getElementById('timer-container').style.display = 'block';
        document.getElementById('resend-container').style.display = 'none';
        document.getElementById('verify-btn').disabled = false;
        
        if (timerId) clearInterval(timerId);
        
        timerId = setInterval(() => {
            timeLeft--;
            document.getElementById('timer').innerText = timeLeft;
            if (timeLeft <= 0) {
                clearInterval(timerId);
                document.getElementById('timer-container').style.display = 'none';
                document.getElementById('resend-container').style.display = 'block';
                // document.getElementById('verify-btn').disabled = true; // Optional: disable verify button
            }
        }, 1000);
    }

    // Start timer on page load
    window.onload = startTimer;

    function resendCode() {
        const errorMsg = document.getElementById('error-msg');
        const successMsg = document.getElementById('success-msg');

        fetch('${pageContext.request.contextPath}/password-reset', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'action=resend'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                successMsg.innerText = 'New verification code sent.';
                successMsg.style.display = 'block';
                errorMsg.style.display = 'none';
                startTimer();
            } else {
                errorMsg.innerText = data.message || 'Failed to resend code.';
                errorMsg.style.display = 'block';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            errorMsg.innerText = 'Something went wrong. Please try again.';
            errorMsg.style.display = 'block';
        });
    }

    function verifyCode() {
        const code = document.getElementById('code').value.trim();
        const errorMsg = document.getElementById('error-msg');
        
        if (!code) {
            errorMsg.innerText = 'Please enter the verification code.';
            errorMsg.style.display = 'block';
            return;
        }

        fetch('${pageContext.request.contextPath}/password-reset', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'action=verify&code=' + encodeURIComponent(code)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.getElementById('verification-section').style.display = 'none';
                document.getElementById('reset-password-section').style.display = 'block';
                errorMsg.style.display = 'none';
                document.getElementById('success-msg').innerText = 'Code verified successfully.';
                document.getElementById('success-msg').style.display = 'block';
            } else {
                errorMsg.innerText = data.message || 'Invalid verification code.';
                errorMsg.style.display = 'block';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            errorMsg.innerText = 'Something went wrong. Please try again.';
            errorMsg.style.display = 'block';
        });
    }

    function resetPassword(event) {
        event.preventDefault();
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const errorMsg = document.getElementById('error-msg');
        const successMsg = document.getElementById('success-msg');

        if (newPassword !== confirmPassword) {
            errorMsg.innerText = 'Passwords do not match.';
            errorMsg.style.display = 'block';
            successMsg.style.display = 'none';
            return;
        }

        fetch('${pageContext.request.contextPath}/password-reset', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'action=reset&newPassword=' + encodeURIComponent(newPassword) + '&confirmPassword=' + encodeURIComponent(confirmPassword)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Password updated successfully. Please login.');
                window.location.href = '${pageContext.request.contextPath}/Login';
            } else {
                errorMsg.innerText = data.message || 'Error updating password.';
                errorMsg.style.display = 'block';
                successMsg.style.display = 'none';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            errorMsg.innerText = 'Something went wrong. Please try again.';
            errorMsg.style.display = 'block';
            successMsg.style.display = 'none';
        });
    }
</script>
</body>
</html>
