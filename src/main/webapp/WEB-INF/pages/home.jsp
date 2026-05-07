<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Heaven Bliss Hotel - Luxury Redefined</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slideshow.css">
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
            <a href="#home">Home</a>
            <a href="#rooms">Rooms</a>
            <a href="#about">About</a>
            <a href="#ratings">Ratings</a>
            <a href="#contact">Contact</a>
        </div>
        <div class="nav-buttons">
            <a href="${pageContext.request.contextPath}/login" class="btn-login">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-register">Register</a>
        </div>
    </div>
</nav>

<!-- Hero Section with Video Background -->
<section id="home" class="hero">
    <!-- Video Background -->
    <video autoplay muted loop playsinline class="hero-video">
        <source src="${pageContext.request.contextPath}/images/home-background.mp4" type="video/mp4">
        <!-- Fallback image if video doesn't load -->
        <img src="${pageContext.request.contextPath}/images/hotel.jpg" alt="Heaven Bliss Hotel">
    </video>
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1 class="hero-title">Experience Hospitality Like Heaven</h1>
        <p class="hero-subtitle">Luxury stays in the heart of the city with world-class amenities</p>
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/login?redirect=browse" class="btn-primary">Book Now →</a>
            <a href="#rooms" class="btn-secondary">Explore Rooms</a>
        </div>
    </div>
</section>

<!-- Featured Rooms Section -->
<section id="rooms" class="rooms">
    <div class="container">
        <h2 class="section-title">Our Popular Rooms</h2>
        <p class="section-subtitle">Experience comfort and luxury in our carefully designed rooms</p>
        
        <div class="rooms-grid">
            <c:forEach items="${featuredRooms}" var="room">
			    <div class="room-card" 
			         data-room-id="${room.room_id}"
			         data-room-number="${room.room_number}"
			         data-room-type="${room.room_type}"
			         data-price="${room.price_per_night}"
			         data-description="${room.description}">
					<div class="room-image">
					    <c:choose>
					        <c:when test="${room.room_type == 'Standard Single'}">
					            <img src="${pageContext.request.contextPath}/images/standard-single/standard-single-bed.jpg" alt="Standard Single Room" class="room-img">
					        </c:when>
					        <c:when test="${room.room_type == 'Standard Double'}">
					            <img src="${pageContext.request.contextPath}/images/standard-double/standard-double-bed.jpg" alt="Standard Double Room" class="room-img">
					        </c:when>
					        <c:when test="${room.room_type == 'Deluxe Twin (2 Beds)'}">
					            <img src="${pageContext.request.contextPath}/images/deluxe/deluxe-bed.jpg" alt="Deluxe Twin Room" class="room-img">
					        </c:when>
					        <c:otherwise>
					            <img src="${pageContext.request.contextPath}/images/hotel.jpg" alt="Room" class="room-img">
					        </c:otherwise>
					    </c:choose>
					</div>
			        <div class="room-content">
			            <h3 class="room-title">${room.room_type}</h3>
			            <div class="room-number">Room ${room.room_number}</div>
			            <p class="room-description">${room.description}</p>
			            <div class="room-price">रु ${room.price_per_night} <span>/ night</span></div>
			            <button class="btn-book view-room-btn" data-room-id="${room.room_id}">View Room →</button>
			        </div>
			    </div>
			</c:forEach>
        </div>
        
        <div class="view-all">
            <a href="${pageContext.request.contextPath}/login" class="btn-view-all">View All Rooms →</a>
        </div>
    </div>
</section>

