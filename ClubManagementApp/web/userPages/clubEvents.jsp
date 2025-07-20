<%-- 
    Document   : myAccount
    Created on : Mar 9, 2025, 10:06:18 PM
    Author     : PC ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.ClubDAO"%>
<%@page import="dao.ClubMemberDAO"%>
<%@page import="dao.EventDAO"%>
<%@page import="dao.QuestionDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>My Account</title>
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

        <jsp:include page="components/header.jsp">
            <jsp:param name="page" value = "myAccount"/>
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

                        <jsp:include page="components/clubSidebar.jsp">
                            <jsp:param name="page" value = "events"/>
                        </jsp:include>

                        <div class="col-lg-9" data-aos="fade-up" data-aos-delay="200">
                            <section id="recent-blog-posts" class="recent-blog-posts section">
                                <div class="container">
                                    <div class="gy-5 club-events-container projects mt-2 mb-0 isotope-layout" data-default-filter="*" data-layout="masonry" data-sort="original-order">
                                        <ul class="portfolio-filters isotope-filters" data-aos="fade-up" data-aos-delay="100">
                                            <li data-filter="*" class="filter-active">All</li>
                                            <li data-filter=".filter-Finished">Finished</li>
                                            <li data-filter=".filter-Ongoing">On going</li>
                                            <li data-filter=".filter-Upcoming">Upcoming</li>
                                            <li data-filter=".filter-Cancel">Cancel</li>
                                        </ul><!-- End Portfolio Filters -->

                                        <div class="config-container">
                                            <c:set var="userRole" value="${ClubMemberDAO.getUserClubRole(id,clubID)}" scope="page"/>
                                            <c:if test="${(not empty user && ClubMemberDAO.isUserInClub(id,clubID) && (userRole.equals('Manager') || userRole.equals('Adviser'))) || (user.getUserRoleID() == 1)}">
                                                <a href="" class="d-flex align-items-center" data-bs-toggle="modal" data-bs-target="#createEventModal">
                                                    Create new event
                                                    <i class="bi bi-plus-square m-2"></i>
                                                </a>
                                            </c:if>

                                        </div>

                                        <div class="row gy-3 isotope-container mt-4">
                                            <c:forEach items="${EventDAO.getEvents()}" var="event">
                                                <c:if test="${(event.getClubInfo().getClubID() == ClubDAO.convertClubID(clubID))}">
                                                    <div class="col-xl-4 col-md-6 event-item isotope-item filter-${event.getStatus()}">
                                                        <div class="post-item position-relative">

                                                            <div class="post-img position-relative overflow-hidden">
                                                                <img src="${pageContext.request.contextPath}/userPages/assets/img/blog/blog-1.jpg" class="img-fluid" alt="">
                                                                <span class="post-date">${event.getEventInfo().getEventDate()}</span>
                                                            </div>

                                                            <div class="post-content d-flex flex-column">

                                                                <h3 class="post-title text-clamp">${event.getEventInfo().getEventName()}</h3>

                                                                <div class="meta d-flex align-items-center">
                                                                    <div class="d-flex align-items-center">
                                                                        <i class="bi bi-person"></i> <span class="ps-2">${event.getClubInfo().getClubName()}</span>
                                                                    </div>
                                                                </div>

                                                                <hr>

                                                                <a href="Events?eventID=${event.getEventID()}" class="readmore stretched-link"><span>Read More</span><i class="bi bi-arrow-right"></i></a>

                                                            </div>

                                                        </div>
                                                    </div><!-- End post item -->
                                                </c:if>
                                            </c:forEach>
                                        </div>

                                    </div>

                                </div>

                            </section><!-- /Recent Blog Posts Section -->

                        </div>

                    </div>

                </div>

            </section><!-- /Service Details Section -->

        </main>

        <jsp:include page="components/footer.jsp"/>

        <jsp:include page="components/scrollTop.jsp"/>

        <jsp:include page="components/preLoader.jsp"/>


        <!-- Create Event Modal -->
        <div class="modal fade" id="createEventModal" tabindex="-1" aria-labelledby="createEventModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Header -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="createEventModalLabel">Create New Event</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <form action="Request" method="post">
                        <!-- Body -->
                        <div class="modal-body">
                            <!-- Event Name -->
                            <div class="mb-3">
                                <label for="eventName" class="form-label">Event Name</label>
                                <input type="text" class="form-control" name="eventName" placeholder="Enter event name" required>
                            </div>

                            <!-- Description -->
                            <div class="mb-3">
                                <label for="eventDescription" class="form-label">Description</label>
                                <input type="text" class="form-control" name="eventDescription" placeholder="Enter description" required>
                            </div>

                            <!-- Date & Time -->
                            <div class="mb-3">
                                <label for="eventDateTime" class="form-label">Date & Time</label>
                                <input type="time" class="form-control" name="eventTime" required >
                                <input type="date" class="form-control" name="eventDate" required >
                            </div>

                            <!-- Event Image -->
                            <div class="mb-3">
                                <label for="eventImage" class="form-label">Event Image</label>
                                <input type="text" class="form-control" name="eventImage" placeholder="Enter link img event" accept="image/*">
                            </div>

                            <!-- Location -->
                            <div class="mb-3">
                                <label for="eventLocation" class="form-label">Location</label>
                                <input type="text" class="form-control" name="eventLocation" placeholder="Enter event location" required>
                            </div>
                        </div>

                        <!-- Footer -->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <input type="hidden" name="action" value="createEvent"/>
                            <input type="hidden" name="id" value="${id}"/>
                            <input type="hidden" name="clubID" value="${clubID}"/>
                            <button type="submit" class="btn btn-primary">Send Request</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy giá trị biến isSuccess từ request
                var isSuccess = '<%=  request.getSession().getAttribute("isSuccess") %>';

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
