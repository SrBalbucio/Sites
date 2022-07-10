package balbucio.plugins.servlets;

import balbucio.utils.cookies.AccountCookieManager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AuthServlet", value = "/oauth")
public class AuthServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isLogged = AccountCookieManager.checkTempID(request.getCookies());
        if(!isLogged) {
            response.sendRedirect("https://user.balbucio.xyz/login.jsp?redirect=https://plugins.balbucio.xyz");
        } else{
            response.sendRedirect("panel.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
