<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Heaven Bliss Hotel</title>
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
            <h1>Manage Users</h1>
            <div class="admin-welcome">
                Welcome, <strong>${sessionScope.userName}</strong>
            </div>
        </div>
        
        <!-- Users Table -->
        <div class="table-container">
            <div class="table-header">
                <h2>👥 Registered Guests</h2>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Login Attempts</th>
                        <th>Registered On</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty users}">
                            <c:forEach items="${users}" var="user">
                                <tr>
                                    <td>${user.user_id}</td>
                                    <td>${user.full_name}</td>
                                    <td>${user.email}</td>
                                    <td>${user.phone}</td>
                                    <td>
                                        <span class="status ${user.is_locked ? 'locked' : 'active'}">
                                            ${user.is_locked ? 'Locked' : 'Active'}
                                        </span>
                                    </td>
                                    <td>${user.login_attempts}/5</td>
                                    <td>${user.created_at}</td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${user.user_id}" class="btn-edit">Edit</a>
                                            <c:if test="${user.is_locked}">
                                                <a href="${pageContext.request.contextPath}/admin/users?action=unlock&id=${user.user_id}" class="btn-unlock" onclick="return confirm('Unlock this user account?')">Unlock</a>
                                            </c:if>
                                            <a href="${pageContext.request.contextPath}/admin/users?action=reset&id=${user.user_id}" class="btn-reset" onclick="return confirm('Reset password to default (password123)?')">Reset Pwd</a>
                                            <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${user.user_id}" class="btn-delete" onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" style="text-align: center;">No users found</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
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