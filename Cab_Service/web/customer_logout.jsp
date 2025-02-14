<%-- 
    Document   : customer_logout
    Created on : Feb 14, 2025, 11:26:57 AM
    Author     : 94775
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            session.invalidate();
            response.sendRedirect("customer_login.jsp");
        %>
    </body>
</html>
