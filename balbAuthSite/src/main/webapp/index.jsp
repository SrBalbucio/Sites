<%@ page import="balbucio.utils.cookies.AccountCookieManager" %>
<%@ page import="balbucio.utils.Account" %>
<%@ page import="balbucio.utils.database.DatabaseClient" %>
<%@ page import="java.util.Objects" %>
<%@ page import="balbucio.utils.Start" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
        Start.i();
    DatabaseClient.createIfNotExists();
    if(!AccountCookieManager.checkTempID(request.getCookies())){
        response.sendRedirect("login.jsp");
    }
    boolean isLogged = AccountCookieManager.checkTempID(request.getCookies());
    Account account = isLogged ? AccountCookieManager.getAccount(request.getCookies()) : new Account();
%>
<html>
<head>
    <title>Seu Perfil - Balbucio Projects</title>
    <link rel="stylesheet" href="css/profile.css">
    <link rel="icon" href="images/balbplugin3.png">
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<header class="d-flex flex-column align-items-center text-center">
    <img src="images/balbplugin3.png" width="48">
</header>
<section>
    <div class="container">
        <div class="main-body">
            <nav aria-label="breadcrumb" class="main-breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a>Home</a></li>
                    <li class="breadcrumb-item"><a href="">Usuário</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Perfil</li>
                </ol>
            </nav>
            <div class="row gutters-sm">
                <div class="col-md-4 mb-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex flex-column align-items-center text-center">
                                <%
                                    if(isLogged){
                                    out.println("<img src="+account.getAvatar()+" alt=\"Sua foto de Perfil\" class=\"rounded-circle\" width=\"150\">");
                                    }
                                %>
                                <div class="mt-3">
                                    <h4><%=account.getUsername()%></h4>
                                    <p class="text-muted font-size-sm">#<%=account.getDiscriminator()%></p>
                                    <button class="btn btn-primary">Logout</button>
                                    <button class="btn btn-outline-primary" onclick="openURL('settings.jsp')">Configurações</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card mt-3">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-globe mr-2 icon-inline"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>Website</h6>
                                <span class="text-secondary"><%=account.getSite()%></span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-github mr-2 icon-inline"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>GitHub</h6>
                                <%
                                if(account.hasGitHub()){
                                    out.println("<a class=\"text-secondary\" href=\""+account.getGitLink()+"\" >"+ account.getGitUsername()+"</a>");
                                } else{
                                    out.println("<a class=\"text-secondary\" href=oauth/send?type=git>Adicionar</a>");
                                }
                                %>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Nome Completo</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <%=account.getName()%>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Email</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <%=account.getEmail()%>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Telefone</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <%=account.getTelefone()%>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Endereço</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <%=account.getEndereco()%>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-12">
                                    <a class="btn btn-info "href="edit.jsp">Editar</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<footer>

</footer>
<script src="js/jquery.min.js"></script>
<script src="js/popper.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
<script src="js/geral.js"></script>
</body>
</html>