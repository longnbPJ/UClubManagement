/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import security.PasswordUtils;
import security.PasswordUtils.HashedPassword;
import static security.PasswordUtils.verifyPassword;

/**
 *
 * @author PC ASUS
 */
public class Login extends HttpServlet {

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
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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
            RequestDispatcher rs = request.getRequestDispatcher("userPages/login.jsp");
            rs.forward(request, response);
        } else {
            if (user.getUserRoleID() != 1) {
                String redirectURL = (String) session.getAttribute("redirectAfterLogin");
                if (redirectURL == null) {
                    redirectURL = "User";
                }
                session.setAttribute("redirectAfterLogin", null);
                response.sendRedirect(redirectURL);
            } else {
                response.sendRedirect("Admin");
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Account account = AccountDAO.getAccountByEmail(email);
        String error;
        if (account == null) {
            error = "Email not found!";
            request.setAttribute("error", error);
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            RequestDispatcher rs = request.getRequestDispatcher("/userPages/login.jsp");
            rs.forward(request, response);
        } else {
            HashedPassword retrievedPassword = HashedPassword.fromString(account.getPassword());
            boolean passwordMatches = verifyPassword(password, retrievedPassword);
            if (!passwordMatches) {
                error = "Incorrect password!";
                request.setAttribute("error", error);
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                RequestDispatcher rs = request.getRequestDispatcher("/userPages/login.jsp");
                rs.forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", account);
                session.setAttribute("id", account.getAccountID());
                if (account.getUserRoleID() != 1) {
                    String redirectURL = (String) session.getAttribute("redirectAfterLogin");
                    if (redirectURL == null) {
                        redirectURL = "User";
                    }
                    session.setAttribute("redirectAfterLogin", null);
                    response.sendRedirect(redirectURL);
                } else {
                    response.sendRedirect("Admin");
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
