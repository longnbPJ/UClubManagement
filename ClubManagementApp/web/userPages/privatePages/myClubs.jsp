<%-- 
    Document   : myClubs
    Created on : Mar 10, 2025, 11:53:17 PM
    Author     : PC ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.ClubMemberDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>My clubs</title>
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
                <jsp:param name="pageTitle" value = "My clubs"/>
                <jsp:param name="imgURL" value = "${pageContext.request.contextPath}/userPages/assets/img/fpt.webp"/>
                <jsp:param name="prevPage" value = "My account"/>
                <jsp:param name="prevLink" value = "${pageContext.request.contextPath}/User"/>
            </jsp:include>

            <!-- Alt Services Section -->
            <section id="alt-services" class="alt-services section">

                <div class="container">

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

                    <div class="row justify-content-around gy-4">

                        <div class="col-lg-10 d-flex flex-column justify-content-center" data-aos="fade-up" data-aos-delay="200">

                            <button class="btn btn-primary w-25" data-bs-toggle="modal" data-bs-target="#createClubModal">Create Club</button>

                            <c:forEach items="${ClubMemberDAO.getClubMembers()}" var="clubMember">
                                <c:if test="${clubMember.getAccount().getAccountID() == id}">
                                    <div class="icon-box d-flex position-relative clb-container" data-aos="fade-up" data-aos-delay="100">
                                        <div class="Clb-Img">
                                            <img src="${pageContext.request.contextPath}/userPages/assets/img/hero-carousel/CLB-FPTU-DN.jpeg" alt=""/>
                                        </div>
                                        <div>
                                            <h4><a href="${pageContext.request.contextPath}/Clubs?clubID=${clubMember.getClubInfo().getClubID()}" class="stretched-link">${clubMember.getClubInfo().getClubName()}</a></h4>
                                            <p>${clubMember.getClubRole()}</p>
                                        </div>
                                    </div><!-- End Icon Box -->
                                </c:if>
                            </c:forEach>

                        </div>
                    </div>

                </div>

            </section><!-- /Alt Services Section -->

        </main>

        <!-- Modal -->
        <div class="modal fade" id="createClubModal" tabindex="-1" aria-labelledby="createClubModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createClubModalLabel">Create New Club</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="Request" method="post">
                        <div class="modal-body">
                            <!-- Club Name -->
                            <div class="mb-3">
                                <label for="clubName" class="form-label">Club Name</label>
                                <input type="text" class="form-control" id="clubName" name="clubName" placeholder="Enter club name" required>
                            </div>

                            <!-- Club Description -->
                            <div class="mb-3">
                                <label for="clubDesc" class="form-label">Club Description</label>
                                <textarea class="form-control" id="clubDesc" rows="3"  name="clubDesc" placeholder="Enter club description" required></textarea>
                            </div>

                            <!-- Club Image Link -->
                            <div class="mb-3">
                                <label for="clubImg" class="form-label">Club Image Link</label>
                                <input type="text" class="form-control" id="clubImg"  name="clubImgUrl" placeholder="Enter image URL">
                            </div>

                            <!-- Establish Date -->
                            <div class="mb-3">
                                <label for="establishDate" class="form-label">Establish Date</label>
                                <input type="date" class="form-control" id="establishDate" name="clubEstablishDate" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <input type="hidden" name="action" value="createClub"/>
                            <input type="hidden" name="id" value="${id}"/>
                            <button type="submit" class="btn btn-primary">Send Request</button>
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