<!-- Room Details Modal -->
<div id="roomModal" class="modal">
    <div class="modal-content">
        <span class="close-modal">&times;</span>
        
        <div class="modal-container">
            <!-- Left Side: Image Slideshow (dynamic) -->
            <div class="modal-slideshow">
                <div class="modal-slideshow-container" id="modalSlidesContainer">
                    <!-- Slides will be added dynamically by JavaScript -->
                </div>
                <div class="modal-dots" id="modalDotsContainer">
                    <!-- Dots will be added dynamically by JavaScript -->
                </div>
            </div>
            
            <!-- Right Side: Room Details -->
            <div class="modal-details">
                <h2 id="modalRoomTitle">Deluxe Executive Suite</h2>
                <div class="modal-room-number" id="modalRoomNumber">Room 101</div>
                <div class="modal-price" id="modalPrice">रु 9,000 <span>/per night</span></div>
                <p class="modal-description" id="modalDescription">Spacious executive suite with city view, comfortable king bed, separate living area, and modern amenities.</p>
                
                <div class="modal-amenities">
                    <h4>Amenities</h4>
                    <div class="amenities-list">
                        <span>✓ Free Wi-Fi</span>
                        <span>✓ Air Conditioning</span>
                        <span>✓ Flat-screen TV</span>
                        <span>✓ Mini Bar</span>
                        <span>✓ Room Service</span>
                        <span>✓ Private Bathroom</span>
                    </div>
                </div>
                
                <div class="modal-booking-info">
                    <div class="info-item">
                        <span>Max Guests:</span>
                        <strong id="modalMaxGuests">2</strong>
                    </div>
                    <div class="info-item">
                        <span>Bed Type:</span>
                        <strong id="modalBedType">King Bed</strong>
                    </div>
                    <div class="info-item">
                        <span>Size:</span>
                        <strong id="modalSize">35 sqm</strong>
                    </div>
                </div>
                
                <button class="modal-book-btn" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">
                    Book This Room →
                </button>
            </div>
        </div>
    </div>
</div>

<!-- About Section with Slideshow -->
<section id="about" class="about">
    <div class="container">
        <div class="about-content">
            <div class="about-text">
                <h2 class="section-title">About Heaven Bliss</h2>
                <p>Established in 2025, Heaven Bliss Hotel is where comfort, elegance, and exceptional service come together to create a memorable stay. Designed for both business and leisure travelers, our hotel offers a perfect blend of modern luxury and a warm, welcoming atmosphere.</p>
                <p>Conveniently located near key attractions and city hubs, we provide easy access while still offering a peaceful and relaxing environment. Each room is thoughtfully designed with stylish interiors and modern amenities to ensure maximum comfort.</p>
                <p>At Heaven Bliss Hotel, we focus on delivering a personalized experience for every guest. From attentive service to carefully curated facilities like fine dining, wellness, and leisure options, every detail is crafted to enhance your stay. Our goal is to provide not just accommodation, but an experience filled with comfort, care, and lasting memories.</p>
                <div class="about-features">
                    <div class="feature">✓ Free Wi-Fi</div>
                    <div class="feature">✓ Parking</div>
                    <div class="feature">✓ Tour Package</div>
                    <div class="feature">✓ Spa & Wellness</div>
                    <div class="feature">✓ Fine Dining</div>
                    <div class="feature">✓ Swimming Pool</div>
                    <div class="feature">✓ Gym Access</div>
                    <div class="feature">✓ Airport Pickup</div>
                </div>
            </div>
            
            <!-- Image Slideshow -->
			<div class="slideshow-container">
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel.jpg" alt="Heaven Bliss Hotel">
			        <div class="slide-caption">Heaven Bliss Hotel Exterior</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/back-hotel.jpg" alt="Back View">
			        <div class="slide-caption">Hotel Back View</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-Lobby.jpg" alt="Hotel Lobby">
			        <div class="slide-caption">Elegant Hotel Lobby</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-lobby-door.jpg" alt="Hotel Entrance">
			        <div class="slide-caption">Grand Hotel Entrance</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-counter-area.jpg" alt="Reception Counter">
			        <div class="slide-caption">Welcome Reception</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-coredoor.jpg" alt="Hotel Corridor">
			        <div class="slide-caption">Luxury Corridor</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-lift.jpg" alt="Hotel Lift">
			        <div class="slide-caption">Modern Elevators</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-indoor-swmming.jpg" alt="Indoor Pool">
			        <div class="slide-caption">Indoor Swimming Pool</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-outdoor-swmmingpool-view.jpg" alt="Outdoor Pool">
			        <div class="slide-caption">Outdoor Pool with View</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-spa.jpg" alt="Spa">
			        <div class="slide-caption">Relaxing Spa</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-sauna-room.jpg" alt="Sauna">
			        <div class="slide-caption">Sauna Room</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-gym.jpg" alt="Gym">
			        <div class="slide-caption">Fully Equipped Gym</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-food-area.jpg" alt="Restaurant">
			        <div class="slide-caption">Fine Dining Restaurant</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-event-hall.jpg" alt="Event Hall">
			        <div class="slide-caption">Grand Event Hall</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-movie-room.jpg" alt="Movie Room">
			        <div class="slide-caption">Private Movie Theater</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-parking.jpg" alt="Parking">
			        <div class="slide-caption">Ample Parking Space</div>
			    </div>
			    <div class="slide fade">
			        <img src="${pageContext.request.contextPath}/images/hotel-wahsroom.jpg" alt="Washroom">
			        <div class="slide-caption">Luxury Washrooms</div>
			    </div>

			    
			    <!-- Navigation Buttons -->
			    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
			    <a class="next" onclick="plusSlides(1)">&#10095;</a>
			</div>
			
			<!-- Dots -->
			<div class="dots-container">
			    <span class="dot" onclick="currentSlide(1)"></span>
			    <span class="dot" onclick="currentSlide(2)"></span>
			    <span class="dot" onclick="currentSlide(3)"></span>
			    <span class="dot" onclick="currentSlide(4)"></span>
			    <span class="dot" onclick="currentSlide(5)"></span>
			    <span class="dot" onclick="currentSlide(6)"></span>
			    <span class="dot" onclick="currentSlide(7)"></span>
			    <span class="dot" onclick="currentSlide(8)"></span>
			    <span class="dot" onclick="currentSlide(9)"></span>
			    <span class="dot" onclick="currentSlide(10)"></span>
			    <span class="dot" onclick="currentSlide(11)"></span>
			    <span class="dot" onclick="currentSlide(12)"></span>
			    <span class="dot" onclick="currentSlide(13)"></span>
			    <span class="dot" onclick="currentSlide(14)"></span>
			    <span class="dot" onclick="currentSlide(15)"></span>
			    <span class="dot" onclick="currentSlide(16)"></span>
			    <span class="dot" onclick="currentSlide(17)"></span>
			</div>
        </div>
    </div>
