<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Error.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
    	 .error-page-wrapper {
        position: relative;
        height: 100vh;
        width: 100vw;
        background-image: url('${pageContext.request.contextPath}/images/404.png');
        background-size: cover;      /* Fills the whole screen */
        background-position: bottom center; /* Keeps the road at the bottom */
        background-repeat: no-repeat;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        padding-top: 8vh; /* Adjusts how high the text sits */
        padding-left: 10vw;
        box-sizing: border-box;
    }
    </style> 

<body>
    <div class="error-page-wrapper">
        <div class="text-content">
            <h1>Oops! Looks like<br>your page is...</h1>
            <p>Lost, like our bus that<br>missed its stop!</p>
            <a href="${pageContext.request.contextPath}/home" class="go-home-btn">Go Home</a>
        </div>
    </div>
</body>
</html>