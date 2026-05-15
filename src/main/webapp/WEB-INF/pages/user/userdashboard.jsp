<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Dashboard - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css">
</head>
<body>

<!-- Hamburger Menu Button -->
<button class="hamburger" onclick="toggleSidebar()">☰</button>

<div class="user-container">
    
    <!-- Sidebar Navigation -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Heaven Bliss Logo" class="sidebar-logo">
            <h2>Heaven Bliss</h2>
            <p>Member Portal</p>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-link active">
                Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/user/rooms" class="nav-link">
                Browse Rooms
            </a>
            <a href="${pageContext.request.contextPath}/user/bookings" class="nav-link">
                My Bookings
            </a>
            <a href="${pageContext.request.contextPath}/user/profile" class="nav-link">
                My Profile
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/home" class="logout-btn">
                ← Back to Home
            </a>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        
        <!-- Hero Banner Image -->
        <div class="hero-banner">
            <img src="${pageContext.request.contextPath}/images/userdashboard.jpg" alt="Heaven Bliss Hotel" class="banner-image">
        </div>
        
        <!-- My Upcoming Reservations -->
        <div class="section">
            <div class="section-header">
                <h2>My Upcoming Reservations</h2>
                <a href="${pageContext.request.contextPath}/user/bookings" class="view-link">View All</a>
            </div>
            
            <div class="bookings-list">
                <c:choose>
                    <c:when test="${not empty userBookings}">
                        <c:set var="hasUpcoming" value="false" />
                        <c:forEach items="${userBookings}" var="booking">
                            <c:if test="${booking.status != 'completed' and booking.status != 'cancelled'}">
                                <c:set var="hasUpcoming" value="true" />
                                <div class="booking-card">
                                    <div class="booking-status ${booking.status}">
                                        ${booking.status}
                                    </div>
                                    <div class="booking-details">
                                        <h3>Room ${booking.room_number} - ${booking.room_type}</h3>
                                        <div class="booking-dates">
                                            <span>Check In: ${booking.check_in_date}</span>
                                            <span>Check Out: ${booking.check_out_date}</span>
                                        </div>
                                        <div class="booking-info">
                                            <span>Guests: ${booking.guest_count}</span>
                                            <span>Total: रु ${booking.total_price}</span>
                                        </div>
                                        <c:if test="${not empty booking.special_requests}">
                                            <div class="special-requests">
                                                Special Request: ${booking.special_requests}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${not hasUpcoming}">
                            <div class="empty-state">
                                <p>No upcoming reservations. <a href="${pageContext.request.contextPath}/user/rooms">Book a room now!</a></p>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <p>You haven't made any bookings yet. <a href="${pageContext.request.contextPath}/user/rooms">Browse available rooms</a></p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- Featured Rooms -->
        <div class="section">
            <div class="section-header">
                <h2>Featured Rooms</h2>
                <a href="${pageContext.request.contextPath}/user/rooms" class="view-link">View all rooms</a>
            </div>
            
            <div class="featured-rooms">
                <!-- Deluxe Twin Room (room_id = 3) -->
                <div class="featured-room-card">
                    <div class="room-image-placeholder" style="background-image: url('${pageContext.request.contextPath}/images/deluxe/deluxe-bed.jpg'); background-size: cover; background-position: center; height: 250px;"></div>
                    <div class="featured-room-content">
                        <h3 class="featured-room-title">Deluxe Twin</h3>
                        <p class="featured-room-desc">Two comfortable single beds with modern amenities. Perfect for friends or colleagues traveling together.</p>
                        <div class="featured-room-features">
                            <span>2 guests</span>
                            <span>2 Single beds</span>
                        </div>
                        <div class="featured-room-price">
                            रु 4,500 <span>/ night</span>
                        </div>
                        <button onclick="openRoomModal(3)" class="book-featured-btn">
                            View Room
                        </button>
                    </div>
                </div>
                
                <!-- Family Room (room_id = 4) -->
                <div class="featured-room-card">
                    <div class="room-image-placeholder" style="background-image: url('${pageContext.request.contextPath}/images/family/king-size-bed.jpg'); background-size: cover; background-position: center; height: 250px;"></div>
                    <div class="featured-room-content">
                        <h3 class="featured-room-title">Family Room</h3>
                        <p class="featured-room-desc">Spacious room with two double beds, perfect for family vacations. Kid-friendly amenities included.</p>
                        <div class="featured-room-features">
                            <span>4 guests</span>
                            <span>2 Double beds</span>
                        </div>
                        <div class="featured-room-price">
                            रु 5,500 <span>/ night</span>
                        </div>
                        <button onclick="openRoomModal(4)" class="book-featured-btn">
                            View Room
                        </button>
                    </div>
                </div>
                
                <!-- VIP Executive (room_id = 6) -->
                <div class="featured-room-card">
                    <div class="room-image-placeholder" style="background-image: url('${pageContext.request.contextPath}/images/vipSuite/vip-bed.jpg'); background-size: cover; background-position: center; height: 250px;"></div>
                    <div class="featured-room-content">
                        <h3 class="featured-room-title">VIP Executive</h3>
                        <p class="featured-room-desc">Luxurious executive suite with king-size bed, panoramic views, and personalized butler service.</p>
                        <div class="featured-room-features">
                            <span>2 guests</span>
                            <span>King bed</span>
                        </div>
                        <div class="featured-room-price">
                            रु 12,000 <span>/ night</span>
                        </div>
                        <button onclick="openRoomModal(6)" class="book-featured-btn">
                            View Room
                        </button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Profile Quick View -->
        <div class="profile-card">
            <div class="profile-header">
                <h2>Your Profile</h2>
                <a href="${pageContext.request.contextPath}/user/profile" class="edit-link">Edit Profile</a>
            </div>
            <div class="profile-info">
                <div class="info-row">
                    <span class="info-label">Full Name:</span>
                    <span class="info-value">${sessionScope.userName}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Email:</span>
                    <span class="info-value">${sessionScope.userEmail}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Member Since:</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${not empty userProfile and not empty userProfile.created_at}">
                                ${userProfile.created_at}
                            </c:when>
                            <c:otherwise>
                                2024
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>
        
    </div>
