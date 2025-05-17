<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="connectionDB.jsp" %> <%-- Include the database connection file --%>

<%
    // Check if the session is valid
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("loginForm.jsp"); // Redirect to login page if session is invalid
        return;
    }

    int userId = (int) session.getAttribute("user_id");
    String currentUsername = "";
    String currentEmail = "";
    String currentPassword = "";

    PreparedStatement stmt = null;
    ResultSet resultSet = null;

    try {
        // Query to fetch the current user details
        String query = "SELECT user_name, user_email, user_password FROM user WHERE user_id = ?";
        stmt = connectionDB.prepareStatement(query);
        stmt.setInt(1, userId);
        resultSet = stmt.executeQuery();

        if (resultSet.next()) {
            currentUsername = resultSet.getString("user_name");
            currentEmail = resultSet.getString("user_email");
            currentPassword = resultSet.getString("user_password");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) resultSet.close();
        if (stmt != null) stmt.close();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
    <link href="css/bootstrap.css" rel="stylesheet">
    <script>
        function togglePasswordVisibility(fieldId, iconId) {
            const passwordField = document.getElementById(fieldId);
            const toggleIcon = document.getElementById(iconId);
            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.classList.remove("bi-eye");
                toggleIcon.classList.add("bi-eye-slash");
            } else {
                passwordField.type = "password";
                toggleIcon.classList.remove("bi-eye-slash");
                toggleIcon.classList.add("bi-eye");
            }
        }
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Update Profile</h1>
        <!-- Current User Details -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Current User Details</h5>
                <p><strong>Username:</strong> <%= currentUsername %></p>
                <p><strong>Email:</strong> <%= currentEmail %></p>
                <div class="input-group">
                    <input type="password" class="form-control" id="currentPassword" value="<%= currentPassword %>" readonly>
                    <button type="button" class="btn btn-outline-secondary" onclick="togglePasswordVisibility('currentPassword', 'toggleCurrentPasswordIcon')">
                        <i class="bi bi-eye" id="toggleCurrentPasswordIcon"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Update Form -->
        <form action="updateUserProfileBackend.jsp" method="post">
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
                <label for="username">New Username</label>
            </div>
            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                <label for="email">New Email</label>
            </div>
            <div class="form-floating mb-3">
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                    <button type="button" class="btn btn-outline-secondary" onclick="togglePasswordVisibility('password', 'togglePasswordIcon')">
                        <i class="bi bi-eye" id="togglePasswordIcon"></i>
                    </button>
                </div>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Update Profile</button>
            </div>
        </form>
    </div>
</body>
</html>
