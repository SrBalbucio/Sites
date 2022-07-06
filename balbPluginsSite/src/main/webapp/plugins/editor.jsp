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
    <form method="post" action="edit">
        <input class="w-full" type="text" placeholder="Plugin Name" name="name" value="<%= hasPluginEdit ? plugin.getName() : "Plugin Name"%>">
        <input class="w-full" type="text" placeholder="Description" name="description" value="<%= hasPluginEdit ? plugin.getDescription() : "Description"%>">
        <input class="w-full" type="text" placeholder="URL de Pagamento" name="payment" value="Nulo" value=<%= hasPluginEdit ? plugin.getPaymentUrl() : "URL de Pagamento"%>>
        <input class="w-full" type="text" placeholder="Senha" name="senha">
        <input type="number" placeholder="Valor" name="price" step="0.01" value=<%= hasPluginEdit ? plugin.getPrice() : 0%>>
        <fieldset>
            <legend>Preencha as opções:</legend>
            <div>
                <input id="gratis" type="checkbox" placeholder="É gratuito?" name="free" <%= hasPluginEdit ? plugin.isFree() ? "checked" : "" : ""%>>
                <label for="gratis">É gratuito?</label>
            </div>
            <div>
                <input id="insp"type="checkbox" placeholder="Tem versão grátis na Spigot?" name="inspigot" <%= hasPluginEdit ? plugin.isInspigot() ? "checked" : "" : ""%>>
                <label for="insp">Tem versão gratuita na Spigot?</label>
            </div>
        </fieldset>
        <input class="w-full spp" type="text" placeholder="Spigot URL" name="spigot" value="<%= hasPluginEdit ? plugin.getSpigotUrl() : "Spigot URL"%>">
        <br>
        <textarea class="textarea" name="content" id="editor1" rows="10" cols="80">
        <%= hasPluginEdit ? plugin.getContent() : "Coloque o content aqui!"%>
            </textarea>
        <script>
            CKEDITOR.replace( 'editor1' );
        </script>
        <br>
        <p><input type="submit" value="Editar Plugin"></p>
    </form>
</section>
<footer>
    <h2>balbPlugins &copy; 2022</h2>
</footer>
</body>
</html>
