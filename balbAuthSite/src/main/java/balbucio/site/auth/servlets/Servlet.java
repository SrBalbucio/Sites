package balbucio.site.auth.servlets;

import balbucio.utils.Account;
import balbucio.utils.cookies.AccountCookieManager;
import balbucio.utils.database.DatabaseClient;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Timer;
import java.util.TimerTask;

@WebServlet(name = "Servlet", urlPatterns = {"/edit", "/password"})
public class Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isLogged = AccountCookieManager.checkTempID(request.getCookies());
        if (!isLogged) {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isLogged = AccountCookieManager.checkTempID(request.getCookies());
        Account account = AccountCookieManager.getAccount(request.getCookies());
        if (!isLogged) {
            response.sendRedirect("login.jsp");
        }
        String action = request.getServletPath();
        if (action.equalsIgnoreCase("/edit")) {
            if (request.getParameterMap().containsKey("name")) {
                account.setName(request.getParameter("name"));
            }
            if (request.getParameterMap().containsKey("endereco")) {
                account.setEndereco(request.getParameter("endereco"));
            }
            if (request.getParameterMap().containsKey("telefone")) {
                account.setTelefone(request.getParameter("telefone"));
            }
            if (request.getParameterMap().containsKey("site")) {
                account.setSite(request.getParameter("site"));
            }
            if (request.getParameterMap().containsKey("username")) {
                account.setUsername(request.getParameter("username"));
            }
            account.save();
            response.sendRedirect("index.jsp");
        } else if (action.equalsIgnoreCase("/password")) {
            String old = "<null-not>";
            if (request.getParameterMap().containsKey("old")) {
                old = request.getParameter("old");
            }
            String senha = request.getParameter("senha");
            if (account.getPassword().equals(old)) {
                account.setPassword(senha);
                response.sendRedirect("settings.jsp");
            } else {
                response.sendRedirect("<h1>Você colocou a senha errada! Retornando para o site em alguns segundos...</h1>");
                TimerTask task = new TimerTask() {

                    public void run() {
                        try {
                            response.sendRedirect("settings.jsp");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                };
                Timer timer = new Timer();
                timer.schedule(task, 40);
            }
        }
    }
}
