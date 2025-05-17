<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
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
    <h3 class="text-center mb-4">Register User</h3>
    <form name="registerForm" action="userRegisterBackend.jsp" method="post">
        <div class="mb-3">
            <label for="user_name" class="form-label">Username:</label>
            <input type="text" class="form-control" id="user_name" name="user_name" required>
        </div>
        <div class="mb-3">
            <label for="user_email" class="form-label">Email:</label>
            <input type="email" class="form-control" id="user_email" name="user_email" required>
        </div>
        <div class="mb-3">
            <label for="user_password" class="form-label">Password:</label>
            <input type="password" class="form-control" id="user_password" name="user_password" required>
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
