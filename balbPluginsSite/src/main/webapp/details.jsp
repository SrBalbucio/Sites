
<%@ page import="balbucio.plugins.cookies.CookieManager" %>
<%@ page import="java.util.UUID" %>
<%@ page import="balbucio.plugins.site.Plugin" %>
<%@ page import="balbucio.plugins.site.License" %>
<%@ page import="balbucio.plugins.StringUtils" %>
<%@ page import="balbucio.utils.database.DatabaseClient" %>
<%@ page import="balbucio.utils.cookies.AccountCookieManager" %>
<%@ page import="balbucio.utils.Account" %>
<%@ page import="balbucio.utils.Start" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    Start.i();
    Plugin.reload();
    License.reload();
    boolean isLogged = AccountCookieManager.checkTempID(request.getCookies());
    Account acc = isLogged ? AccountCookieManager.getAccount(request.getCookies()) : new Account();
%>
<html lang="pt">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta property="og:site_name" content="balbPlugins"/> <!-- website name -->
    <meta property="og:site" content="https://plugins.balbucio.xyz"/> <!-- website link -->
    <meta property="og:title" content="balbPlugins - Loja de Plugins"/> <!-- title shown in the actual shared post -->
    <meta property="og:description" content="Os Melhores Plugins para o seu Servidor!"/>
    <!-- description shown in the actual shared post -->
    <meta property="og:image" content="images/balbplugin3.png"/> <!-- image link, make sure it's jpg -->
    <meta property="og:url" content="https://plugins.balbucio.xyz"/> <!-- where do you want your post to link to -->
    <meta property="og:type" content="store"/>


    <meta name="author" content="balbPlugins">
    <meta name="google" value="notranslate">
    <meta name="revisit-after" content="1 week">
    <meta name="robots" content="index,follow,noodp,noydir">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>balbPlugins - Detalhes</title>
    <meta name="description" content="Qualidade, segurança e facilidade em primeiro lugar.">
    <meta name="keywords" content="balbplugins, minecraft, plugins, plugin grátis">

    <link rel="icon" href="images/balbplugin3.png">

    <link rel="preload"
          href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap">

    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="animate.css">
    <script src="https://kit.fontawesome.com/36e5a32442.js" crossorigin="anonymous"></script>
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
                if(isLogged){
                    out.println("<li><a class=btn grow href=oauth>Painel</a></li>");
                    out.println("<img class=avatar src="+acc.getAvatar()+" alt=\"Ir para Área de Usuários\" onclick=openURL('https://user.balbucio.xyz') >");
                } else{
                    out.println("<li><a class=btn grow href=oauth>Logar</a></li>");
                }

                if(!request.getParameterMap().containsKey("plugin") || !Plugin.has(request.getParameter("plugin"))){
                    response.sendRedirect("https://plugins.balbucio.xyz");
                    return;
                }

                Plugin plugin = Plugin.getPluginByName().get(request.getParameter("plugin"));
            %>
        </ul>
    </nav>
</header>

<div id="plugins" class="details">
    <div class="internal">
        <div class="desc">
            <h1><%=plugin.getName()%></h1>
            <h3><%=plugin.getDescription()%></h3>
            <br>
        </div>
        <div class="options">
            <%
                if(!isLogged || !License.hasLicense(acc.getEmail(), plugin)){
                    String v = plugin.isFree() ? "plugins/download?plugin="+plugin.getName() : "buy.jsp?plugin="+plugin.getName();
                    String t = plugin.isFree() ? "BAIXAR" : "COMPRAR";
                    out.println("<a href="+v+" target=\"_blank\">"+t+"</a>");
                }
                if(isLogged && License.hasLicense(acc.getEmail(), plugin)){
                    out.println("<a href=plugins/download?plugin="+plugin.getName()+" target=\"_blank\">BAIXAR</a>");
                }
                if(plugin.isInspigot()) {
                    out.println("<a href=" + plugin.getSpigotUrl() + " target=_blank>SPIGOT</a>");
                }
            %>
            <h4>Versão Atual: v<%=plugin.getVersion()%></h4>
            <h4 class="semmargin">Valor: R$<%=plugin.getPrice()%></h4>
        </div>
    </div>
    <div class="wrapper">
        <div class="tabs">
            <div class="tab">
                <input type="radio" name="css-tabs" id="tab-1" checked class="tab-switch">
                <label for="tab-1" class="tab-label">Overview</label>
                <div class="tab-content"><%=StringUtils.acentos(plugin.getContent())%></div>
            </div>
            <div class="tab">
                <input type="radio" name="css-tabs" id="tab-2" class="tab-switch">
                <label for="tab-2" class="tab-label">Versões</label>
                <div class="tab-content">
                    <div class="pluginversions">
                      <%
                          out.println(plugin.getVersions().size());
                          for(Double ver : plugin.getVersions().keySet()){
                              out.println("<details>");
                              out.println("<summary>v"+ver+"</summary>");
                              out.println("<div class=summarycontent>");
                              out.println(StringUtils.acentos(plugin.getVersions().get(ver)));
                              out.println("</div>");
                              out.println("</details>");
                          }
                      %>
                    </div>
                </div>
            </div>
            <div class="tab">
                <input type="radio" name="css-tabs" id="tab-3" class="tab-switch">
                <label for="tab-3" class="tab-label">Docs</label>
                <div class="tab-content"><%=StringUtils.acentos(plugin.getDocumentation())%></div>
            </div>
        </div>
    </div>
</div>

<div class="features">
    <h3 class="header">Vantagens</h3>
    <div class="cards">
        <div class="card">
            <img src="images/security.png" alt="Segurança">
            <h3 class="card-title">Segurança</h3>
            <p class="card-subtitle">A segurança é o nosso lema. Usamos padrões de segurança a nível mundial.</p>
        </div>
        <div class="card">
            <img src="images/updates.png" alt="Atualizações">
            <h3 class="card-title">Atualizações</h3>
            <p class="card-subtitle">Todos os nossos plugins recebem atualizações periodicamente.</p>
        </div>
        <div class="card">
            <img src="images/control.png" alt="Control">
            <h3 class="card-title">Praticidade</h3>
            <p class="card-subtitle">Nossos plugins são planejados para terem uma instalação fácil e rápida.</p>
        </div>
        <div class="card">
            <img src="images/support.png" alt="Suporte">
            <h3 class="card-title">Suporte</h3>
            <p class="card-subtitle">Possuimos um suporte por tickets através de nosso <a href="../discord">grupo do
                Discord</a>.</p>
        </div>
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
<script src="geral.js" type="text/javascript"></script>
<script src="error.js" type="text/javascript"></script>
<div style="z-index: 2147483647;"></div>
</body>
</html>