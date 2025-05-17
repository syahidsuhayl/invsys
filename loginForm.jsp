<%@ page session="true" %>
<%
    // Check if the user_id session attribute is null
    /*if (session.getAttribute("user_id") != null) {
        response.sendRedirect("userMainMenu.jsp"); // Redirect to dashboard if already logged in
        return;
    } */
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f9;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .card {
            width: 400px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .card-header {
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        .back-arrow {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
            color: #007bff;
            text-decoration: none;
        }
        .back-arrow:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="card p-4">
    <!-- Header with Back Arrow -->
    <div class="card-header">
        <a href="index.html" class="back-arrow">
            <i class="bi bi-arrow-left"></i>
        </a>
        <h3 class="text-center mb-4">Login</h3>
    </div>

    <form action="loginBackend.jsp" method="post">
        <!-- Username Input -->
        <div class="mb-3">
            <label for="username" class="form-label">Username:</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>

        <!-- Password Input -->
        <div class="mb-4">
            <label for="password" class="form-label">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <!-- Login Button -->
        <div class="text-center mb-3">
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </div>

        <!-- Links as Buttons -->
        <div class="d-flex justify-content-between">
            <a href="index.html" class="btn btn-link">
                <i class="bi bi-arrow-left"></i> Back to Home
            </a>
            <a href="userRegisterForm.jsp" class="btn btn-outline-primary">Register</a>
        </div>
    </form>
</div>

</body>
</html>