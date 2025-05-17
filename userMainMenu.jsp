<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check if the session is valid
    if (session.getAttribute("user_id") == null && session.getAttribute("user_name") == null) {
        response.sendRedirect("loginForm.jsp"); // Redirect to login page if session is invalid
        return;
    }
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Main Menu</title>
    <link href="css/bootstrap.css" rel="stylesheet"> <%-- Link to the Litera theme --%>
    <style>
        /* Ensure the footer stays at the bottom */
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
        }
        main {
            flex: 1; /* Pushes the footer to the bottom */
        }
        footer {
            background-color: #f8f9fa;
            padding: 10px 0;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Inventory System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Inventory</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Reports</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <!-- Theme Toggle Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="themeDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-circle-half"></i> Toggle Theme
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="themeDropdown">
                            <li><button class="dropdown-item" onclick="setTheme('light')"><i class="bi bi-sun"></i> Light</button></li>
                            <li><button class="dropdown-item" onclick="setTheme('dark')"><i class="bi bi-moon"></i> Dark</button></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                        <a class="nav-link" href="updateUserProfile.jsp">Update Profile</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h1 class="text-center">Welcome, <%= session.getAttribute("user_name") %>!</h1>
                <p class="text-center">What would you like to do today?</p>
            </div>
        </div>

        <!-- Cards Section -->
        <div class="row mt-4">
            <!-- Add Inventory Card -->
            <div class="col-md-6">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Add Inventory</h5>
                        <p class="card-text">Add new items to your inventory.</p>
                        <a href="addInventory.jsp" class="btn btn-primary">Add Inventory</a>
                    </div>
                </div>
            </div>

            <!-- Scan Barcode Card -->
            <div class="col-md-6">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Scan Barcode</h5>
                        <p class="card-text">Scan barcodes to quickly add or manage inventory items.</p>
                        <a href="scanBarcode.jsp" class="btn btn-success">Scan Barcode</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="text-center">
        <div class="text-center p-3">
            © 2025 Inventory System. All rights reserved.
        </div>
    </footer>

    <script>
        function setTheme(theme) {
            if (theme === 'light') {
                document.documentElement.setAttribute('data-bs-theme', 'light');
            } else if (theme === 'dark') {
                document.documentElement.setAttribute('data-bs-theme', 'dark');
            }
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.js"></script>
</body>
</html>