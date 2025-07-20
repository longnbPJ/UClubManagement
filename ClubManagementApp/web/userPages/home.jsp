<%-- 
    Document   : home
    Created on : Mar 11, 2025, 12:37:30 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.EventDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Events</title>
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
            <jsp:param name="page" value = "home"/>
        </jsp:include>

        <main class="main">

            <!-- Hero Section -->
            <section id="hero" class="hero section dark-background">

                <div class="info d-flex align-items-center">
                    <div class="container">
                        <div class="row justify-content-center hero-slide-custom" data-aos="fade-up" data-aos-delay="100">
                            <div class="col-lg-6 text-center">
                                <h2>Welcome to Club Management App</h2>
                                <p>Our Club Management App streamlines member tracking, event planning, and communication, ensuring efficient and organized club operations.</p>
                                <c:if test="${empty user}">
                                    <a href="Login" class="btn-get-started">Login</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="hero-carousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="5000">

                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/userPages/assets/img/hero-carousel/CLB-FPTU-DN.jpeg" alt=""/>
                    </div>

                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/userPages/assets/img/hero-carousel/screen-shot-2021-05-24-at-12.36.27-pm-910x603_1.png" alt=""/>
                    </div>

                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/userPages/assets/img/hero-carousel/ntclub2.jpeg" alt=""/>
                    </div>

                    <a class="carousel-control-prev" href="#hero-carousel" role="button" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon bi bi-chevron-left" aria-hidden="true"></span>
                    </a>

                    <a class="carousel-control-next" href="#hero-carousel" role="button" data-bs-slide="next">
                        <span class="carousel-control-next-icon bi bi-chevron-right" aria-hidden="true"></span>
                    </a>

                </div>

            </section><!-- /Hero Section -->

            <!-- Recent Blog Posts Section -->
            <section id="recent-blog-posts" class="recent-blog-posts section">

                <!-- Section Title -->
                <div class="container section-title" data-aos="fade-up">
                    <h2>Recent Events</h2>
                </div><!-- End Section Title -->

                <div class="container">

                    <div class="row gy-5">
                        <c:set var="count" value="0" scope="page" />
                        <c:forEach items="${EventDAO.getEvents()}" var="event" varStatus="loop">
                            <c:if test="${!event.getStatus().equals('Cancel') && !event.getStatus().equals('Upcoming') && count < 3}">

                                <div class="col-xl-4 col-md-6">
                                    <div class="post-item position-relative h-100" data-aos="fade-up" data-aos-delay="100">

                                        <div class="post-img position-relative overflow-hidden">
                                            <img src="${pageContext.request.contextPath}/userPages/assets/img/blog/blog-1.jpg" class="img-fluid" alt="">
                                            <span class="post-date">${event.getEventInfo().getEventDate()}</span>
                                        </div>

                                        <div class="post-content d-flex flex-column">

                                            <h3 class="post-title">${event.getEventInfo().getEventName()}</h3>
                                            <div class="meta d-flex align-items-center">
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-person"></i> <span class="ps-2">${event.getClubInfo().getClubName()}</span>
                                                </div>
                                            </div>

                                            <hr>

                                            <a href="Events?id=${user.getAccountID()}&eventID=${event.getEventID()}" class="readmore stretched-link"><span>Read More</span><i class="bi bi-arrow-right"></i></a>

                                        </div>

                                    </div>
                                </div><!-- End post item -->
                                <c:set var="count" value="${count + 1}" scope="page" />
                            </c:if>
                        </c:forEach>

                    </div>

                </div>

            </section><!-- /Recent Blog Posts Section -->

        </main>

        <jsp:include page="components/footer.jsp"/>

        <jsp:include page="components/scrollTop.jsp"/>

        <jsp:include page="components/preLoader.jsp"/>

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
