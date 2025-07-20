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
                <jsp:param name="pageTitle" value = "My information"/>
                <jsp:param name="imgURL" value = "${pageContext.request.contextPath}/userPages/assets/img/fpt.webp"/>
                <jsp:param name="prevPage" value = "My account"/>
                <jsp:param name="prevLink" value = "${pageContext.request.contextPath}/User"/>
            </jsp:include>

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

            <section id="alt-services" class="alt-services section">

                <div class="container">

                    <div class="row justify-content-around gy-4">
                        <div class="features-image col-lg-4">
                            <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-1.jpg" alt=""> 
                        </div>

                        <div class="col-lg-8 d-flex flex-column justify-content-center">
                            <h3>${user.getFullname()}</h3>
                            <p class="member-desc">${user.getDescription()}<a href=""> <i class="bi bi-pencil-square"></i> </a> </p>

                            <div class="icon-box d-flex position-relative infor-detail">
                                <div>
                                    <h4>Email</h4>
                                    <p>${user.getEmail()}</p>
                                </div>
                            </div><!-- End Icon Box -->
                            <c:if test="${user.getUserRoleID() != 1 && user.getUserRoleID() != 2}">
                                <div class="icon-box d-flex position-relative infor-detail">
                                    <div>
                                        <h4>Major</h4>
                                        <p>${user.getUserRoleID() != 3 ? "Null" : AccountDAO.getAccountByID(user.getAccountID()).getStudentInfo().getMajor()}</p>
                                    </div>
                                </div><!-- End Icon Box -->
                            </c:if>
                            <c:if test="${user.getUserRoleID() == 1 || user.getUserRoleID() == 2}">
                                <div class="icon-box d-flex position-relative infor-detail">
                                    <div>
                                        <h4>Role</h4>
                                        <p>${AccountDAO.getRoleAccount(user.getUserRoleID())}</p>
                                    </div>
                                </div><!-- End Icon Box -->
                            </c:if>
                            <div class="mt-3">
                                <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#changePasswordModal">Change password</button>
                            </div>
                        </div>
                    </div>
                </div>

            </section><!-- /Alt Services Section -->

        </main>

        <!-- Modal -->
        <div class="modal fade " id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="changePasswordModalLabel">Change password</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="User" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current password</label>
                                <input type="password" class="form-control ${error == "Incorrect password!" ? "is-invalid" : ""}" id="currentPassword" name="currentPassword" placeholder="Enter current password" value="${currentPassword}" required/>
                                <div class="invalid-feedback">${error}</div>
                            </div>
                            <div class="mb-3">
                                <label for="newPassword" class="form-label ${error == "Password length must > 6!" ? "is-invalid" : ""}">New password</label> 
                                <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Enter new password"  value="${newPassword}" required/>
                                <div class="invalid-feedback">${error}</div>
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label ${error == "Confirm password not match!" ? "is-invalid" : ""}">Confirm new password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password"  value="${confirmPassword}" required/>
                                <div class="invalid-feedback">${error}</div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <input type="hidden" name="action" value="changePassword"/>
                            <input type="hidden" name="id" value="${id}"/>
                            <button type="submit" class="btn btn-primary" id="savePassword">Save</button>
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
                var error = "<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>";
                if (error.trim() !== "") {
                    var myModal = new bootstrap.Modal(document.getElementById('changePasswordModal'));
                    myModal.show();
                }
            });

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