</div>

<!-- ==================== MODALS ==================== -->

<!-- Room Details Modal -->
<div id="roomModal" class="modal">
    <div class="modal-content">
        <span class="close-modal" onclick="closeRoomModal()">&times;</span>
        
        <div class="modal-container">
            <!-- Left Side: Image Slideshow -->
            <div class="modal-slideshow">
                <div class="modal-slideshow-container" id="modalSlidesContainer">
                    <!-- Slides added by JavaScript -->
                </div>
                <div class="modal-dots" id="modalDotsContainer">
                    <!-- Dots added by JavaScript -->
                </div>
            </div>
            
            <!-- Right Side: Room Details -->
            <div class="modal-details">
                <h2 id="modalRoomTitle"></h2>
                <div class="modal-room-number" id="modalRoomNumber"></div>
                <div class="modal-price" id="modalPrice"></div>
                <p class="modal-description" id="modalDescription"></p>
                
                <div class="modal-amenities">
                    <h4>Features</h4>
                    <div class="amenities-list" id="modalAmenitiesList"></div>
                </div>
                
                <div class="modal-booking-info">
                    <div class="info-item">
                        <span>Max Guests:</span>
                        <strong id="modalMaxGuests"></strong>
                    </div>
                    <div class="info-item">
                        <span>Bed Type:</span>
                        <strong id="modalBedType"></strong>
                    </div>
                    <div class="info-item">
                        <span>Size:</span>
                        <strong id="modalSize"></strong>
                    </div>
                </div>
                
                <button class="modal-book-btn" onclick="openBookingModal()">Book This Room →</button>
            </div>
        </div>
    </div>
</div>

