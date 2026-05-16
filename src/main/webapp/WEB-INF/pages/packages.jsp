<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Packages - Heaven Bliss Hotel</title>
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
            <a href="${pageContext.request.contextPath}/activities">Activities</a>
            <a href="${pageContext.request.contextPath}/packages" class="active">Packages</a>
            <a href="${pageContext.request.contextPath}/#about">About</a>
            <a href="${pageContext.request.contextPath}/#ratings">Ratings</a>
            <a href="${pageContext.request.contextPath}/#contact">Contact</a>
        </div>
        <div class="nav-buttons">
		    <!-- Show Login/Register when NOT logged in -->
		    <c:choose>
		        <c:when test="${empty sessionScope.user}">
		            <a href="${pageContext.request.contextPath}/login" class="btn-login">Login</a>
		            <a href="${pageContext.request.contextPath}/register" class="btn-register">Register</a>
		        </c:when>
		        <c:otherwise>
		            <!-- Show Dashboard and Logout when logged in -->
		            <a href="${pageContext.request.contextPath}/user/dashboard" class="btn-dashboard">My Account</a>
		            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
		        </c:otherwise>
		    </c:choose>
		</div>
    </div>
</nav>

<!-- Packages Hero Section -->
<div class="packages-hero">
    <h1>Special Offer Packages</h1>
    <p>Exclusive deals for unforgettable experiences</p>
</div>

<!-- Packages Container -->
<div class="packages-container">
    <div class="packages-grid">
        
        <!-- Package 1: Romantic Getaway -->
        <div class="package-card" data-package-id="1">
            <div class="package-image">
                <img src="${pageContext.request.contextPath}/images/packages/romantic-boating.jpg" alt="Romantic Getaway">
                <div class="discount-badge">15% OFF</div>
            </div>
            <div class="package-info">
                <h3 class="package-title">Romantic Package</h3>
                <p class="package-desc">Perfect for couples. Includes Deluxe Room, Spa Treatment, and Candlelight Dinner.</p>
                <div class="package-price">
                    <span class="original-price">रु 15000</span>
                    <span class="discounted-price">रु 12750 <span>/ package</span></span>
                </div>
                <button class="btn-book-package view-details-btn" data-package-id="1">View Details →</button>
            </div>
        </div>
        
        <!-- Package 2: Wellness Retreat -->
        <div class="package-card" data-package-id="2">
            <div class="package-image">
                <img src="${pageContext.request.contextPath}/images/activities/spa.jpg" alt="Wellness Retreat">
                <div class="discount-badge">20% OFF</div>
            </div>
            <div class="package-info">
                <h3 class="package-title">Wellness Retreat Package</h3>
                <p class="package-desc">Relax your body and mind. Includes Spa, Sauna, Yoga session, and Healthy meals.</p>
                <div class="package-price">
                    <span class="original-price">रु 12000</span>
                    <span class="discounted-price">रु 9600 <span>/ package</span></span>
                </div>
                <button class="btn-book-package view-details-btn" data-package-id="2">View Details →</button>
            </div>
        </div>
        
        <!-- Package 3: Adventure Package -->
        <div class="package-card" data-package-id="3">
            <div class="package-image">
                <img src="${pageContext.request.contextPath}/images/packages/rafting.jpg" alt="Adventure Package">
                <div class="discount-badge">10% OFF</div>
            </div>
            <div class="package-info">
                <h3 class="package-title">Adventure Package</h3>
                <p class="package-desc">For thrill-seekers. Includes Mountain Hiking, Rafting, and Sightseeing Tour.</p>
                <div class="package-price">
                    <span class="original-price">रु 18000</span>
                    <span class="discounted-price">रु 16200 <span>/ package</span></span>
                </div>
                <button class="btn-book-package view-details-btn" data-package-id="3">View Details →</button>
            </div>
        </div>
        
        <!-- Package 4: Family Fun Pack -->
        <div class="package-card" data-package-id="4">
            <div class="package-image">
                <img src="${pageContext.request.contextPath}/images/activities/dreamy-movie-room.jpg" alt="Family Fun Pack">
                <div class="discount-badge">25% OFF</div>
            </div>
            <div class="package-info">
                <h3 class="package-title">Family Fun Package</h3>
                <p class="package-desc">Fun for whole family. Includes Family Room, Movie Room access, Indoor Pool, and Kids meals.</p>
                <div class="package-price">
                    <span class="original-price">रु 20000</span>
                    <span class="discounted-price">रु 15000 <span>/ package</span></span>
                </div>
                <button class="btn-book-package view-details-btn" data-package-id="4">View Details →</button>
            </div>
        </div>
        
        <!-- Package 5: Spa & Relaxation -->
        <div class="package-card" data-package-id="5">
            <div class="package-image">
                <img src="${pageContext.request.contextPath}/images/activities/jacuzee.jpg" alt="Spa & Relaxation">
                <div class="discount-badge">10% OFF</div>
            </div>
            <div class="package-info">
                <h3 class="package-title">Spa & Relaxation Package</h3>
                <p class="package-desc">Complete pampering experience. Includes Spa, Jacuzzi, Massage, and Sauna.</p>
                <div class="package-price">
                    <span class="original-price">रु 10000</span>
                    <span class="discounted-price">रु 9000 <span>/ package</span></span>
                </div>
                <button class="btn-book-package view-details-btn" data-package-id="5">View Details →</button>
            </div>
        </div>
        
    </div>
