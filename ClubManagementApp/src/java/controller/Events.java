/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.EventInfoDAO;
import dao.EventParticipantDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author PC ASUS
 */
public class Events extends HttpServlet {

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
            out.println("<title>Servlet Events</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Events at " + request.getContextPath() + "</h1>");
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
        String eventID = request.getParameter("eventID");
        if (eventID == null) {
            RequestDispatcher rs = request.getRequestDispatcher("userPages/events.jsp");
            rs.forward(request, response);
        } else {
            request.setAttribute("eventID", eventID);
            RequestDispatcher rs = request.getRequestDispatcher("userPages/eventDetail.jsp");
            rs.forward(request, response);
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
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");

        if (action.equals("joinEvent")) {
            if (id == null) {
                String eventID = request.getParameter("eventID");
                String requestedURL = request.getContextPath() + "/Events?eventID=" + eventID;
                session = request.getSession(true);
                session.setAttribute("redirectAfterLogin", requestedURL);

                // Chuyển hướng đến trang đăng nhập
                response.sendRedirect(request.getContextPath() + "/Login");
            } else {
                int eventID = Integer.parseInt(request.getParameter("eventID"));
                EventParticipantDAO.joinAccountToEventParticipant(eventID, id, "Guest", "Participated");
                request.setAttribute("eventID", eventID);
                RequestDispatcher rs = request.getRequestDispatcher("userPages/eventDetail.jsp");
                rs.forward(request, response);
            }
        } else if (action.equals("editEventInfo")) {
            String eventName = request.getParameter("eventName");
            String eventLocation = request.getParameter("eventLocation");
            String eventImg = request.getParameter("eventImg");
            String eventDate = request.getParameter("eventDate");
            String eventTime = request.getParameter("eventTime");
            String eventDesc = request.getParameter("eventDesc");
            String eventID = request.getParameter("eventID");
            boolean isSuccess = EventInfoDAO.updateEventInfo(eventName, eventLocation, eventTime, eventDesc, eventDate, eventImg, Integer.parseInt(eventID));
            request.getSession().setAttribute("isSuccess", isSuccess);
            response.sendRedirect("Events?eventID=" + eventID);
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
