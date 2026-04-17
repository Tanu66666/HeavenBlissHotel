<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css">
</head>
<body>

<div class="admin-container">
    
    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="sidebar-brand">
            <h2>Heaven Bliss</h2>
            <p>Admin Panel</p>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active">
                 Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/rooms" class="nav-link">
                 Rooms
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">
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
        
        <!-- Top Bar -->
        <div class="top-bar">
            <h1>Dashboard</h1>
            <div class="admin-welcome">
                Welcome, <strong>${sessionScope.userName}</strong>
            </div>
        </div>
        
        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="card">
                <div class="card-info">
                    <h3>${totalRooms}</h3>
                    <p>Total Rooms</p>
                </div>
                <div class="card-trend">${availableRooms} Available</div>
            </div>
            
            <div class="card">
                <div class="card-info">
                    <h3>${totalBookings}</h3>
                    <p>Total Bookings</p>
                </div>
                <div class="card-trend">${pendingBookings} Pending</div>
            </div>
            
            <div class="card">
                <div class="card-info">
                    <h3>${totalUsers}</h3>
                    <p>Total Guests</p>
                </div>
                <div class="card-trend">Registered Users</div>
            </div>
            
            <div class="card">
                <div class="card-info">
                    <h3>रु ${totalRevenue}</h3>
                    <p>Total Revenue</p>
                </div>
                <div class="card-trend">Lifetime</div>
            </div>
        </div>
        
        <!-- Small Stats Row -->
        <div class="small-stats">
            <div class="stat-box">
                <span>Available Rooms</span>
                <strong class="green">${availableRooms}</strong>
            </div>
            <div class="stat-box">
                <span>Booked Rooms</span>
                <strong class="orange">${bookedRooms}</strong>
            </div>
            <div class="stat-box">
                <span>Maintenance</span>
                <strong class="red">${maintenanceRooms}</strong>
            </div>
        </div>
        
        <!-- Recent Bookings Table -->
        <div class="table-container">
            <div class="table-header">
                <h2>📋 Recent Bookings</h2>
                <a href="${pageContext.request.contextPath}/admin/bookings" class="view-link">View All →</a>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Guest Name</th>
                        <th>Room</th>
                        <th>Check In</th>
                        <th>Check Out</th>
                        <th>Total</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    List<Map<String, Object>> recentBookings = (List<Map<String, Object>>) request.getAttribute("recentBookings");
                    if (recentBookings != null && !recentBookings.isEmpty()) {
                        for (Map<String, Object> booking : recentBookings) {
                    %>
                    <tr>
                        <td><%= booking.get("full_name") %></td>
                        <td><%= booking.get("room_number") %> - <%= booking.get("room_type") %></td>
                        <td><%= booking.get("check_in_date") %></td>
                        <td><%= booking.get("check_out_date") %></td>
                        <td>रु <%= booking.get("total_price") %></td>
                        <td>
                            <span class="status <%= booking.get("status") %>">
                                <%= booking.get("status") %>
                            </span>
                        </td>
                    </tr>
                    <% 
                        }
                    } else { 
                    %>
                    <tr>
                        <td colspan="6" style="text-align: center;">No bookings found</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <!-- Recent Users Table -->
        <div class="table-container">
            <div class="table-header">
                <h2>👤 Recent Guests</h2>
                <a href="${pageContext.request.contextPath}/admin/users" class="view-link">View All →</a>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Registered On</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    List<Map<String, Object>> recentUsers = (List<Map<String, Object>>) request.getAttribute("recentUsers");
                    if (recentUsers != null && !recentUsers.isEmpty()) {
                        for (Map<String, Object> user : recentUsers) {
                    %>
                    <tr>
                        <td><%= user.get("full_name") %></td>
                        <td><%= user.get("email") %></td>
                        <td><%= user.get("phone") %></td>
                        <td><%= user.get("created_at") %></td>
                    </tr>
                    <% 
                        }
                    } else { 
                    %>
                    <tr>
                        <td colspan="4" style="text-align: center;">No users found</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
    </div>
</div>

</body>
</html>