<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activities - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="nav-container">
        <div class="nav-logo">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Heaven Bliss Hotel" class="nav-logo-img">
            <h2>Heaven Bliss</h2>
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/#rooms">Rooms</a>
            <a href="${pageContext.request.contextPath}/activities" class="active">Activities</a>
            <a href="${pageContext.request.contextPath}/packages">Packages</a>
            <a href="${pageContext.request.contextPath}/#about">About</a>
            <a href="${pageContext.request.contextPath}/#ratings">Ratings</a>
            <a href="${pageContext.request.contextPath}/#contact">Contact</a>
        </div>
        <div class="nav-buttons">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/login" class="btn-login">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn-register">Register</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/dashboard" class="btn-dashboard">My Account</a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<!-- Activities Hero Section -->
<div class="activities-hero">
    <h1>Activities & Experiences</h1>
    <p>Make your stay unforgettable with our premium activities</p>
</div>

<!-- Activities Container -->
<div class="activities-container">
    <!-- Category Filter Buttons -->
    <div class="category-filter">
        <button class="category-btn active" data-category="all">All</button>
        <button class="category-btn" data-category="spa">Spa & Wellness</button>
        <button class="category-btn" data-category="entertainment">Entertainment</button>
        <button class="category-btn" data-category="dining">Dining</button>
        <button class="category-btn" data-category="pool">Pool & Fitness</button>
    </div>
    
    <!-- Activities Grid -->
    <div class="activities-grid">
        <c:forEach items="${activities}" var="activity">
            <div class="activity-card" data-category="${activity.category}">
                <div class="activity-image">
                    <img src="${pageContext.request.contextPath}${activity.image_path}" alt="${activity.activity_name}">
                </div>
                <div class="activity-info">
                    <span class="activity-category">${activity.category}</span>
                    <h3 class="activity-title">${activity.activity_name}</h3>
                    <p class="activity-desc">${activity.description}</p>
                    <div class="activity-meta">
                        <span>${activity.duration}</span>
                    </div>
                    <div class="activity-price">
                        रु ${activity.price} <span>/ per person</span>
                    </div>
                    <button class="btn-book-activity" onclick="openActivityBookingModal(${activity.activity_id}, '${activity.activity_name}', ${activity.price})">
                        Book Now →
                    </button>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Activity Booking Modal -->
<div id="activityBookingModal" class="booking-modal">
    <div class="booking-modal-content">
        <div class="booking-modal-header">
            <h3>Book Activity</h3>
            <span class="close-booking-modal" onclick="closeActivityBookingModal()">&times;</span>
        </div>
        <div class="booking-modal-body">
            <div class="booking-room-summary">
                <p><strong>Activity:</strong> <span id="modalActivityName"></span></p>
                <p><strong>Price:</strong> रु <span id="modalActivityPrice"></span> / per person</p>
            </div>
            
            <form id="activityBookingForm" method="POST" action="${pageContext.request.contextPath}/book-activity">
                <input type="hidden" name="activityId" id="activityId">
                <input type="hidden" name="activityName" id="activityName">
                <input type="hidden" name="totalPrice" id="totalPrice">
                
                <div class="booking-form-group">
                    <label>Booking Date</label>
                    <input type="date" name="bookingDate" id="bookingDate" required>
                </div>
                
                <div class="booking-form-group">
                    <label>Number of Guests</label>
                    <select name="guestCount" id="guestCount" onchange="calculateActivityTotal()">
                        <option value="1">1 Guest</option>
                        <option value="2">2 Guests</option>
                        <option value="3">3 Guests</option>
                        <option value="4">4 Guests</option>
                        <option value="5">5 Guests</option>
                        <option value="6">6 Guests</option>
                    </select>
                </div>
                
                <div class="booking-form-group">
                    <label>Special Requests (Optional)</label>
                    <textarea name="specialRequests" id="specialRequests" rows="2" placeholder="Any special requests?"></textarea>
                </div>
                
                <div id="activityPriceBreakdown" style="display: none; background: #f0ebe3; padding: 10px; border-radius: 8px; margin: 12px 0; text-align: center;">
                    <strong>रु <span id="pricePerPerson">0</span></strong> × <span id="guestCountDisplay">0</span> guests = 
                    <strong>रु <span id="totalPriceDisplay">0</span></strong>
                </div>
                
                <div class="booking-modal-footer">
                    <button type="button" class="btn-cancel" onclick="closeActivityBookingModal()">Cancel</button>
                    <button type="button" class="btn-confirm-booking" onclick="showConfirmationAndSubmit()">Confirm Booking →</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Booking Confirmation Modal -->
<div id="confirmationModal" class="booking-modal">
    <div class="booking-modal-content" style="max-width: 400px; text-align: center;">
        <div style="font-size: 60px; color: #2d6a4f; margin: 20px 0 10px;">✓</div>
        <h3>Booking Confirmed!</h3>
        <p>Your activity has been successfully booked.</p>
        <div style="background: #f0ebe3; padding: 15px; margin: 20px; text-align: left; border-left: 3px solid #c9a84c;">
            <p><strong>Activity:</strong> <span id="confirmActivityName"></span></p>
            <p><strong>Date:</strong> <span id="confirmDate"></span></p>
            <p><strong>Guests:</strong> <span id="confirmGuests"></span></p>
            <p><strong>Total:</strong> रु <span id="confirmTotal"></span></p>
        </div>
        <div class="booking-modal-footer" style="justify-content: center; border-top: none;">
            <button class="btn-confirm-booking" onclick="goToMyActivities()">Go to My Activities</button>
            <button class="btn-cancel" onclick="closeConfirmationModal()">Close</button>
        </div>
    </div>
