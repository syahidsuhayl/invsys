<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Registration Status</title>
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
                String adminName = request.getParameter("admin_name");
                String adminPassword = request.getParameter("admin_password");
                String adminEmail = request.getParameter("admin_email");

                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost/invsys";
                String usernameMySQL = "root";
                String passwordMySQL = "";

                try (
                    Connection connectionDB = DriverManager.getConnection(url, usernameMySQL, passwordMySQL);
                    PreparedStatement psInsertAdmin = connectionDB.prepareStatement(
                        "INSERT INTO admin (admin_name, admin_password, admin_email) VALUES (?, ?, ?)")
                ) {
                    psInsertAdmin.setString(1, adminName);
                    psInsertAdmin.setString(2, adminPassword);
                    psInsertAdmin.setString(3, adminEmail);

                    int rowsInserted = psInsertAdmin.executeUpdate();

                    if (rowsInserted > 0) {
                        out.println("<p class='text-success'>Admin registration successful!</p>");
                        out.println("<p>Name: " + adminName + "</p>");
                    } else {
                        out.println("<p class='text-danger'>Registration failed. Please try again.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                }
            %>
        </div>
        <div class="text-center mt-3">
            <a href="adminRegisterForm.jsp" class="btn btn-primary">Back to Register</a>
            <a href="loginForm.jsp" class="btn btn-secondary">Login</a>
        </div>
    </div>
</body>
</html>