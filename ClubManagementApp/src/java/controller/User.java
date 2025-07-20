/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import dao.NotificationDAO;
import dao.ReceivantDAO;
import dao.StudentInfoDAO;
import emailService.EmailSender;
import jakarta.mail.MessagingException;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import model.Account;
import security.PasswordUtils;
import security.PasswordUtils.HashedPassword;

/**
 *
 * @author PC ASUS
 */
@MultipartConfig
public class User extends HttpServlet {

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
            out.println("<title>Servlet User</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet User at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login");
        } else {
            String page = request.getParameter("page");
            if (page == null) {
                RequestDispatcher rs = request.getRequestDispatcher("userPages/privatePages/myAccount.jsp");
                rs.forward(request, response);
            } else {
                String id = request.getParameter("id");
                switch (page) {
                    case "clubs":
                        request.setAttribute("id", id);
                        RequestDispatcher rs1 = request.getRequestDispatcher("userPages/privatePages/myClubs.jsp");
                        rs1.forward(request, response);
                        break;
                    case "events":
                        request.setAttribute("id", id);
                        RequestDispatcher rs2 = request.getRequestDispatcher("userPages/privatePages/myEvents.jsp");
                        rs2.forward(request, response);
                        break;
                    case "info":
                        request.setAttribute("id", id);
                        RequestDispatcher rs3 = request.getRequestDispatcher("userPages/privatePages/myInfo.jsp");
                        rs3.forward(request, response);
                        break;
                    case "sendMessage":
                        request.setAttribute("id", id);
                        RequestDispatcher rs4 = request.getRequestDispatcher("userPages/privatePages/sendMessage.jsp");
                        rs4.forward(request, response);
                        break;
                    case "senderInfo":
                        String senderID = request.getParameter("senderID");
                        request.setAttribute("senderID", senderID);
                        RequestDispatcher rs5 = request.getRequestDispatcher("userPages/privatePages/senderInfo.jsp");
                        rs5.forward(request, response);
                        break;
                    case "logout":
                        break;
                    default:
                }
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
        if ("import".equals(action)) {
            Part filePart = request.getPart("addUserFile");
            if (filePart == null || filePart.getSize() == 0) {
                response.getWriter().write("No file uploaded!");
                return;
            }
            // Đọc file CSV
            try (InputStream inputStream = filePart.getInputStream(); BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
                String line;
                reader.readLine(); // Bỏ qua dòng tiêu đề
                boolean isSuccess = false;
                while ((line = reader.readLine()) != null) {
                    String[] data = line.split(",");
                    if (data.length >= 5) {
                        isSuccess = AccountDAO.addStudents(data[0].trim(), data[1].trim(), data[2].trim(), data[3].trim(), data[4].trim());
                    }
                }
                request.getSession().setAttribute("isSuccess", isSuccess);
                response.sendRedirect("Admin?page=viewUser");
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("Lỗi khi import dữ liệu!");
            }
        } else if ("add".equals(action)) {
            boolean isSuccess;
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String userRoleID = request.getParameter("userRole");
            if ("3".equals(userRoleID)) {
                String studentID = request.getParameter("studentID");
                String major = request.getParameter("major");
                String course = request.getParameter("course");
                isSuccess = AccountDAO.addAccount(fullName, email, Integer.parseInt(userRoleID))
                        && StudentInfoDAO.addStudentInfo(email, studentID, major, course);
            } else {
                isSuccess = AccountDAO.addAccount(fullName, email, Integer.parseInt(userRoleID));
            }
            request.getSession().setAttribute("isSuccess", isSuccess);
            response.sendRedirect("Admin?page=viewUser");
        } else if ("resetPassword".equals(action)) {
            String email = request.getParameter("email");
            Account account = AccountDAO.getAccountByEmail(email);
            if (account != null) {
                int accountID = account.getAccountID();
                String newPassword = PasswordUtils.generateRandomPassword(6);
                try {
                    EmailSender sender = new EmailSender("longxz135@gmail.com", "nxjw uecr wgcm vsmc");
                    sender.sendEmail(email, "RESET PASSWORD", "Your new password: " + newPassword + ". Please change your password.");
                    String hashPassword = PasswordUtils.hashPassword(newPassword).toString();
                    boolean isSuccess = AccountDAO.changePassword(hashPassword, accountID);
                    request.getSession().setAttribute("isSuccess", isSuccess);
                    if (((Account) request.getSession().getAttribute("user")) != null) {
                        response.sendRedirect("Admin?page=viewUser");
                    } else {
                        response.sendRedirect("Login");
                    }
                } catch (MessagingException e) {
                    String message = e.getMessage();
                    request.setAttribute("message", message);
                    RequestDispatcher rs = request.getRequestDispatcher("test.jsp");
                    rs.forward(request, response);
                }
            } else {
                request.setAttribute("error", "Email not found, can not reset password!.");
                RequestDispatcher rs = request.getRequestDispatcher("userPages/login.jsp");
                rs.forward(request, response);
            }
        } else if ("sendMessage".equals(action)) {
            String id = request.getParameter("id");
            String reveivantsEmails = request.getParameter("email");
            String title = request.getParameter("title");
            String message = request.getParameter("message");
            String link = request.getParameter("link");

            boolean isSuccess = NotificationDAO.createNoti(Integer.parseInt(id), link, title, message, "in-app");
            String[] reveivantsEmailArr = reveivantsEmails.split(",");
            for (String reveivantEmail : reveivantsEmailArr) {
                if (isSuccess) {
                    Account receivant = AccountDAO.getAccountByEmail(reveivantEmail.trim());
                    isSuccess = isSuccess && ReceivantDAO.createReceivant(receivant.getAccountID());
                }
            }
            request.getSession().setAttribute("isSuccess", isSuccess);
            response.sendRedirect("User");
        } else if ("checkNoti".equals(action)) {
            String id = request.getParameter("id");
            String notiID = request.getParameter("notiID");
            String status = request.getParameter("status");

            boolean isSuccess = ReceivantDAO.checkNoti(Integer.parseInt(notiID), Integer.parseInt(id), Integer.parseInt(status));
            request.getSession().setAttribute("isOpen", true);
            response.sendRedirect("User");
        } else if ("changePassword".equals(action)) {
            String id = request.getParameter("id");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            HashedPassword currentHashPassword = HashedPassword.fromString(AccountDAO.getAccountByID(Integer.parseInt(id)).getPassword());
            String confirmPassword = request.getParameter("confirmPassword");
            String error = null;
            if (!PasswordUtils.verifyPassword(currentPassword, currentHashPassword)) {
                error = "Incorrect password!";
            } else if (newPassword.length() < 6) {
                error = "Password length must > 6!";
            } else if (!newPassword.equals(confirmPassword)) {
                error = "Confirm password not match!";
            }
            if (error == null) {
                HashedPassword newHashPassword = PasswordUtils.hashPassword(newPassword);
                boolean isSuccess = AccountDAO.changePassword(newHashPassword.toString(), Integer.parseInt(id));
                request.getSession().setAttribute("isSuccess", isSuccess);
                if (AccountDAO.getAccountByID(Integer.parseInt(id)).getUserRoleID() != 1) {
                    response.sendRedirect("User?page=info");
                } else {
                    response.sendRedirect("Admin");
                }
            } else {
                request.setAttribute("currentPassword", currentPassword);
                request.setAttribute("newPassword", newPassword);
                request.setAttribute("confirmPassword", confirmPassword);
                request.setAttribute("error", error);
                if (AccountDAO.getAccountByID(Integer.parseInt(id)).getUserRoleID() != 1) {
                    RequestDispatcher rs = request.getRequestDispatcher("userPages/privatePages/myInfo.jsp");
                    rs.forward(request, response);
                } else {
                    RequestDispatcher rs = request.getRequestDispatcher("adminPages/pages/dashboard.jsp");
                    rs.forward(request, response);
                }
            }
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
