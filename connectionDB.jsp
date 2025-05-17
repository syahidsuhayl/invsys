<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost/invsys";
    String usernameMySQL = "root";
    String passwordMySQL = "";
    Connection connectionDB = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // use cj for newer MySQL versions
        connectionDB = DriverManager.getConnection(url, usernameMySQL, passwordMySQL);
    } catch (Exception e) {
        out.println("Connection failed: " + e.getMessage());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
%>
