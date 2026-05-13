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
        
        <!-- Spa & Wellness Activities -->
        <div class="activity-card" data-category="spa">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/spa.jpg" alt="Luxury Spa">
            </div>
            <div class="activity-info">
                <span class="activity-category">spa</span>
                <h3 class="activity-title">Luxury Spa Treatment</h3>
                <p class="activity-desc">Enjoy a relaxing full-body spa treatment with hot stones, essential oils, and traditional Ayurvedic techniques. Each session is personalized by our experienced therapists to suit your needs. Finish your experience with herbal tea and fresh seasonal fruits.</p>
                <div class="activity-meta">
                    <span>1 hour</span>
                </div>
                <div class="activity-price">रु 3,500 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <div class="activity-card" data-category="spa">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/jacuzee.jpg" alt="Jacuzzi">
            </div>
            <div class="activity-info">
                <span class="activity-category">spa</span>
                <h3 class="activity-title">Jacuzzi Experience</h3>
                <p class="activity-desc">Relax in a private jacuzzi with champagne, rose petals, and beautiful open views. The warm hydro-massage jets help ease stress and calm the body. Perfect for couples, celebrations, or peaceful personal time.</p>
                <div class="activity-meta">
                    <span>1.5 hours</span>
                </div>
                <div class="activity-price">रु 4,000 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <div class="activity-card" data-category="spa">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/massage-room.jpg" alt="Massage">
            </div>
            <div class="activity-info">
                <span class="activity-category">spa</span>
                <h3 class="activity-title">Massage Therapy</h3>
                <p class="activity-desc">Professional massage therapy by certified therapists. Choose from various techniques.</p>
                <div class="activity-meta">
                    <span>1 hour</span>
                </div>
                <div class="activity-price">रु 3,000 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <div class="activity-card" data-category="spa">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/sauna-room.jpg" alt="Sauna">
            </div>
            <div class="activity-info">
                <span class="activity-category">spa</span>
                <h3 class="activity-title">Sauna & Steam Room</h3>
                <p class="activity-desc">Refresh your body and mind in our Finnish sauna and eucalyptus steam room. The soothing heat helps relax muscles, cleanse the skin, and reduce stress. Fresh towels, cooling cloths, and refreshments are provided.</p>
                <div class="activity-meta">
                    <span>1 hour</span>
                </div>
                <div class="activity-price">रु 2,000 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <!-- Entertainment Activities -->
        <div class="activity-card" data-category="entertainment">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/dreamy-movie-room.jpg" alt="Movie Room">
            </div>
            <div class="activity-info">
                <span class="activity-category">entertainment</span>
                <h3 class="activity-title">Dreamy Movie Room</h3>
                <p class="activity-desc">Enjoy a private cinema experience with a 4K screen, surround sound, and comfortable reclining seats. Watch films from our curated collection while enjoying gourmet snacks and drinks. Ideal for couples, families, or a quiet evening.</p>
                <div class="activity-meta">
                    <span>2 hours</span>
                </div>
                <div class="activity-price">रु 2,500 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <div class="activity-card" data-category="entertainment">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/event-hall.jpg" alt="Event Hall">
            </div>
            <div class="activity-info">
                <span class="activity-category">entertainment</span>
                <h3 class="activity-title">Grand Event Hall</h3>
                <p class="activity-desc">Host weddings, celebrations, and special events in our elegant grand hall. Featuring chandeliers, premium lighting, and modern sound and AV systems, the space is designed for memorable occasions. Our events team takes care of every detail.</p>
                <div class="activity-meta">
                    <span>4 hours</span>
                </div>
                <div class="activity-price">रु 10,000 <span>/ per booking</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <div class="activity-card" data-category="entertainment">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/cozy-movie-room.jpg" alt="Cozy Movie Room">
            </div>
            <div class="activity-info">
                <span class="activity-category">entertainment</span>
                <h3 class="activity-title">Cozy Movie Room</h3>
                <p class="activity-desc">A comfortable and intimate movie space perfect for small groups and family nights. Relax on plush bean bags with an HD screen and complete privacy. Simple, cozy, and enjoyable.</p>
                <div class="activity-meta">
                    <span>2 hours</span>
                </div>
                <div class="activity-price">रु 1,800 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <!-- Dining Activities -->
        <div class="activity-card" data-category="dining">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/food-area.jpg" alt="Fine Dining">
            </div>
            <div class="activity-info">
                <span class="activity-category">dining</span>
                <h3 class="activity-title">Fine Dining Experience</h3>
                <p class="activity-desc">Enjoy a carefully prepared three-course meal made with fresh seasonal ingredients. From appetizers to signature desserts, every dish is crafted with care and elegance. Paired with fine wines and attentive table service.</p>
                <div class="activity-meta">
                    <span>2 hours</span>
                </div>
                <div class="activity-price">रु 3,000 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <div class="activity-card" data-category="dining">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/beverage-area.jpg" alt="Beverage Tasting">
            </div>
            <div class="activity-info">
                <span class="activity-category">dining</span>
                <h3 class="activity-title">Beverage Tasting</h3>
                <p class="activity-desc">Discover a selection of premium wines, craft beers, and artisan spirits in a guided tasting experience. Enjoy expert pairings with fine cheese and charcuterie while learning about each beverage. Perfect for both beginners and enthusiasts.</p>
                <div class="activity-meta">
                    <span>1.5 hours</span>
                </div>
                <div class="activity-price">रु 2,500 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <!-- Pool & Fitness Activities -->
        <div class="activity-card" data-category="pool">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/indoor-swmming.jpg" alt="Indoor Pool">
            </div>
            <div class="activity-info">
                <span class="activity-category">pool</span>
                <h3 class="activity-title">Indoor Swimming Pool</h3>
                <p class="activity-desc">Relax in our heated indoor pool with lap lanes, a quiet lounge area, and a jacuzzi corner. Fresh towels, comfortable loungers, and chilled infused water are available throughout your visit. Peaceful, private, and open daily.</p>
                <div class="activity-meta">
                    <span>Wwhole Day</span>
                </div>
                <div class="activity-price">रु 1,500 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <div class="activity-card" data-category="pool">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/outdoor-swmmingpool-view.jpg" alt="Outdoor Pool">
            </div>
            <div class="activity-info">
                <span class="activity-category">pool</span>
                <h3 class="activity-title">Outdoor Pool with View</h3>
                <p class="activity-desc">Swim in our infinity pool surrounded by panoramic mountain and sky views. Enjoy crystal-clear water, warm sunlight, and a calm atmosphere. Poolside service, sunbeds, and private cabanas are available for your comfort.</p>
                <div class="activity-meta">
                    <span>Whole Day</span>
                </div>
                <div class="activity-price">रु 2,000 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
        <div class="activity-card" data-category="fitness">
            <div class="activity-image">
                <img src="${pageContext.request.contextPath}/images/activities/gym.jpg" alt="Gym">
            </div>
            <div class="activity-info">
                <span class="activity-category">fitness</span>
                <h3 class="activity-title">Fitness Center</h3>
                <p class="activity-desc">Stay active in our modern fitness center with cardio machines, free weights, and stretching areas. Certified trainers are available to guide and personalize your workout. Complimentary towels, lockers, and refreshments are included for all guests.</p>
                <div class="activity-meta">
                    <span>Whole Day</span>
                </div>
                <div class="activity-price">रु 1,000 <span>/ per person</span></div>
                <button class="btn-book-activity" onclick="window.location.href='${pageContext.request.contextPath}/login?redirect=browse'">Book Now →</button>
            </div>
        </div>
        
    </div>
</div>

<script>
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