<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login – Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>

<div class="page-wrapper">

    <!-- Background overlay -->
    <div class="bg-overlay"></div>

    <!-- Hotel name top -->
    <div class="hotel-header">
        <h1>Heaven Bliss Hotel</h1>
        <p>Experience Hospitality Like Heaven</p>
    </div>

    <!-- Login Card -->
    <div class="login-card">

        <div class="card-label">Welcome Back</div>
        <h2 class="card-title">Login and Get Started</h2>
        <div class="gold-bar"></div>

        <%-- SUCCESS MESSAGE --%>
		<c:if test="${not empty success}">
		    <div class="msg msg-success">
		        ${success}
		    </div>
		</c:if>
		
		<%-- ERROR MESSAGE --%>
		<c:if test="${not empty error}">
		    <div class="msg msg-error">
		        ${error}
		    </div>
		</c:if>

        <!-- Login Form -->
        <form action="${pageContext.request.contextPath}/login" method="post">

            <!-- Email Field -->
            <div class="form-field">
                <label for="email">Email Address</label>
                <div class="input-wrap">
                    <span class="input-icon">&#9993;</span>
                    <input type="email" id="email" name="email"
                           placeholder="your@email.com" 
                           value="${not empty rememberedEmail ? rememberedEmail : ''}"
                           required>
                </div>
            </div>

            <!-- Password Field -->
            <div class="form-field">
                <label for="password">Password</label>
                <div class="input-wrap">
                    <span class="input-icon">&#128274;</span>
                    <input type="password" id="password" name="password"
                           placeholder="********" required>
                    <button type="button" class="eye-btn"
                            onclick="togglePassword()">&#128065;</button>
                </div>
            </div>

            <!-- Remember + Forgot -->
            <div class="form-row">
                <label class="remember-label">
                    <input type="checkbox" name="remember" ${rememberChecked ? 'checked' : ''}> Remember device
                </label>
                <a href="${pageContext.request.contextPath}/forgotpassword" class="forgot-link">Forgot Password?</a>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn-login">login</button>

        </form>

        <div class="divider"><span>or</span></div>

        <!-- Register Link -->
        <p class="register-text">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register">Register here</a>
        </p>

    </div>

    <!-- Footer -->
    <div class="page-footer">
        &copy; 2024 Heaven Bliss Hotel Group &nbsp;&bull;&nbsp;
        Terms of Service &nbsp;&bull;&nbsp; Privacy Protocol
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