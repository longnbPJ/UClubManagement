<%-- 
    Document   : pageTitle
    Created on : Mar 11, 2025, 11:35:32 PM
    Author     : PC ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Page Title -->
<div class="page-title dark-background" style="background-image: url(${param.imgURL});">
    <div class="container position-relative">
        <h1>${param.pageTitle}</h1>
        <c:if test="${param.prevPage != null}">
            <nav class="breadcrumbs">
                <ol>
                    <li>                    
                        <p>
                            <a href="${param.prevLink}">${param.prevPage}</a>
                            > 
                            <a href="">${param.pageTitle}</a>
                        </p>
                    </li>
                </ol>
            </nav>
        </c:if>
    </div>
</div><!-- End Page Title -->
