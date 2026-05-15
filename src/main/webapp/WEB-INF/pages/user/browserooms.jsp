<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Rooms - Heaven Bliss Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/browserooms.css">
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
		    <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-link">
		        Dashboard
		    </a>
		    <a href="${pageContext.request.contextPath}/user/rooms" class="nav-link active">
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
		    <a href="${pageContext.request.contextPath}/" class="logout-btn">
		        ← Back to Home
		    </a>
		</div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        
        <!-- Header -->
        <div class="welcome-header">
            <div>
                <h1>Browse Our Rooms</h1>
                <p>Find your perfect stay at Heaven Bliss Hotel</p>
            </div>
        </div>
        
        <!-- Search and Filter Section -->
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/user/rooms" method="get" class="filter-form">
                <div class="filter-row">
                    <div class="filter-group">
                        <label>Search</label>
                        <input type="text" name="search" placeholder="Room number, type..." value="${search}">
                    </div>
                    
                    <div class="filter-group">
                        <label>Room Type</label>
                        <select name="roomType">
                            <option value="all">All Types</option>
                            <c:forEach items="${roomTypes}" var="type">
                                <option value="${type}" ${selectedType == type ? 'selected' : ''}>${type}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label>Min Price (NPR)</label>
                        <input type="number" name="minPrice" placeholder="Min" value="${selectedMinPrice}">
                    </div>
                    
                    <div class="filter-group">
                        <label>Max Price (NPR)</label>
                        <input type="number" name="maxPrice" placeholder="Max" value="${selectedMaxPrice}">
                    </div>
                    
                    <div class="filter-group filter-actions">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn-filter">Search</button>
                        <a href="${pageContext.request.contextPath}/user/rooms" class="btn-reset">Reset</a>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Results Count -->
        <div class="results-count">
            Found <strong>${rooms.size()}</strong> rooms available
        </div>
        
        <!-- Rooms Grid -->
        <div class="rooms-container">
            <c:choose>
                <c:when test="${not empty rooms}">
                    <c:forEach items="${rooms}" var="room">
                        <div class="room-card">
						    <div class="room-image" style="background-image: url('${pageContext.request.contextPath}/images/${room.room_type == 'Standard Single' ? 'standard-single/standard-single-bed.jpg' : room.room_type == 'Standard Double' ? 'standard-double/standard-double-bed.jpg' : room.room_type == 'Deluxe Twin' || room.room_type == 'Deluxe Twin (2 Beds)' ? 'deluxe/deluxe-bed.jpg' : room.room_type == 'Family Room' || room.room_type == 'Family Room (2 Beds)' ? 'family/king-size-bed.jpg' : room.room_type == 'Triple Room' || room.room_type == 'Triple Room (3 Beds)' ? 'tripleRoom/triple-room-bed.jpg' : room.room_type == 'VIP Executive' ? 'vipSuite/vip-bed.jpg' : room.room_type == 'Junior Suite' ? 'juniorSuite/junior-suite-bed.jpg' : 'hotel.jpg'}'); background-size: cover; background-position: center; height: 250px;"></div>
						    <div class="room-details">
						        <div class="room-number">Room ${room.room_number}</div>
						        <h3 class="room-title">${room.room_type}</h3>
						        <p class="room-description">${room.description}</p>
						        <div class="room-price">
						            रु ${room.price_per_night} <span>/ night</span>
						        </div>
						        <div class="room-actions">
						            <button onclick="openRoomModal(${room.room_id}, '${room.room_type}', ${room.price_per_night}, '${room.description}', '${room.room_number}')" class="btn-book">
						                View Room →
						            </button>
						        </div>
						    </div>
						</div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <p>No rooms available at the moment.</p>
                        <p>Please check back later or try different search criteria.</p>
                        <a href="${pageContext.request.contextPath}/user/rooms" class="btn-reset">Clear Filters</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
    </div>
</div>

