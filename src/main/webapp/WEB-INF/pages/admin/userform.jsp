<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminusers.css">
</head>
<body>

<!-- Hamburger Menu Button -->
<button class="hamburger" onclick="toggleSidebar()">☰</button>

<div class="admin-container">
    
    <!-- Sidebar Navigation -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <h2>Heaven Bliss</h2>
            <p>Admin Panel</p>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/rooms" class="nav-link">
                Rooms
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-link active">
                Users
            </a>
            <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link">
                Bookings
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
        <div class="top-bar">
            <h1>Edit User</h1>
            <div class="admin-welcome">
                Welcome, <strong>${sessionScope.userName}</strong>
            </div>
        </div>
        
        <!-- User Form -->
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/users" method="post" class="user-form">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="user_id" value="${user.user_id}">
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name *</label>
                        <input type="text" name="full_name" value="${user.full_name}" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Email Address *</label>
                        <input type="email" name="email" value="${user.email}" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Phone Number *</label>
                        <input type="tel" name="phone" value="${user.phone}" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Role *</label>
                        <select name="role" required>
                            <option value="guest" ${user.role == 'guest' ? 'selected' : ''}>Guest</option>
                            <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Admin</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Account Status</label>
                        <select name="is_locked">
                            <option value="false" ${not user.is_locked ? 'selected' : ''}>Active</option>
                            <option value="true" ${user.is_locked ? 'selected' : ''}>Locked</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Login Attempts</label>
                        <input type="text" value="${user.login_attempts} / 5" disabled>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Registered On</label>
                    <input type="text" value="${user.created_at}" disabled>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn-save">Update User</button>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn-cancel">Cancel</a>
                </div>
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
</script>

</body>
</html>