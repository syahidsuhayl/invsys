<%@ page session="true" %>
<%@include file="connectionDB.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check if the session is valid
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("loginForm.jsp"); // Redirect to login page if session is invalid
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Inventory</title>
    <link href="css/bootstrap.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .form-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-section h2 {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="form-section">
            <h2 class="text-center">Add New Product</h2>
            <form action="addInventoryBackend.jsp" method="post">
                <!-- Product Name -->
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="itemName" name="item_name" placeholder="Product Name" required>
                    <label for="itemName">Product Name</label>
                </div>

                <!-- Quantity -->
                <div class="form-floating mb-3">
                    <input type="number" class="form-control" id="itemQuantity" name="item_quantity" placeholder="Quantity" min="1" required>
                    <label for="itemQuantity">Quantity</label>
                </div>

                <!-- Unit -->
                <div class="form-floating mb-3">
                    <select class="form-select" id="itemUnit" name="item_unit" required>
                        <option value="" disabled selected>Select Unit</option>
                        <option value="pcs">Pieces</option>
                        <option value="kg">Kilograms</option>
                        <option value="liters">Liters</option>
                        <option value="boxes">Boxes</option>
                    </select>
                    <label for="itemUnit">Unit</label>
                </div>

                <!-- Expiry Date -->
                <div class="form-floating mb-3">
                    <input type="date" class="form-control" id="itemExpiryDate" name="item_expiry_date" placeholder="Expiry Date">
                    <label for="itemExpiryDate">Expiry Date (Optional)</label>
                </div>

                <!-- Barcode -->
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="itemBarcode" name="item_barcode" placeholder="Barcode">
                    <label for="itemBarcode">Barcode (Optional)</label>
                    <small class="text-muted">Use a barcode scanner or manually enter the barcode.</small>
                </div>

                <!-- Category -->
                <div class="form-floating mb-3">
                    <select class="form-select" id="itemCategory" name="item_category" required>
                        <option value="" disabled selected>Select Category</option>
                        <option value="Uncategorized">Uncategorized</option>
                        <%
                            // Fetch categories from the database
                            PreparedStatement stmt = null;
                            ResultSet rs = null;
                            try {
                                String query = "SELECT DISTINCT item_category FROM inventory WHERE item_category IS NOT NULL";
                                stmt = connectionDB.prepareStatement(query);
                                rs = stmt.executeQuery();
                                while (rs.next()) {
                        %>
                            <option value="<%= rs.getString("item_category") %>"><%= rs.getString("item_category") %></option>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                            }
                        %>
                    </select>
                    <label for="itemCategory">Category</label>
                </div>

                <!-- Submit Button -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary btn-lg">Add Product</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>