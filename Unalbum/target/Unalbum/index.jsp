<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>

<head>
    <base href="<%=basePath%>">
</head>

<body>
<c:if test="${!empty USER_CONTEXT.userName}">
    <div style="color:red">${ USER_CONTEXT.userName }已登录
    ${USER_CONTEXT.userInterests}
    </div>
</c:if>
<a href="/login">用户登录</a>
</body>
</html>
