<%--
    Document   : logout.jsp
    Created on : 8 Dis 2024, 10:58:25 am
    Author     : syahid
    Description : to exit from system
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
        <%
            // Completely invalidate the session
            session.invalidate();
            // Redirect to login page
            response.sendRedirect("loginForm.jsp");
        %>
    </body>
</html>
