<%-- 
    Document   : waitingEvents
    Created on : Mar 13, 2025, 5:02:07 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.RequestDAO"%>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Waiting Events</title>

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
                                                        <th>Event name</th>
                                                        <th>Event desc</th>
                                                        <th>Event date</th>
                                                        <th>Event location</th>
                                                        <th>Event time</th>
                                                        <th>Requester</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tfoot>
                                                    <tr>
                                                        <th>Event name</th>
                                                        <th>Event desc</th>
                                                        <th>Event date</th>
                                                        <th>Event location</th>
                                                        <th>Event time</th>
                                                        <th>Requester</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </tfoot>
                                                <tbody>
                                                    <c:forEach items="${RequestDAO.getRequests()}" var="request">
                                                        <c:if test="${request.getType() == 'Create Event' && request.getStatusID() == 1}">
                                                            <tr>
                                                                <td>${request.getEventInfo().getEventName()}</td>
                                                                <td>${request.getEventInfo().getEventDesc()}</td>
                                                                <td>${request.getEventInfo().getEventDate()}</td>
                                                                <td>${request.getEventInfo().getEventLocation()}</td>
                                                                <td>${request.getEventInfo().getEventTime().replaceAll("\\.?0+$", "")}</td>
                                                                <td>${request.getAccount().getFullname()}</td>
                                                                <td>
                                                                    <form action="Request" method="Post">
                                                                        <input type="hidden" name="requestID" value="${request.getRequestID()}">
                                                                        <input type="hidden" name="accountID" value="${request.getAccount().getAccountID()}">
                                                                        <input type="hidden" name="action" value="CreateEventApproval">
                                                                        <input type="submit" class="btn btn-success btn-sm edit-btn" name="isApproved" value="Approve">
                                                                    </form>
                                                                    <form action="Request" method="Post">
                                                                        <input type="hidden" name="requestID" value="${request.getRequestID()}">
                                                                        <input type="hidden" name="accountID" value="${request.getAccount().getAccountID()}">
                                                                        <input type="hidden" name="action" value="CreateEventApproval">
                                                                        <input type="submit" class="btn btn-danger btn-sm me-2" name="isApproved" value="Reject">
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                        </c:if>
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
