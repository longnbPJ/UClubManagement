<%-- 
    Document   : memberDetail
    Created on : Mar 11, 2025, 1:21:49 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.AccountDAO"%>
<%@page import="dao.ClubInfoDAO"%>
<%@page import="dao.ClubMemberDAO"%>
<%@page import="dao.EventDAO"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Member Detail</title>
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
        <link href="${pageContext.request.contextPath}/userPages/assets/css/custom.css?v=1.0.5" rel="stylesheet">

        <style>
            .edit-form {
                display: none; /* Ẩn form mặc định */
                margin-left: 10px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="../components/header.jsp">
            <jsp:param name="page" value = "club"/>
        </jsp:include>

        <main class="main">

            <!-- Page Title -->
            <div class="page-title dark-background" style="background-image: url(assets/img/page-title-bg.jpg);">
                <div class="container position-relative">
                    <h1>Ten clb</h1>
                </div>
            </div><!-- End Page Title -->

            <!-- Service Details Section -->
            <section id="service-details" class="service-details section">

                <div class="container">

                    <div class="row gy-4">

                        <jsp:include page="../components/clubSidebar.jsp">
                            <jsp:param name="page" value = "members"/>
                        </jsp:include>


                        <div class="col-lg-8" data-aos="fade-up" data-aos-delay="200">

                            <!-- Alt Services Section -->
                            <section id="alt-services" class="alt-services section">

                                <div class="container">

                                    <div class="row justify-content-around gy-4">
                                        <div class="features-image col-lg-6" data-aos="fade-up" data-aos-delay="100">
                                            <img src="${pageContext.request.contextPath}/userPages/assets/img/team/team-1.jpg" class="img-fluid" alt=""> 
                                        </div>

                                        <div class="col-lg-5 d-flex flex-column justify-content-center" data-aos="fade-up" data-aos-delay="200">

                                            <c:set var="getAccount" value="${AccountDAO.getAccountByID(memberID)}" scope="page"/>
                                            <c:set var="getClubInfor" value="${ClubInfoDAO.getClubInfoByID(clubID)}" scope="page"/>
                                            <h3 class="club-member-name justify-content-between">${getAccount.getFullname()} 
                                                <a href="${pageContext.request.contextPath}/Clubs?page=clubMembers&clubID=${clubID}"> 
                                                    <i class="bi bi-box-arrow-left"></i> 
                                                </a>
                                            </h3>
                                            <p class="member-desc">${getAccount.getDescription()}</p>

                                            <div class="icon-box d-flex position-relative infor-detail" data-aos="fade-up" data-aos-delay="300">
                                                <div>
                                                    <h4>Group</h4>
                                                    <p>${getClubInfor.getClubName()}</p>
                                                </div>
                                            </div><!-- End Icon Box -->

                                            <div class="icon-box d-flex position-relative infor-detail" data-aos="fade-up" data-aos-delay="300">
                                                <div>
                                                    <!--                                                    <h4>Role 
                                                                                                            <a href=""> 
                                                                                                                <i class="bi bi-pencil-square"></i> 
                                                                                                            </a>
                                                                                                        </h4>-->
                                                    <h4>Role
                                                        <c:if test="${user.getUserRoleID() == 1 
                                                                      || (ClubMemberDAO.getUserClubRole(id,clubID) == 'Manager' && ClubMemberDAO.getUserClubRole(memberID,clubID) != 'Manager') 
                                                                      || (ClubMemberDAO.getUserClubRole(id,clubID) == 'Advicer' && ClubMemberDAO.getUserClubRole(memberID,clubID) != 'Advicer')}"
                                                              >
                                                            <a onclick="toggleEditForm()"> 
                                                                <i class="bi bi-pencil-square"></i> 
                                                            </a>

                                                            <!-- Form hiển thị ngay bên cạnh -->
                                                            <span class="edit-form" id="editForm">
                                                                <form action="Clubs" method="POST" style="display: block;">
                                                                    <select name="newRole" class="form-select" style="display: block; width: auto; height: 33px;">
                                                                        <c:if test="${user.getUserRoleID() == 1}">
                                                                            <option value="Manager" >Manager</option>
                                                                        </c:if>
                                                                        <option value="Adviser" >Adviser</option>
                                                                        <option value="Member" >Member</option>
                                                                    </select>

                                                                    <input type="hidden" name="action" value="editMemberRole">
                                                                    <input type="hidden" name="clubID" value="${clubID}">
                                                                    <input type="hidden" name="memberID" value="${memberID}">
                                                                    <button type="submit" class="btn btn-primary btn-sm">Save</button>
                                                                    <button type="button" class="btn btn-secondary btn-sm" onclick="toggleEditForm()">Cancel</button>
                                                                </form>
                                                            </span>
                                                        </c:if>
                                                    </h4>
                                                    <p>${ClubMemberDAO.getUserClubRole(memberID,clubID)}</p>
                                                </div>
                                            </div><!-- End Icon Box -->

                                            <div class="icon-box d-flex position-relative infor-detail" data-aos="fade-up" data-aos-delay="500">
                                                <div>
                                                    <h4>Email</h4>
                                                    <p>${getAccount.getEmail()}</p>
                                                </div>
                                            </div><!-- End Icon Box -->

                                            <div class="icon-box d-flex position-relative infor-detail" data-aos="fade-up" data-aos-delay="700">
                                                <div>
                                                    <h4>Join Date</h4>
                                                    <p>${ClubMemberDAO.getMember(memberID, clubID).getDate()}</p>
                                                </div>
                                            </div><!-- End Icon Box -->

                                            <div class="icon-box d-flex position-relative infor-detail" data-aos="fade-up" data-aos-delay="800">
                                                <div>
                                                    <h4>Approved By</h4>
                                                    <p>${AccountDAO.getAccountByID(ClubMemberDAO.getMember(memberID, clubID).getApprovedBy()).getFullname()}</p>
                                                </div>
                                            </div><!-- End Icon Box -->

                                        </div>
                                    </div>
                                </div>

                            </section><!-- /Alt Services Section -->




                            <!-- Stats Counter Section -->
                            <section id="stats-counter" class="stats-counter section">

                                <!-- Section Title -->
                                <div class="container section-title" data-aos="fade-up">
                                    <h2>This Semester</h2>
                                </div><!-- End Section Title -->

                                <div class="container" data-aos="fade-up" data-aos-delay="100">

                                    <div class="row gy-4">

                                        <div class="col-lg-6 col-md-6">
                                            <div class="stats-item d-flex align-items-center w-100 h-100">
                                                <i class="bi bi-emoji-smile color-blue flex-shrink-0"></i>
                                                <div>
                                                    <span>${EventDAO.getEventsByIDs(clubID, memberID).size() / EventDAO.countEventsByClubIDThisSemester(clubID) * 100}%</span>
                                                    <p>Positive</p>
                                                </div>
                                            </div>
                                        </div><!-- End Stats Item -->

                                        <div class="col-lg-6 col-md-6">
                                            <div class="stats-item d-flex align-items-center w-100 h-100">
                                                <i class="bi bi-journal-richtext color-orange flex-shrink-0"></i>
                                                <div>
                                                    <span data-purecounter-start="0" data-purecounter-end="${EventDAO.getEventsByIDs(clubID, memberID).size()}" data-purecounter-duration="1" class="purecounter"></span>
                                                    <p>Events participants</p>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                </div>

                            </section><!-- /Stats Counter Section -->

                            <!-- Stats Counter Section -->
                            <section id="stats-counter" class="stats-counter section">

                                <!-- Section Title -->
                                <div class="container section-title mt-5" data-aos="fade-up">
                                    <h2>History</h2>
                                </div><!-- End Section Title -->

                                <div class="container" data-aos="fade-up" data-aos-delay="100">

                                    <div class="row gy-4">
                                        <c:forEach items="${EventDAO.getEventsByIDs(clubID,memberID)}" var="event">
                                            <c:if test="${event.getStatus().equals('Ongoing') || event.getStatus().equals('Finished')}">
                                                <div class="col-lg-4 filter-it isotope-item event-item">
                                                    <article class="position-relative h-100">

                                                        <div class="post-img position-relative overflow-hidden">
                                                            <img src="${pageContext.request.contextPath}/userPages/assets/img/blog/blog-1.jpg" class="img-fluid" alt="">
                                                            <span class="post-date">${event.getEventInfo().getEventDate()}</span>
                                                        </div>

                                                        <div class="post-content d-flex flex-column">

                                                            <h3 class="post-title text-clamp">${event.getEventInfo().getEventName()}</h3>

                                                            <div class="meta d-flex align-items-center">
                                                                <div class="d-flex align-items-center">
                                                                    <i class="bi bi-person"></i> <span class="ps-2 text-clamp-1">${event.getClubInfo().getClubName()}</span>
                                                                </div>
                                                            </div>

                                                            <p class="text-clamp-4">
                                                                ${event.getEventInfo().getEventDesc()}
                                                            </p>

                                                            <hr>

                                                            <a href="Events?eventID=${event.getEventID()}" class="readmore stretched-link"><span>Read More</span><i class="bi bi-arrow-right"></i></a>

                                                        </div>

                                                    </article>
                                                </div><!-- End post list item -->
                                            </c:if>
                                        </c:forEach>

                                        <!--                                        <div class="col-lg-4 col-md-6">
                                                                                    <div class="stats-item d-flex align-items-center w-100 h-100">
                                                                                        <i class="bi bi-journal-richtext color-orange flex-shrink-0"></i>
                                                                                        <div>
                                                                                            <span data-purecounter-start="0" data-purecounter-end="521" data-purecounter-duration="1" class="purecounter"></span>
                                                                                            <p>Events participants</p>
                                                                                        </div>
                                                                                    </div>
                                                                                </div> End Stats Item -->

                                    </div>

                                </div>

                            </section><!-- /Stats Counter Section -->

                        </div>

                    </div>


            </section><!-- /Service Details Section -->

        </main>

        <script>
            function toggleEditForm() {
                var form = document.getElementById("editForm");
                if (form.style.display === "none" || form.style.display === "") {
                    form.style.display = "block";
                } else {
                    form.style.display = "none";
                }
            }
        </script>

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
