<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myprofile.css">
</head>
<body>

<!-- Hamburger Menu Button -->
<button class="hamburger" onclick="toggleSidebar()">☰</button>

<div class="user-container">
    
    <!-- Sidebar Navigation -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <h2>Heaven Bliss</h2>
            <p>Member Portal</p>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-link">
                Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/user/bookings" class="nav-link">
                My Bookings
            </a>
            <a href="${pageContext.request.contextPath}/user/profile" class="nav-link active">
                My Profile
            </a>
            <a href="${pageContext.request.contextPath}/user/rooms" class="nav-link">
                Browse Rooms
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                Logout
            </a>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        
        <!-- Header -->
        <div class="welcome-header">
            <div>
                <h1>My Profile</h1>
                <p>View and manage your account information</p>
            </div>
        </div>
        
        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="msg-success">
                ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="msg-error">
                ${error}
            </div>
        </c:if>
        
        <!-- Edit Profile Section -->
        <div class="profile-section">
            <div class="profile-section-header">
                <h2>✏️ Edit Profile Information</h2>
            </div>
            
            <form class="profile-form" action="${pageContext.request.contextPath}/user/profile" method="post">
                <input type="hidden" name="action" value="updateProfile">
                
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" value="${userProfile.full_name}" required>
                </div>
                
                <div class="row-2cols">
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" value="${userProfile.email}" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="tel" name="phone" value="${userProfile.phone}" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Member Since</label>
                    <input type="text" value="${userProfile.created_at}" disabled>
                </div>
                
                <button type="submit" class="btn-save">Save Changes</button>
            </form>
        </div>
        
        <!-- Change Password Section -->
        <div class="profile-section">
            <div class="profile-section-header">
                <h2>🔒 Change Password</h2>
            </div>
            
            <form class="profile-form" action="${pageContext.request.contextPath}/user/profile" method="post" 
                  onsubmit="return validatePasswordForm()">
                <input type="hidden" name="action" value="changePassword">
                
                <div class="form-group">
                    <label>Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" placeholder="Enter current password">
                    <span class="toggle-password" onclick="togglePassword('currentPassword')">Show</span>
                </div>
                
                <div class="form-group">
                    <label>Or Answer Security Question</label>
                    <div class="security-question-box">
                        <strong>Security Question:</strong> ${securityQuestion}
                    </div>
                    <input type="text" name="securityAnswer" placeholder="Enter your security answer">
                </div>
                
                <div class="row-2cols">
                    <div class="form-group">
                        <label>New Password</label>
                        <input type="password" id="newPassword" name="newPassword" placeholder="Min 6 characters" required>
                        <span class="toggle-password" onclick="togglePassword('newPassword')">Show</span>
                    </div>
                    
                    <div class="form-group">
                        <label>Confirm New Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter new password" required>
                        <span class="toggle-password" onclick="togglePassword('confirmPassword')">Show</span>
                    </div>
                </div>
                
                <button type="submit" class="btn-change">Change Password</button>
            </form>
        </div>
        
    </div>
</div>

<script>
    function toggleSidebar() {
        var sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('open');
    }
    
    document.addEventListener('click', function(event) {
        var sidebar = document.getElementById('sidebar');
        var hamburger = document.querySelector('.hamburger');
        if (sidebar.classList.contains('open')) {
            if (!sidebar.contains(event.target) && !hamburger.contains(event.target)) {
                sidebar.classList.remove('open');
            }
        }
    });
    
    function togglePassword(fieldId) {
        var field = document.getElementById(fieldId);
        if (field.type === 'password') {
            field.type = 'text';
        } else {
            field.type = 'password';
        }
    }
    
    function validatePasswordForm() {
        var newPass = document.getElementById('newPassword').value;
        var confirmPass = document.getElementById('confirmPassword').value;
        
        if (newPass.length < 6) {
            alert('New password must be at least 6 characters long');
            return false;
        }
        
        if (newPass !== confirmPass) {
            alert('New passwords do not match');
            return false;
        }
        
        return true;
    }
</script>

</body>
</html>