package balbucio.plugins.servlets;

import balbucio.utils.database.DatabaseClient;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Bot API", value = "/bot")
public class BotServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        DatabaseClient.createIfNotExists();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameterMap().containsKey("token") && request.getParameter("token").equals("SenHAJkasSuperSseguroi")){
        } else{
            response.getWriter().println("Ops... Senha errada!");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
