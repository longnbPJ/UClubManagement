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
<%@page import="dao.RequestDAO"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Club Review</title>
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
        <link href="${pageContext.request.contextPath}/userPages/assets/css/main.css?v=1.0.1" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/userPages/assets/css/custom.css" rel="stylesheet">
    </head>
    <body>

        <jsp:include page="components/header.jsp">
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

                        <jsp:include page="components/clubSidebar.jsp">
                            <jsp:param name="page" value="review"/>
                        </jsp:include>

                        <div class="col-lg-9" data-aos="fade-up" data-aos-delay="200">
                            <div class="row gy-5">

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

                                <!-- About Section -->
                                <section id="about" class="about section">

                                    <div class="container">

                                        <div class="row position-relative">

                                            <div class="col-lg-6 about-img" data-aos="zoom-out" data-aos-delay="200"><img src="${pageContext.request.contextPath}/userPages/assets/img/about.jpg"></div>

                                            <div class="col-lg-8" data-aos="fade-up" data-aos-delay="100">
                                                <c:if test="${(ClubMemberDAO.isUserInClub(id,clubID) && (not empty user) && (ClubMemberDAO.getUserClubRole(id,clubID).equals('Manager') || ClubMemberDAO.getUserClubRole(id,clubID).equals('Adviser'))) || (user.getUserRoleID() == 1)}">
                                                    <a href="" data-bs-toggle="modal" data-bs-target="#clubModal"><i class="bi bi-gear fs-3"></i></a>
                                                    </c:if>
                                                <h2 class="inner-title d-flex flex-column">
                                                </h2>
                                                <!--<div></div>-->
                                                <div class="our-story">
                                                    <h4>${ClubDAO.getClubByID(clubID).getEstablishDate()}</h4>
                                                    <h3>Our Story</h3>
                                                    <p>${ClubDAO.getClubByID(clubID).getClubInfo().getClubDesc()}</p>

                                                    <div class="watch-video d-flex align-items-center position-relative">
                                                        <i class="bi bi-play-circle"></i>
                                                        <a href="https://www.youtube.com/watch?v=Y7f98aduVJ8" class="glightbox stretched-link">Watch Video</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </div>

                                </section><!-- /About Section -->

                                <!-- Stats Counter Section -->
                                <section id="stats-counter" class="stats-counter section">

                                    <!-- Section Title -->
                                    <div class="container section-title" data-aos="fade-up">
                                        <h2>Statistics</h2>
                                    </div><!-- End Section Title -->

                                    <div class="container" data-aos="fade-up" data-aos-delay="100">

                                        <div class="row gy-4 d-flex justify-content-center">

                                            <div class="col-xl-3 col-md-6">
                                                <div class="stats-item d-flex align-items-center w-100 h-100">
                                                    <i class="bi bi-people"></i>
                                                    <div>
                                                        <span data-purecounter-start="0" data-purecounter-end="${ClubMemberDAO.countMembersByClubID(clubID)}" data-purecounter-duration="1" class="purecounter"></span>
                                                        <p>Members</p>
                                                    </div>
                                                </div>
                                            </div><!-- End Stats Item -->

                                            <div class="col-xl-3 col-md-6">
                                                <div class="stats-item d-flex align-items-center w-100 h-100">
                                                    <i class="bi bi-card-checklist"></i>
                                                    <div>
                                                        <span data-purecounter-start="0" data-purecounter-end="${EventDAO.countEventsByClubID(clubID)}" data-purecounter-duration="1" class="purecounter"></span>
                                                        <p>Events</p>
                                                    </div>
                                                </div>
                                            </div><!-- End Stats Item -->

                                            <div class="col-xl-3 col-md-6">
                                                <div class="stats-item d-flex align-items-center w-100 h-100">
                                                    <i class="bi bi-calendar-event"></i>
                                                    <div>
                                                        <span data-purecounter-start="0" data-purecounter-end="${ClubDAO.getClubByID(clubID).getClubYears()}" data-purecounter-duration="1" class="purecounter"></span>
                                                        <p>Years</p>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </section><!-- /Stats Counter Section -->

                                <section id="recent-blog-posts" class="recent-blog-posts section">
                                    <!-- Section Title -->
                                    <div class="container section-title" data-aos="fade-up">
                                        <h2>Recent Events</h2>
                                    </div><!-- End Section Title -->
                                    <div class="container">
                                        <div class="row gy-5">
                                            <c:forEach items="${EventDAO.getEvents()}" var="event">
                                                <c:if test="${!event.getStatus().equals('Cancel') && (event.getClubInfo().getClubID() == ClubDAO.convertClubID(clubID))}">
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

                                                                <a href="Events?eventID=${event.getEventID()}" class="readmore stretched-link"><span>Read More</span><i class="bi bi-arrow-right"></i></a>

                                                            </div>

                                                        </div>
                                                    </div><!-- End post item -->
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>

                                </section><!-- /Recent Blog Posts Section -->

                                <!-- Team Section -->
                                <section id="team" class="team section">

                                    <!-- Section Title -->
                                    <div class="container section-title" data-aos="fade-up">
                                        <h2>Team</h2>
                                    </div><!-- End Section Title -->

                                    <div class="container">

                                        <div class="row gy-5">

                                            <c:forEach items="${ClubMemberDAO.getClubMembers()}" var="clubMember">
                                                <c:if test="${clubMember.getClubInfo().getClubID() == clubID && (clubMember.getClubRole().equals('Manager') )}">
                                                    <div class="col-lg-4 col-md-6 member" data-aos="fade-up" data-aos-delay="100">
                                                        <div class="member-img">
                                                            <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-1.jpg" class="img-fluid" alt="">
                                                        </div>
                                                        <div class="member-info text-center">
                                                            <h4>${clubMember.getAccount().getFullname()}</h4>
                                                            <span>${clubMember.getClubRole()}</span>
                                                            <p>${clubMember.getAccount().getDescription()}</p>
                                                        </div>
                                                    </div><!-- End Team Member -->
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach items="${ClubMemberDAO.getClubMembers()}" var="clubMember">
                                                <c:if test="${clubMember.getClubInfo().getClubID() == ClubDAO.convertClubID(clubID) && (clubMember.getClubRole().equals('Adviser') )}">
                                                    <div class="col-lg-4 col-md-6 member" data-aos="fade-up" data-aos-delay="100">
                                                        <div class="member-img">
                                                            <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-1.jpg" class="img-fluid" alt="">
                                                        </div>
                                                        <div class="member-info text-center">
                                                            <h4>${clubMember.getAccount().getFullname()}</h4>
                                                            <span>${clubMember.getClubRole()}</span>
                                                            <p>${clubMember.getAccount().getDescription()}</p>
                                                        </div>
                                                    </div><!-- End Team Member -->
                                                    <c:set var="count" value="0" scope="page" />
                                                </c:if>
                                            </c:forEach>

                                        </div>

                                    </div>

                                </section><!-- /Team Section -->


                                <section id="clb-contact" class="recent-blog-posts section">
                                    <div class="container clb-contact-container">
                                        <!--Contact-->
                                        <div class="col-lg-4">
                                            <h3>Contact</h3>
                                            <c:forEach items="${ClubMemberDAO.getClubMembers()}" var="clubMember">
                                                <c:if test="${clubMember.getClubInfo().getClubID() == ClubDAO.convertClubID(clubID) && (clubMember.getClubRole().equals('Manager') )}">
                                                    <p>Email: ${clubMember.getAccount().getEmail()}</p>
                                                </c:if>
                                            </c:forEach>
                                        </div><!--End Contact-->

                                        <!--Edit and join club-->
                                        <div class="col-lg-4 join-now-button-container">
                                            <input type="hidden" name="eventID" value="${eventID}">
                                            <input type="hidden" name="accountID" value="${user.getAccountID()}">

                                            <c:if test="${(ClubMemberDAO.isUserInClub(id,clubID) && (not empty user) && (ClubMemberDAO.getUserClubRole(id,clubID).equals('Manager') || ClubMemberDAO.getUserClubRole(id,clubID).equals('Adviser'))) || (user.getUserRoleID() == 1)}">
                                                <input type="hidden" name="action" value="editClubReview">
                                                <input type="submit" value="Edit form" class="join-now-button" data-bs-toggle="modal" data-bs-target="#editQuestionsModal"/>
                                            </c:if>
                                            <c:if test="${!ClubMemberDAO.isUserInClub(id,clubID) && (not empty user)}">
                                                <c:if test="${!RequestDAO.hasJoinRequest(id,clubID,'Join Club',1)}">
                                                    <input type="button" value="JOIN NOW" class="join-now-button" data-bs-toggle="modal" data-bs-target="#registerModal"/>
                                                </c:if>                                                
                                                <c:if test="${RequestDAO.hasJoinRequest(id,clubID,'Join Club',1)}">
                                                    <button type="button" class="btn btn-secondary disabled">Waiting</button>
                                                </c:if>
                                            </c:if>

                                            <form action="Clubs" method="POST"> 
                                                <c:if test="${empty user}">
                                                    <input type="hidden" name="action" value="logIn">
                                                    <input type="hidden" name="clubID" value="${clubID}">
                                                    <input type="submit" value="JOIN NOW" class="join-now-button"/>
                                                </c:if>
                                            </form>
                                        </div> <!--End Edit and join club-->
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



        <!-- Modal Form Đăng ký -->
        <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Header -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="registerModalLabel">Registration Form</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <form action="Clubs" method="POST">
                        <!-- Body -->
                        <div class="modal-body">
                            <div class="mb-3">
                                <input type="hidden" name="action" value="sendAnswer">
                                <input type="hidden" name="clubID" value="${clubID}">
                                <input type="hidden" name="id" value="${id}">
                                <c:set var="count" value="1" scope="page"/>
                                <c:forEach items="${QuestionDAO.getQuestionsByClubID(clubID)}" var="question">
                                    <div class="mb-3">
                                        <label for="q${count}" class="form-label">Question ${count}: ${question.getContent()}</label>
                                        <textarea class="form-control" id="q${count}" name="answer${count}" placeholder="Your answer" required></textarea>
                                        <!-- Lưu QuestionID vào input ẩn -->
                                        <input type="hidden" name="question${count}" value="${question.getQuestionID()}"/>
                                        <c:set var="count" value="${count + 1}" scope="page"/> 
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Footer -->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <input type="hidden" name="action" value="joinClub">
                            <input type="submit" class="btn btn-primary"  value="Send"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal Form Chỉnh Sửa -->
        <div class="modal fade" id="editQuestionsModal" tabindex="-1" aria-labelledby="editQuestionsModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Header -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="editQuestionsModalLabel">Edit Registration Questions</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <!-- Body -->
                    <div class="modal-body">
                        <form action="UpdateQuestionsServlet" method="post">
                            <input type="hidden" name="clubID" value="${clubID}"/>

                            <%-- Lưu vai trò của người dùng trong club vào biến role --%>
                            <c:set var="role" value="${ClubMemberDAO.getUserClubRole(id, clubID)}" scope="page"/>

                            <%-- Hiển thị nút "Thêm câu hỏi" nếu thỏa mãn điều kiện --%>
                            <c:if test="${role.equals('Manager') || role.equals('Adviser') || user.getUserRoleID() == 1}">
                                <div class="d-flex justify-content-start mb-3">
                                    <a href="Clubs?action=addQuestion&clubID=${clubID}" class="btn btn-primary">Thêm câu hỏi</a>
                                </div>
                            </c:if>

                            <%-- Hiển thị danh sách câu hỏi để chỉnh sửa --%>
                            <c:set var="editCount" value="1" scope="page"/>
                            <c:forEach items="${QuestionDAO.getQuestionsByClubID(clubID)}" var="question">
                                <div class="mb-3">
                                    <label for="editQ${editCount}" class="form-label">Question ${editCount}</label>
                                    <input type="text" class="form-control" id="editQ${editCount}" name="content${editCount}" 
                                           value="${question.content}" required>
                                    <!-- Lưu QuestionID vào input ẩn -->
                                    <input type="hidden" name="questionID${editCount}" value="${question.questionID}"/>

                                    <%-- Hiển thị nút "Xóa câu hỏi" nếu thỏa mãn điều kiện --%>
                                    <c:if test="${role.equals('Manager') || role.equals('Adviser') || user.getUserRoleID() == 1}">
                                        <div class="d-flex justify-content-end mt-2">
                                            <a href="Clubs?action=deleteQuestion&questionID=${question.questionID}&clubID=${clubID}" 
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa câu hỏi này?')">Xóa câu hỏi</a>
                                        </div>
                                    </c:if>

                                    <c:set var="editCount" value="${editCount + 1}" scope="page"/> 
                                </div>
                            </c:forEach>
                        </form>
                    </div>

                    <!-- Footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade" id="clubModal" tabindex="-1" aria-labelledby="clubModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="clubModalLabel">Edit Club Information</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="Clubs" method="post">
                        <div class="modal-body">
                            <!-- Club Name -->
                            <div class="mb-3">
                                <label for="clubName" class="form-label">Club Name</label>
                                <input type="text" class="form-control" id="clubName" name="clubName" placeholder="Enter club name" value="${ClubDAO.getClubByID(clubID).getClubInfo().getClubName()}">
                            </div>
                            <!-- Story -->
                            <div class="mb-3">
                                <label for="clubStory" class="form-label">Story</label>
                                <textarea class="form-control" id="clubStory" rows="3" name="clubDesc" placeholder="Write about the club" >${ClubDAO.getClubByID(clubID).getClubInfo().getClubDesc()}</textarea>
                            </div>
                            <!-- Profile Image -->
                            <div class="mb-3">
                                <label for="clubImage" class="form-label">Club Image</label>
                                <input type="file" class="form-control" id="clubImage" name="clubImgURL">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <input type="hidden" name="action" value="editClubInfo" />
                            <input type="hidden" name="clubID" value="${clubID}" />
                            <button type="submit" class="btn btn-primary">Save Changes</button>
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