<!-- Booking Details Modal -->
<div id="bookingModal" class="booking-modal">
    <div class="booking-modal-content">
        <div class="booking-modal-header">
            <h3>Complete Your Booking</h3>
            <span class="close-booking-modal" onclick="closeBookingModal()">&times;</span>
        </div>
        
        <div class="booking-modal-body">
            <div class="booking-room-summary">
                <p><strong>Room:</strong> <span id="bookingSummaryRoom"></span> (<span id="bookingSummaryRoomNumber"></span>)</p>
                <p><strong>Price:</strong> रु <span id="bookingSummaryPrice"></span> / night</p>
            </div>
            
            <form id="bookingForm" method="POST" action="${pageContext.request.contextPath}/book-room">
                <input type="hidden" name="roomId" id="bookingRoomId">
                <input type="hidden" name="roomNumber" id="bookingRoomNumber">
                <input type="hidden" name="roomType" id="bookingRoomType">
                <input type="hidden" name="pricePerNight" id="bookingPricePerNight">
                
                <div class="booking-form-group">
                    <label>Check-in Date:</label>
                    <input type="date" name="checkInDate" id="bookingCheckInDate" required>
                </div>
                
                <div class="booking-form-group">
                    <label>Check-out Date:</label>
                    <input type="date" name="checkOutDate" id="bookingCheckOutDate" required>
                </div>
                
                <div class="booking-form-group">
                    <label>Number of Guests:</label>
                    <select name="numberOfGuests" id="bookingNumberOfGuests">
                        <option value="1">1 Guest</option>
                        <option value="2">2 Guests</option>
                        <option value="3">3 Guests</option>
                        <option value="4">4 Guests</option>
                    </select>
                </div>
                
                <div class="booking-form-group">
                    <label>Special Requests (Optional):</label>
                    <textarea name="specialRequests" id="bookingSpecialRequests" rows="2" placeholder="Any special requests?"></textarea>
                </div>
                
                <div id="bookingPriceBreakdown" style="display: none; background: #f0ebe3; padding: 10px; border-radius: 8px; margin: 12px 0; text-align: center; font-size: 13px;">
                    <strong>रु <span id="bookingPricePerNightDisplay">0</span></strong> × <span id="bookingNightsCount">0</span> nights = 
                    <strong>रु <span id="bookingTotalPriceDisplay">0</span></strong>
                </div>
                
                <div class="booking-modal-footer">
                    <button type="button" class="btn-cancel" onclick="closeBookingModal()">Cancel</button>
                    <button type="submit" class="btn-confirm-booking">Confirm Booking →</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
