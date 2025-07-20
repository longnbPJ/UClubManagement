/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;
import dao.AnnouncementDAO;
import dao.AnswerDAO;
import dao.ClubDAO;
import dao.ClubInfoDAO;
import dao.ClubMemberDAO;
import dao.EventDAO;
import dao.EventParticipantDAO;
import dao.QuestionDAO;
import dao.ReportDAO;
import dao.RequestDAO;
import dao.SemesterDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Account;
import model.Club;
import model.Question;
import model.Report;

/**
 *
 * @author PC ASUS
 */
public class Clubs extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Clubs</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Clubs at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("user");
        String id = null;
        if (account != null) {
            id = String.valueOf(account.getAccountID());
        }
        String clubID = request.getParameter("clubID");
        if (clubID == null) {
            RequestDispatcher rs = request.getRequestDispatcher("userPages/clubs.jsp");
            rs.forward(request, response);
        } else {
            String page = request.getParameter("page");
            request.getSession().setAttribute("id", id);
            request.getSession().setAttribute("clubID", clubID);
            if (page == null) {
                RequestDispatcher rs = request.getRequestDispatcher("userPages/clubReview.jsp");
                rs.forward(request, response);
            } else if ("clubEvents".equals(page)) {
                RequestDispatcher rs = request.getRequestDispatcher("userPages/clubEvents.jsp");
                rs.forward(request, response);
            } else if (account != null) {
                if (ClubMemberDAO.isUserInClub(id, clubID) || account.getUserRoleID() == 1) {
                    if ("clubMembers".equals(page)) {
                        request.setAttribute("requests", RequestDAO.getJoinRequestsByClubID(Integer.parseInt(clubID)));
                        RequestDispatcher rs = request.getRequestDispatcher("userPages/privatePages/clubMembers.jsp");
                        rs.forward(request, response);
                    } else if ("clubAnnouncement".equals(page)) {
                        RequestDispatcher rs = request.getRequestDispatcher("userPages/privatePages/clubAnnouncement.jsp");
                        rs.forward(request, response);
                    } else if ("createReport".equals(page)) {
                        RequestDispatcher rs = request.getRequestDispatcher("userPages/privatePages/createReport.jsp");
                        rs.forward(request, response);
                    } else if ("member".equals(page)) {
                        String memberID = request.getParameter("memberID");
                        request.setAttribute("memberID", memberID);
                        RequestDispatcher rs = request.getRequestDispatcher("userPages/privatePages/memberDetail.jsp");
                        rs.forward(request, response);
                    }
                }
            } else {
                response.sendRedirect("Login");
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("editMemberRole".equals(action)) {
            String memberID = request.getParameter("memberID");
            String clubID = request.getParameter("clubID");
            String newRole = request.getParameter("newRole");
            ClubMemberDAO.updateUserClubRole(memberID, clubID, newRole);
            request.setAttribute("memberID", memberID);
            RequestDispatcher rs = request.getRequestDispatcher("userPages/privatePages/memberDetail.jsp");
            rs.forward(request, response);
        } else if ("chooseManager".equals(action)) {
            String clubId = request.getParameter("id");
            request.setAttribute("id", clubId);
            RequestDispatcher rs = request.getRequestDispatcher("adminPages/pages/changeManager.jsp");
            rs.forward(request, response);
        } else if ("changeManager".equals(action)) {
            String newManagerId = request.getParameter("newManagerId");
            String clubId = request.getParameter("clubId");
            boolean isSuccess
                    = ClubMemberDAO.changeManager(Integer.parseInt(newManagerId), Integer.parseInt(clubId))
                    && ClubDAO.changeManager(Integer.parseInt(newManagerId), Integer.parseInt(clubId));
            request.setAttribute("isSuccess", isSuccess);
            RequestDispatcher rs = request.getRequestDispatcher("adminPages/pages/clubView.jsp");
            rs.forward(request, response);
        } else if ("generateReport".equals(action)) {
            String clubId = request.getParameter("id");
            Club club = ClubDAO.getClubByID(Integer.parseInt(clubId));
            Report report = ReportDAO.getReportByClubID(Integer.parseInt(clubId));
            if (report != null) {
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=\"Club " + club.getClubInfo().getClubName() + " report " + SemesterDAO.getThisSemester().getCode() + ".pdf\"");

                try {
                    // Tạo file PDF trực tiếp vào OutputStream của response
                    Document document = new Document();
                    PdfWriter.getInstance(document, response.getOutputStream());
                    document.open();

                    // Đường dẫn tới font hỗ trợ tiếng Việt (Times New Roman, Arial, v.v.)
                    String fontPath = "C:\\Users\\PC ASUS\\Downloads\\times-new-roman\\times.ttf"; // Chỉnh đường dẫn theo hệ thống của bạn

                    // Nhúng font vào tài liệu PDF
                    BaseFont baseFont = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                    Font vietnameseFont = new Font(baseFont, 16, Font.NORMAL);

                    Paragraph para1 = new Paragraph("CLUB REPORT", vietnameseFont);
                    para1.setAlignment(Paragraph.ALIGN_CENTER);
                    para1.setSpacingAfter(10);
                    document.add(para1);

                    Paragraph para2 = new Paragraph(ClubDAO.getClubByID(report.getClubID()).getClubInfo().getClubName(), vietnameseFont);
                    para2.setAlignment(Paragraph.ALIGN_CENTER);
                    para2.setSpacingAfter(10);
                    document.add(para2);

                    Paragraph para8 = new Paragraph("- Date: " + report.getCreatedAt(), vietnameseFont);
                    para8.setAlignment(Paragraph.ALIGN_LEFT);
                    para8.setSpacingAfter(10);
                    document.add(para8);

                    Paragraph para3 = new Paragraph("- Semester: " + SemesterDAO.getThisSemester().getCode(), vietnameseFont);
                    para3.setAlignment(Paragraph.ALIGN_LEFT);
                    para3.setSpacingAfter(10);
                    document.add(para3);

                    Paragraph para4 = new Paragraph("- Member quantity: " + report.getMemberQuantity(), vietnameseFont);
                    para4.setAlignment(Paragraph.ALIGN_LEFT);
                    para4.setSpacingAfter(10);
                    document.add(para4);

                    Paragraph para5 = new Paragraph("- Member changes: " + report.getMemberChanges(), vietnameseFont);
                    para5.setAlignment(Paragraph.ALIGN_LEFT);
                    para5.setSpacingAfter(10);
                    document.add(para5);

                    Paragraph para6 = new Paragraph("- Event summary: " + report.getEventSummary(), vietnameseFont);
                    para6.setAlignment(Paragraph.ALIGN_LEFT);
                    para6.setSpacingAfter(10);
                    document.add(para6);

                    Paragraph para7 = new Paragraph("- Participation stats: " + report.getParticipationStats(), vietnameseFont);
                    para7.setAlignment(Paragraph.ALIGN_LEFT);
                    para7.setSpacingAfter(10);
                    document.add(para7);

                    document.close();
                } catch (Exception e) {
                    throw new ServletException(e);
                }
            } else {
                String message = "Club report not available !";
                request.getSession().setAttribute("message", message);
                RequestDispatcher rs = request.getRequestDispatcher("adminPages/pages/clubView.jsp");
                rs.forward(request, response);
            }
        } else if ("logIn".equals(action)) {
            String clubID = request.getParameter("clubID");
            String requestedURL = request.getContextPath() + "/Clubs?clubID=" + clubID;
            HttpSession session = request.getSession();
            session = request.getSession(true);
            session.setAttribute("redirectAfterLogin", requestedURL);

            // Chuyển hướng đến trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/Login");
        } else if ("sendAnswer".equals(action)) {
            String clubID = request.getParameter("clubID");
            String id = request.getParameter("id");
            boolean isSuccess = RequestDAO.createRequest(Integer.parseInt(id), Integer.parseInt(clubID), "Join Club", 1);
            ArrayList<Question> questions = QuestionDAO.getQuestionsByClubID(clubID);
            for (int i = 1; i <= questions.size(); i++) {
                String questionID = request.getParameter("question" + i);
                String content = request.getParameter("answer" + i);
                isSuccess = isSuccess && AnswerDAO.createAnswer(Integer.parseInt(questionID), Integer.parseInt(id), content);
            }
            if (isSuccess) {
                response.sendRedirect("Clubs?clubID=" + clubID);
            } else {
                response.sendRedirect("Home");
            }
        } else if ("createAnnouncement".equals(action)) {
            String clubID = request.getParameter("clubID");
            String id = request.getParameter("id");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            boolean isSuccess = AnnouncementDAO.createAnnouncement(Integer.parseInt(clubID), Integer.parseInt(id), title, content);
            request.getSession().setAttribute("isSuccess", isSuccess);
            response.sendRedirect("Clubs?page=clubAnnouncement&clubID=" + clubID);
        } else if ("createReport".equals(action)) {
            String clubID = request.getParameter("clubID");
            String id = request.getParameter("id");
            int memberQuantity = ClubMemberDAO.countMembersByClubID(clubID);
            int memberChanges = memberQuantity - ReportDAO.getMemberQuantityLastSem(clubID);
            String eventSummary = request.getParameter("eventSummary");
            double ParticipationSats
                    = Math.round((double) EventParticipantDAO.countParticipantsThisSemester(Integer.parseInt(clubID))
                            / (EventDAO.countEventsByClubIDThisSemester(clubID)
                            * memberQuantity) * 100.0) / 100.0;
            boolean isSuccess = ReportDAO.createNewReport(Integer.parseInt(id), Integer.parseInt(clubID), memberQuantity, memberChanges, eventSummary, ParticipationSats);
            request.getSession().setAttribute("isSuccess", isSuccess);
            response.sendRedirect("Clubs?page=createReport&clubID=" + clubID);
        } else if ("editReport".equals(action)) {
            String reportID = request.getParameter("reportID");
            String clubID = request.getParameter("clubID");
            String eventSummary = request.getParameter("eventSummary");
            boolean isSuccess = ReportDAO.editReport(Integer.parseInt(reportID), eventSummary);
            request.getSession().setAttribute("isSuccess", isSuccess);
            response.sendRedirect("Clubs?page=createReport&clubID=" + clubID);
        } else if ("editClubInfo".equals(action)) {
            String clubID = request.getParameter("clubID");
            String clubName = request.getParameter("clubName");
            String clubImgURL = request.getParameter("clubImgURL");
            String clubDesc = request.getParameter("clubDesc");
            boolean isSuccess = ClubInfoDAO.updateClubInfo(Integer.parseInt(clubID), clubName, clubImgURL, clubDesc);
            request.getSession().setAttribute("isSuccess", isSuccess);
            response.sendRedirect("Clubs?clubID=" + clubID);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
