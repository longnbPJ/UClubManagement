<%-- 
    Document   : clubs
    Created on : Mar 11, 2025, 12:33:04 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.ClubDAO"%>
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
        <link href="${pageContext.request.contextPath}/userPages/assets/css/custom.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="components/header.jsp">
            <jsp:param name="page" value = "club"/>
        </jsp:include>
        <main class="main">

            <jsp:include page="components/pageTitle.jsp">
                <jsp:param name="pageTitle" value = "Clubs"/>
                <jsp:param name="imgURL" value = "${pageContext.request.contextPath}/userPages/assets/img/fpt.webp"/>
            </jsp:include>

            <!-- Alt Services 2 Section -->
            <section id="alt-services-2" class="alt-services-2 section search-section">

                <div class="container">

                </div>

            </section><!-- /Alt Services 2 Section -->

            <c:forEach items="${ClubDAO.getClubs()}" var="club">
                <section id="alt-services-2" class="alt-services-2 section">
                    <div class="container">
                        <div class="row justify-content-around gy-4 club-item">     
                            <div class="col-lg-6 d-flex flex-column justify-content-center order-2 order-lg-1" data-aos="fade-up" data-aos-delay="100">
                                <h3>${club.getClubInfo().getClubName()}</h3>
                                <p>${club.getClubInfo().getClubDesc()}</p>
                                <div class="row">
                                    <section id="clb-contact" class="recent-blog-posts section">
                                        <div class="container clb-contact-container">
                                            <div class="col-lg-4">
                                            </div>

                                            <div class="col-lg-4 join-now-button-container">
                                                <form action="Clubs" method="GET">
                                                    <input type="hidden" name="id" value="${user.getAccountID()}"/>
                                                    <input type="hidden" name="clubID" value="${club.getClubID()}"/>
                                                    <input type="submit" value="SEE MORE >" class="join-now-button"/>
                                                </form>
                                            </div>
                                        </div>
                                    </section><!-- /Recent Blog Posts Section -->
                                </div>

                            </div>

                            <div class="features-image col-lg-5 order-1 order-lg-2" data-aos="fade-up" data-aos-delay="200">
                                <img src="${pageContext.request.contextPath}/userPages/assets/img/features-3-2.jpg" alt="">
                            </div>
                        </div>
                    </div>
                </section><!-- /Alt Services 2 Section -->
            </c:forEach>

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
