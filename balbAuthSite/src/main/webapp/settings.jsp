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
    <title>Configurações do seu Perfil - Balbucio Projects</title>
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
                            <button class="btn btn-primary">Logout</button>
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
                        <a href="#notification" data-toggle="tab" class="nav-item nav-link has-icon nav-link-faded">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round" class="feather feather-bell mr-2">
                                <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                                <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                            </svg>
                            Notificações
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
                        <li class="nav-item">
                            <a href="#notification" data-toggle="tab" class="nav-link has-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-bell">
                                    <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                                    <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                                </svg>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#billing" data-toggle="tab" class="nav-link has-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-credit-card">
                                    <rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect>
                                    <line x1="1" y1="10" x2="23" y2="10"></line>
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
                                <small id="fullNameHelp" class="form-text text-muted">Este é nome será usado para
                                    processar pagamentos e informações legais. Não será compartilhado!</small>
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
                        <form>
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input name="username" type="text" class="form-control" id="username"
                                       aria-describedby="usernameHelp"
                                       placeholder="Enter your username" value="<%=account.getUsername()%>">
                                <small id="usernameHelp" class="form-text text-muted">Geralmente usamos o seu Nick do
                                    Discord para usar como Username aqui no site, mas você tem a opção de trocar isso
                                    por aqui.</small>
                            </div>
                            <hr>
                            <div class="form-group">
                                <label class="d-block text-danger">Delete Account</label>
                                <p class="text-muted font-size-sm">Once you delete your account, there is no going back.
                                    Please be certain.</p>
                            </div>
                            <button class="btn btn-danger" type="button">Delete Account</button>
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
                                <input name="senha"type="text" class="form-control mt-1" placeholder="Nova senha">
                                <hr>
                                <button class="btn btn-info" type="submit">Trocar senha</button>
                            </div>
                        </form>
                        <hr>
                        <form>
                            <div class="form-group">
                                <label class="d-block">Two Factor Authentication</label>
                                <button class="btn btn-info" type="button">Enable two-factor authentication</button>
                                <p class="small text-muted mt-2">Two-factor authentication adds an additional layer of
                                    security to your account by requiring more than just a password to log in.</p>
                            </div>
                        </form>
                        <hr>
                        <form>
                            <div class="form-group mb-0">
                                <label class="d-block">Sessions</label>
                                <p class="font-size-sm text-secondary">This is a list of devices that have logged into
                                    your account. Revoke any sessions that you do not recognize.</p>
                                <ul class="list-group list-group-sm">
                                    <li class="list-group-item has-icon">
                                        <div>
                                            <h6 class="mb-0">San Francisco City 190.24.335.55</h6>
                                            <small class="text-muted">Your current session seen in United States</small>
                                        </div>
                                        <button class="btn btn-light btn-sm ml-auto" type="button">More info</button>
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane" id="notification">
                        <h6>NOTIFICATION SETTINGS</h6>
                        <hr>
                        <form>
                            <div class="form-group">
                                <label class="d-block mb-0">Security Alerts</label>
                                <div class="small text-muted mb-3">Receive security alert notifications via email</div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="customCheck1" checked="">
                                    <label class="custom-control-label" for="customCheck1">Email each time a
                                        vulnerability is found</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="customCheck2" checked="">
                                    <label class="custom-control-label" for="customCheck2">Email a digest summary of
                                        vulnerability</label>
                                </div>
                            </div>
                            <div class="form-group mb-0">
                                <label class="d-block">SMS Notifications</label>
                                <ul class="list-group list-group-sm">
                                    <li class="list-group-item has-icon">
                                        Comments
                                        <div class="custom-control custom-control-nolabel custom-switch ml-auto">
                                            <input type="checkbox" class="custom-control-input" id="customSwitch1"
                                                   checked="">
                                            <label class="custom-control-label" for="customSwitch1"></label>
                                        </div>
                                    </li>
                                    <li class="list-group-item has-icon">
                                        Updates From People
                                        <div class="custom-control custom-control-nolabel custom-switch ml-auto">
                                            <input type="checkbox" class="custom-control-input" id="customSwitch2">
                                            <label class="custom-control-label" for="customSwitch2"></label>
                                        </div>
                                    </li>
                                    <li class="list-group-item has-icon">
                                        Reminders
                                        <div class="custom-control custom-control-nolabel custom-switch ml-auto">
                                            <input type="checkbox" class="custom-control-input" id="customSwitch3"
                                                   checked="">
                                            <label class="custom-control-label" for="customSwitch3"></label>
                                        </div>
                                    </li>
                                    <li class="list-group-item has-icon">
                                        Events
                                        <div class="custom-control custom-control-nolabel custom-switch ml-auto">
                                            <input type="checkbox" class="custom-control-input" id="customSwitch4"
                                                   checked="">
                                            <label class="custom-control-label" for="customSwitch4"></label>
                                        </div>
                                    </li>
                                    <li class="list-group-item has-icon">
                                        Pages You Follow
                                        <div class="custom-control custom-control-nolabel custom-switch ml-auto">
                                            <input type="checkbox" class="custom-control-input" id="customSwitch5">
                                            <label class="custom-control-label" for="customSwitch5"></label>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane" id="billing">
                        <h6>BILLING SETTINGS</h6>
                        <hr>
                        <form>
                            <div class="form-group">
                                <label class="d-block mb-0">Payment Method</label>
                                <div class="small text-muted mb-3">You have not added a payment method</div>
                                <button class="btn btn-info" type="button">Add Payment Method</button>
                            </div>
                            <div class="form-group mb-0">
                                <label class="d-block">Payment History</label>
                                <div class="border border-gray-500 bg-gray-200 p-3 text-center font-size-sm">You have
                                    not made any payment.
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>
