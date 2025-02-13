<%-- 
    Document   : login
    Created on : Feb 13, 2025, 5:59:09 AM
    Author     : 94775
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" type="text/css" href="css/loginPage.css">
    </head>
    <body>
        <div class="login-container">
        <h1>Login</h1>
        <form action="" method="post">
            <table>
                <tr>
                    <td>Username:</td>
                    <td><input type="text" name="username" required></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input type="password" name="password"></td>
                </tr>
                <tr>
                    <td>
                        <input type="reset" value="Reset">
                        <input type="submit" value="Submit">
                    </td>
                </tr>
            </table>
        </form>
        </div>
    </body>
</html>