</section>

<!-- Ratings Section -->
<section id="ratings" class="ratings">
    <div class="container">
        <h2 class="section-title">Guest Ratings</h2>
        <p class="section-subtitle">What our guests say about us</p>
        
        <div class="ratings-grid">
            <div class="rating-card">
                <div class="rating-profile">
                    <img src="${pageContext.request.contextPath}/images/profile1.jpg" alt="Prapti Bhattrai" class="profile-img">
                </div>
                <div class="rating-author">Prapti Bhattrai</div>
                <div class="rating-stars">★★★★★</div>
                <p class="rating-text">"Amazing stay! The staff was incredibly helpful and the room was spotless. Will definitely come back!"</p>
            </div>
            
            <div class="rating-card">
                <div class="rating-profile">
                    <img src="${pageContext.request.contextPath}/images/rabin-profile.jpeg" alt="Rabin Bam" class="profile-img">
                </div>
                <div class="rating-author">Rabin Bam</div>
                <div class="rating-stars">★★★★★</div>
                <p class="rating-text">"Best hotel in the city! The view from my room was breathtaking. Highly recommended!"</p>
            </div>
            
            <div class="rating-card">
                <div class="rating-profile">
                    <img src="${pageContext.request.contextPath}/images/shristi-profile.jpeg" alt="Shristi Adhikari" class="profile-img">
                </div>
                <div class="rating-author">Shristi Adhikari</div>
                <div class="rating-stars">★★★★★</div>
                <p class="rating-text">"Wonderful experience from check-in to check-out. The breakfast buffet was amazing!"</p>
            </div>
        </div>
    </div>
</section>

