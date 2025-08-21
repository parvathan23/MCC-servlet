<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Admin" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<User> users = (List<User>) request.getAttribute("users");
%>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --info: #560bad;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', system-ui, -apple-system, sans-serif;
        }

        body {
            background-color: #f5f7ff;
            color: var(--dark);
            min-height: 100vh;
        }

        .dashboard-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            background: linear-gradient(180deg, var(--primary), var(--secondary));
            color: white;
            padding: 2rem 1.5rem;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 2.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .brand i {
            font-size: 1.75rem;
        }

        .brand h1 {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 2rem;
            padding: 0.75rem;
            border-radius: 0.5rem;
            background: rgba(255,255,255,0.1);
        }

        .user-profile i {
            font-size: 1.25rem;
            background: var(--accent);
            padding: 0.75rem;
            border-radius: 50%;
        }

        .user-info h3 {
            font-size: 0.9rem;
            font-weight: 500;
        }

        .user-info p {
            font-size: 0.8rem;
            opacity: 0.8;
        }

        .nav-menu {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            color: white;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .nav-item:hover, .nav-item.active {
            background: rgba(255,255,255,0.2);
        }

        .nav-item i {
            width: 1.5rem;
            text-align: center;
        }

        .logout-btn {
            margin-top: auto;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255,255,255,0.1);
        }

        /* Main Content Styles */
        .main-content {
            padding: 2rem;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            border-left: 4px solid var(--primary);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-icon {
            width: 2.5rem;
            height: 2.5rem;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .stat-icon.users {
            background: var(--success);
        }

        .stat-icon.books {
            background: var(--warning);
        }

        .stat-icon.customers {
            background: var(--danger);
        }

        .stat-icon.requests {
            background: var(--info);
        }

        .stat-value {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--dark);
        }

        .stat-title {
            font-size: 0.9rem;
            color: #6c757d;
        }

        .actions-section {
            background: white;
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--dark);
        }

        /* User Management Styles */
        .user-management {
            margin-top: 2rem;
        }

        .create-user-form {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 0.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 0.5rem;
            font-size: 0.9rem;
        }

        button[type="submit"] {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: background 0.3s;
            font-size: 0.9rem;
        }

        button[type="submit"]:hover {
            background: var(--secondary);
        }

        .user-list table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 0.5rem;
            overflow: hidden;
        }

        .user-list th {
            background: var(--primary);
            color: white;
            padding: 1rem;
            text-align: left;
        }

        .user-list td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }

        .user-list tr:last-child td {
            border-bottom: none;
        }

        .delete-btn {
            background: var(--danger);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: background 0.3s;
        }

        .delete-btn:hover {
            background: #d1144a;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 1.5rem;
            border-radius: 0.5rem;
            width: 350px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            position: relative;
        }

        .close-modal {
            position: absolute;
            top: 0.5rem;
            right: 1rem;
            font-size: 1.5rem;
            color: #aaa;
            cursor: pointer;
        }

        .close-modal:hover {
            color: var(--danger);
        }

        .modal h3 {
            font-size: 1.1rem;
            margin-bottom: 1rem;
            color: var(--dark);
            text-align: center;
        }

        .modal-actions {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .modal-btn {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            background: var(--light);
            border-radius: 0.5rem;
            text-decoration: none;
            color: var(--dark);
            transition: all 0.2s ease;
            font-size: 0.9rem;
        }

        .modal-btn:hover {
            background: var(--primary);
            color: white;
        }

        .modal-btn i {
            width: 1.25rem;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="brand">
                <i class="fas fa-shield-alt"></i>
                <h1>Admin Panel</h1>
            </div>

            <div class="user-profile">
                <i class="fas fa-user-cog"></i>
                <div class="user-info">
                    <h3><%= admin.getAdminName() %></h3>
                    <p>Administrator</p>
                </div>
            </div>

            <div class="nav-menu">
                <a href="adminDashboard.jsp" class="nav-item active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
                <a href="#" class="nav-item" id="manageUsersBtn">
                    <i class="fas fa-users-cog"></i>
                    <span>Manage Users</span>
                </a>
                <a href="manageBooks.jsp" class="nav-item">
                    <i class="fas fa-book"></i>
                    <span>Manage Books</span>
                </a>
                <a href="item-form.jsp" class="nav-item">
                    <i class="fas fa-user-edit"></i>
                    <span>Customer Form</span>
                </a>
                <a href="item-list.jsp" class="nav-item">
                    <i class="fas fa-list-ul"></i>
                    <span>Customer List</span>
                </a>

                <div class="logout-btn">
                    <a href="logout.jsp" class="nav-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <div class="page-title">
                    <h2>Users Management</h2>
                </div>
            </div>

            <!-- Stats Cards -->

            <!-- User Management Section -->
            <div class="actions-section">
                <div class="user-management">
                    <!-- Create User Form -->
                    <div class="create-user-form">
                        <h4 style="margin-bottom: 1rem; color: var(--dark);">Create New User</h4>
                        <form action="manage-users" method="post">
                            <input type="hidden" name="action" value="create">

                            <div class="form-group">
                                <label>Username:</label>
                                <input type="text" name="userName" required>
                            </div>

                            <div class="form-group">
                                <label>Role:</label>
                                <select name="role" required>
                                    <option value="admin">Admin</option>
                                    <option value="manager">Manager</option>
                                    <option value="staff">Staff</option>
                                    <option value="guest">Guest</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Password:</label>
                                <input type="password" name="password" required>
                            </div>

                            <button type="submit">Create User</button>
                        </form>
                    </div>

                    <!-- User List Table -->
                    <div class="user-list">
                        <h4 style="margin-bottom: 1rem; color: var(--dark);">User List</h4>
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Username</th>
                                    <th>Role</th>
                                    <th>Last Login</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (users != null && !users.isEmpty()) { %>
                                    <% for (User user : users) { %>
                                        <tr>
                                            <td><%= user.getUserId() %></td>
                                            <td><%= user.getUserName() %></td>
                                            <td><%= user.getRole() %></td>
                                            <td><%= user.getLoginTime() != null ? user.getLoginTime() : "Never" %></td>
                                            <td>
                                                <form action="manage-users" method="post" style="display: inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                                                    <button type="submit" class="delete-btn">Delete</button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% } %>
                                <% } else { %>
                                    <tr>
                                        <td colspan="5" style="text-align: center;">No users found</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for User Management -->
    <div id="userModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h3>User Actions</h3>
            <div class="modal-actions">
                <a href="#" class="modal-btn">
                    <i class="fas fa-user-plus"></i>
                    <span>Add New User</span>
                </a>
                <a href="#" class="modal-btn">
                    <i class="fas fa-user-edit"></i>
                    <span>Edit User</span>
                </a>
                <a href="#" class="modal-btn">
                    <i class="fas fa-user-lock"></i>
                    <span>Reset Password</span>
                </a>
            </div>
        </div>
    </div>

    <script>
        // Modal functionality
        const modal = document.getElementById("userModal");
        const btn = document.getElementById("manageUsersBtn");
        const span = document.getElementsByClassName("close-modal")[0];

        btn.onclick = function() {
            modal.style.display = "block";
        }

        span.onclick = function() {
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>