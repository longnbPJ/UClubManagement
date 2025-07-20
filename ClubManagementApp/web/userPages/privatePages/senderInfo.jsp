<%-- 
    Document   : MyInfo
    Created on : Mar 9, 2025, 9:47:11 PM
    Author     : PC ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.AccountDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>My Info</title>
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
                <jsp:param name="pageTitle" value = "Sender Info"/>
                <jsp:param name="imgURL" value = "${pageContext.request.contextPath}/userPages/assets/img/fpt.webp"/>
                <jsp:param name="prevPage" value = "My account"/>
                <jsp:param name="prevLink" value = "${pageContext.request.contextPath}/User"/>
            </jsp:include>

            <section id="alt-services" class="alt-services section">

                <div class="container">

                    <div class="row justify-content-around gy-4">
                        <div class="features-image col-lg-4">
                            <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-1.jpg" alt=""> 
                        </div>

                        <div class="col-lg-8 d-flex flex-column justify-content-center">
                            <h3>${AccountDAO.getAccountByID(senderID).getFullname()}</h3>
                            <p class="member-desc">${AccountDAO.getAccountByID(senderID).getDescription()}<a href=""> <i class="bi bi-pencil-square"></i> </a> </p>

                            <div class="icon-box d-flex position-relative infor-detail">
                                <div>
                                    <h4>Email</h4>
                                    <p>${AccountDAO.getAccountByID(senderID).getEmail()}</p>
                                </div>
                            </div><!-- End Icon Box -->
                            <c:if test="${AccountDAO.getAccountByID(senderID).getUserRoleID() != 1 && AccountDAO.getAccountByID(senderID).getUserRoleID() != 2}">
                                <div class="icon-box d-flex position-relative infor-detail">
                                    <div>
                                        <h4>Major</h4>
                                        <p>${AccountDAO.getAccountByID(senderID).getUserRoleID() != 3 ? "Null" : AccountDAO.getAccountByID(senderID).getStudentInfo().getMajor()}</p>
                                    </div>
                                </div><!-- End Icon Box -->
                            </c:if>
                            <c:if test="${AccountDAO.getAccountByID(senderID).getUserRoleID() == 1 || AccountDAO.getAccountByID(senderID).getUserRoleID() == 2}">
                                <div class="icon-box d-flex position-relative infor-detail">
                                    <div>
                                        <h4>Role</h4>
                                        <p>${AccountDAO.getRoleAccount(AccountDAO.getAccountByID(senderID).getUserRoleID())}</p>
                                    </div>
                                </div><!-- End Icon Box -->
                            </c:if>

                        </div>
                    </div>
                </div>

            </section><!-- /Alt Services Section -->

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
