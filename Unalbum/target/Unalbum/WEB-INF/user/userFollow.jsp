<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/4/8
  Time: 16:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>Personal Gallery</title>
    <!-- Google fonts -->
    <link href='/assets/Googlefonts.css' rel='stylesheet' type='text/css'>
    <link href='/assets/Googlefonts2.css' rel='stylesheet' type='text/css'>
    <!-- font awesome -->
    <link href="/assets/font-awesome.min.css" rel="stylesheet">
    <!-- bootstrap -->
    <link rel="stylesheet" href="/assets/bootstrap/css/bootstrap.min.css" />
    <!-- animate.css -->
    <link rel="stylesheet" href="/assets/animate/animate.css" />
    <link rel="stylesheet" href="/assets/animate/set.css" />
    <!-- gallery -->
    <link rel="stylesheet" href="/assets/gallery/blueimp-gallery.min.css">
    <!-- favicon -->
    <link rel="shortcut icon" href="/img/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="/assets/style.css">

</head>

<body>


<div id="home">
    <!-- Slider Starts -->
    <div class="banner">
        <div style="width: 100%;" id="imgBack">
            <img src="/${pagePicture.picURL}" style="width:100%; height:100%;" alt="banner" class="img-responsive">
        </div>
        <div class="caption">
            <div class="caption-wrapper">
                <div class="caption-info">
                    <img src="/${user.photo}"  class="img-circle profile">
                    <h3 class="animated bounceInUp">个人简介</h3>
                    <p class="animated bounceInLeft">${user.userProfile}</p>
                    <div class="animated bounceInDown">
                        <a href="#works" class="btn btn-default explore">查看全部</a>
                        <a href="/home" class="btn btn-default">返回</a>&nbsp;&nbsp;&nbsp;
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- #Slider Ends -->
</div>

<!-- works -->
<div id="works"  class=" clearfix grid">
    <c:forEach items="${userFollowList}" var="follow"  varStatus="followStatus" begin="0" step="1">
        <figure class="effect-oscar  wowload fadeInUp">

            <c:forEach items="${followUserPage}" var="picture" varStatus="pictureStatus" begin="0" step="1">
                <c:if test="${followStatus.index == pictureStatus.index}">
                    <img src="/${picture.picURL}" alt="img01"/>
                </c:if>
            </c:forEach>

            <figcaption>
                <h2>${follow.followUser.userName}</h2>
                <p><a href="/gallery/userGalleryHome?id=${follow.followUser.id}" id="${follow.id}">查看相册</a></p>
            </figcaption>
        </figure>
    </c:forEach>
</div>
<!-- works -->


<!-- The Bootstrap Image Gallery lightbox, should be a child element of the document body -->
<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls">
    <!-- The container for the modal slides -->
    <div class="slides"></div>
    <!-- Controls for the borderless lightbox -->
    <h3 class="title">Title</h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <!-- The modal dialog, which will be used to wrap the lightbox content -->
</div>



<!-- jquery -->
<script src="/assets/jquery.js"></script>



<!-- wow script -->
<script src="/assets/wow/wow.min.js"></script>
<!-- boostrap -->
<script src="/assets/bootstrap/js/bootstrap.js" type="text/javascript" ></script>

<!-- jquery mobile -->
<script src="/assets/mobile/touchSwipe.min.js"></script>
<script src="/assets/respond/respond.js"></script>

<!-- gallery -->
<script src="/assets/gallery/jquery.blueimp-gallery.min.js"></script>


<!-- custom script -->
<script src="/assets/script.js"></script>

<script>
    var width = window.innerWidth;
    var height = window.innerHeight;
    console.log($("#imgBack").css("height"));
    $("#imgBack").css("height" , height);
    console.log($("#imgBack").css("height"));
</script>

</body>
</html>
