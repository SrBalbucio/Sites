package balbucio.plugins.servlets;

import balbucio.plugins.cookies.CookieManager;
import balbucio.plugins.site.License;
import balbucio.plugins.site.Plugin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Licenses Servlet", urlPatterns = {"/license/add", "/license/remove"})
public class LicensesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Plugin.update();
        License.reload();
        if(!CookieManager.isAdmin(request.getCookies())) {
            if (!request.getParameterMap().containsKey("senha") || !request.getParameter("senha").equalsIgnoreCase("oBomEVelhoSexo1902932438949243"))
            {
                response.sendRedirect("https://plugins.balbucio.xyz");
                return;
            }
        }
        if(!CookieManager.isAdmin(request.getCookies())){
            response.addCookie(CookieManager.createAdminCookie());
        }
        String action = request.getServletPath();
        if(action.equalsIgnoreCase("/license/add")){
            String email = request.getParameter("email");
            String plugin = request.getParameter("email");
            License license = new License(email, Plugin.getPluginByName().get(plugin));
            response.sendRedirect("../plugins/license.jsp");
        } else if(action.equalsIgnoreCase("/license/remove")){
            String email = request.getParameter("email");
            String plugin = request.getParameter("email");
            License.removeLicense(email,  Plugin.getPluginByName().get(plugin));
            response.sendRedirect("../plugins/license.jsp");
        }
    }
}
