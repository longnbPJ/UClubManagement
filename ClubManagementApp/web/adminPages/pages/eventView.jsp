<%-- 
    Document   : eventView
    Created on : Mar 13, 2025, 4:46:01 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.EventDAO"%>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Event View</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/adminPages/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/adminPages/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/adminPages/css/adminCss.css" rel="stylesheet">

    </head>
    <body id="page-top">

        <!-- Page Wrapper -->
        <div id="wrapper">

            <jsp:include page="../components/sidebar.jsp"/>

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <jsp:include page="../components/topbar.jsp"/>

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

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <!-- Page Heading -->
                        <!--                        <h1 class="h3 mb-4 text-gray-800">Clubs</h1>-->

                        <div class="row">

                            <div class="col-lg-12">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Events table</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>Event ID</th>
                                                        <th>Status</th>
                                                        <th>Club ID</th>
                                                        <th>Event Name</th>
                                                        <th>Event Date</th>
                                                        <th>Event Location</th>
                                                        <th>Event Time</th>
                                                        <th>Event Desc</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tfoot>
                                                    <tr>
                                                        <th>Event ID</th>
                                                        <th>Status</th>
                                                        <th>Club ID</th>
                                                        <th>Event Name</th>
                                                        <th>Event Date</th>
                                                        <th>Event Location</th>
                                                        <th>Event Time</th>
                                                        <th>Event Desc</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </tfoot>
                                                <tbody>
                                                    <c:forEach items="${EventDAO.getEvents()}" var="event">
                                                        <tr>
                                                            <td>${event.getEventID()}</td>
                                                            <td>${event.getStatus()}</td>
                                                            <td>${event.getClubInfo().getClubID()}</td>
                                                            <td>${event.getEventInfo() != null ? event.getEventInfo().getEventName() : null}</td>
                                                            <td>${event.getEventInfo() != null ? event.getEventInfo().getEventDate() : null}</td>
                                                            <td>${event.getEventInfo() != null ? event.getEventInfo().getEventLocation() : null}</td>
                                                            <td>${event.getEventInfo() != null ? event.getEventInfo().getEventTime().replaceAll("\\.?0+$", "") : null}</td>
                                                            <td>${event.getEventInfo() != null ? event.getEventInfo().getEventDesc() : null}</td>                                               
                                                            <td>
                                                                <button class="btn btn-info btn-sm view-btn me-2" onclick="location.href = 'Events?eventID=${event.getEventID()}'">
                                                                    View Event
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                    <!-- /.container-fluid -->


                </div>
                <!-- End of Main Content -->

                <!-- Footer -->
                <footer class="sticky-footer bg-white">
                    <div class="container my-auto">
                        <div class="copyright text-center my-auto">
                            <span>Copyright &copy; Your Website 2021</span>
                        </div>
                    </div>
                </footer>
                <!-- End of Footer -->

            </div>
            <!-- End of Content Wrapper -->

        </div>
        <!-- End of Page Wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

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

        <!-- Bootstrap core JavaScript-->
        <script src="${pageContext.request.contextPath}/adminPages/vendor/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/adminPages/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/adminPages/js/sb-admin-2.min.js"></script>

        <!-- Page level plugins -->
        <script src="${pageContext.request.contextPath}/adminPages/vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <!-- Page level custom scripts -->
        <script src="${pageContext.request.contextPath}/adminPages/js/demo/datatables-demo.js"></script>

    </body>
</html>
