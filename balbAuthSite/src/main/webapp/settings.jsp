<%@ page import="balbucio.utils.Start" %>
<%@ page import="balbucio.utils.database.DatabaseClient" %>
<%@ page import="balbucio.utils.cookies.AccountCookieManager" %>
<%@ page import="balbucio.utils.Account" %><%--
  Created by IntelliJ IDEA.
  User: balbucio
  Date: 7/5/2022
  Time: 7:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    Start.i();
    DatabaseClient.createIfNotExists();
    if (!AccountCookieManager.checkTempID(request.getCookies())) {
        response.sendRedirect("login.jsp");
    }
    boolean isLogged = AccountCookieManager.checkTempID(request.getCookies());
    Account account = isLogged ? AccountCookieManager.getAccount(request.getCookies()) : new Account();
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta property="og:site_name" content="Balbucio Projects" />
    <meta property="og:site" content="https://user.balbucio.xyz" />
    <meta property="og:title" content="Balbucio Projects - Área para Usuários"/>
    <meta property="og:description" content="Gerencie tudo sobre sua conta em um lugar só!" />
    <meta property="og:image" content="http://user.balbucio.xyz/images/balbplugins.png" />
    <meta property="og:url" content="https://user.balbucio.xyz" />
    <meta name="author" content="Balbucio">
    <meta name="google" value="notranslate">
    <meta name="revisit-after" content="1 week">
    <meta name="robots" content="index,follow,noodp,noydir">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Tudo sobre sua conta em um lugar só!">
    <meta name="keywords" content="balbplugins, balbprojects, balbucio, datacrack">
    <title>Configurações do seu Perfil - Balbucio Projects</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="css/profile.css">
    <link rel="icon" href="images/balbplugin3.png">
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<header class="d-flex flex-column align-items-center text-center">
    <img src="images/balbplugin3.png" width="48">
