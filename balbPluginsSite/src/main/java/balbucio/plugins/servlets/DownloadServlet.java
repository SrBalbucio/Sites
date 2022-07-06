package balbucio.plugins.servlets;

import balbucio.plugins.site.Plugin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet(name = "Download Servlet", value = "/plugins/download")
public class DownloadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!request.getParameterMap().containsKey("plugin")) {
            response.sendRedirect("https://plugins.balbucio.xyz");
            return;
        }
        boolean isEspecifVersion = request.getParameterMap().containsKey("version");
        Plugin plugin = Plugin.getPluginByName().get(request.getParameter("plugin"));
        Double version = plugin.getVersion();
        if (isEspecifVersion) {
            version = Double.parseDouble(request.getParameter("version"));
        }
        File file = plugin.getDownloadFile(getServletContext().getRealPath(""));
        if (isEspecifVersion) {
            file = plugin.getDownloadFile(getServletContext().getRealPath(""), version);
        }
        if (file == null) {
            response.getWriter().println("Ops... Aparentemente essa versão do Plugin não pode ser baixada. Contate um administrador se você acha que isso é um erro!");
            return;
        }
        response.setContentType("text/plain");
        response.setHeader("Content-disposition", "attachment; filename=" + plugin.getName() + "-" + version + ".jar");

        try {
            FileInputStream in = new FileInputStream(new File(""));
            OutputStream out = response.getOutputStream();
            byte[] buffer = new byte[1048];

            int numBytesRead;
            while ((numBytesRead = in.read(buffer)) > 0) {
                out.write(buffer, 0, numBytesRead);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Ops... Aparentemente essa versão do Plugin não pode ser baixada. Contate um administrador se você acha que isso é um erro!");
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