<!-- Room Details Modal -->
<div id="roomModal" class="modal">
    <div class="modal-content">
        <span class="close-modal" onclick="closeRoomModal()">&times;</span>
        <div class="modal-container">
            <div class="modal-slideshow">
                <div class="modal-slideshow-container" id="modalSlidesContainer"></div>
                <div class="modal-dots" id="modalDotsContainer"></div>
            </div>
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
                    <div class="info-item"><span>Max Guests</span><strong id="modalMaxGuests"></strong></div>
                    <div class="info-item"><span>Bed Type</span><strong id="modalBedType"></strong></div>
                    <div class="info-item"><span>Size</span><strong id="modalSize"></strong></div>
                </div>
                <button class="modal-book-btn" onclick="openBookingModal()">Book This Room →</button>
            </div>
        </div>
    </div>
</div>

<!-- Booking Modal - UPDATED WITH FORM ACTION -->
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
                    <label>Check-in Date</label>
                    <input type="date" name="checkInDate" id="bookingCheckInDate" required>
                </div>
                <div class="booking-form-group">
                    <label>Check-out Date</label>
                    <input type="date" name="checkOutDate" id="bookingCheckOutDate" required>
                </div>
                <div class="booking-form-group">
                    <label>Number of Guests</label>
                    <select name="numberOfGuests" id="bookingNumberOfGuests">
                        <option value="1">1 Guest</option>
                        <option value="2">2 Guests</option>
                        <option value="3">3 Guests</option>
                        <option value="4">4 Guests</option>
                    </select>
                </div>
                <div class="booking-form-group">
                    <label>Special Requests (Optional)</label>
                    <textarea name="specialRequests" id="bookingSpecialRequests" rows="2" placeholder="Any special requests?"></textarea>
                </div>
                <div id="bookingPriceBreakdown" style="display: none; background: #f0ebe3; padding: 10px; border-radius: 8px; margin: 12px 0; text-align: center;">
                    <strong>रु <span id="bookingPricePerNightDisplay">0</span></strong> × <span id="bookingNightsCount">0</span> nights = <strong>रु <span id="bookingTotalPriceDisplay">0</span></strong>
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
    function toggleSidebar() {
        var sidebar = document.getElementById('sidebar');
        var hamburger = document.querySelector('.hamburger');
        sidebar.classList.toggle('open');
        
        if (sidebar.classList.contains('open')) {
            hamburger.style.display = 'none';
        } else {
            hamburger.style.display = 'block';
        }
    }
    
    document.addEventListener('click', function(event) {
        var sidebar = document.getElementById('sidebar');
        var hamburger = document.querySelector('.hamburger');
        if (sidebar.classList.contains('open')) {
            if (!sidebar.contains(event.target) && !hamburger.contains(event.target)) {
                sidebar.classList.remove('open');
                hamburger.style.display = 'block';
            }
        }
    });
    
    window.addEventListener('load', function() {
        var sidebar = document.getElementById('sidebar');
        var hamburger = document.querySelector('.hamburger');
        if (!sidebar.classList.contains('open')) {
            hamburger.style.display = 'block';
        }
    });
</script>