</div>

<!-- Package Details Modal -->
<div id="packageModal" class="modal">
    <div class="modal-content">
        <span class="close-modal">&times;</span>
        
        <div class="modal-container">
            <!-- Left Side: Image Slideshow -->
            <div class="modal-slideshow">
                <div class="modal-slideshow-container" id="packageModalSlides">
                    <!-- Slides will be added dynamically -->
                </div>
                <div class="modal-dots" id="packageModalDots">
                    <!-- Dots will be added dynamically -->
                </div>
            </div>
            
            <!-- Right Side: Package Details -->
            <div class="modal-details">
                <h2 id="packageModalTitle">Romantic Package</h2>
                <div class="modal-price" id="packageModalPrice">रु 12,750 <span>/ package</span></div>
                <p class="modal-description" id="packageModalDesc">Perfect for couples. Includes Deluxe Room, Spa Treatment, and Candlelight Dinner.</p>
                
                <div class="modal-includes">
                    <h4>Package Includes</h4>
                    <ul id="packageModalIncludes">
                        <li>Deluxe Room Accommodation</li>
                        <li>Spa Treatment</li>
                        <li>Candlelight Dinner</li>
                        <li>Breakfast Included</li>
                        <li>Free Wi-Fi</li>
                    </ul>
                </div>
                
                <div class="modal-booking-info">
                    <div class="info-item">
                        <span>Duration:</span>
                        <strong id="packageModalDuration">2 Nights / 3 Days</strong>
                    </div>
                    <div class="info-item">
                        <span>Valid Until:</span>
                        <strong id="packageModalValid">December 31, 2025</strong>
                    </div>
                </div>
                
                <button class="modal-book-btn" onclick="showPackageBookingAlert('${packageModalTitle}', '${packageModalPrice}')">
				    Book This Package →
				</button>
                <div class="booking-note">
                    Advance payment required. Terms and conditions apply.
                </div>
            </div>
        </div>
    </div>
</div>

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