</div>

<script>
    // Category Filter
    const categoryBtns = document.querySelectorAll('.category-btn');
    const activityCards = document.querySelectorAll('.activity-card');
    
    categoryBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            categoryBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            const category = this.getAttribute('data-category');
            activityCards.forEach(card => {
                if (category === 'all' || card.getAttribute('data-category') === category) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
    
    let currentActivityPrice = 0;
    let currentActivityName = '';
    let currentActivityId = 0;
    
    function openActivityBookingModal(activityId, activityName, price) {
        currentActivityId = activityId;
        currentActivityName = activityName;
        currentActivityPrice = price;
        
        document.getElementById('modalActivityName').innerText = activityName;
        document.getElementById('modalActivityPrice').innerText = price;
        document.getElementById('activityId').value = activityId;
        document.getElementById('activityName').value = activityName;
        
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('bookingDate').min = today;
        document.getElementById('bookingDate').value = '';
        document.getElementById('guestCount').value = '1';
        document.getElementById('specialRequests').value = '';
        document.getElementById('activityPriceBreakdown').style.display = 'none';
        document.getElementById('totalPrice').value = '';
        
        document.getElementById('activityBookingModal').style.display = 'block';
    }
    
    function calculateActivityTotal() {
        const guests = parseInt(document.getElementById('guestCount').value);
        const total = guests * currentActivityPrice;
        
        document.getElementById('pricePerPerson').innerText = currentActivityPrice;
        document.getElementById('guestCountDisplay').innerText = guests;
        document.getElementById('totalPriceDisplay').innerText = total;
        document.getElementById('totalPrice').value = total;
        document.getElementById('activityPriceBreakdown').style.display = 'block';
    }
    
    function closeActivityBookingModal() {
        document.getElementById('activityBookingModal').style.display = 'none';
    }
    
    function closeConfirmationModal() {
        document.getElementById('confirmationModal').style.display = 'none';
    }
    
    function goToMyActivities() {
        // Submit the form to save booking, then go to My Activities
        document.getElementById('activityBookingForm').submit();
    }
    
    function showConfirmationAndSubmit() {
        // Get form values
        const bookingDate = document.getElementById('bookingDate').value;
        const guests = document.getElementById('guestCount').value;
        
        // Validate
        if (!bookingDate) {
            alert('Please select a booking date');
            return;
        }
        
        // Calculate total if not calculated yet
        if (!document.getElementById('totalPrice').value || document.getElementById('totalPrice').value === '0') {
            calculateActivityTotal();
        }
        
        const total = document.getElementById('totalPrice').value;
        
        if (!total || total === '0') {
            alert('Please select number of guests');
            return;
        }
        
        // Show confirmation modal with booking details
        document.getElementById('confirmActivityName').innerText = currentActivityName;
        document.getElementById('confirmDate').innerText = bookingDate;
        document.getElementById('confirmGuests').innerText = guests;
        document.getElementById('confirmTotal').innerText = total;
        
        // Close booking modal and show confirmation
        closeActivityBookingModal();
        document.getElementById('confirmationModal').style.display = 'block';
        
        // No auto-submit - user clicks "Go to My Activities" to submit
    }
    
    window.onclick = function(event) {
        if (event.target.classList.contains('booking-modal')) {
            event.target.style.display = 'none';
        }
    }
</script>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-about">
            <h3>Heaven Bliss Hotel</h3>
            <p>Welcome to Heaven Bliss Hotel, relax in comfort and enjoy exceptional hospitality. Discover spaces designed for peace and let every moment here feel truly special.</p>
        </div>
        <div class="footer-links">
            <h4>Quick Links</h4>
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/#rooms">Rooms</a>
            <a href="${pageContext.request.contextPath}/activities">Activities</a>
            <a href="${pageContext.request.contextPath}/packages">Packages</a>
            <a href="${pageContext.request.contextPath}/#about">About</a>
            <a href="${pageContext.request.contextPath}/#contact">Contact</a>
        </div>
        <div class="footer-links">
            <h4>Support</h4>
            <a href="${pageContext.request.contextPath}/login">Login</a>
            <a href="${pageContext.request.contextPath}/register">Register</a>
            <a href="#">FAQ</a>
            <a href="#">Privacy Policy</a>
        </div>
        <div class="footer-social">
            <h4>Follow Us</h4>
            <div class="social-icons">
                <a href="https://github.com/Tanu66666" target="_blank">
                    <img src="${pageContext.request.contextPath}/images/github.jpg" alt="GitHub" width="24" height="24">
                </a>
                <a href="https://www.linkedin.com/in/tanisha-maharjan-72739b371/" target="_blank">
                    <img src="${pageContext.request.contextPath}/images/linkedin.jpg" alt="LinkedIn" width="24" height="24">
                </a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 Heaven Bliss Hotel. All rights reserved.</p>
    </div>
</footer>

</body>
</html>