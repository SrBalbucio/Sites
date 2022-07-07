<%@ page import="balbucio.plugins.site.Plugin" %>
<%@ page import="balbucio.utils.database.DatabaseClient" %>
<%@ page import="balbucio.plugins.site.License" %>
<%@ page import="balbucio.utils.cookies.AccountCookieManager" %>
<%@ page import="balbucio.utils.Account" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt">
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

    <meta name="description" content="Qualidade, segurança e facilidade em primeiro lugar.">
    <meta name="keywords" content="balbplugins, minecraft, plugins, plugin grátis">
    <title>balbPlugins - Início</title>

    <link rel="icon" href="images/balbplugin3.png">

    <link rel="preload" href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap">

    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="animate.css">
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet" />
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
        boolean isLogged = AccountCookieManager.checkTempID(request.getCookies());
                Account acc = isLogged ? AccountCookieManager.getAccount(request.getCookies()) : null;
                if(isLogged){
                    out.println("<li><a class=btn grow href=oauth>Painel</a></li>");
                    out.println("<img class=avatar src=https://cdn.discordapp.com/avatars/"+acc.getDiscordID()+"/"+acc.getAvatar()+".png alt=\"Ir para o Painel\" href=panel>");
                } else{
                    out.println("<li><a class=btn grow href=oauth>Logar</a></li>");
                }
        %>
        </ul>
    </nav>
</header>
<div class="content">
    <div class="about">
        <img src="images/mc.png" alt="Logo">
        <div style="text-align: center;">
            <h2>BalbPlugins</h2>
            <p>
                Seja bem-vindo! Está procurando por plugins de alta qualidade, otimizados e seguros para o seu servidor? Você está no lugar certo! Confira abaixo alguns de nossos principais trabalhos. Sinta-se a vontade para
                consultar <a href="../discord">nosso suporte</a>.
            </p>
        </div>
    </div>

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
                    out.println(" <a href=details.jsp?plugin="+plugin.getName()+" class=\"btn\" target=_blank>DETALHES</a>");
                    if (!plugin.isFree()) {
                        if (isLogged) {
                            out.println(" <a href=./oauth class=\"btn grow\" target=_blank>VER NO PAINEL</a>");
                        } else {
                            out.println(" <a href=buy?plugin=" + plugin.getName() + " class=\"btn grow\" target=_blank>COMPRAR</a>");
                        }
                        if(plugin.isInspigot()){
                            out.println(" <a href="+ plugin.getSpigotUrl() + " class=\"btn grow\" target=_blank>TESTAR</a>");
                        }
                    } else{
                        out.println(" <a href=plugins/download?plugin=" + plugin.getName() + " class=\"btn grow\" target=_blank>BAIXAR</a>");
                    }
                    out.println("</div>");
                }
            %>
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
                <p class="card-subtitle">Possuimos um suporte por tickets através de nosso <a href="../discord">grupo do Discord</a>.</p>
            </div>
        </div>
    </div>
    <div class="w-full features">
        <h3 class="header">Perguntas Frequentes</h3>
        <div class="questions">
        <details>
            <summary>Summary</summary>
            <ul>
                <li>1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
                <li>5</li>
            </ul>
        </details>
        <details>
            <summary>Summary</summary>
            <h1>Test headline</h1>
            <ul>
                <li>1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
                <li>5</li>
            </ul>
        </details>
        <details>
            <summary>Summary</summary>
            <ul>
                <li>1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
                <li>5</li>
            </ul>
        </details>
        <details>
            <summary>Summary</summary>
            <ul>
                <li>1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
                <li>5</li>
            </ul>
        </details>
        <details>
            <summary>Summary</summary>
            <ul>
                <li>1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
                <li>5</li>
            </ul>
        </details>
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