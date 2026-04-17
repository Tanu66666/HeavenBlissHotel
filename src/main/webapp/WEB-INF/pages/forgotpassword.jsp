<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forgotpassword.css">
</head>
<body>

<div class="page-wrapper">
    <div class="bg-overlay"></div>

    <div class="hotel-header">
        <h1>Heaven Bliss Hotel</h1>
        <p>Reset Your Password</p>
    </div>

    <div class="reset-card">
        <div class="card-label">Need Help?</div>
        <h2 class="card-title">Forgot Password</h2>
        <div class="gold-bar"></div>

        <%-- Error Message --%>
        <% if (request.getAttribute("error") != null) { %>
            <div class="msg msg-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <%-- Success Message --%>
        <% if (request.getAttribute("success") != null) { %>
            <div class="msg msg-success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <%-- Step 1: Show email input (if security question not shown) --%>
        <% if (request.getAttribute("showQuestion") == null || !(Boolean) request.getAttribute("showQuestion")) { %>
            <form action="${pageContext.request.contextPath}/forgotpassword" method="post">
                <input type="hidden" name="step" value="checkEmail">
                
                <div class="form-field">
                    <label for="email">Email Address</label>
                    <div class="input-wrap">
                        <span class="input-icon">📧</span>
                        <input type="email" id="email" name="email" 
                               placeholder="your@email.com" required>
                    </div>
                </div>
                
                <button type="submit" class="btn-reset">Verify Email →</button>
            </form>
        <% } %>

        <%-- Step 2: Show security question and password reset form --%>
        <% if (request.getAttribute("showQuestion") != null && (Boolean) request.getAttribute("showQuestion")) { %>
            <form action="${pageContext.request.contextPath}/forgotpassword" method="post">
                <input type="hidden" name="step" value="resetPassword">
                
                <div class="form-field">
                    <label>Security Question</label>
                    <div class="question-box">
                        <%= request.getAttribute("securityQuestion") %>
                    </div>
                </div>
                
                <div class="form-field">
                    <label for="securityAnswer">Your Answer</label>
                    <div class="input-wrap">
                        <span class="input-icon">❓</span>
                        <input type="text" id="securityAnswer" name="securityAnswer" 
                               placeholder="Enter your answer" required>
                    </div>
                </div>
                
                <div class="form-field">
                    <label for="newPassword">New Password</label>
                    <div class="input-wrap">
                        <span class="input-icon">🔒</span>
                        <input type="password" id="newPassword" name="newPassword" 
                               placeholder="Min 6 characters" required>
                    </div>
                </div>
                
                <div class="form-field">
                    <label for="confirmPassword">Confirm Password</label>
                    <div class="input-wrap">
                        <span class="input-icon">🔒</span>
                        <input type="password" id="confirmPassword" name="confirmPassword" 
                               placeholder="Re-enter password" required>
                    </div>
                </div>
                
                <button type="submit" class="btn-reset">Reset Password →</button>
            </form>
        <% } %>

        <div class="divider"><span>or</span></div>

        <p class="back-link">
            <a href="${pageContext.request.contextPath}/login">← Back to Login</a>
        </p>
    </div>

    <div class="page-footer">
        &copy; 2024 Heaven Bliss Hotel Group
    </div>
</div>

</body>
</html>