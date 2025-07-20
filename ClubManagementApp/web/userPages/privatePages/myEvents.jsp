<%-- 
    Document   : myEvents
    Created on : Mar 11, 2025, 12:03:27 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.EventParticipantDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>My Events</title>
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
            <jsp:param name="page" value = "myAccount"/>
        </jsp:include>

        <main class="main">

            <jsp:include page="../components/pageTitle.jsp">
                <jsp:param name="pageTitle" value = "My events"/>
                <jsp:param name="imgURL" value = "${pageContext.request.contextPath}/userPages/assets/img/fpt.webp"/>
                <jsp:param name="prevPage" value = "My account"/>
                <jsp:param name="prevLink" value = "${pageContext.request.contextPath}/User"/>
            </jsp:include>

            <!-- Blog Posts Section -->
            <section id="blog-posts" class="blog-posts section eventsReview">

                <div class="container">

                    <div class="row gy-4 justify-content-center search-section">

                        <!-- Search Widget -->
                        <div class="search-widget widget-item col-lg-6">

                            <!--                            <h3 class="widget-title">Search</h3>-->
                            <form action="">
                                <input type="text" placeholder="Search">
                                <button type="submit" title="Search"><i class="bi bi-search"></i></button>
                            </form>

                        </div><!--/Search Widget -->
                    </div>


                    <div class="row gy-4">

                        <c:forEach items="${EventParticipantDAO.getEventParticipants()}" var="eventParticipant">
                            <c:if test="${eventParticipant.getAccount().getAccountID() == id}">
                                <div class="col-lg-4">
                                    <article class="position-relative h-100">

                                        <div class="post-img position-relative overflow-hidden">
                                            <img src="${pageContext.request.contextPath}/userPages/assets/img/blog/blog-1.jpg" class="img-fluid" alt="">
                                            <span class="post-date">${eventParticipant.getEvent().getEventInfo().getEventDate()}</span>
                                        </div>

                                        <div class="post-content d-flex flex-column">

                                            <h3 class="post-title">${eventParticipant.getEvent().getEventInfo().getEventName()}</h3>

                                            <div class="meta d-flex align-items-center">
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-person"></i> <span class="ps-2">${eventParticipant.getEvent().getClubInfo().getClubName()}</span>
                                                </div>
                                            </div>

                                            <p>
                                                ${eventParticipant.getEvent().getEventInfo().getEventDesc()}
                                            </p>

                                            <hr>

                                            <a href="Events?eventID=${eventParticipant.getEvent().getEventID()}" class="readmore stretched-link"><span>Read More</span><i class="bi bi-arrow-right"></i></a>

                                        </div>

                                    </article>
                                </div><!-- End post list item -->
                            </c:if>
                        </c:forEach>
                        <c:if test="${empty EventParticipantDAO.getEventParticipantsByID(user.getAccountID())}">
                            <center>
                                <button class="btn btn-primary w-25">
                                    <a href="Events">Join an event.</a>
                                </button>
                            </center>
                        </c:if>
                    </div>
                </div>

            </section><!-- /Blog Posts Section -->

            <!--             Blog Pagination Section 
                        <section id="blog-pagination" class="blog-pagination section">
            
                            <div class="container">
                                <div class="d-flex justify-content-center">
                                    <ul>
                                        <li><a href="#"><i class="bi bi-chevron-left"></i></a></li>
                                        <li><a href="#">1</a></li>
                                        <li><a href="#" class="active">2</a></li>
                                        <li><a href="#">3</a></li>
                                        <li><a href="#">4</a></li>
                                        <li>...</li>
                                        <li><a href="#">10</a></li>
                                        <li><a href="#"><i class="bi bi-chevron-right"></i></a></li>
                                    </ul>
                                </div>
                            </div>
            
                        </section> /Blog Pagination Section -->

        </main>

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
