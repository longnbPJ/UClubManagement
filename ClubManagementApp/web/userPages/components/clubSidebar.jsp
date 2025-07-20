<%-- 
    Document   : clubSidebar
    Created on : Mar 12, 2025, 12:28:05 AM
    Author     : PC ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.ClubMemberDAO"%>
<div class="col-lg-3" data-aos="fade-up" data-aos-delay="100">
    <div class="services-list">
        <form>
            <a href="${pageContext.request.contextPath}/Clubs?clubID=${clubID}" class="${param.page == "review" ? "active" : ""}">Review</a>
        </form>
        <hr>
        <a href="${pageContext.request.contextPath}/Clubs?page=clubEvents&clubID=${clubID}" class="${param.page == "events" ? "active" : ""}">Events</a>
        <c:if test="${user != null && (ClubMemberDAO.isUserInClub(id, clubID) || user.getUserRoleID() == 1)}">
            <a href="${pageContext.request.contextPath}/Clubs?page=clubMembers&clubID=${clubID}" class="${param.page == "members" ? "active" : ""}">Members</a>
            <a href="${pageContext.request.contextPath}/Clubs?page=clubAnnouncement&clubID=${clubID}" class="${param.page == "announcement" ? "active" : ""}">Announcement</a>
        </c:if>
        <c:if test="${user != null && (ClubMemberDAO.getUserClubRole(id, clubID) == 'Manager' || user.getUserRoleID() == 1)}">
            <a href="${pageContext.request.contextPath}/Clubs?page=createReport&clubID=${clubID}" class="${param.page == "report" ? "active" : ""}">Report</a>
        </c:if>
    </div>
</div>
