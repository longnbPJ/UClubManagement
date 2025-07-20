<%-- 
    Document   : clubView
    Created on : Mar 13, 2025, 4:57:48 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.ClubDAO"%>
<%@page import="dao.ClubMemberDAO"%>

<!DOCTYPE html>
<html>
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Club View</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/adminPages/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/adminPages/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/adminPages/css/adminCss.css?v=1.0.2" rel="stylesheet">

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


                        <h1 class="h3 mb-4 text-gray-800">Clubs</h1>

                        <div class="row">

                            <div class="col-lg-12">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Clubs table </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Name</th>
                                                        <th>Role</th>
                                                        <th>Action ${ClubMemberDAO}</th>
                                                    </tr>
                                                </thead>
                                                <tfoot>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Name</th>
                                                        <th>Role</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </tfoot>
                                                <tbody>
                                                    <c:forEach items="${ClubMemberDAO.getClubMembers()}" var="clubMember">
                                                        <c:if test="${clubMember.getClubInfo().getClubID() == id}">
                                                            <tr>
                                                                <td>${clubMember.getAccount().getAccountID()}</td>
                                                                <td>${clubMember.getAccount().getFullname()}</td>
                                                                <td>${clubMember.getClubRole()}</td>
                                                                <td>
                                                                    <c:if test="${clubMember.getClubRole() != 'Manager'}">
                                                                        <button 
                                                                            class="btn btn-primary btn-sm edit-btn" 
                                                                            data-manager="${clubMember.getAccount().getAccountID()}"
                                                                            data-id="${clubMember.getClubInfo().getClubID()}"
                                                                            data-toggle="modal" 
                                                                            data-target="#confirmModal"
                                                                            >
                                                                            Set Manager
                                                                        </button>
                                                                    </c:if>
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

        <!-- Modal xác nhận -->
        <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmModalLabel">Confirm change</h5>
                    </div>
                    <div class="modal-body">
                        Are you sure to change manager?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <form action="Clubs" method="post">
                            <input type="hidden" name="action" value="changeManager"/>
                            <input type="hidden" id="editManager" name="newManagerId"/>
                            <input type="hidden" id="editId" name="clubId" value="${clubMember.getClubInfo().getClubID()}"/>
                            <input type="submit" class="btn btn-primary" value="Change"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

        <script>
            document.querySelectorAll('.edit-btn').forEach(button => {
                button.addEventListener('click', function () {
                    // Lưu thông tin cần cập nhật vào biến
                    const manager = this.getAttribute('data-manager');
                    const id = this.getAttribute('data-id');

                    // Gán dữ liệu vào input ẩn của modal chỉnh sửa
                    document.getElementById('editManager').value = manager;
                    document.getElementById('editId').value = id;

                });
            });
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
