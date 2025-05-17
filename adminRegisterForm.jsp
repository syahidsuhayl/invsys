<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Registration</title>
    <link href="css/bootstrap.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
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
    </style>
</head>
<body>

<div class="card p-4">
    <h3 class="text-center mb-4">Register Admin</h3>
    <form name="adminRegisterForm" action="adminRegisterBackend.jsp" method="post">
        <div class="mb-3">
            <label for="admin_name" class="form-label">Admin Name:</label>
            <input type="text" class="form-control" id="admin_name" name="admin_name" required>
        </div>
        <div class="mb-3">
            <label for="admin_password" class="form-label">Password:</label>
            <input type="password" class="form-control" id="admin_password" name="admin_password" required>
        </div>
        <div class="mb-4">
            <label for="admin_email" class="form-label">Email (Optional):</label>
            <input type="email" class="form-control" id="admin_email" name="admin_email">
        </div>
        <div class="d-flex justify-content-between mb-3">
            <button type="submit" class="btn btn-success w-45">Register</button>
            <button type="reset" class="btn btn-danger w-45">Reset</button>
        </div>
        <div class="text-center">
            <a href="loginForm.jsp" class="d-block mb-1">Already have an account? Login here</a>
            <a href="index.html">Back to Home</a>
        </div>
    </form>
</div>

</body>
</html>