<%@ page import="balbucio.plugins.cookies.CookieManager" %>
<%@ page import="balbucio.plugins.site.Plugin" %>
<%@ page import="balbucio.plugins.site.License" %><%--
  Created by IntelliJ IDEA.
  User: balbucio
  Date: 7/10/2022
  Time: 11:12 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
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
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>balbPlugins - Editor de Licenças</title>
    <link rel="stylesheet" href="editor.css">
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet" />
    <script src="https://cdn.ckeditor.com/4.19.0/full/ckeditor.js"></script>
</head>
<body>
<header>
    <h1>Editor de Licenças</h1>
</header>
<section class="create">
    <h1 style="color: #fff">+atio+=ã
        +otio+=õ
        +asu+=á
        +osu+=ó
        +esu+=é
        +acha+=â
        +echa+=ê
        +ocha+=ô
        +cidilha+=ç</h1>
    <form  method="post" action="../license/add">
        <input class="w-full" type="text" placeholder="Email" name="email">
        <input class="w-full" type="text" placeholder="Senha" name="senha">
        <label for="plugin">Escolha o plugin:</label>

        <select name="plugin" id="plugin">
            <%
                for(Plugin plugin : Plugin.getPlugins()){
                    out.println("<option value="+plugin.getName()+">"+plugin.getName()+"</option>");
                }
            %>
        </select>
        <p><input type="submit" value="Criar Licença"></p>
    </form>
    <br>
    <hr>
    <br>
    <form  method="post" action="../license/remove" >
        <input class="w-full" type="text" placeholder="Email" name="email">
        <input class="w-full" type="text" placeholder="Senha" name="senha">
        <label for="plugin">Escolha o plugin:</label>

        <select name="plugin" id="plugin">
            <%
                for(Plugin plugin : Plugin.getPlugins()){
                    out.println("<option value="+plugin.getName()+">"+plugin.getName()+"</option>");
                }
            %>
        </select>
        <p><input type="submit" value="Delete licença"></p>
    </form>
</section>
<footer>
    <h2>balbPlugins &copy; 2022</h2>
</footer>
<script src="editor.js"></script>
</body>
</html>
