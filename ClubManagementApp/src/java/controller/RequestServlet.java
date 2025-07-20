/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ClubDAO;
import dao.ClubInfoDAO;
import dao.ClubMemberDAO;
import dao.EventDAO;
import dao.EventInfoDAO;
import dao.RequestDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ClubInfo;
import model.EventInfo;
import model.Request;

/**
 *
 * @author PC ASUS
 */
public class RequestServlet extends HttpServlet {

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
            out.println("<title>Servlet RequestServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RequestServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        if ("CreateClubApproval".equals(action)) {
            String requestID = request.getParameter("requestID");
            String accountID = request.getParameter("accountID");
            String isApproved = request.getParameter("isApproved");
            if ("Approve".equals(isApproved)) {
                boolean isSuccess1 = RequestDAO.approveRequest(Integer.parseInt(requestID), 2);
                Request thisRequest = RequestDAO.getRequestByID(Integer.parseInt(requestID));
                int ClubID = ClubDAO.createClub(Integer.parseInt(accountID), thisRequest.getClubInfo().getEstablishDate());
                boolean isSuccess2 = ClubInfoDAO.addClubInfoToClub(thisRequest.getClubInfo().getClubInfoID(), ClubID);
                boolean isSuccess3 = ClubMemberDAO.createClubMember(Integer.parseInt(accountID), ClubID, "Manager", 1);
                boolean isSuccess = isSuccess1 && isSuccess2 && isSuccess3;
                request.getSession().setAttribute("isSuccess", isSuccess);
                response.sendRedirect("Admin?page=viewClub");
            } else {
                boolean isSuccess = RequestDAO.approveRequest(Integer.parseInt(requestID), 3);
                request.getSession().setAttribute("isSuccess", isSuccess);
                response.sendRedirect("Admin?page=viewClub");
            }
        } else if ("CreateEventApproval".equals(action)) {
            String requestID = request.getParameter("requestID");
            String isApproved = request.getParameter("isApproved");
            if ("Approve".equals(isApproved)) {
                boolean isSuccess1 = RequestDAO.approveRequest(Integer.parseInt(requestID), 2);
                Request thisRequest = RequestDAO.getRequestByID(Integer.parseInt(requestID));
                int EventID = EventDAO.createEvent(RequestDAO.getRequestByID(Integer.parseInt(requestID)).getClub().getClubID());
                boolean isSuccess2 = EventInfoDAO.addEventInfoIntoEvent(thisRequest.getEventInfo().getEventInfoID(), EventID);
                boolean isSuccess = isSuccess1 && isSuccess2;
                request.getSession().setAttribute("isSuccess", isSuccess);
                response.sendRedirect("Admin?page=viewEvent");
            } else {
                boolean isSuccess = RequestDAO.approveRequest(Integer.parseInt(requestID), 3);
                request.getSession().setAttribute("isSuccess", isSuccess);
                response.sendRedirect("Admin?page=viewEvent");
            }
        } else if ("acceptJoinClub".equals(action)) {
            String requestID = request.getParameter("requestID");
            String isAccept = request.getParameter("isAccept");
            String id = request.getParameter("id");
            String clubID = request.getParameter("clubID");
            if ("Accept".equals(isAccept)) {
                boolean isSuccess1 = RequestDAO.approveRequest(Integer.parseInt(requestID), 2);
                boolean isSuccess2
                        = ClubMemberDAO.createClubMember(Integer.parseInt(id),
                                Integer.parseInt(clubID),
                                "Member",
                                Integer.parseInt((String) request.getSession().getAttribute("id")));
                boolean isSuccess = isSuccess1 && isSuccess2;
                request.getSession().setAttribute("isSuccess", isSuccess);
                response.sendRedirect("Clubs?page=clubMembers&clubID=" + clubID);
            } else {
                boolean isSuccess = RequestDAO.approveRequest(Integer.parseInt(requestID), 3);
                request.getSession().setAttribute("isSuccess", isSuccess);
                response.sendRedirect("Clubs?page=clubMembers&clubID=" + clubID);
            }
        } else if ("createEvent".equals(action)) {
            String id = request.getParameter("id");
            String clubID = request.getParameter("clubID");
            String eventName = request.getParameter("eventName");
            String eventDescription = request.getParameter("eventDescription");
            String eventDate = request.getParameter("eventDate");
            String eventTime = request.getParameter("eventTime");
            String eventImage = request.getParameter("eventImage");
            String eventLocation = request.getParameter("eventLocation");
            boolean isSuccess1 = RequestDAO.createRequest(Integer.parseInt(id), Integer.parseInt(clubID), "Create Event", 1);
            EventInfo newEventInfo = new EventInfo(0, 0, 0, eventName, eventDate, eventLocation, eventTime, eventDescription, eventImage);
            boolean isSuccess2 = EventInfoDAO.createEventInfo(newEventInfo);
            boolean isSuccess = isSuccess1 && isSuccess2;
            request.getSession().setAttribute("isSuccess", isSuccess);
            response.sendRedirect("Clubs?page=clubEvents&clubID=" + clubID);
        } else if ("createClub".equals(action)) {
            String id = request.getParameter("id");
            String clubName = request.getParameter("clubName");
            String clubDesc = request.getParameter("clubDesc");
            String clubImgUrl = request.getParameter("clubImgUrl");
            String clubEstablishDate = request.getParameter("clubEstablishDate");
            boolean isSuccess1 = RequestDAO.createRequest(Integer.parseInt(id), 0, "Create Club", 1);
            ClubInfo newClubInfo = new ClubInfo(0, 0, 0, clubName, clubImgUrl, clubDesc, clubEstablishDate);
            boolean isSuccess2 = ClubInfoDAO.createClubInfo(newClubInfo);
            boolean isSuccess = isSuccess1 && isSuccess2;
            request.getSession().setAttribute("isSuccess", isSuccess);
            response.sendRedirect("User?page=clubs");
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
