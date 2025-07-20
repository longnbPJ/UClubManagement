<%-- 
    Document   : header
    Created on : Mar 9, 2025, 9:27:51 PM
    Author     : PC ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.ReceivantDAO" %>
<%@page import="dao.AccountDAO" %>

<header id="header" class="header d-flex align-items-center fixed-top">
    <div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">

        <a href="Home" class="logo d-flex align-items-center">
            <!-- Uncomment the line below if you also wish to use an image logo -->
            <!-- <img src="assets/img/logo.png" alt=""> -->
            <h1 class="sitename">CMA</h1> <span>.</span>
        </a>

        <nav id="navmenu" class="navmenu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/Home" class="${param.page == "home" ? "active" : ""}">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/Clubs" class="${param.page == "club" ? "active" : ""}">Clubs</a></li>
                <li><a href="${pageContext.request.contextPath}/Events" class="${param.page == "event" ? "active" : ""}">Events</a></li>
                    <c:if test="${not empty user}">
                    <li>
                        <div class="notification-container">
                            <button class="notification-button noti-btn" id="notificationButton">
                                <i class="bi bi-bell-fill fs-5 m-0"></i>
                                <c:if test="${ReceivantDAO.getNumberOfNotiNotRead(id) > 0}">
                                    <span id="notificationCount" class="notification-badge">${ReceivantDAO.getNumberOfNotiNotRead(id)}</span>
                                </c:if>
                            </button>

                            <!-- Notification Dropdown -->
                            <div class="notification-dropdown custom-scrollbar ${isOpen != null ? "show" : ""}" id="notificationDropdown">
                                <%request.getSession().removeAttribute("isOpen");%>
                                <h4 class="noti-header">Notification</h4>
                                <c:if test="${ReceivantDAO.getNumberOfNoti(id) == 0}">
                                    <h5 class="NotiHeading">No notification</h5>
                                </c:if>
                                <c:forEach items="${ReceivantDAO.getReceivants()}" var="receivant">
                                    <c:if  test="${receivant.getReceiverID() == id}">
                                        <div  class="notification-item d-flex justify-content-between ${receivant.getIsRead() == 1 ? "isRead" : ""}">
                                            <div >
                                                <a href="User?page=senderInfo&senderID=${receivant.getNotification().getSenderID()}" class="receiverLink">
                                                    <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-2.jpg" alt=""/>
                                                </a>
                                                <a href="${receivant.getNotification().getLink() != null ? receivant.getNotification() : "#"}">
                                                    <div class="notification-content">
                                                        <h6>${receivant.getNotification().getTitle()}</h6>
                                                        <p>${receivant.getNotification().getMessage()}</p>
                                                        <small class="notification-time">
                                                            ${AccountDAO.getAccountByID(receivant.getNotification().getSenderID()).getFullname()}
                                                        </small> 
                                                        <br/>
                                                        <small class="notification-time">${receivant.getNotification().getDate()} 
                                                            - ${receivant.getNotification().getTime()}
                                                        </small>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="d-flex align-items-end">
                                                <form action="User" method="Post">
                                                    <c:if test="${receivant.getIsRead() == 0}">
                                                        <input type="hidden" name="action" value="checkNoti"/>
                                                        <input type="hidden" name="notiID" value="${receivant.getNoticationID()}"/>
                                                        <input type="hidden" name="id" value="${id}"/>
                                                        <input type="hidden" name="status" value="1"/>
                                                        <button type="submit" class="btn btn-sm btn-success">Set is Read</button>
                                                    </c:if>
                                                    <c:if test="${receivant.getIsRead() != 0}">
                                                        <input type="hidden" name="action" value="checkNoti"/>
                                                        <input type="hidden" name="notiID" value="${receivant.getNoticationID()}"/>
                                                        <input type="hidden" name="id" value="${id}"/>
                                                        <input type="hidden" name="status" value="0"/>
                                                        <button type="submit" class="btn btn-sm btn-danger">Set not Read</button>
                                                    </c:if>
                                                </form>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </li>
                </c:if>
                <li>
                    <c:if test="${empty user}">
                        <a href="${pageContext.request.contextPath}/Login" class="login-button ${param.page == "login" ? "active" : ""}">Login</a>
                    </c:if>
                    <c:if test="${not empty user}">
                        <a href="${pageContext.request.contextPath}/User" class="${param.page == "User" ? "active" : ""}">
                            <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-1.jpg" class="user-avatar"></a>
                    </c:if>
                </li>
            </ul>
            <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
        </nav>

        <script>
            document.getElementById('notificationButton').addEventListener('click', function (event) {
                let dropdown = document.getElementById('notificationDropdown');
                dropdown.classList.toggle('show'); // Toggle hiển thị dropdown

                event.stopPropagation(); // Ngăn chặn sự kiện lan ra ngoài
            });

            // Đóng dropdown khi click ra ngoài
            document.addEventListener('click', function (event) {
                let dropdown = document.getElementById('notificationDropdown');
                let button = document.getElementById('notificationButton');
                if (!button.contains(event.target) && !dropdown.contains(event.target)) {
                    dropdown.classList.remove('show');
                }
            });
        </script>
    </div>
</header>
