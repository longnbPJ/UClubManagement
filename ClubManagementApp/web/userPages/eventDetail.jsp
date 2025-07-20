<%-- 
    Document   : eventDetail
    Created on : Mar 11, 2025, 12:42:21 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.EventDAO"%>
<%@page import="dao.ClubDAO"%>
<%@page import="dao.EventParticipantDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Event Detail</title>
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
        <link href="${pageContext.request.contextPath}/userPages/assets/css/custom.css?v=1.0.4" rel="stylesheet">

    </head>
    <body>

        <jsp:include page="components/header.jsp">
            <jsp:param name="page" value = "event"/>
        </jsp:include>

        <main class="main">

            <!-- Page Title -->
            <div class="page-title dark-background" style="background-image: url(assets/img/page-title-bg.jpg);">
                <div class="container position-relative">
                    <h1>Event Details</h1>
                    <nav class="breadcrumbs">
                        <ol>
                            <li><a href="index.html">Home</a></li>
                            <li class="current">Event Details</li>
                        </ol>
                    </nav>
                </div>
            </div><!-- End Page Title -->

            <div class="container">
                <div class="row">
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
                    </c:if>

                    <div class="col-lg-8">
                        <!-- Blog Details Section -->
                        <section id="blog-details" class="blog-details section">
                            <div class="container">

                                <article class="article">
                                    <h2 class="title">${EventDAO.getEventByID(eventID).getEventInfo().getEventName()}</h2>
                                    <div class="meta-top">
                                        <ul>
                                            <li class="d-flex align-items-center"><i class="bi bi-person"></i> <a href="Clubs?clubID=${EventDAO.getEventByID(eventID).getClubInfo().getClubID()}">${EventDAO.getEventByID(eventID).getClubInfo().getClubName()}</a></li>
                                            <li class="d-flex align-items-center"><i class="bi bi-clock"></i> <a>${EventDAO.getEventByID(eventID).getEventInfo().getEventDate()}</a></li>
                                            <li class="d-flex align-items-center"><i class="bi bi-clock"></i> <a>${EventDAO.getEventByID(eventID).getEventInfo().getEventTime()}</a></li>
                                        </ul>
                                    </div><!-- End meta top -->

                                    <div class="content event-detail-content">
                                        <img src="${pageContext.request.contextPath}/userPages/assets/img/constructions-1.jpg" class="img-fluid" alt="">
                                        <p>
                                            ${EventDAO.getEventByID(eventID).getEventInfo().getEventDesc()}
                                        </p>  
                                    </div><!-- End post content -->

                                    <div class="event-detail-actions">
                                        <c:if test="${user.getAccountID() == ClubDAO.getClubByID(EventDAO.getEventByID(eventID).getClubInfo().getClubID()).getManager() 
                                                      && EventDAO.getEventByID(eventID).getStatus() != 'Finished' 
                                                      && EventDAO.getEventByID(eventID).getStatus() != 'Cancel' 
                                                      || user.getUserRoleID() == 1}">
                                              <a href="" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editEventModal">Edit</a>
                                        </c:if>

                                        <form action="Events" method="POST">
                                            <input type="hidden" name="eventID" value="${eventID}">
                                            <input type="hidden" name="action" value="joinEvent">
                                            <c:if test="${id == null || !EventParticipantDAO.joinEventParticipant(eventID,id) 
                                                          && EventDAO.getEventByID(eventID).getStatus() != 'Finished' 
                                                          && EventDAO.getEventByID(eventID).getStatus() != 'Cancel'}">
                                                  <input type="submit" value="Join Event" class="btn btn-primary"/>
                                            </c:if>
                                        </form>
                                    </div>

                                </article>
                            </div>

                        </section><!-- /Blog Details Section -->
                    </div>

                    <div class="col-lg-4 sidebar">

                        <div class="widgets-container">
                            <!-- Recent Posts Widget -->
                            <div class="recent-posts-widget widget-item">
                                <h3 class="widget-title">Other Events: </h3>
                                <c:forEach items="${EventDAO.getEvents()}" var="event" begin="0" end="5">
                                    <div class="post-item">
                                        <img src="${pageContext.request.contextPath}/userPages/assets/img/constructions-1.jpg" alt="" class="flex-shrink-0">
                                        <div>
                                            <h4><a href="Events?eventID=${event.getEventInfo().getEventID()}">${event.getEventInfo().getEventName()}</a></h4>
                                            <a>${event.getEventInfo().getEventDate()}</a>
                                        </div>
                                    </div><!-- End recent post item-->
                                </c:forEach>
                            </div><!--/Recent Posts Widget -->    

                        </div>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="components/footer.jsp"/>

        <jsp:include page="components/scrollTop.jsp"/>

        <jsp:include page="components/preLoader.jsp"/>

        <!-- Modal -->
        <div class="modal fade" id="editEventModal" tabindex="-1" aria-labelledby="editEventModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editEventModalLabel">Edit Event</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="editEventForm" action="Events" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="eventName" class="form-label">Event Name</label>
                                <input type="text" class="form-control" id="eventName" name="eventName" placeholder="Enter event name" required value="${EventDAO.getEventByID(eventID).getEventInfo().getEventName()}">
                            </div>
                            <div class="mb-3">
                                <label for="eventName" class="form-label">Event Location</label>
                                <input type="text" class="form-control" id="eventLocation" name="eventName" placeholder="Enter event name" required value="${EventDAO.getEventByID(eventID).getEventInfo().getEventLocation()}">
                            </div>
                            <div class="mb-3">
                                <label for="eventImg" class="form-label">Image URL</label>
                                <input type="url" class="form-control" id="eventImg" name="eventImg" placeholder="Enter image URL" value="${EventDAO.getEventByID(eventID).getEventInfo().getEventImgURL()}">
                            </div>
                            <div class="mb-3">
                                <label for="eventDate" class="form-label">Event Date</label>
                                <input type="date" class="form-control" id="eventDate" name="eventDate"  required value="${EventDAO.getEventByID(eventID).getEventInfo().getEventDate()}">
                            </div>
                            <div class="mb-3">
                                <label for="eventTime" class="form-label">Event Time</label>
                                <input type="time" class="form-control" id="eventTime" required  name="eventTime" value="${EventDAO.getEventByID(eventID).getEventInfo().getEventTime()}">
                            </div>
                            <div class="mb-3">
                                <label for="eventDesc" class="form-label">Description</label>
                                <textarea class="form-control" id="eventDesc" rows="3"  name="eventDesc" placeholder="Enter event description" required>${EventDAO.getEventByID(eventID).getEventInfo().getEventDesc()}</textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <input type="hidden" name="action" value="editEventInfo"/>
                            <input type="hidden" name="eventID" value="${eventID}"/>
                            <button type="submit" class="btn btn-primary" id="saveEvent">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

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

        <%request.getSession().removeAttribute("isSuccess");%>

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
