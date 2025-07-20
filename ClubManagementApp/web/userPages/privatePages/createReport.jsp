<%-- 
    Document   : myAccount
    Created on : Mar 9, 2025, 10:06:18 PM
    Author     : PC ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.ClubDAO"%>
<%@page import="dao.ReportDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Club name</title>
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
        <link href="${pageContext.request.contextPath}/userPages/assets/css/custom.css" rel="stylesheet">
    </head>
    <body>

        <jsp:include page="../components/header.jsp">
            <jsp:param name="page" value = ""/>
        </jsp:include>

        <main class="main">

            <!-- Page Title -->
            <div class="page-title dark-background" style="background-image: url(${pageContext.request.contextPath}/userPages/assets/img/page-title-bg.jpg);">
                <div class="container position-relative">
                    <h1>${ClubDAO.getClubByID(clubID).getClubInfo().getClubName()}</h1>
                </div>
            </div><!-- End Page Title -->

            <!-- Service Details Section -->
            <section id="service-details" class="service-details section">

                <div class="container">

                    <div class="row gy-4">

                        <jsp:include page="../components/clubSidebar.jsp">
                            <jsp:param name="page" value = "report"/>
                        </jsp:include>

                        <div class="col-lg-9" data-aos="fade-up" data-aos-delay="200">
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
                            <section id="testimonials" class="testimonials section">

                                <div class="container" data-aos="fade-up" data-aos-delay="100">

                                    <c:if test="${ReportDAO.getReportByClubID(clubID) == null}">
                                        <div class="swiper init-swiper">
                                            <div class="swiper-wrapper">
                                                <form action="Clubs" method="post">
                                                    <h2>Create Report</h2>
                                                    <label for="eventSummary" class="form-label">Event Summary</label>
                                                    <textarea class="form-control" id="eventSummary" name="eventSummary" rows="5"></textarea>
                                                    <input type="hidden" name="id" value="${id}"/>
                                                    <input type="hidden" name="clubID" value="${clubID}"/>
                                                    <input type="hidden" name="action" value="createReport"/>
                                                    <button type="submit" class="btn btn-primary mt-2">Create</button>
                                                </form>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${ReportDAO.getReportByClubID(clubID) != null}">
                                        <div class="swiper init-swiper">
                                            <div class="swiper-wrapper">
                                                <form action="Clubs" method="post">
                                                    <h2>Edit Report</h2>
                                                    <label for="eventSummary" class="form-label">Event Summary</label>
                                                    <textarea class="form-control" id="eventSummary" name="eventSummary" rows="5">${ReportDAO.getReportByClubID(clubID).getEventSummary()}</textarea>
                                                    <input type="hidden" name="reportID" value="${ReportDAO.getReportByClubID(clubID).getReportID()}"/>
                                                    <input type="hidden" name="clubID" value="${clubID}"/>
                                                    <input type="hidden" name="action" value="editReport"/>
                                                    <button type="submit" class="btn btn-primary mt-2">Save changes</button>
                                                </form>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </section>
                        </div>                    
                    </div>                   
                </div>

            </section><!-- /Service Details Section -->

        </main>

        <!-- Modal -->
        <div class="modal fade" id="announcementModal" tabindex="-1" aria-labelledby="announcementModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="announcementModalLabel">Post new announcement</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <form action="Clubs" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="announcementTitle" class="form-label">Title</label>
                                <input type="text" class="form-control" id="announcementTitle" name="title" placeholder="Enter title">
                            </div>
                            <div class="mb-3">
                                <label for="announcementContent" class="form-label">Content</label>
                                <textarea class="form-control" id="announcementContent" name="content"  rows="4" placeholder="Enter content"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <input type="hidden" name="clubID" value="${clubID}" />
                            <input type="hidden" name="id" value="${id}"/>
                            <input type="hidden" name="action" value="createAnnouncement" />
                            <button type="submit" class="btn btn-primary" id="saveAnnouncement">Post</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="../components/footer.jsp"/>

        <jsp:include page="../components/scrollTop.jsp"/>

        <jsp:include page="../components/preLoader.jsp"/>
        
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

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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
