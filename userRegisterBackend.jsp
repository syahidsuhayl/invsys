<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Registration Status</title>
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
        <h3 class="text-center mb-4">Registration Status</h3>
        <div>
            <%
                String userName = request.getParameter("user_name");
                String userEmail = request.getParameter("user_email");
                String userPassword = request.getParameter("user_password");

                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost/invsys";
                String usernameMySQL = "root";
                String passwordMySQL = "";

                try (
                    Connection connectionDB = DriverManager.getConnection(url, usernameMySQL, passwordMySQL);
                    PreparedStatement psCheckAdmin = connectionDB.prepareStatement(
                        "SELECT admin_id FROM admin WHERE admin_name = ?");
                    PreparedStatement psInsertUser = connectionDB.prepareStatement(
                        "INSERT INTO user (user_name, user_email, user_password) VALUES (?, ?, ?)")
                ) {
                    // Check if the username conflicts with an admin
                    psCheckAdmin.setString(1, userName);
                    ResultSet rsAdmin = psCheckAdmin.executeQuery();

                    if (rsAdmin.next()) {
                        // If username conflicts with an admin
                        out.println("<p class='text-danger'>Registration failed: The username is already used by an admin.</p>");
                    } else {
                        // Insert the new user into the user table
                        psInsertUser.setString(1, userName);
                        psInsertUser.setString(2, userEmail);
                        psInsertUser.setString(3, userPassword);

                        int rowsInserted = psInsertUser.executeUpdate();

                        if (rowsInserted > 0) {
                            out.println("<p class='text-success'>Registration successful!</p>");
                            out.println("<p>Name: " + userName + "</p>");
                            out.println("<p>Email: " + userEmail + "</p>");
                        } else {
                            out.println("<p class='text-danger'>Registration failed. Please try again.</p>");
                        }
                    }
                } catch (SQLException e) {
                    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                }
            %>
        </div>
        <div class="text-center mt-3">
            <a href="userRegisterForm.jsp" class="btn btn-primary">Back to Register</a>
            <a href="loginForm.jsp" class="btn btn-secondary">Login</a>
        </div>
    </div>
</body>
</html>
