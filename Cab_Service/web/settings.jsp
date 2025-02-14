<%-- 
    Document   : settings
    Created on : Feb 13, 2025, 10:16:44 AM
    Author     : 94775
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Settings</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" type="text/css" href="css/settings_page.css">
    </head>
    <body>
        <div class="dashboard">
            <jsp:include page="sidebar.jsp" />
            <main class="content">
                <header class="header">
                    <h2>Settings</h2>
                    <div class="profile">
                        <i class="fas fa-user-circle"></i>
                        <span class="username"><%= session.getAttribute("username") %></span>
                    </div>
                </header>
                <section class="settings-container">
                    <h2>Account Settings</h2>
                    <form action="UpdateSettingsServlet" method="post">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" value="<%= session.getAttribute("username") %>" required>   
                        </div>
                        <div class="form-group">
                            <label for="password">New Password:</label>
                            <input type="password" id="password" name="password">
                        </div>
<!--                        <div class="form-group">
                            <label for="language">Preferred Language:</label>
                            <select id="language" name="language">
                                <option value="english">English</option>
                                <option value="spanish">Spanish</option>
                                <option value="french">French</option>
                            </select>
                        </div>-->
                        <button type="submit">Save Changes</button>
                    </form>
                </section>
            </main>
        </div>
    </body>
</html>
