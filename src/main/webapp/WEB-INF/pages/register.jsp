<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register – Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>

<div class="page-wrapper">
    <div class="bg-overlay"></div>

    <!-- Hotel Header -->
    <div class="hotel-header">
        <h1>Heaven Bliss Hotel</h1>
        <p>Join the Inner Circle of Heaven Bliss</p>
    </div>

    <!-- Register Card -->
    <div class="register-card">
        <div class="card-label">Welcome</div>
        <h2 class="card-title">Register Your Account</h2>
        <div class="gold-bar"></div>

        <!-- Success Message -->
        <% if (request.getAttribute("success") != null) { %>
            <div class="msg msg-success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <!-- Error Message -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="msg msg-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <!-- Registration Form -->
        <form action="${pageContext.request.contextPath}/register" method="post">
            
            <!-- Full Name -->
            <div class="form-field">
                <label for="fullName">Full Name</label>
                <div class="input-wrap">
                    <span class="input-icon">👤</span>
                    <input type="text" id="fullName" name="fullName" 
                           placeholder="Your full name" required>
                </div>
            </div>

            <!-- Email -->
            <div class="form-field">
                <label for="email">Email Address</label>
                <div class="input-wrap">
                    <span class="input-icon">📧</span>
                    <input type="email" id="email" name="email" 
                           placeholder="your@email.com" required>
                </div>
            </div>

            <!-- Phone -->
            <div class="form-field">
                <label for="phone">Phone Number</label>
                <div class="input-wrap">
                    <span class="input-icon">📞</span>
                    <input type="tel" id="phone" name="phone" 
                           placeholder="9800000000" required>
                </div>
                <small style="color: #8b7355; font-size: 10px;">Enter 10-digit phone number</small>
            </div>

            <!-- Password -->
            <div class="form-field">
                <label for="password">Create Password</label>
                <div class="input-wrap">
                    <span class="input-icon">🔒</span>
                    <input type="password" id="password" name="password" 
                           placeholder="••••••••" required>
                    <button type="button" class="eye-btn" onclick="togglePassword()">👁️</button>
                </div>
                <small style="color: #8b7355; font-size: 10px;">Password must be at least 6 characters</small>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn-register">Join With Us</button>

        </form>

        <div class="divider"><span>or</span></div>

        <!-- Login Link -->
        <p class="login-text">
            Already a member? 
            <a href="${pageContext.request.contextPath}/login">Sign In</a>
        </p>
    </div>

    <!-- Footer -->
    <div class="page-footer">
        &copy; 2024 Heaven Bliss Hotel Group &nbsp;&bull;&nbsp;
        By joining, you agree to our Terms of Service and Privacy Policy
    </div>
</div>

<script>
    function togglePassword() {
        var pwd = document.getElementById('password');
        pwd.type = (pwd.type === 'password') ? 'text' : 'password';
    }
</script>

</body>
</html>