// Room Data based on YOUR DATABASE
const roomData = {
    3: {  // Deluxe Twin (2 Beds) - room_id = 3
        id: 3,
        title: 'Deluxe Twin',
        number: '103',
        price: 4500,
        description: 'Perfect for friends or colleagues. Features two single beds, separate work areas, garden view, luxury bathroom, and elegant decor.',
        maxGuests: '2 guests',
        bedType: 'Two Single Beds',
        size: '30 sqm',
        amenities: ['Free Wi-Fi', 'Flat-screen TV', 'Room Service', 'Air Conditioning', 'Mini Bar', 'Private Bathroom', 'Garden View', 'Work Desk'],
        images: [
            '${pageContext.request.contextPath}/images/deluxe/deluxe-bed.jpg',
            '${pageContext.request.contextPath}/images/deluxe/deluxe-room-decore.jpg',
            '${pageContext.request.contextPath}/images/deluxe/deluxe-bathroom.jpg'
        ]
    },
    4: {  // Family Room (2 Beds) - room_id = 4
        id: 4,
        title: 'Family Room',
        number: '104',
        price: 5500,
        description: 'Large family room with two double beds, perfect for family vacations. Kid-friendly amenities and spacious layout.',
        maxGuests: '4 guests',
        bedType: 'Two Double Beds',
        size: '45 sqm',
        amenities: ['Free Wi-Fi', '2 Flat-screen TVs', 'Room Service', 'Air Conditioning', 'Mini Bar', 'Private Bathroom', 'Kid-Friendly', 'Living Area'],
        images: [
            '${pageContext.request.contextPath}/images/family/king-size-bed.jpg',
            '${pageContext.request.contextPath}/images/family/kids-bunk-bed-room.jpg',
            '${pageContext.request.contextPath}/images/family/family-room-living-room.jpg',
            '${pageContext.request.contextPath}/images/family/family-bathroom.jpg'
        ]
    },
    6: {  // VIP Executive - room_id = 6
        id: 6,
        title: 'VIP Executive',
        number: '106',
        price: 12000,
        description: 'Luxurious executive suite with king-size bed, panoramic views, and personalized butler service. Experience ultimate comfort.',
        maxGuests: '2 guests',
        bedType: 'King Bed',
        size: '55 sqm',
        amenities: ['Free Wi-Fi', 'Smart TV', '24/7 Butler Service', 'Air Conditioning', 'Complimentary Bar', 'Jacuzzi', 'Panoramic View', 'Work Desk'],
        images: [
            '${pageContext.request.contextPath}/images/vipSuite/vip-bed.jpg',
            '${pageContext.request.contextPath}/images/vipSuite/vip-living-room.jpg',
            '${pageContext.request.contextPath}/images/vipSuite/vip-decor.jpg',
            '${pageContext.request.contextPath}/images/vipSuite/vip-bathroom.jpg',
            '${pageContext.request.contextPath}/images/vipSuite/vip-private-pool.jpg',
            '${pageContext.request.contextPath}/images/vipSuite/vip-dining-table.jpg',
            '${pageContext.request.contextPath}/images/vipSuite/vip-dressing-room.jpg'
        ]
    }
};

let currentRoom = null;
let currentSlideIndex = 1;
let slideInterval;

// Open Room Modal by room_id
function openRoomModal(roomId) {
    currentRoom = roomData[roomId];
    if (!currentRoom) return;
    
    document.getElementById('modalRoomTitle').innerText = currentRoom.title;
    document.getElementById('modalRoomNumber').innerText = 'Room ' + currentRoom.number;
    document.getElementById('modalPrice').innerHTML = 'रु ' + currentRoom.price + ' <span>/ per night</span>';
    document.getElementById('modalDescription').innerText = currentRoom.description;
    document.getElementById('modalMaxGuests').innerText = currentRoom.maxGuests;
    document.getElementById('modalBedType').innerText = currentRoom.bedType;
    document.getElementById('modalSize').innerText = currentRoom.size;
    
    const amenitiesList = document.getElementById('modalAmenitiesList');
    amenitiesList.innerHTML = currentRoom.amenities.map(a => '<span>✓ ' + a + '</span>').join('');
    
    buildSlideshow(currentRoom.images);
    document.getElementById('roomModal').style.display = 'block';
    startSlideshow();
}

function buildSlideshow(images) {
    const container = document.getElementById('modalSlidesContainer');
    const dotsContainer = document.getElementById('modalDotsContainer');
    
    container.innerHTML = '';
    dotsContainer.innerHTML = '';
    
    images.forEach((img, index) => {
        const slide = document.createElement('div');
        slide.className = 'modal-slide fade';
        const imgEl = document.createElement('img');
        imgEl.src = img;
        imgEl.style.width = '100%';
        imgEl.style.height = '350px';
        imgEl.style.objectFit = 'cover';
        slide.appendChild(imgEl);
        container.appendChild(slide);
        
        const dot = document.createElement('span');
        dot.className = 'modal-dot';
        dot.onclick = function() { currentSlide = index + 1; showSlide(currentSlide); resetTimer(); };
        dotsContainer.appendChild(dot);
    });
    
    const prevBtn = document.createElement('a');
    prevBtn.className = 'modal-prev';
    prevBtn.innerHTML = '&#10094;';
    prevBtn.onclick = function() { changeSlide(-1); };
    const nextBtn = document.createElement('a');
    nextBtn.className = 'modal-next';
    nextBtn.innerHTML = '&#10095;';
    nextBtn.onclick = function() { changeSlide(1); };
    container.appendChild(prevBtn);
    container.appendChild(nextBtn);
    
    currentSlide = 1;
    showSlide(1);
}