<!-- Contact Section -->
<section id="contact" class="contact">
    <div class="container">
        <h2 class="section-title">Contact Us</h2>
        <p class="section-subtitle">We'd love to hear from you</p>
        
        <div class="contact-grid">
            <div class="contact-info">
                <div class="contact-item">
                    <div class="contact-icon">📍</div>
                    <div class="contact-detail">
                        <h4>Address</h4>
                        <p>Kathmandu, Nepal</p>
                    </div>
                </div>
                <div class="contact-item">
                    <div class="contact-icon">📞</div>
                    <div class="contact-detail">
                        <h4>Phone</h4>
                        <p>+977 9800000000</p>
                    </div>
                </div>
                <div class="contact-item">
                    <div class="contact-icon">✉️</div>
                    <div class="contact-detail">
                        <h4>Email</h4>
                        <p>info@heavenbliss.com</p>
                    </div>
                </div>
                <div class="contact-item">
                    <div class="contact-icon">🌐</div>
                    <div class="contact-detail">
                        <h4>Website</h4>
                        <p>www.heavenbliss.com</p>
                    </div>
                </div>
                
                <!-- Option 5: Working Hours -->
                <div class="contact-item">
                    <div class="contact-icon">⏰</div>
                    <div class="contact-detail">
                        <h4>Working Hours</h4>
                        <p>24/7 - Always Open</p>
                        <span class="working-hours-badge">Available Now</span>
                    </div>
                </div>
            </div>
            
            <div class="contact-form">
                <form action="#" method="post">
                    <input type="text" placeholder="Your Name" required>
                    <input type="email" placeholder="Your Email" required>
                    <input type="text" placeholder="Subject">
                    <textarea rows="4" placeholder="Your Message"></textarea>
                    <button type="submit" class="btn-send">Send Message →</button>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-about">
            <h3>Heaven Bliss Hotel</h3>
            <p>Welcome to Heaven Bliss Hotel, relax in comfort and enjoy exceptional hospitality. Discover spaces designed for peace and let every moment here feel truly special.</p>
        </div>
        <div class="footer-links">
            <h4>Quick Links</h4>
            <a href="#home">Home</a>
            <a href="#rooms">Rooms</a>
            <a href="#about">About</a>
            <a href="#ratings">Ratings</a>
            <a href="#contact">Contact</a>
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
        <p>&copy; 2024 Heaven Bliss Hotel. All rights reserved. Hand-crafted excellence since 2024.</p>
    </div>
</footer>

<!-- Slideshow JavaScript -->
<script>
    let slideIndex = 1;
    let slideInterval;
    
    // Start slideshow
    function startSlideshow() {
        slideInterval = setInterval(function() {
            plusSlides(1);
        }, 4000);
    }
    
    // Stop slideshow
    function stopSlideshow() {
        clearInterval(slideInterval);
    }
    
    // Show slides
    function showSlides(n) {
        let i;
        let slides = document.getElementsByClassName("slide");
        let dots = document.getElementsByClassName("dot");
        
        if (n > slides.length) { slideIndex = 1; }
        if (n < 1) { slideIndex = slides.length; }
        
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        
        slides[slideIndex - 1].style.display = "block";
        if (dots[slideIndex - 1]) {
            dots[slideIndex - 1].className += " active";
        }
    }
    
    // Next/Previous controls
    function plusSlides(n) {
        showSlides(slideIndex += n);
        stopSlideshow();
        startSlideshow();
    }
    
    // Dot controls
    function currentSlide(n) {
        showSlides(slideIndex = n);
        stopSlideshow();
        startSlideshow();
    }
    
    // Start slideshow when page loads
    window.onload = function() {
        showSlides(slideIndex);
        startSlideshow();
    };
</script>

