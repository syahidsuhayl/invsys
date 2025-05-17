<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check if the session is valid and the user is an admin
    if (session.getAttribute("admin_id") == null) {
        response.sendRedirect("loginForm.jsp"); // Redirect to login page if session is invalid
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link href="css/bootstrap.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
            <a class="navbar-brand" href="#">Admin Panel</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h1 class="text-center">Welcome, Admin!</h1>
                <p class="text-center">Manage the system using the options below:</p>
            </div>
        </div>

        <!-- Cards Section -->
        <div class="row mt-4">
            <!-- Add Categories Card -->
            <div class="col-md-6">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Add Categories</h5>
                        <p class="card-text">Create new categories for inventory items.</p>
                        <a href="addCategoryForm.jsp" class="btn btn-primary">Add Categories</a>
                    </div>
                </div>
            </div>

            <!-- Approve Barcode Items Card -->
            <div class="col-md-6">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Approve Barcode Items</h5>
                        <p class="card-text">Review and approve items added by users via barcode scanning.</p>
                        <a href="approveBarcodeItems.jsp" class="btn btn-success">Approve Items</a>
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
</body>
</html>