<%@ page import="balbucio.plugins.cookies.CookieManager" %>
<%@ page import="balbucio.plugins.site.Plugin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    Plugin.update();
%>
<%
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
    if(!request.getParameterMap().containsKey("plugin")){
        response.sendRedirect("list.jsp");
    }
    boolean hasPluginEdit = Plugin.has(request.getParameter("plugin"));
    Plugin plugin = hasPluginEdit ? Plugin.getPluginByName().get(request.getParameter("plugin")) : null;
%>
<head>
    <title>balbPlugins - Editor de Plugins</title>
    <link rel="stylesheet" href="editor.css">
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet" />
    <script src="https://cdn.ckeditor.com/4.19.0/full/ckeditor.js"></script>
</head>
<body>
<header>
    <h1>Editor de Plugins</h1>
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
    <form method="post" action="update" enctype="multipart/form-data">
        <input class="w-full" type="text" placeholder="Plugin Name" name="name" value="<%= hasPluginEdit ? plugin.getName() : "Plugin Name"%>">
        <input class="w-full" type="text" placeholder="Senha" name="senha">
        <input class="w-full" type="number" placeholder="Versão" name="version" step="0.01" value=<%= hasPluginEdit ? plugin.getNextVersion() : 0%>>
        <textarea class="textarea" name="changelog" id="editor1" rows="10" cols="80">
        <%= hasPluginEdit ? plugin.getDocumentation() : "Coloque a changelog aqui!"%>
            </textarea>
        <script>
            CKEDITOR.replace( 'editor1' );
        </script>
        <br>
        <input type="file" name="file" />
        <p><input type="submit" value="Atualizar Plugin"></p>
    </form>
</section>
<footer>
    <h2>balbPlugins &copy; 2022</h2>
</footer>
</body>
</html>
