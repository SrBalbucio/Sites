<%@ page import="balbucio.plugins.site.Plugin" %>
<%@ page import="balbucio.plugins.cookies.CookieManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    Plugin.update();
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
    <title>balbPlugins - Criador de Plugins</title>
    <link rel="stylesheet" href="editor.css">
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet" />
    <script src="https://cdn.ckeditor.com/4.19.0/full/ckeditor.js"></script>
</head>
<body>
<header>
    <h1>Criador de Plugins</h1>
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
    <form  method="post" action="save" enctype="multipart/form-data">
        <input class="w-full" type="text" placeholder="Plugin Name" name="name">
        <input class="w-full" type="text" placeholder="Description" name="description">
        <input class="w-full" type="text" placeholder="Changelog da Versão" name="changelog">
        <input class="w-full" type="text" placeholder="URL de Pagamento" name="payment" value="Nulo">
        <input class="w-full" type="text" placeholder="Senha" name="senha">
        <input type="number" placeholder="Valor" name="price" step="0.01">
        <input class="pulo" type="number" placeholder="Version" name="version" step="0.01">
        <fieldset>
            <legend>Preencha as opções:</legend>
            <div>
                <input id="gratis" type="checkbox" placeholder="É gratuito?" name="free">
                <label for="gratis">É gratuito?</label>
            </div>
            <div>
                <input id="inspigot" type="checkbox" placeholder="Tem versão grátis na Spigot?" name=inspigot">
                <label for="inspigot">Tem versão gratuita na Spigot?</label>
            </div>
        </fieldset>
        <input class="w-full spp" type="text" placeholder="Spigot URL" name="spigot">
        <br>
        <textarea class="textarea" name="content" id="editor1" rows="10" cols="80">
                Coloque o content aqui!
            </textarea>
        <script>
            CKEDITOR.replace( 'editor1' );
        </script>
        <br>
        <input type="file" name="file" />
        <p><input type="submit" value="Criar Plugin"></p>
    </form>
</section>
<footer>
    <h2>balbPlugins &copy; 2022</h2>
</footer>
<script src="editor.js"></script>
</body>
</html>