<!-- Modal JavaScript -->
<script>
    // Room data with REAL IMAGE PATHS
    const roomDetails = {
        1: {
            title: "Standard Single",
            number: "101",
            price: 2500,
            description: "Cozy single room perfect for solo travelers. Features a comfortable single bed, work desk, and city view. Ensuite bathroom with premium toiletries.",
            maxGuests: 1,
            bedType: "Single Bed",
            size: "20 sqm",
            images: ["/images/standard-single/standard-single-bed.jpg", "/images/standard-single/standard-single-bathroom.jpg"]
        },
        2: {
            title: "Standard Double",
            number: "102",
            price: 3500,
            description: "Comfortable double room ideal for couples. Features a queen bed, seating area, modern amenities, and private bathroom.",
            maxGuests: 2,
            bedType: "Queen Bed",
            size: "25 sqm",
            images: ["/images/standard-double/standard-double-bed.jpg", "/images/standard-double/standard-double-bathroom.jpg"]
        },
        3: {
            title: "Deluxe Twin (2 Beds)",
            number: "103",
            price: 4500,
            description: "Perfect for friends or colleagues. Features two single beds, separate work areas, garden view, luxury bathroom, and elegant decor.",
            maxGuests: 2,
            bedType: "Two Single Beds",
            size: "30 sqm",
            images: ["/images/deluxe/deluxe-bed.jpg", "/images/deluxe/deluxe-bathroom.jpg", "/images/deluxe/deluxe-room-decore.jpg"]
        }
    };
    
    // Get modal elements
    const modal = document.getElementById('roomModal');
    const closeModal = document.querySelector('.close-modal');
    const modalSlidesContainer = document.getElementById('modalSlidesContainer');
    const modalDotsContainer = document.getElementById('modalDotsContainer');
    
    let currentModalSlide = 1;
    let modalSlideInterval;
    let currentRoomImages = [];
    
    // Open modal when View Room button is clicked
    document.querySelectorAll('.view-room-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            
            const roomId = this.getAttribute('data-room-id');
            const room = roomDetails[roomId];
            
            if (room) {
                // Set room details
                document.getElementById('modalRoomTitle').innerText = room.title;
                document.getElementById('modalRoomNumber').innerText = 'Room ' + room.number;
                document.getElementById('modalPrice').innerHTML = 'रु ' + room.price + ' <span>/ per night</span>';
                document.getElementById('modalDescription').innerText = room.description;
                document.getElementById('modalMaxGuests').innerText = room.maxGuests;
                document.getElementById('modalBedType').innerText = room.bedType;
                document.getElementById('modalSize').innerText = room.size;
                
                // Store current room images
                currentRoomImages = room.images;
                
                // Clear and rebuild slides
                modalSlidesContainer.innerHTML = '';
                modalDotsContainer.innerHTML = '';
                
                // Create slides and dots
                room.images.forEach((img, index) => {
                    // Create slide
                    const slide = document.createElement('div');
                    slide.className = 'modal-slide fade';
                    const imgElement = document.createElement('img');
                    imgElement.src = '${pageContext.request.contextPath}' + img;
                    imgElement.alt = room.title + ' image ' + (index + 1);
                    imgElement.style.width = '100%';
                    imgElement.style.height = '350px';
                    imgElement.style.objectFit = 'cover';
                    slide.appendChild(imgElement);
                    modalSlidesContainer.appendChild(slide);
                    
                    // Create dot
                    const dot = document.createElement('span');
                    dot.className = 'modal-dot';
                    dot.onclick = (function(idx) {
                        return function() { currentModalSlide(idx + 1); showModalSlide(currentModalSlide); resetModalSlideshowTimer(); };
                    })(index);
                    modalDotsContainer.appendChild(dot);
                });
                
                // Add navigation buttons
                const prevBtn = document.createElement('a');
                prevBtn.className = 'modal-prev';
                prevBtn.innerHTML = '&#10094;';
                prevBtn.onclick = function() { changeModalSlide(-1); };
                const nextBtn = document.createElement('a');
                nextBtn.className = 'modal-next';
                nextBtn.innerHTML = '&#10095;';
                nextBtn.onclick = function() { changeModalSlide(1); };
                modalSlidesContainer.appendChild(prevBtn);
                modalSlidesContainer.appendChild(nextBtn);
                
                currentModalSlide = 1;
                showModalSlide(1);
                modal.style.display = 'block';
                startModalSlideshow();
            }
        });
    });
    
    // Close modal
    if (closeModal) {
        closeModal.onclick = function() {
            modal.style.display = 'none';
            stopModalSlideshow();
        }
    }
    
    // Close modal when clicking outside
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = 'none';
            stopModalSlideshow();
        }
    }
    
    // Modal slideshow functions
    function showModalSlide(n) {
        let slides = document.getElementsByClassName("modal-slide");
        let dots = document.getElementsByClassName("modal-dot");
        
        if (!slides.length) return;
        
        if (n > slides.length) { currentModalSlide = 1; }
        if (n < 1) { currentModalSlide = slides.length; }
        
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        for (let i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        
        if (slides[currentModalSlide - 1]) {
            slides[currentModalSlide - 1].style.display = "block";
        }
        if (dots[currentModalSlide - 1]) {
            dots[currentModalSlide - 1].className += " active";
        }
    }
    
    function changeModalSlide(n) {
        showModalSlide(currentModalSlide += n);
        resetModalSlideshowTimer();
    }
    
    function startModalSlideshow() {
        if (modalSlideInterval) clearInterval(modalSlideInterval);
        modalSlideInterval = setInterval(function() {
            changeModalSlide(1);
        }, 4000);
    }
    
    function stopModalSlideshow() {
        if (modalSlideInterval) {
            clearInterval(modalSlideInterval);
            modalSlideInterval = null;
        }
    }
    
    function resetModalSlideshowTimer() {
        stopModalSlideshow();
        startModalSlideshow();
    }
</script>
</body>
</html>