<!-- Modal JavaScript -->
<script>
    // Package details data
    const packageDetails = {
        1: {
            title: "Romantic Package",
            price: "रु 12,750",
            description: "Perfect for couples. Includes Deluxe Room, Spa Treatment, and Candlelight Dinner.",
            duration: "2 Nights / 3 Days",
            validUntil: "June 31, 2026",
            includes: [
                "Deluxe Room Accommodation",
                "Spa Treatment for Two",
                "Candlelight Dinner",
                "Breakfast Included",
                "Free Wi-Fi",
                "Airport Transfer"
            ],
            images: ["/images/deluxe/deluxe-bed.jpg","/images/packages/romantic-boating.jpg","/images/packages/candle-dinner.jpg", "/images/activities/spa.jpg","/images/activities/jacuzee.jpg"]
        },
        2: {
            title: "Wellness Retreat Package",
            price: "रु 9,600",
            description: "Relax your body and mind. Includes Spa, Sauna, Yoga session, and Healthy meals.",
            duration: "2 Nights / 3 Days",
            validUntil: "June 31, 2026",
            includes: [
                "Standard Room Accommodation",
                "Spa Treatment",
                "Sauna Access",
                "Daily Yoga Session",
                "Healthy Meals",
                "Free Wi-Fi"
            ],
            images: ["/images/activities/spa.jpg", "/images/activities/sauna-room.jpg", "/images/activities/gym.jpg","/images/packages/relax-gathering.jpg","/images/packages/healthy-food.jpg","/images/packages/yoga.jpg"]
        },
        3: {
            title: "Adventure Package",
            price: "रु 16,200",
            description: "For thrill-seekers. Includes Mountain Hiking, Rafting, and Sightseeing Tour.",
            duration: "3 Nights / 4 Days",
            validUntil: "June 31, 2026",
            includes: [
                "Standard Room Accommodation",
                "Mountain Hiking Trip",
                "River Rafting",
                "Sightseeing Tour",
                "All Meals",
                "Travel Insurance"
            ],
            images: ["/images/packages/rafting.jpg", "/images/activities/outdoor-swmmingpool-view.jpg", "/images/packages/romantic-boating.jpg", "/images/packages/bungee.jpg","/images/packages/diving-closer.jpg", "/images/packages/diving.jpg", "/images/packages/jet.jpg", "/images/packages/jungle-ride.jpg", "/images/packages/Parasailing.jpg", "/images/packages/Trekking.jpg"]
        },
        4: {
            title: "Family Fun Package",
            price: "रु 15,000",
            description: "Fun for whole family. Includes Family Room, Movie Room access, Indoor Pool, and Kids meals.",
            duration: "3 Nights / 4 Days",
            validUntil: "June 31, 2026",
            includes: [
                "Family Room Accommodation",
                "Movie Room Access",
                "Indoor Pool Access",
                "Kids Meals",
                "Free Wi-Fi",
                "Parking"
            ],
            images: ["/images/family/king-size-bed.jpg","/images/family/kids-bunk-bed-room.jpg","/images/activities/dreamy-movie-room.jpg", "/images/activities/indoor-swmming.jpg", "/images/activities/food-area.jpg", "/images/packages/diving-closer.jpg", "/images/packages/romantic-boating.jpg"]
        },
        5: {
            title: "Spa & Relaxation Package",
            price: "रु 9,000",
            description: "Complete pampering experience. Includes Spa, Jacuzzi, Massage, and Sauna.",
            duration: "2 Nights / 3 Days",
            validUntil: "June 31, 2026",
            includes: [
                "Deluxe Room Accommodation",
                "Spa Treatment",
                "Jacuzzi Access",
                "Massage Therapy",
                "Sauna Access",
                "Free Wi-Fi"
            ],
            images: ["/images/activities/jacuzee.jpg", "/images/activities/massage-room.jpg", "/images/activities/sauna-room.jpg", "/images/activities/spa.jpg"]
        }
    };
    
    // Get modal elements
    const modal = document.getElementById('packageModal');
    const closeModal = document.querySelector('.close-modal');
    const modalSlidesContainer = document.getElementById('packageModalSlides');
    const modalDotsContainer = document.getElementById('packageModalDots');
    
    let currentSlide = 1;
    let slideInterval;
    let currentImages = [];
    
    // Open modal when View Details button is clicked
    document.querySelectorAll('.view-details-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            
            const packageId = this.getAttribute('data-package-id');
            const pkg = packageDetails[packageId];
            
            if (pkg) {
                // Set package details
                document.getElementById('packageModalTitle').innerText = pkg.title;
                document.getElementById('packageModalPrice').innerHTML = pkg.price + ' <span>/ package</span>';
                document.getElementById('packageModalDesc').innerText = pkg.description;
                document.getElementById('packageModalDuration').innerText = pkg.duration;
                document.getElementById('packageModalValid').innerText = pkg.validUntil;
                
                // Set includes list
                const includesList = document.getElementById('packageModalIncludes');
                includesList.innerHTML = '';
                pkg.includes.forEach(item => {
                    const li = document.createElement('li');
                    li.innerHTML = '✓ ' + item;
                    includesList.appendChild(li);
                });
                
                // Set images for slideshow
                currentImages = pkg.images;
                
                // Clear and rebuild slides
                modalSlidesContainer.innerHTML = '';
                modalDotsContainer.innerHTML = '';
                
                pkg.images.forEach((img, index) => {
                    // Create slide
                    const slide = document.createElement('div');
                    slide.className = 'modal-slide fade';
                    const imgElement = document.createElement('img');
                    imgElement.src = '${pageContext.request.contextPath}' + img;
                    imgElement.alt = pkg.title + ' image ' + (index + 1);
                    imgElement.style.width = '100%';
                    imgElement.style.height = '350px';
                    imgElement.style.objectFit = 'cover';
                    slide.appendChild(imgElement);
                    modalSlidesContainer.appendChild(slide);
                    
                    // Create dot
                    const dot = document.createElement('span');
                    dot.className = 'modal-dot';
                    dot.onclick = (function(idx) {
                        return function() { currentSlide = idx + 1; showSlide(currentSlide); resetTimer(); };
                    })(index);
                    modalDotsContainer.appendChild(dot);
                });
                
                // Add navigation buttons
                const prevBtn = document.createElement('a');
                prevBtn.className = 'modal-prev';
                prevBtn.innerHTML = '&#10094;';
                prevBtn.onclick = function() { changeSlide(-1); };
                const nextBtn = document.createElement('a');
                nextBtn.className = 'modal-next';
                nextBtn.innerHTML = '&#10095;';
                nextBtn.onclick = function() { changeSlide(1); };
                modalSlidesContainer.appendChild(prevBtn);
                modalSlidesContainer.appendChild(nextBtn);
                
                currentSlide = 1;
                showSlide(1);
                modal.style.display = 'block';
                startSlideshow();
            }
        });
    });
    
    // Close modal
    if (closeModal) {
        closeModal.onclick = function() {
            modal.style.display = 'none';
            stopSlideshow();
        }
    }
    
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = 'none';
            stopSlideshow();
        }
    }
    
    // Slideshow functions
    function showSlide(n) {
        let slides = document.getElementsByClassName("modal-slide");
        let dots = document.getElementsByClassName("modal-dot");
        
        if (!slides.length) return;
        
        if (n > slides.length) { currentSlide = 1; }
        if (n < 1) { currentSlide = slides.length; }
        
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        for (let i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        
        if (slides[currentSlide - 1]) {
            slides[currentSlide - 1].style.display = "block";
        }
        if (dots[currentSlide - 1]) {
            dots[currentSlide - 1].className += " active";
        }
    }
    
    function changeSlide(n) {
        showSlide(currentSlide += n);
        resetTimer();
    }
    
    function startSlideshow() {
        if (slideInterval) clearInterval(slideInterval);
        slideInterval = setInterval(function() {
            changeSlide(1);
        }, 4000);
    }
    
    function stopSlideshow() {
        if (slideInterval) {
            clearInterval(slideInterval);
            slideInterval = null;
        }
    }
    
    function resetTimer() {
        stopSlideshow();
        startSlideshow();
    }
    
    function showPackageBookingAlert(packageName, packagePrice) {
        const modalHtml = `
            <div id="packageContactModal" class="booking-modal" style="display: block;">
                <div class="booking-modal-content" style="max-width: 400px; text-align: center;">
                    <div class="booking-modal-header">
                        <h3>Package Booking</h3>
                        <span class="close-booking-modal" onclick="closePackageContactModal()">&times;</span>
                    </div>
                    <div class="booking-modal-body">
                        <div style="margin: 15px 0;">
                            <h4>${packageName}</h4>
                            <p style="font-size: 18px; color: #c9a84c; margin: 10px 0;">${packagePrice}</p>
                            <p style="margin: 10px 0; color: #555;">For package bookings, please contact our reservation team:</p>
                            <div style="background: #f0ebe3; padding: 15px; border-radius: 8px; margin: 15px 0;">
                                <p><strong>Phone:</strong> +977 9800000000</p>
                                <p><strong>Email:</strong> reservations@heavenbliss.com</p>
                            </div>
                            <p style="font-size: 12px; color: #888;">Our team will help you customize your package and confirm availability.</p>
                        </div>
                    </div>
                    <div class="booking-modal-footer" style="justify-content: center;">
                        <button class="btn-confirm-booking" onclick="closePackageContactModal()">Close</button>
                    </div>
                </div>
            </div>
        `;
        
        const existingModal = document.getElementById('packageContactModal');
        if (existingModal) {
            existingModal.remove();
        }
        
        document.body.insertAdjacentHTML('beforeend', modalHtml);
        
        window.onclick = function(event) {
            const modal = document.getElementById('packageContactModal');
            if (event.target === modal) {
                closePackageContactModal();
            }
        }
    }

    function closePackageContactModal() {
        const modal = document.getElementById('packageContactModal');
        if (modal) {
            modal.remove();
        }
    }
</script>

</body>
</html>