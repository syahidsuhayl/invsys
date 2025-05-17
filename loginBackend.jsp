<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="connectionDB.jsp" %> <%-- Include the database connection file --%>

<%
    // Retrieve login details from the login form
    String loginInput = request.getParameter("username"); // Get email or username from the form
    String userPassword = request.getParameter("password"); // Get password from the form

    PreparedStatement stmt = null;
    ResultSet resultSet = null;

    try {
        // Query to validate the admin's login credentials
        String adminQuery = "SELECT admin_id, admin_name FROM admin WHERE admin_name = ? AND admin_password = ?";
        stmt = connectionDB.prepareStatement(adminQuery);
        stmt.setString(1, loginInput); // Set the first parameter as admin_name
        stmt.setString(2, userPassword); // Set the second parameter as admin_password

        resultSet = stmt.executeQuery(); // Execute the query

        if (resultSet.next()) {
            // If admin credentials match
            int adminId = resultSet.getInt("admin_id");
            String adminName = resultSet.getString("admin_name");

            // Store admin information in session
            session.setAttribute("admin_id", adminId); // Store admin_id in session
            session.setAttribute("admin_name", adminName); // Store admin_name in session

            // Redirect to the admin main menu
            response.sendRedirect("adminMainMenu.jsp");
        } else {
            // If not an admin, check for regular user credentials
            String userQuery = "SELECT user_id, user_name FROM user WHERE (user_email = ? OR user_name = ?) AND user_password = ?";
            stmt = connectionDB.prepareStatement(userQuery);
            stmt.setString(1, loginInput); // Set the first parameter as user_email
            stmt.setString(2, loginInput); // Set the second parameter as user_name
            stmt.setString(3, userPassword); // Set the third parameter as user_password

            resultSet = stmt.executeQuery(); // Execute the query

            if (resultSet.next()) {
                // If user credentials match
                int userId = resultSet.getInt("user_id");
                String userName = resultSet.getString("user_name");

                // Store user information in session
                session.setAttribute("user_id", userId); // Store user_id in session
                session.setAttribute("user_name", userName); // Store user_name in session

                // Redirect to the user main menu
                response.sendRedirect("userMainMenu.jsp");
            } else {
                // Show an error message and redirect back to the login form if credentials are invalid
                out.println("<script>alert('Invalid username or password!'); window.location.href='loginForm.jsp';</script>");
            }
        }
    } catch (SQLException e) {
        // Handle database query errors
        out.println("<script>alert('An error occurred while processing your request. Please try again later.'); window.location.href='loginForm.jsp';</script>");
        e.printStackTrace();
    } finally {
        // Close database resources
        try {
            if (resultSet != null) resultSet.close();
            if (stmt != null) stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>