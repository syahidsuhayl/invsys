<%@include file="connectionDB.jsp"%>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Initialize variables for status messages
    String statusMessage = null;
    String statusClass = null;

    // Check if the session is valid
    if (session == null || session.getAttribute("user_id") == null) {
        statusMessage = "Session is invalid. Please log in again.";
        statusClass = "alert-danger";
    } else {
        // Retrieve user_id from the session
        Integer userId = (Integer) session.getAttribute("user_id");

        // Check if the form was submitted
        if ("POST".equalsIgnoreCase(request.getMethod())) {
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
                    statusMessage = "Product added successfully!";
                    statusClass = "alert-success";
                } else {
                    statusMessage = "Failed to add the product. Please try again.";
                    statusClass = "alert-danger";
                }
            } catch (Exception e) {
                e.printStackTrace();
                statusMessage = "An error occurred while adding the product. Please try again later.";
                statusClass = "alert-danger";
            } finally {
                // Close resources
                if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
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
    <script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>
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
        #reader {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="form-section">
            <h2 class="text-center">Add New Product</h2>

            <!-- Display Status Message -->
            <% if (statusMessage != null) { %>
                <div class="alert <%= statusClass %> text-center" role="alert">
                    <%= statusMessage %>
                </div>
            <% } %>

            <!-- Inventory Form -->
            <form action="addInventory.jsp" method="post">
                <!-- Barcode Scanner -->
                <div class="mb-3 text-center">
                    <div id="reader"></div>
                </div>

                <!-- Barcode -->
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="itemBarcode" name="item_barcode" placeholder="Barcode">
                    <label for="itemBarcode">Barcode</label>
                </div>

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

                <!-- Category -->
                <div class="form-floating mb-3">
                    <select class="form-select" id="itemCategory" name="item_category" required>
                        <option value="" disabled selected>Select Category</option>
                        <option value="Electronics">Electronics</option>
                        <option value="Groceries">Groceries</option>
                        <option value="Clothing">Clothing</option>
                        <option value="Furniture">Furniture</option>
                        <option value="Uncategorized">Uncategorized</option>
                    </select>
                    <label for="itemCategory">Category</label>
                </div>

                <!-- Submit Button -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary btn-lg">Add Product</button>
                </div>
            </form>

            <!-- Link to return to the main menu -->
            <div class="text-center mt-4">
                <a href="userMainMenu.jsp" class="btn btn-secondary">Return to Main Menu</a>
            </div>
        </div>
    </div>

    <script>
        function onScanSuccess(decodedText, decodedResult) {
            // Handle the scanned barcode
            document.getElementById("itemBarcode").value = decodedText;
        }

        function onScanFailure(error) {
            // Handle scan failure
            console.warn(`Code scan error = ${error}`);
        }

        let html5QrcodeScanner = new Html5QrcodeScanner(
            "reader", { fps: 10, qrbox: 250 });
        html5QrcodeScanner.render(onScanSuccess, onScanFailure);
    </script>
</body>
</html>