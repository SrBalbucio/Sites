package balbucio.site.auth.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

import balbucio.site.auth.servlets.auths.*;
import balbucio.utils.Account;
import balbucio.utils.cookies.AccountCookieManager;
import balbucio.utils.cookies.CookieUtils;
import balbucio.utils.database.DatabaseClient;
import org.json.JSONObject;


@WebServlet(name = "Auth Servlet", urlPatterns = {"/oauth/dc", "/oauth/git", "/oauth/google", "/oauth/face","/oauth/imgur", "/oauth/send"})
public class AuthServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        DatabaseClient.createIfNotExists();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isRedirect = CookieUtils.hasCookie("bRedirect", request.getCookies());
        Cookie redirectCookie = isRedirect ? CookieUtils.getCookie("bRedirect", request.getCookies()) : new Cookie("", "");
        String action = request.getServletPath();
        if(action.equalsIgnoreCase("/oauth/dc")){
            if(!request.getParameterMap().containsKey("code")){
                response.sendRedirect("https://user.balbucio.xyz/login.jsp");
                return;
            }
            try {
                Account acc = DiscordAuth.getAccount(request.getParameter("code"));
                response.addCookie(AccountCookieManager.createTempID(acc));
                if (!acc.isNewAccount()) {
                    response.sendRedirect("/index.jsp?new=true");
                } else {
                    if (isRedirect) {
                        response.sendRedirect(redirectCookie.getValue());
                    } else {
                        response.sendRedirect("/index.jsp");
                    }
                }
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
                JSONObject json = GitAuth.getJSON(request.getParameter("code"));
                acc.setGitHub(json);
                response.sendRedirect("/index.jsp");
            } catch (Exception e){
                e.printStackTrace();
                response.sendRedirect("https://user.balbucio.xyz/login.jsp?error=Ocorreu um erro ao sincronizar a conta!");
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
