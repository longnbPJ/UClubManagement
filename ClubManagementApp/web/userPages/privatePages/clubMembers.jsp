<%-- 
    Document   : clubMembers
    Created on : Mar 11, 2025, 1:12:16 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.RequestDAO"%>
<%@page import="dao.ClubMemberDAO"%>
<%@page import="dao.ClubDAO"%>
<%@page import="dao.QuestionDAO"%>
<%@page import="dao.AnswerDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Clubs</title>
        <meta name="description" content="">
        <meta name="keywords" content="">

        <link href="${pageContext.request.contextPath}/userPages/assets/img/favicon.png" rel="icon">
        <link href="${pageContext.request.contextPath}/userPages/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,300;1,400;1,500;1,600;1,700;1,800&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="${pageContext.request.contextPath}/userPages/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/userPages/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/userPages/assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/userPages/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/userPages/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/userPages/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

        <!-- Main CSS File -->
        <link href="${pageContext.request.contextPath}/userPages/assets/css/main.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/userPages/assets/css/custom.css?v=1.0.6" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="../components/header.jsp">
            <jsp:param name="page" value = "club"/>
        </jsp:include>

        <main class="main">

            <!-- Page Title -->
            <div class="page-title dark-background" style="background-image: url(${pageContext.request.contextPath}/userPages/assets/img/page-title-bg.jpg);">
                <div class="container position-relative">
                    <h1>${ClubDAO.getClubByID(clubID).getClubInfo().getClubName()}</h1>
                </div>
            </div><!-- End Page Title -->

            <c:if test="${not empty isSuccess}">
                <c:choose>
                    <c:when test="${isSuccess == true}">
                        <div id="notification" class="alert alert-success alert-dismissible fade show" role="alert">
                            Update Successfully!
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div id="notification" class="alert alert-danger alert-dismissible fade show" role="alert">
                            Update fail!
                        </div>
                    </c:otherwise>
                </c:choose>
                <%request.getSession().removeAttribute("isSuccess");%>
            </c:if>

            <!-- Service Details Section -->
            <section id="service-details" class="service-details section">

                <div class="container">

                    <div class="row gy-4">

                        <jsp:include page="../components/clubSidebar.jsp">
                            <jsp:param name="page" value = "members"/>
                        </jsp:include>

                        <div class="col-lg-9" data-aos="fade-up" data-aos-delay="200">
                            <div class="config-container">
                                <c:set var="userRole" value="${ClubMemberDAO.getUserClubRole(id,clubID)}" scope="page"/>
                                <c:if test="${(not empty user && ClubMemberDAO.isUserInClub(id,clubID) && (userRole.equals('Manager') && RequestDAO.getJoinRequestsByClubID(clubID).size() > 0 || userRole.equals('Adviser'))) || (user.getUserRoleID() == 1)}">
                                    <a href="#" class="d-inline-block d-flex align-items-center" data-bs-toggle="modal" data-bs-target="#joinRequestsModal">
                                        Join Requests
                                        <i class="position-relative bi bi-envelope m-2">
                                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                                ${RequestDAO.getJoinRequestsByClubID(clubID).size()}
                                            </span>
                                        </i>
                                    </a>
                                </c:if>
                            </div>
                            <div class="row gy-5">
                                <c:forEach items="${ClubMemberDAO.getClubMembers()}" var="clubMember">
                                    <c:if test="${clubMember.getClubInfo().getClubID() == ClubDAO.convertClubID(clubID) && (clubMember.getClubRole().equals('Manager'))}">
                                        <div class="col-lg-2 col-md-6 member" data-aos="fade-up" data-aos-delay="100">
                                            <a href="Clubs?page=member&clubID=${clubID}&memberID=${clubMember.getAccount().getAccountID()}">
                                                <div class="member-img">
                                                    <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-1.jpg" class="img-fluid" alt=""> 
                                                </div>
                                                <div class="member-info text-center">
                                                    <h4>${clubMember.getAccount().getFullname()}</h4>
                                                    <span>${clubMember.getClubRole()}</span>
                                                    <p>${clubMember.getAccount().getDescription()}</p>
                                                </div>
                                            </a>
                                        </div><!-- End Team Member -->
                                    </c:if>
                                </c:forEach>
                                <c:forEach items="${ClubMemberDAO.getClubMembers()}" var="clubMember">
                                    <c:if test="${clubMember.getClubInfo().getClubID() == ClubDAO.convertClubID(clubID) && (clubMember.getClubRole().equals('Adviser'))}">
                                        <div class="col-lg-2 col-md-6 member" data-aos="fade-up" data-aos-delay="100">
                                            <a href="Clubs?page=member&clubID=${clubID}&memberID=${clubMember.getAccount().getAccountID()}">
                                                <div class="member-img">
                                                    <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-1.jpg" class="img-fluid" alt=""> 
                                                </div>
                                                <div class="member-info text-center">
                                                    <h4>${clubMember.getAccount().getFullname()}</h4>
                                                    <span>${clubMember.getClubRole()}</span>
                                                    <p>${clubMember.getAccount().getDescription()}</p>
                                                </div>
                                            </a>
                                        </div><!-- End Team Member -->
                                        <c:set var="count" value="0" scope="page" />
                                    </c:if>
                                </c:forEach>
                                <c:forEach items="${ClubMemberDAO.getClubMembers()}" var="clubMember">
                                    <c:if test="${clubMember.getClubInfo().getClubID() == ClubDAO.convertClubID(clubID) && !clubMember.getClubRole().equals('Adviser') && !clubMember.getClubRole().equals('Manager')}">
                                        <div class="col-lg-2 col-md-6 member" data-aos="fade-up" data-aos-delay="100">
                                            <a href="Clubs?page=member&clubID=${clubID}&memberID=${clubMember.getAccount().getAccountID()}">
                                                <div class="member-img">
                                                    <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-1.jpg" class="img-fluid" alt=""> 
                                                </div>
                                                <div class="member-info text-center">
                                                    <h4>${clubMember.getAccount().getFullname()}</h4>
                                                    <span>${clubMember.getClubRole()}</span>
                                                    <p>${clubMember.getAccount().getDescription()}</p>
                                                </div>
                                            </a>
                                        </div><!-- End Team Member -->
                                        <c:set var="count" value="0" scope="page" />
                                    </c:if>
                                </c:forEach>
                            </div>

                        </div>

                    </div>

            </section><!-- /Service Details Section -->

        </main>

        <!-- Join Requests Modal -->
        <div class="modal fade" id="joinRequestsModal" tabindex="-1" aria-labelledby="joinRequestsModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Header -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="joinRequestsModalLabel">Join Requests</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <!-- Body -->
                    <div class="modal-body">
                        <div class="list-group">
                            <c:set var="count1" value="1" scope="page"/>
                            <c:forEach items="${RequestDAO.getJoinRequestsByClubID(clubID)}" var="request">
                                <!-- Request 1 -->
                                <div class="list-group-item d-flex align-items-center justify-content-between">
                                    <div class="d-flex align-items-center join-request-container">
                                        <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-1.jpg" class="rounded-circle me-3" alt="Avatar">
                                        <div>
                                            <h6 class="mb-0">${request.getAccount().getFullname()}</h6>
                                            <div>
                                                <p class="requestTime">
                                                    ${request.getDate()}
                                                </p>
                                                <p class="requestTime">
                                                    ${request.getTime()}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <button 
                                        class="btn btn-outline-primary btn-sm"
                                        id="btn${count1}"
                                        data-bs-toggle="modal" 
                                        data-bs-target="#requestDetailsModal${count1}" 
                                        data-accountID="${request.getAccount().getAccountID()}"
                                        data-name="${request.getAccount().getFullname()}"
                                        >
                                        View Details
                                    </button>
                                </div>
                                <c:set var="count1" value="${count1 + 1}" scope="page"/>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <c:set var="i" value="1" scope="page"/>
        <c:forEach items="${requests}" var="request">
            <!-- Request Details Modal 1 -->
            <div class="modal fade" id="requestDetailsModal${i}" tabindex="-1" aria-labelledby="requestDetailsModalLabel${i}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="requestDetailsModalLabel${i}">${request.getAccount().getFullname()}'s answers</h5>
                        </div>
                        <div class="modal-body">
                            <c:set var="count" value="1" scope="page"/>
                            <c:forEach items="${QuestionDAO.getQuestionsByClubID(clubID)}" var="question">
                                <p><strong>Question ${count}: ${question.getContent()}</strong></p>
                                <p>${AnswerDAO.getAnswer(request.getAccount().getAccountID(), question.getQuestionID()).getContent()}</p>
                                <c:set var="count" value="${count + 1}" scope="page"/>
                            </c:forEach>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#joinRequestsModal">
                                Back
                            </button>
                            <form action="Request" method="post">
                                <input type="hidden" name="action" value="acceptJoinClub"/>
                                <input type="hidden" name="isAccept" value="Accept"/>
                                <input type="hidden" name="requestID" value="${request.getRequestID()}"/>
                                <input type="hidden" name="id" value="${request.getAccount().getAccountID()}"/>
                                <input type="hidden" name="clubID" value="${clubID}"/>
                                <input type="submit" class="btn btn-success" value="Accept"/>
                            </form>
                            <form action="Request" method="post">
                                <input type="hidden" name="action" value="acceptJoinClub"/>
                                <input type="hidden" name="isAccept" value="Reject"/>
                                <input type="hidden" name="requestID" value="${request.getRequestID()}"/>
                                <input type="hidden" name="id" value="${request.getAccount().getAccountID()}"/>
                                <input type="hidden" name="clubID" value="${clubID}"/>
                                <input type="submit" class="btn btn-danger" value="Reject"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>        
            <c:set var="i" value="${i+1}" scope="page"/>
        </c:forEach>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy giá trị biến isSuccess từ request
                var isSuccess = '<%= request.getSession().getAttribute("isSuccess") %>';

                if (isSuccess === 'true') {
                    showNotification("Cập nhật thành công!", "success");
                } else if (isSuccess === 'false') {
                    showNotification("Cập nhật thất bại!", "danger");
                }
            });

            function showNotification(message, type) {
                var notification = document.getElementById("notification");

                // Tự động ẩn thông báo sau 3 giây
                setTimeout(function () {
                    notification.style.display = "none";
                }, 3000);
            }
        </script>

        <jsp:include page="../components/footer.jsp"/>

        <jsp:include page="../components/scrollTop.jsp"/>

        <jsp:include page="../components/preLoader.jsp"/>

        <!-- Vendor JS Files -->
        <script src="${pageContext.request.contextPath}/userPages/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/userPages/assets/vendor/php-email-form/validate.js"></script>
        <script src="${pageContext.request.contextPath}/userPages/assets/vendor/aos/aos.js"></script>
        <script src="${pageContext.request.contextPath}/userPages/assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="${pageContext.request.contextPath}/userPages/assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
        <script src="${pageContext.request.contextPath}/userPages/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
        <script src="${pageContext.request.contextPath}/userPages/assets/vendor/swiper/swiper-bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/userPages/assets/vendor/purecounter/purecounter_vanilla.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/userPages/assets/js/main.js"></script>

    </body>
</html>
