<%@ page import="balbucio.utils.database.DatabaseClient" %>
<%@ page import="balbucio.utils.cookies.AccountCookieManager" %><%--
  Created by IntelliJ IDEA.
  User: balbucio
  Date: 7/3/2022
  Time: 8:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<%
    DatabaseClient.createIfNotExists();
    if(AccountCookieManager.checkTempID(request.getCookies())){
        response.sendRedirect("/");
    }
%>
<html lang="en">
<head>
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
                    <form action="#" class="login-form" method="post">
                        <div class="form-group">
                            <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-user"></span></div>
                            <input type="text" class="form-control" placeholder="Email" name="email"required>
                        </div>
                        <div class="form-group">
                            <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-lock"></span></div>
                            <input type="password" class="form-control" name="senha" placeholder="Senha" required>
                        </div>
                        <div class="form-group d-md-flex">
                            <div class="w-100 text-md-right">
                                <a href="#">Esqueceu a senha?</a>
                            </div>
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

</body>
</html>

