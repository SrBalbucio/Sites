package balbucio.site.auth.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

import balbucio.site.auth.servlets.auths.*;
import balbucio.utils.Account;
import balbucio.utils.cookies.AccountCookieManager;
import balbucio.utils.database.DatabaseClient;


@WebServlet(name = "Auth Servlet", urlPatterns = {"/oauth/dc", "/oauth/git", "/oauth/google", "/oauth/face","/oauth/imgur", "/oauth/send"})
public class AuthServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        DatabaseClient.createIfNotExists();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if(action.equalsIgnoreCase("/oauth/dc")){
            if(!request.getParameterMap().containsKey("code")){
                response.sendRedirect("https://user.balbucio.xyz/login.jsp");
                return;
            }
            try {
                response.addCookie(AccountCookieManager.createTempID(DiscordAuth.getAccount(request.getParameter("code"))));
                response.sendRedirect("https://user.balbucio.xyz/");
            } catch (Exception e){
                response.sendRedirect("https://user.balbucio.xyz/login.jsp");
            }
        } else if(action.equalsIgnoreCase("/oauth/git")){
            if(!AccountCookieManager.checkTempID(request.getCookies())){
                response.sendRedirect("https://user.balbucio.xyz/login.jsp");
                return;
            }
            if(!request.getParameterMap().containsKey("code")){
                response.sendRedirect("https://user.balbucio.xyz/");
                return;
            }
            try {
                Account acc = AccountCookieManager.getAccount(request.getCookies());
                acc.setGitHub(GitAuth.getJSON(request.getParameter("code")));
                response.sendRedirect("https://user.balbucio.xyz/");
            } catch (Exception e){
                e.printStackTrace();
                response.sendRedirect("https://user.balbucio.xyz/login.jsp");
            }
        } else if(action.equalsIgnoreCase("/oauth/send")){
            if(!request.getParameterMap().containsKey("type")){
                response.sendRedirect("https://user.balbucio.xyz/login.jsp");
                return;
            }
            String type = request.getParameter("type");
            if(type.equalsIgnoreCase("discord")){
                response.sendRedirect(DiscordAuth.getURL());
            } else if(type.equalsIgnoreCase("git")){
                response.sendRedirect(GitAuth.getURL());
            } else{
                response.sendRedirect("https://user.balbucio.xyz/login.jsp");
            }
        } else{
            response.sendRedirect("https://user.balbucio.xyz/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
