/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filter;

/**
 *
 * @author PC ASUS
 */
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

//user auth filter
@WebFilter("/userPages/privatePages/*")
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            // Lưu lại URL trang mà người dùng muốn vào
            String requestedURL = req.getRequestURI();
            session = req.getSession(true);
            session.setAttribute("redirectAfterLogin", requestedURL);

            // Chuyển hướng đến trang đăng nhập
            res.sendRedirect(req.getContextPath() + "/Login");
        } else {
            chain.doFilter(request, response); // Tiếp tục nếu đã đăng nhập
        }
    }
}