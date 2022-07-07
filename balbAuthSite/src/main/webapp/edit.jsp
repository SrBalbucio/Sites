<%@ page import="balbucio.utils.cookies.AccountCookieManager" %>
<%@ page import="balbucio.utils.database.DatabaseClient" %>
<%@ page import="balbucio.utils.Start" %>
<%@ page import="balbucio.utils.Account" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: balbucio
  Date: 7/5/2022
  Time: 7:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    Start.i();
    boolean isLogged = AccountCookieManager.checkTempID(request.getCookies());
    if (!isLogged) {
        response.sendRedirect("login.jsp");
    }
    Account account = AccountCookieManager.getAccount(request.getCookies());
    if (account == null) {
        response.sendRedirect("login.jsp");
    }
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
    <title>Editar seu Perfil - Balbucio Projects</title>
    <link rel="stylesheet" href="css/profile.css">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
    <div class="main-body">
        <nav aria-label="breadcrumb" class="main-breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a>Home</a></li>
                <li class="breadcrumb-item"><a href="">Usuário</a></li>
                <li class="breadcrumb-item" aria-current="page"><a href="index.jsp">Perfil</a></li>
                <li class="breadcrumb-item active" aria-current="page">Editar</li>
            </ol>
        </nav>
        <div class="row">
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                            <img src=<%=Objects.requireNonNull(account.getAvatar())%> alt="Sua foto de Perfil"
                            class="rounded-circle" width="150">
                            <div class="mt-3">
                                <h4><%=account.getUsername()%>
                                </h4>
                                <p class="text-muted font-size-sm">#<%=account.getDiscriminator()%>
                                </p>
                                <button class="btn btn-primary" onclick="openURL('logoff')">Logout</button>
                                <button class="btn btn-outline-primary">Configurações</button>
                            </div>
                        </div>
                        <hr class="my-4">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-globe mr-2 icon-inline"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>Website</h6>
                                <span class="text-secondary"><%=account.getSite()%></span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                <h6 class="mb-0">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                         stroke-linejoin="round" class="feather feather-github mr-2 icon-inline">
                                        <path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path>
                                    </svg>
                                    GitHub
                                </h6>
                                <%
                                    if (account.hasGitHub()) {
                                        out.println("<a class=\"text-secondary\" href=\"" + account.getGitLink() + "\" >" + account.getGitUsername() + "</a>");
                                    } else {
                                        out.println("<a class=\"text-secondary\" href=oauth/send?type=git>Adicionar</a>");
                                    }
                                %>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="card">
                    <div class="card-body">
                        <form clas="col-lg-8 card" method="post" action="edit">
                            <div class="row mb-3">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Nome Completo</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <input name="name" type="text" class="form-control" value="<%=account.getName()%>">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Email</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <%=account.getEmail()%>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Telefone</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <input name="telefone" type="text" class="form-control"
                                           value="<%=account.getTelefone()%>">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Endereço</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <input name="endereco" type="text" class="form-control"
                                           value="<%=account.getEndereco()%>">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3"></div>
                                <div class="col-sm-9 text-secondary">
                                    <input type="submit" class="btn btn-primary px-4" value="Save Changes">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<script src="js/geral.js"></script>
</body>
</html>
