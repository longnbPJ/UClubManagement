<%-- 
    Document   : index.jsp
    Created on : Mar 9, 2025, 11:03:54 PM
    Author     : PC ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import ="model.Account"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:if test="${user.getUserRoleID() != 1}">
            <% response.sendRedirect(request.getContextPath() + "/Home"); %>
        </c:if>
        <c:if test="${user.getUserRoleID() == 1}">
            <% response.sendRedirect(request.getContextPath() + "/Admin"); %>
        </c:if>
    </body>
</html>
