<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/3/13
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登陆</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="css/styles1.css">

</head>
<body  style="background-image: url(img/background.jpg);background-size:1920px 1080px;">

<div  class="container">
    <a>
        <img style="height: 110px; width: auto; float: left;" src="img/icon.svg" alt="找不到图片">
    </a>

</div>
<div class="wrapper"  style="background: rgba(20,20,20,20)">

    <div class="container">

        <h1>Login</h1>
        <h3>Welcome back.</h3>
        <form class="form" action="<c:url value="/doLogin.html" />" method="post">
            <input type="text" placeholder="用户名">
            <input type="password" placeholder="密码">
            <button type="submit" id="login-button">登录</button>
            <p>
                还未注册? <a href="doRegister.html" style="color: #3c5081;">加入</a>
            </p>
        </form>

    </div>


    <ul class="bg-bubbles">
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
    </ul>

</div>



<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
    $('#login-button').click(function(event){
        event.preventDefault();
        $('form').fadeOut(500);
        $('.wrapper').addClass('form-success');
    });
</script>

</body>
</html>