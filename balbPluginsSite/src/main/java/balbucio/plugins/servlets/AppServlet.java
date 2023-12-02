package balbucio.plugins.servlets;

import balbucio.plugins.site.License;
import balbucio.plugins.site.Plugin;
import balbucio.utils.database.DatabaseClient;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "App API", urlPatterns = {"/app/plugin/create", "/app/plugin/update", "/app/plugin/delete"})
public class AppServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        DatabaseClient.createIfNotExists();
        Plugin.reload();
        License.reload();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if(action.equalsIgnoreCase("/app/plugin/create")){
            try{
                String password = request.getHeader("password");
                if(!password.equals("*")){

                    response.getWriter().println(new JSONObject().put("error", true).put("message", "Ops... Senha incorreta! Você foi bloqueado <3"));
                    return;
                }
                JSONObject json = new JSONObject(request.getHeader("json"));
                if(!Plugin.has(json.getString("name"))){
                    Plugin.createPlugin(json);
                    response.getWriter().println(new JSONObject().put("error", false).put("message", "Trabalhando nisso!"));
                } else{
                    response.getWriter().println(new JSONObject().put("error", true).put("message", "Plugin já existe!"));
                }
            } catch (Exception e){
                response.getWriter().println(new JSONObject().put("error", true).put("message", "Argumentos inválidos!"));
            }
        } else if(action.equalsIgnoreCase("/app/plugin/delete")){
            try{
                String password = request.getHeader("password");
                if(!password.equals("*")){

                    response.getWriter().println(new JSONObject().put("error", true).put("message", "Ops... Senha incorreta! Você foi bloqueado <3"));
                    return;
                }
                JSONObject json = new JSONObject(request.getHeader("json"));
                if(Plugin.has(json.getString("name"))){
                    Plugin.deletePlugin(json);
                    response.getWriter().println(new JSONObject().put("error", false).put("message", "Trabalhando nisso!"));
                } else{
                    response.getWriter().println(new JSONObject().put("error", true).put("message", "Plugin não existe!"));
                }
            } catch (Exception e){
                response.getWriter().println(new JSONObject().put("error", true).put("message", "Argumentos inválidos!"));
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if(action.equalsIgnoreCase("/app/plugin/create")){
            try{
                String password = request.getHeader("password");
                if(!password.equals("*!")){

                    response.getWriter().println(new JSONObject().put("error", true).put("message", "Ops... Senha incorreta! Você foi bloqueado <3"));
                    return;
                }
                JSONObject json = new JSONObject(request.getHeader("json"));
                if(!Plugin.has(json.getString("name"))){
                    Plugin.createPlugin(json);
                    response.getWriter().println(new JSONObject().put("error", false).put("message", "Trabalhando nisso!"));
                } else{
                    response.getWriter().println(new JSONObject().put("error", true).put("message", "Plugin já existe!"));
                }
            } catch (Exception e){
                response.getWriter().println(new JSONObject().put("error", true).put("message", "Argumentos inválidos!"));
            }
        } else if(action.equalsIgnoreCase("/app/plugin/delete")){
            try{
                String password = request.getHeader("password");
                if(!password.equals("*")){

                    response.getWriter().println(new JSONObject().put("error", true).put("message", "Ops... Senha incorreta! Você foi bloqueado <3"));
                    return;
                }
                JSONObject json = new JSONObject(request.getHeader("json"));
                if(Plugin.has(json.getString("name"))){
                    Plugin.deletePlugin(json);
                    response.getWriter().println(new JSONObject().put("error", false).put("message", "Trabalhando nisso!"));
                } else{
                    response.getWriter().println(new JSONObject().put("error", true).put("message", "Plugin não existe!"));
                }
            } catch (Exception e){
                response.getWriter().println(new JSONObject().put("error", true).put("message", "Argumentos inválidos!"));
            }
        }
    }
}
