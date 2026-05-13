<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmed - Heaven Bliss</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background-image: url('${pageContext.request.contextPath}/images/confirmation-backgroud.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            position: relative;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 0;
        }
        
        .confirmation-container {
            position: relative;
            z-index: 1;
            max-width: 400px;
            width: 100%;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            animation: fadeInUp 0.5s ease;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .confirmation-header {
            background: linear-gradient(135deg, #c9a84c 0%, #d4b85c 100%);
            padding: 25px 20px;
            text-align: center;
        }
        
        .success-icon {
            width: 60px;
            height: 60px;
            background: #4caf50;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
            font-size: 32px;
            color: white;
            animation: scaleIn 0.5s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }
        
        .confirmation-header h2 {
            font-size: 22px;
            color: #1a1208;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .confirmation-header p {
            font-size: 12px;
            color: #4a3a1a;
            opacity: 0.9;
        }
        
        .booking-details {
            padding: 20px;
            background: white;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #e8e0d5;
        }
        
        .detail-label {
            font-weight: 600;
            color: #2d1f0e;
            font-size: 13px;
            width: 100px;
        }
        
        .detail-value {
            color: #5a4a32;
            font-size: 13px;
            font-weight: 500;
            text-align: right;
            flex: 1;
        }
        
        .detail-value strong {
            color: #c9a84c;
            font-size: 14px;
        }
        
        .price-highlight {
            background: #f5efe0;
            padding: 15px;
            border-radius: 12px;
            margin-top: 15px;
            text-align: center;
        }
        
        .price-highlight .total-price {
            font-size: 28px;
            font-weight: bold;
            color: #c9a84c;
        }
        
        .price-highlight .total-label {
            font-size: 11px;
            color: #8b7355;
            margin-top: 5px;
            letter-spacing: 1px;
        }
        
        .booking-id-badge {
            display: inline-block;
            background: #e8e0d5;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 11px;
            color: #5a4a32;
            font-weight: 500;
        }
        
        .id-wrapper {
            text-align: center;
            margin-top: 15px;
        }
        
        .action-buttons {
            display: flex;
            gap: 12px;
            padding: 5px 20px 20px 20px;
            background: white;
        }
        
        .btn-my-account {
            flex: 1;
            padding: 10px 15px;
            background: #c9a84c;
            color: #1a1208;
            text-decoration: none;
            border-radius: 40px;
            font-weight: bold;
            font-size: 13px;
            transition: all 0.3s;
            text-align: center;
            border: none;
            cursor: pointer;
            display: inline-block;
        }
        
        .btn-my-account:hover {
            background: #b8922e;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .btn-back-home {
            flex: 1;
            padding: 10px 15px;
            background: transparent;
            border: 2px solid #c9a84c;
            color: #c9a84c;
            text-decoration: none;
            border-radius: 40px;
            font-weight: bold;
            font-size: 13px;
            transition: all 0.3s;
            text-align: center;
            cursor: pointer;
            display: inline-block;
        }
        
        .btn-back-home:hover {
            background: #c9a84c;
            color: #1a1208;
            transform: translateY(-2px);
        }
        
        @media (max-width: 480px) {
            .confirmation-container {
                max-width: 95%;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 10px;
                padding: 0 15px 15px 15px;
            }
            
            .booking-details {
                padding: 15px;
            }
            
            .confirmation-header {
                padding: 20px 15px;
            }
            
            .detail-label {
                width: 85px;
                font-size: 12px;
            }
            
            .detail-value {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>

<div class="confirmation-container">
    <div class="confirmation-header">
        <div class="success-icon">✓</div>
        <h2>Booking Confirmed!</h2>
        <p>Your reservation is complete</p>
    </div>
    
    <div class="booking-details">
        <div class="detail-row">
            <span class="detail-label">Room Type</span>
            <span class="detail-value"><strong>${booking.roomType}</strong> (${booking.roomNumber})</span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Check-in Date</span>
            <span class="detail-value">${booking.checkInDate}</span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Check-out Date</span>
            <span class="detail-value">${booking.checkOutDate}</span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Nights</span>
            <span class="detail-value">${nights} night${nights != 1 ? 's' : ''}</span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Guests</span>
            <span class="detail-value">${booking.numberOfGuests} guest${booking.numberOfGuests != 1 ? 's' : ''}</span>
        </div>
        
        <div class="price-highlight">
            <div class="total-price">रु ${Math.round(booking.totalPrice)}</div>
            <div class="total-label">TOTAL AMOUNT</div>
        </div>
        
        <div class="id-wrapper">
            <span class="booking-id-badge">Booking ID: #${booking.bookingId}</span>
        </div>
    </div>
    
    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/user/dashboard" class="btn-my-account">My Account</a>
        <a href="${pageContext.request.contextPath}/home" class="btn-back-home">Back to Home</a>
    </div>
</div>

</body>
</html>