<%-- 
    Document   : login.jsp
    Created on : Mar 9, 2025, 9:26:12 PM
    Author     : PC ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String redirectURL = (String) session.getAttribute("redirectAfterLogin");
    if (redirectURL == null) {
        redirectURL = "User"; 
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Login</title>
        <meta name="description" content="">
        <meta name="keywords" content="">

        <!-- Favicons -->
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
        <link href="${pageContext.request.contextPath}/userPages/assets/css/custom.css?v=1.0.1" rel="stylesheet">
    </head>
    <body class="contact-page">

        <jsp:include page="components/header.jsp">
            <jsp:param name="page" value = "login"/>
        </jsp:include>

        <main class="main">

            <jsp:include page="components/pageTitle.jsp">
                <jsp:param name="pageTitle" value = "Login"/>
                <jsp:param name="imgURL" value = "${pageContext.request.contextPath}/userPages/assets/img/fpt.webp"/>
            </jsp:include>

            <c:if test="${not empty isSuccess}">
                <c:choose>
                    <c:when test="${isSuccess == true}">
                        <div id="notification" class="alert alert-success alert-dismissible fade show" role="alert">
                            Reset Successfully!
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div id="notification" class="alert alert-danger alert-dismissible fade show" role="alert">
                            Reset fail!
                        </div>
                    </c:otherwise>
                </c:choose>
                <%request.getSession().removeAttribute("isSuccess");%>
            </c:if>

            <!-- Contact Section -->
            <section id="contact" class="contact section">

                <div class="container" data-aos="fade-up" data-aos-delay="100">

                    <div class="col-lg-6 mx-auto">
                        <!--<form action="Login" method="post" class="php-email-form" data-aos="fade-up" data-aos-delay="400">-->
                        <form action="Login" method="post" class="login-form" data-aos="fade-up" data-aos-delay="400">
                            <div class="row gy-4">

                                <div class="col-md-12">
                                    <label >Email</label>
                                    <input type="text" class="form-control ${not empty error ? "is-invalid" : ''}" name="email" placeholder="Enter email" required="" value="${not empty error ? email : ''}">
                                </div>

                                <div class="col-md-12">
                                    <label>Password</label>
                                    <input type="password" class="form-control ${not empty error ? "is-invalid" : ''}" name="password" placeholder="Enter password" required="" value="${not empty error ? password : ''}">
                                </div>  

                                <c:if test="${error != null}">
                                    <p class="login-error">${error}</p>
                                </c:if>
                                <a href="" data-bs-toggle="modal" data-bs-target="#emailModal">Reset password</a>
                                <input type="submit" value="Login" class="login-signup-button"/>
                            </div>
                        </form>
                    </div><!-- End Contact Form -->

                </div>

            </section><!-- /Contact Section -->

        </main>

        <!-- Modal -->
        <div class="modal fade" id="emailModal" tabindex="-1" aria-labelledby="emailModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="emailModalLabel">Enter email to reset password</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="emailForm" action="User" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="emailInput" class="form-label">Email</label>
                                <input type="email" class="form-control" id="emailInput" name="email" placeholder="Enter your email">
                                <div class="invalid-feedback">Enter your email</div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" name="action" value="resetPassword"/>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" id="submitEmail">Reset</button>
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
