<%@ page import="balbucio.utils.database.DatabaseClient" %>
<%@ page import="balbucio.utils.cookies.AccountCookieManager" %>
<%@ page import="balbucio.utils.Start" %><%--
  Created by IntelliJ IDEA.
  User: balbucio
  Date: 7/3/2022
  Time: 8:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<%
    Start.i();
    if(AccountCookieManager.checkTempID(request.getCookies())){
        response.sendRedirect("index.jsp");
    }
%>
<html lang="en">
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

    <title>Login - Balbucio Projects</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://kit.fontawesome.com/36e5a32442.js" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="images/balbplugin3.png">
</head>
<body>
<section class="ftco-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="login-wrap py-5">
                    <div class="img d-flex align-items-center justify-content-center" style="background-image: url(images/balbplugins.png);"></div>
                    <h3 class="text-center mb-0">Seja bem-vindo!</h3>
                    <p class="text-center">Logue e aproveite ao máximo nosso conteúdo</p>
                    <form action="login" class="login-form" method="post">
                        <div class="form-group">
                            <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-user"></span></div>
                            <input type="text" class="form-control" placeholder="Email" name="email"required>
                        </div>
                        <div class="form-group">
                            <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-lock"></span></div>
                            <input type="password" class="form-control" name="password" placeholder="Senha" required>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn form-control btn-primary rounded submit px-3">Logar</button>
                        </div>
                    </form>
                    <div class="w-100 text-center mt-4 text">
                        <p class="mb-0">Ainda não tem conta ou login rápido?</p>
                        <a href="oauth/send?type=discord"><i class="fab fa-discord"></i>   Logar com Discord!</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="js/jquery.min.js"></script>
<script src="js/popper.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
<script src="js/error.js"></script>
<script src="js/geral.js"></script>
</body>
</html>

