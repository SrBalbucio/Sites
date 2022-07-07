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

@WebServlet(name = "Servlet", urlPatterns = {"/edit", "/password", "/deleteaccount", "/deleteconfirm", "/logoff", "/login"})
public class Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isLogged = AccountCookieManager.checkTempID(request.getCookies());
        Account account = AccountCookieManager.getAccount(request.getCookies());

        String action = request.getServletPath();
        if(action.equalsIgnoreCase("/deleteaccount") && isLogged){
            response.getWriter().print("<h1>Você tem certeza disso, todos seus projetos, subcontas e afins, serão deletados junto? <a href=deleteconfirm>Clique aqui se tem certeza</a></h1>");
        } else if(action.equalsIgnoreCase("/deleteconfirm") && isLogged){
            response.getWriter().println("<h1>Agradecemos todo tempo que passou usando nosso serviços. Sua conta será deletada em poucos segundos.</h1>");
            DatabaseClient.getInstance().getDatacrack().getManager().deleteRootPack(account.getEmail());
            Cookie cookie = new Cookie("balbUniqueID", "");
            cookie.setMaxAge(1);
            response.addCookie(cookie);
            response.sendRedirect("login.jsp");
        } else if(action.equalsIgnoreCase("/logoff") && isLogged){
            AccountCookieManager.remove(AccountCookieManager.getTempID(request.getCookies()));
            Cookie cookie = new Cookie("balbUniqueID", "");
            cookie.setMaxAge(1);
            cookie.setDomain("balbucio.xyz");
            cookie.setPath("/");
            response.addCookie(cookie);
            response.sendRedirect("login.jsp");
        } else{
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isLogged = AccountCookieManager.checkTempID(request.getCookies());
        Account account = AccountCookieManager.getAccount(request.getCookies());
        String action = request.getServletPath();
        if (action.equalsIgnoreCase("/edit") && isLogged) {
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
            if (request.getParameterMap().containsKey("bio")){
                account.setBio(request.getParameter("bio"));
            }
            account.save();
            response.sendRedirect("index.jsp");
        } else if (action.equalsIgnoreCase("/password") && isLogged) {
            String old = "<null-not>";
            if (request.getParameterMap().containsKey("old")) {
                old = request.getParameter("old");
            }
            String senha = request.getParameter("senha");
            if (account.getPassword().equals(old)) {
                account.setPassword(senha);
                response.sendRedirect("settings.jsp");
            } else {
                response.getWriter().println("<h1>Você colocou a senha errada! Retornando para o site em alguns segundos...</h1>");
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
        } else if(action.equalsIgnoreCase("/logoff") && isLogged){
            Cookie cookie = new Cookie("balbUniqueID", "");
            cookie.setMaxAge(1);
            response.addCookie(cookie);
            response.sendRedirect("login.jsp");
        } else if(action.equalsIgnoreCase("/login")){
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            if(Account.contains(email)) {
                Account acc = new Account(email);
                if (acc.getPassword().equalsIgnoreCase(pass)) {
                    response.addCookie(AccountCookieManager.createTempID(acc));
                    response.sendRedirect("index.jsp");
                } else{
                    response.sendRedirect("login.jsp?error=Credenciais incorretas!");
                }
            } else{
                response.sendRedirect("login.jsp?error=Credenciais incorretas!");
            }
        }
    }
}