<script>
// Room Data
const roomDetailsData = {
    1: { maxGuests: '1 guest', bedType: 'Single Bed', size: '20 sqm', amenities: ['Free Wi-Fi', 'Flat-screen TV', 'Room Service', 'Air Conditioning', 'Mini Bar', 'Private Bathroom', 'City View', 'Work Desk'], images: ['/images/standard-single/standard-single-bed.jpg', '/images/standard-single/standard-single-bathroom.jpg'] },
    2: { maxGuests: '2 guests', bedType: 'Queen Bed', size: '25 sqm', amenities: ['Free Wi-Fi', 'Flat-screen TV', 'Room Service', 'Air Conditioning', 'Mini Bar', 'Private Bathroom', 'City View', 'Seating Area'], images: ['/images/standard-double/standard-double-bed.jpg', '/images/standard-double/standard-double-bathroom.jpg'] },
    3: { maxGuests: '2 guests', bedType: 'Two Single Beds', size: '30 sqm', amenities: ['Free Wi-Fi', 'Flat-screen TV', 'Room Service', 'Air Conditioning', 'Mini Bar', 'Private Bathroom', 'Garden View', 'Work Desk'], images: ['/images/deluxe/deluxe-bed.jpg', '/images/deluxe/deluxe-room-decore.jpg', '/images/deluxe/deluxe-bathroom.jpg'] },
    4: { maxGuests: '4 guests', bedType: 'One king bed and kids bunk bed', size: '45 sqm', amenities: ['Free Wi-Fi', '2 Flat-screen TVs', 'Room Service', 'Air Conditioning', 'Mini Bar', 'Private Bathroom', 'Kid-Friendly', 'Living Area'], images: ['/images/family/king-size-bed.jpg', '/images/family/kids-bunk-bed-room.jpg', '/images/family/family-room-living-room.jpg', '/images/family/family-bathroom.jpg'] },
    5: { maxGuests: '3 guests', bedType: 'Three Single Beds', size: '35 sqm', amenities: ['Free Wi-Fi', 'Flat-screen TV', 'Room Service', 'Air Conditioning', 'Mini Bar', 'Private Bathroom', 'City View'], images: ['/images/tripleRoom/triple-room-bed.jpg', '/images/tripleRoom/triple-room-bathroom.jpg', '/images/tripleRoom/triple-room-living-room.jpg'] },
    6: { maxGuests: '2 guests', bedType: 'King Bed', size: '55 sqm', amenities: ['Free Wi-Fi', 'Smart TV', '24/7 Butler Service', 'Air Conditioning', 'Complimentary Bar', 'Jacuzzi', 'Panoramic View', 'Work Desk'], images: ['/images/vipSuite/vip-bed.jpg', '/images/vipSuite/vip-living-room.jpg', '/images/vipSuite/vip-decor.jpg', '/images/vipSuite/vip-bathroom.jpg', '/images/vipSuite/vip-private-pool.jpg', '/images/vipSuite/vip-dining-table.jpg', '/images/vipSuite/vip-dressing-room.jpg'] },
    7: { maxGuests: '2 guests', bedType: 'King Bed', size: '40 sqm', amenities: ['Free Wi-Fi', 'Flat-screen TV', 'Room Service', 'Air Conditioning', 'Mini Bar', 'Private Bathroom', 'Living Area', 'City View'], images: ['/images/juniorSuite/junior-suite-bed.jpg', '/images/juniorSuite/junior-suite-bathroom.jpg', '/images/juniorSuite/junior-suite-living-room.jpg', '/images/juniorSuite/junior-suite-swing.jpg'] }
};

let currentRoom = null;
let currentSlideIndex = 1;
let slideInterval;

function openRoomModal(roomId, roomType, price, description, roomNumber) {
    const details = roomDetailsData[roomId] || roomDetailsData[3];
    currentRoom = {
        id: roomId,
        title: roomType,
        number: roomNumber,
        price: price,
        description: description,
        maxGuests: details.maxGuests,
        bedType: details.bedType,
        size: details.size,
        amenities: details.amenities,
        images: details.images
    };
    
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
        imgEl.src = '${pageContext.request.contextPath}' + img;
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
            const nights = Math.ceil((new Date(checkOut.value) - new Date(checkIn.value)) / (1000 * 60 * 60 * 24));
            if (nights > 0) {
                document.getElementById('bookingPricePerNightDisplay').innerText = pricePerNight;
                document.getElementById('bookingNightsCount').innerText = nights;
                document.getElementById('bookingTotalPriceDisplay').innerText = nights * pricePerNight;
                document.getElementById('bookingPriceBreakdown').style.display = 'block';
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
</script>

</body>
</html>