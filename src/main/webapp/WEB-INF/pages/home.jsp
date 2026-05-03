<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Heaven Bliss Hotel - Luxury Redefined</title>
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

<!-- Hero Section -->
<section id="home" class="hero">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1 class="hero-title">Experience Hospitality Like Heaven</h1>
        <p class="hero-subtitle">Luxury stays in the heart of the city with world-class amenities</p>
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/login" class="btn-primary">Book Now →</a>
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
                <div class="room-card">
                    <div class="room-image">🛏️</div>
                    <div class="room-content">
                        <h3 class="room-title">${room.room_type}</h3>
                        <div class="room-number">Room ${room.room_number}</div>
                        <p class="room-description">${room.description}</p>
                        <div class="room-price">रु ${room.price_per_night} <span>/ night</span></div>
                        <a href="${pageContext.request.contextPath}/login" class="btn-book">View Room →</a>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <div class="view-all">
            <a href="${pageContext.request.contextPath}/login" class="btn-view-all">View All Rooms →</a>
        </div>
    </div>
</section>

<!-- About Section -->
<section id="about" class="about">
    <div class="container">
        <div class="about-content">
            <div class="about-text">
                <h2 class="section-title">About Heaven Bliss</h2>
                <p>Established in 2025, Heaven Bliss Hotel is where comfort, elegance, and exceptional service come together to create a memorable stay. Designed for both business and leisure travelers, our hotel offers a perfect blend of modern luxury and a warm, welcoming atmosphere. Conveniently located near key attractions and city hubs, we provide easy access while still offering a peaceful and relaxing environment. Each room is thoughtfully designed with stylish interiors and modern amenities to ensure maximum comfort.</p>
                <p>At Heaven Bliss Hotel, we focus on delivering a personalized experience for every guest. From attentive service to carefully curated facilities like fine dining, wellness, and leisure options, every detail is crafted to enhance your stay. Our goal is to provide not just accommodation, but an experience filled with comfort, care, and lasting memories.</p>
                <div class="about-features">
                    <div class="feature">✓ Free Wi-Fi</div>
                    <div class="feature">✓ Parking</div>
                    <div class="feature">✓ Tour package</div>
                    <div class="feature">✓ Spa & Wellness</div>
                    <div class="feature">✓ Fine Dining</div>
                    <div class="feature">✓ Swimming Pool</div>
                    <div class="feature">✓ Gym Access</div>
                    <div class="feature">✓ Airport Pickup</div>
                </div>
            </div>
            <div class="about-image">
                <div class="about-icon">🏨</div>
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
                <div class="rating-stars">★★★★★</div>
                <p class="rating-text">"Amazing stay! The staff was incredibly helpful and the room was spotless. Will definitely come back!"</p>
                <div class="rating-author">- Prapti Bhattrai</div>
            </div>
            <div class="rating-card">
                <div class="rating-stars">★★★★★</div>
                <p class="rating-text">"Best hotel in the city! The view from my room was breathtaking. Highly recommended!"</p>
                <div class="rating-author">- Rabin Bam</div>
            </div>
            <div class="rating-card">
                <div class="rating-stars">★★★★★</div>
                <p class="rating-text">"Wonderful experience from check-in to check-out. The breakfast buffet was amazing!"</p>
                <div class="rating-author">- Shristi Adhikari</div>
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

</body>
</html>