<%@ page import="balbucio.plugins.accounts.Account" %>
<%@ page import="balbucio.plugins.cookies.CookieManager" %>
<%@ page import="java.util.UUID" %>
<%@ page import="balbucio.plugins.DatabaseClient" %>
<%@ page import="balbucio.plugins.site.Plugin" %>
<%@ page import="balbucio.plugins.site.License" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt">
<%
    Plugin.update();
    if(!CookieManager.isAdmin(request.getCookies())) {
        if (!request.getParameterMap().containsKey("senha") || !request.getParameter("senha").equalsIgnoreCase("oBomEVelhoSexo1902932438949243"))
        {
            response.sendRedirect("https://plugins.balbucio.xyz");
            return;
        }
    }
    if(!CookieManager.isAdmin(request.getCookies())) {
        response.addCookie(CookieManager.createAdminCookie());
    }
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta property="og:site_name" content="balbPlugins" /> <!-- website name -->
    <meta property="og:site" content="https://plugins.balbucio.xyz" /> <!-- website link -->
    <meta property="og:title" content="balbPlugins - Loja de Plugins"/> <!-- title shown in the actual shared post -->
    <meta property="og:description" content="Os Melhores Plugins para o seu Servidor!" /> <!-- description shown in the actual shared post -->
    <meta property="og:image" content="images/balbplugin3.png" /> <!-- image link, make sure it's jpg -->
    <meta property="og:url" content="https://plugins.balbucio.xyz" /> <!-- where do you want your post to link to -->
    <meta property="og:type" content="store" />


    <meta name="author" content="balbPlugins">
    <meta name="google" value="notranslate">
    <meta name="revisit-after" content="1 week">
    <meta name="robots" content="index,follow,noodp,noydir">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>balbPlugins - Listar</title>
    <meta name="description" content="Qualidade, segurança e facilidade em primeiro lugar.">
    <meta name="keywords" content="balbplugins, minecraft, plugins, plugin grátis">

    <link rel="icon" href="../images/balbplugin3.png">

    <link rel="preload" href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap">

    <link rel="stylesheet" href="../style.css">
    <link rel="stylesheet" href="../animate.css">
    <style></style>
</head>

<body>
<header>
    <nav class="navbar">
        <div>
            <a class="logo" href="https://plugins.balbucio.xyz">
                <img src="images/balbplugin3.png" alt="Logo">
            </a>
        </div>
        <button class="om float-left hidden-lg-up">
            <div class="om-box">
                <span class="om-inner"></span>
            </div>
        </button>
        <ul class="menu">
            <li><a class="nav-item" href="#plugins">Plugins</a></li>
            <li><a class="nav-item" href="../docs">Documentação</a></li>
            <%
                DatabaseClient.createIfNotExists();
                Plugin.reload();
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
        </ul>
    </nav>
</header>
<div class="content">

    <div id="plugins" class="plugins">
        <h3 class="header">Plugins</h3>
        <div class="cards">
            <%
                for(Plugin plugin : Plugin.getPlugins()) {
                    out.println("<div class=card>");
                    String valores = plugin.isFree() ? "GRATUITO" : plugin.isInspigot() ? "VERSÃO FREE E PREMIUM" : "PAGO";
                    out.println(" <h3>" + plugin.getName() + "</h3>");
                    out.println(" <p>" + plugin.getDescription() + "</p>");
                    out.println(" <p class=price>" + valores + "</p>");
                    out.println(" <a href=delete?plugin="+plugin.getName()+" class=\"btn\">APAGAR</a>");
                    out.println(" <a href=editor.jsp?plugin="+plugin.getName()+" class=\"btn\">EDITAR</a>");
                    out.println(" <a href=docedit.jsp?plugin="+plugin.getName()+" class=\"btn\">EDITAR DOC</a>");
                    out.println(" <a href=update.jsp?plugin="+plugin.getName()+" class=\"btn\">ATUALIZAR</a>");
                    out.println("</div>");
                }
            %>
        </div>
    </div>
</div>
<br>

<footer>
    <div class="content">
        <div class="top">
            <div class="contact-us">
                <h4>Redes Sociais</h4>
                <p>YouTube: <a href="https://www.youtube.com/channel/UCjDv8sCm6DQXjy2YAZKWOIg">Sr_Balbucio</a></p>
                <p>-</p><br>
                <p>GitHub: <a href="https://github.com/SrBalbucio">@SrBalbucio</a></p>
                <p>-</p><br>
                <p>Discord: <a href="../discord" target="_blank">Link do convite</a></p>
                <br>
            </div>
            <div class="about-us">
                <h4>Saber Mais</h4>
                <p><a href="https://hyper-mc.net">HyperNetwork</a></p>
                <p>-</p><br>
                <br>
            </div>
            <div class="about-us">
                <h4>Emails</h4>
                <p>Financeiro: <a>financeiro@balbucio.xyz</a></p>
                <p>-</p><br>
                <p>Suporte: <a>suporte@balbucio.xyz</a></p>
                <br>
            </div>
        </div>
        <div class="bottom"></div>
        <div align="center">
            <p>Criado com ❤ para toda comunidade de Minecraft!</p>
            <span>© 2022 balbucio.xyz - Todos os direitos reservados.</span>
            <br>
            <span><a href="../termos.pdf"><abbr title="Clique para saber mais">Termos de Uso, Política de Privacidade e Regras da Comunidade</abbr></a></span>
        </div>
    </div>
</footer>
<script src="jquery.js" type="text/javascript"></script>
<script src="core.js" type="text/javascript"></script>
<div style="z-index: 2147483647;"></div>
</body>
</html>