function showSlide(n) {
    const slides = document.getElementsByClassName('modal-slide');
    const dots = document.getElementsByClassName('modal-dot');
    if (!slides.length) return;
    if (n > slides.length) currentSlide = 1;
    if (n < 1) currentSlide = slides.length;
    for (let i = 0; i < slides.length; i++) slides[i].style.display = 'none';
    for (let i = 0; i < dots.length; i++) dots[i].className = dots[i].className.replace(' active', '');
    slides[currentSlide - 1].style.display = 'block';
    if (dots[currentSlide - 1]) dots[currentSlide - 1].className += ' active';
}

function changeSlide(direction) {
    showSlide(currentSlide += direction);
    resetTimer();
}

function startSlideshow() {
    if (slideInterval) clearInterval(slideInterval);
    slideInterval = setInterval(function() { changeSlide(1); }, 4000);
}

function resetTimer() {
    if (slideInterval) clearInterval(slideInterval);
    startSlideshow();
}

function closeRoomModal() {
    document.getElementById('roomModal').style.display = 'none';
    if (slideInterval) clearInterval(slideInterval);
}

// Open Booking Modal and populate form
function openBookingModal() {
    if (!currentRoom) return;
    
    document.getElementById('bookingSummaryRoom').innerText = currentRoom.title;
    document.getElementById('bookingSummaryRoomNumber').innerText = currentRoom.number;
    document.getElementById('bookingSummaryPrice').innerText = currentRoom.price;
    
    document.getElementById('bookingRoomId').value = currentRoom.id;
    document.getElementById('bookingRoomNumber').value = currentRoom.number;
    document.getElementById('bookingRoomType').value = currentRoom.title;
    document.getElementById('bookingPricePerNight').value = currentRoom.price;
    
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('bookingCheckInDate').min = today;
    document.getElementById('bookingCheckOutDate').min = today;
    document.getElementById('bookingCheckInDate').value = '';
    document.getElementById('bookingCheckOutDate').value = '';
    document.getElementById('bookingNumberOfGuests').value = '1';
    document.getElementById('bookingSpecialRequests').value = '';
    document.getElementById('bookingPriceBreakdown').style.display = 'none';
    
    closeRoomModal();
    document.getElementById('bookingModal').style.display = 'block';
    
    setupDateCalculation(currentRoom.price);
}

function setupDateCalculation(pricePerNight) {
    const checkIn = document.getElementById('bookingCheckInDate');
    const checkOut = document.getElementById('bookingCheckOutDate');
    
    function calculateTotal() {
        if (checkIn.value && checkOut.value) {
            const start = new Date(checkIn.value);
            const end = new Date(checkOut.value);
            const nights = Math.ceil((end - start) / (1000 * 60 * 60 * 24));
            
            if (nights > 0) {
                document.getElementById('bookingPricePerNightDisplay').innerText = pricePerNight;
                document.getElementById('bookingNightsCount').innerText = nights;
                document.getElementById('bookingTotalPriceDisplay').innerText = nights * pricePerNight;
                document.getElementById('bookingPriceBreakdown').style.display = 'block';
            } else {
                document.getElementById('bookingPriceBreakdown').style.display = 'none';
            }
        }
    }
    
    checkIn.onchange = calculateTotal;
    checkOut.onchange = calculateTotal;
}

function closeBookingModal() {
    document.getElementById('bookingModal').style.display = 'none';
}

// Close modals when clicking outside
window.onclick = function(event) {
    if (event.target.classList.contains('modal')) {
        closeRoomModal();
    }
    if (event.target.classList.contains('booking-modal')) {
        document.getElementById('bookingModal').style.display = 'none';
    }
}

// Sidebar Functions
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