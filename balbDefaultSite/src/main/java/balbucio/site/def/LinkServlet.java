package balbucio.site.def;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Links Servlet", urlPatterns = { "/discord", "/youtube" } )
public class LinkServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if(action.equalsIgnoreCase("/discord")){
            response.sendRedirect("https://discord.gg/Y2V8EfrYA4");
        } else if(action.equalsIgnoreCase("/youtube")){
            response.sendRedirect("https://www.youtube.com/channel/UCjDv8sCm6DQXjy2YAZKWOIg");
        } else{
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
