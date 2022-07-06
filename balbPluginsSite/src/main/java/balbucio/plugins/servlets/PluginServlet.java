package balbucio.plugins.servlets;

import balbucio.plugins.cookies.CookieManager;
import balbucio.plugins.site.Plugin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet(name = "Plugin Servlet", urlPatterns = {"/plugins/delete", "/plugins/save", "/plugins/edit", "/plugins/docs", "/plugins/update"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class PluginServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        Plugin.update();
    }

    private final int ARBITARY_SIZE = 1048;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!CookieManager.isAdmin(request.getCookies())) {
            if (!request.getParameterMap().containsKey("senha") || !request.getParameter("senha").equalsIgnoreCase("oBomEVelhoSexo1902932438949243")) {
                response.sendRedirect("https://plugins.balbucio.xyz");
                return;
            }
        }
        if (!CookieManager.isAdmin(request.getCookies())) {
            response.addCookie(CookieManager.createAdminCookie());
        }
        String action = request.getServletPath();
        if (action.equalsIgnoreCase("/plugins/delete")) {
            Plugin.deletePlugin(request.getParameter("plugin"));
            response.sendRedirect("list.jsp");
        } else {
            response.sendRedirect("list.jsp");
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        if(action.equalsIgnoreCase("/plugins/save")){
            String pluginName = request.getParameter("name");
            String description = request.getParameter("description");
            String changelog = request.getParameter("changelog");
            String payment = request.getParameter("payment");
            String spigot = request.getParameter("spigot");
            String content = request.getParameter("content");
            Double price = Double.parseDouble(request.getParameter("price"));
            Double version = Double.parseDouble(request.getParameter("version"));
            boolean free = request.getParameterMap().containsKey("free");
            boolean inspigot = request.getParameterMap().containsKey("inspigot");
            if(!Plugin.has(pluginName)) {
                Plugin plugin = new Plugin(pluginName, description, payment, spigot, price, free, inspigot, content);
                plugin.addVersion(version, changelog);
            } else{
                Plugin plugin = Plugin.getPluginByName().get(pluginName);
                plugin.setContent(content);
                plugin.setDescription(description);
                plugin.setSpigotUrl(spigot);
                plugin.setFree(free);
                plugin.setInspigot(inspigot);
                plugin.setPaymentUrl(payment);
                plugin.setPrice(price);
                plugin.addVersion(version, changelog);
            }
            String uploadPath = getServletContext().getRealPath("") + File.separator + "plugin" + File.separator + pluginName;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            for (Part part : request.getParts()) {
                part.write(uploadPath + File.separator + pluginName + "-" + version + ".jar");
            }
            response.sendRedirect("list.jsp");
        } else if(action.equalsIgnoreCase("/plugins/edit")){
            String pluginName = request.getParameter("name");
            String description = request.getParameter("description");
            String payment = request.getParameter("payment");
            String spigot = request.getParameter("spigot");
            String content = request.getParameter("content");
            Double price = Double.parseDouble(request.getParameter("price"));
            boolean free = request.getParameterMap().containsKey("free");
            boolean inspigot = request.getParameterMap().containsKey("inspigot");
            if (Plugin.has(pluginName)) {
                Plugin plugin = Plugin.getPluginByName().get(pluginName);
                plugin.setContent(content);
                plugin.setDescription(description);
                plugin.setSpigotUrl(spigot);
                plugin.setFree(free);
                plugin.setInspigot(inspigot);
                plugin.setPaymentUrl(payment);
                plugin.setPrice(price);
            }
            response.sendRedirect("list.jsp");
        } else if(action.equalsIgnoreCase("/plugins/update")){
            String pluginName = request.getParameter("name");
            String changelog = request.getParameter("changelog");
            Double version = Double.parseDouble(request.getParameter("version"));
            if(Plugin.has(pluginName)) {
                Plugin.getPluginByName().get(pluginName).addVersion(version, changelog);
                String uploadPath = getServletContext().getRealPath("") + File.separator + "plugin" + File.separator + pluginName;

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                for (Part part : request.getParts()) {
                    part.write(uploadPath + File.separator + pluginName + "-" + version + ".jar");
                }
                response.sendRedirect("list.jsp");
            } else{
                response.getWriter().println("Erro ao escrever a nova versão!");
            }
        } else if(action.equalsIgnoreCase("/plugins/docs")){
            String pluginName = request.getParameter("name");
            String documentation = request.getParameter("documentation");
            if(Plugin.has(pluginName)) {
               Plugin.getPluginByName().get(pluginName).setDocumentation(documentation);
            }
            response.sendRedirect("list.jsp");
        }
    }

}