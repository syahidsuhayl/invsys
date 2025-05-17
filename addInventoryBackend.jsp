<%@include file="connectionDB.jsp"%>
<%@ page session="true" %>
<%
    // Check if the session is valid
    if (session == null || session.getAttribute("user_id") == null) {
        out.println("<p style='color: red; text-align: center;'>Session is invalid. Please log in again.</p>");
        return;
    }

    // Retrieve user_id from the session
    Integer userId = (Integer) session.getAttribute("user_id");

    // Retrieve form data
    String itemName = request.getParameter("item_name");
    String itemQuantity = request.getParameter("item_quantity");
    String itemUnit = request.getParameter("item_unit");
    String itemExpiryDate = request.getParameter("item_expiry_date");
    String itemBarcode = request.getParameter("item_barcode");
    String itemCategory = request.getParameter("item_category");

    PreparedStatement stmt = null;

    try {
        // SQL query to insert data into the inventory table
        String sql = "INSERT INTO inventory (item_name, item_quantity, item_unit, item_expiry_date, item_barcode, item_category, user_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        stmt = connectionDB.prepareStatement(sql);
        stmt.setString(1, itemName);
        stmt.setInt(2, Integer.parseInt(itemQuantity));
        stmt.setString(3, itemUnit);

        // Handle optional expiry date
        if (itemExpiryDate != null && !itemExpiryDate.isEmpty()) {
            stmt.setDate(4, Date.valueOf(itemExpiryDate));
        } else {
            stmt.setNull(4, Types.DATE);
        }

        // Handle optional barcode
        if (itemBarcode != null && !itemBarcode.isEmpty()) {
            stmt.setString(5, itemBarcode);
        } else {
            stmt.setNull(5, Types.VARCHAR);
        }

        // Set the item category
        stmt.setString(6, itemCategory);

        // Set the user ID
        stmt.setInt(7, userId);

        // Execute the query
        int rowsInserted = stmt.executeUpdate();

        if (rowsInserted > 0) {
            // Display success message
            out.println("<p style='color: green; text-align: center;'>Product added successfully!</p>");
        } else {
            // Display error message
            out.println("<p style='color: red; text-align: center;'>Failed to add the product. Please try again.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color: red; text-align: center;'>An error occurred while adding the product. Please try again later.</p>");
    } finally {
        // Close resources
        if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>

<!-- Link to return to the main menu -->
<div style="text-align: center; margin-top: 20px;">
    <a href="userMainMenu.jsp" class="btn btn-primary">Return to Main Menu</a>
</div>