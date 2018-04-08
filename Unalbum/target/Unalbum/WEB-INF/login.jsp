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
    <!-- favicon -->
    <link rel="shortcut icon" href="/img/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon">

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="../css/styles1.css">

</head>
<body  style="background-image: url(../img/background.jpg);background-size:1920px 1080px;">
<a href="/home">
    <img style="height: 50px; width: auto; float: left;" src="/img/icon.svg" alt="找不到图片">
</a>

<div  class="container">


</div>
<div class="wrapper"  style="background: rgba(20,20,20,20)">

    <div class="container">

        <h1>Login</h1>
        <h3>Welcome back.</h3>
        <form class="form" action="<c:url value="/login" />" accept-charset="UTF-8" method="post">
            <div style="color:red; font-size:20px;">${errorUser}</div>
            <input type="text" placeholder="用户名" name="userName"/>
            <c:if test="${errorMsg eq '用户不存在'}">
                <div style="color:red; font-size:15px;">${errorMsg}</div>
            </c:if>
            <input type="password" placeholder="密码" name="password"/>
            <c:if test="${errorMsg eq '用户密码错误'}">
                <div style="color:red; font-size:15px;">${errorMsg}</div>
            </c:if>
            <input type="submit" value="登陆"/>
            <p>
                还未注册? <a href="register" style="color: #3c5081;">加入</a>
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



<script type="text/javascript" src="../js/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
    $('#login-button').click(function(event){
        event.preventDefault();
        $('form').fadeOut(500);
        $('.wrapper').addClass('form-success');
    });
</script>

</body>
</html>