</header>
<body>
<div class="container">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="main-breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a>Home</a></li>
            <li class="breadcrumb-item"><a href="">Usuário</a></li>
            <li class="breadcrumb-item"><a href="index.jsp">Perfil</a></li>
            <li class="breadcrumb-item active" aria-current="page">Configurações</li>
        </ol>
    </nav>
    <!-- /Breadcrumb -->

    <div class="row gutters-sm">
        <div class="col-md-4 d-none d-md-block">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex flex-column align-items-center text-center">
                        <%
                            if (isLogged) {
                                out.println("<img src=" + account.getAvatar() + " alt=\"Sua foto de Perfil\" class=\"rounded-circle\" width=\"150\">");
                            }
                        %>
                        <div class="mt-3">
                            <h4><%=account.getUsername()%>
                            </h4>
                            <p class="text-muted font-size-sm">#<%=account.getDiscriminator()%>
                            </p>
                            <button class="btn btn-primary" onclick="openURL('logoff')">Logout</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <nav class="nav flex-column nav-pills nav-gap-y-1">
                        <a href="#profile" data-toggle="tab" class="nav-item nav-link has-icon nav-link-faded active">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round" class="feather feather-user mr-2">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                <circle cx="12" cy="7" r="4"></circle>
                            </svg>
                            Informações
                        </a>
                        <a href="#account" data-toggle="tab" class="nav-item nav-link has-icon nav-link-faded">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round" class="feather feather-settings mr-2">
                                <circle cx="12" cy="12" r="3"></circle>
                                <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
                            </svg>
                            Config. da Conta
                        </a>
                        <a href="#security" data-toggle="tab" class="nav-item nav-link has-icon nav-link-faded">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round" class="feather feather-shield mr-2">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                            </svg>
                            Segurança
                        </a>
                    </nav>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-header border-bottom mb-3 d-flex d-md-none">
                    <ul class="nav nav-tabs card-header-tabs nav-gap-x-1" role="tablist">
                        <li class="nav-item">
                            <a href="#profile" data-toggle="tab" class="nav-link has-icon active">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-user">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#account" data-toggle="tab" class="nav-link has-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-settings">
                                    <circle cx="12" cy="12" r="3"></circle>
                                    <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
                                </svg>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#security" data-toggle="tab" class="nav-link has-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-shield">
                                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                </svg>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="card-body tab-content">
                    <div class="tab-pane active" id="profile">
                        <h6>Informações sobre sua conta</h6>
                        <hr>
                        <form method="post" action="edit">
                            <div class="form-group">
                                <label for="fullName">Nome Completo</label>
                                <input name="name" type="text" class="form-control" id="fullName"
                                       aria-describedby="fullNameHelp"
                                       placeholder="Coloque seu Nome Completo" value="<%=account.getName()%>">
                                <small id="fullNameHelp" class="form-text text-muted">Este nome será usado para
                                    processar pagamentos e informações legais. Não será compartilhado! Não use Acentos!</small>
                            </div>
                            <div class="form-group">
                                <label for="bio">Sua Bio</label>
                                <textarea name="bio" class="form-control autosize" id="bio"
                                          placeholder="Escreva um pouco sobre você!"
                                          style="overflow: hidden; overflow-wrap: break-word; resize: none; height: 62px;"><%=account.getBio()%></textarea>
                            </div>
                            <div class="form-group">
                                <label for="url">Website</label>
                                <input name="site" type="text" class="form-control" id="url"
                                       placeholder="Adicione o URL do seu WebSite" value="<%=account.getSite()%>">
                                <small id="urlText" class="form-text text-muted">Usamos este URL para espalhar seus
                                    projetos em momentos oportunos.</small>
                            </div>
                            <div class="form-group">
                                <label for="location">Endereço</label>
                                <input name="endereco" type="text" class="form-control" id="location"
                                       placeholder="Enter your location"
                                       value="<%=account.getEndereco()%>">
                            </div>
                            <div class="form-group small text-muted">
                                Esses dados são usados para processar pagamentos, produtos e exibição do seu perfil,
                                nenhum dos dados aqui colocados serão compartilhados sem seu consentimento e a qualquer
                                momento podem ser alterados ou removidos.
                            </div>
                            <button type="submit" class="btn btn-primary">Atualizar</button>
                        </form>
                    </div>
                    <div class="tab-pane" id="account">
                        <h6>Configurações da sua Conta</h6>
                        <hr>
                        <form action="edit" method="post">
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input name="username" type="text" class="form-control" id="username"
                                       aria-describedby="usernameHelp"
                                       placeholder="Insira seu username" value="<%=account.getUsername()%>">
                                <small id="usernameHelp" class="form-text text-muted">Geralmente usamos o seu Nick do
                                    Discord para usar como Username aqui no site, mas você tem a opção de trocar isso
                                    por aqui.</small>
                                <button type="submit" class="btn btn-primary">Atualizar</button>
                            </div>
                        </form>
                        <hr>
                        <form method="get" action="deleteaccount">
                            <div class="form-group">
                                <label class="d-block text-danger">Deletar conta</label>
                                <p class="text-muted font-size-sm">Depois de excluir sua conta, não há como voltar
                                    atrás. Por favor, tenha certeza.</p>
                            </div>
                            <button class="btn btn-danger" type="submit">Deletar conta</button>
                        </form>
                    </div>
                    <div class="tab-pane" id="security">
                        <h6>Segurança</h6>
                        <hr>
                        <form action="password" method="post">
                            <div class="form-group">
                                <label class="d-block">Troca senha</label>
                                <%
                                    if (account.getPassword().equalsIgnoreCase("<null-not>")) {
                                        out.println("<span class=\"text-secondary\">Você ainda não adicionou uma senha!</span>");
                                    } else {
                                        out.println("<input name=old type=\"text\" class=\"form-control\" placeholder=\"Insira sua senha antiga\">");
                                    }
                                %>
                                <input name="senha" type="text" class="form-control mt-1" placeholder="Nova senha">
                                <hr>
                                <button class="btn btn-info" type="submit">Trocar senha</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script src="js/geral.js"></script>
</body>
</html>
