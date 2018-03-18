<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/3/18
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>

    <title>Picture Category</title>

    <!--- basic page needs
================================================== -->
    <meta charset="utf-8">

    <!-- mobile specific metas
    ================================================== -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <!-- CSS
  ================================================== -->

    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/demo1.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/component1.css" />

    <link rel="stylesheet" href="<%=basePath%>css/base.css">
    <link rel="stylesheet" href="<%=basePath%>css/vendor.css">
    <link rel="stylesheet" href="<%=basePath%>css/main.css">
    <link rel="stylesheet" href="<%=basePath%>css/unsplash.css" />

    <!-- script
    ================================================== -->
    <script src="<%=basePath%>js/modernizr.js"></script>
    <script src="<%=basePath%>js/pace.min.js"></script>
    <script src="<%=basePath%>js/modernizr.custom.js"></script>
</head>
<body>

<div class="js-flash-container"></div>


<div class="offset-fixed-navbar js-global-nav-offset"></div>

<div class="navbar navbar--fixed js-global-nav hidden-xs">
    <div class="container-fluid">

        <div class="navbar__links-container navbar__links-container--left">
            <a href="/home" title="Home &mdash; Unalbum">
                <img class="navbar__logo " src="<%=basePath%>img/logo-black-b37a09de4a228cd8fb72adbabc95931c5090611a0cae8e76f1fd077d378ec080.svg" alt="Logo black" />
            </a>
        </div>

        <ul class="navbar__links-container navbar__links-container--center navbar__text-links">
            <li class="navbar__element navbar__element--heading navbar__element--hide-on-xs ">
                <a class="a" href="/home">主页</a>
            </li>
            <li class="navbar__element navbar__element--heading navbar__element--hide-on-xs">
                <a class="search-trigger"><i class="fa fa-search">搜索</i></a>
            </li>

        </ul>

        <div class="search-wrap">

            <form role="search" method="get" class="search-form" action="#">
                <label>
                    <span class="hide-content">Search for:</span>
                    <input type="search" class="search-field" placeholder="Search for" value="" name="s" title="Search for:" autocomplete="off">
                </label>
                <input type="submit" class="search-submit" value="Search">
            </form>

            <a href="#" id="close-search" class="close-btn">Close</a>

        </div>

        <ul class="navbar__links-container navbar__links-container--right">
            <li class="navbar__element navbar__element--heading navbar__element--half-spacing">
                <ul class="nav">
                    <li class="navbar__element navbar__element--full-spacing">
                        <a class="btn btn-outline btn--small text-weight--medium hidden-xs" href="picture/submit">上传图片</a>
                    </li>
                    <c:if test="${!empty USER_CONTEXT.photo}">
                        <a href="/@shisheng01">
                            <img src="<%=basePath %>${USER_CONTEXT.photo}" sizes="32px" class="avatar avatar--small avatar--small-mobile">
                            <span class="sr-only">Shi sheng</span>
                        </a>
                    </c:if>
                    <c:if test="${empty USER_CONTEXT.photo}">
                        <li class="navbar__element navbar__element--full-spacing">
                            <a class="btn btn-outline btn--small text-weight--medium hidden-xs" href="/login">立即登陆</a>
                        </li>
                        <li class="navbar__element navbar__element--full-spacing">
                            <a class="btn btn-outline btn--small text-weight--medium hidden-xs" href="/register">现在加入</a>
                        </li>
                    </c:if>
                </ul>
            </li>
        </ul>
    </div> <!-- close .container-fluid -->
</div> <!-- close .navbar -->
<div class="wrapper">

<div class="container">

    <div id="grid-gallery" class="grid-gallery">
        <section class="grid-wrap">
            <ul class="grid">
                <li class="grid-sizer"></li><!-- for Masonry column width -->
                <li>
                    <figure>
                        <img src="<%=basePath%>img/thumb/1.png" alt="img01"/>
                    </figure>
                </li>
            </ul>
        </section><!-- // grid-wrap -->
        <section class="slideshow">
            <ul>
                <li>
                    <figure>
                        <figcaption>
                            <h3>Letterpress asymmetrical</h3>
                            <p>Kale chips lomo biodiesel stumptown Godard Tumblr, mustache sriracha tattooed cray aute slow-carb placeat delectus. Letterpress asymmetrical fanny pack art party est pour-over skateboard anim quis, ullamco craft beer.</p>
                        </figcaption>
                        <img src="<%=basePath%>img/large/1.png" alt="img01"/>
                    </figure>
                </li>
            </ul>
            <nav>
                <span class="icon nav-prev"></span>
                <span class="icon nav-next"></span>
                <span class="icon nav-close"></span>
            </nav>
            <div class="info-keys icon">Navigate with arrow keys</div>
        </section><!-- // slideshow -->
    </div><!-- // grid-gallery -->
    <div class="row">

        <nav class="pagination">
            <span class="page-numbers prev inactive">Prev</span>
            <span class="page-numbers current">1</span>
            <a href="#" class="page-numbers">2</a>
            <a href="#" class="page-numbers">3</a>
            <a href="#" class="page-numbers">4</a>
            <a href="#" class="page-numbers">5</a>
            <a href="#" class="page-numbers">6</a>
            <a href="#" class="page-numbers">7</a>
            <a href="#" class="page-numbers">8</a>
            <a href="#" class="page-numbers">9</a>
            <a href="#" class="page-numbers next">Next</a>
        </nav>

    </div>
</div>
</div>

<%--<footer class="footer-global js-global-footer">
    <div class="container">

        <div class="footer-main">
            <div class="row">
                <div class="col-sm-4">
                    <h6 class="epsilon footer-main__header text-sans text-weight--bold">Unalbum</h6>
                    <p class="footer-main__paragraph">Beautiful, free photos gifted by the world’s most generous community of photographers.</p>
                </div>
            </div>
        </div> <!-- close .footer-main -->

        <div class="footer-sub">
            <div class="row">
                <div class="col-sm-12">
                    <a href="/home" title="Home &mdash; Unalbum"><img class="footer-sub__logo" src="<%=basePath%>img/logo-black-b37a09de4a228cd8fb72adbabc95931c5090611a0cae8e76f1fd077d378ec080.svg" alt="Logo black" /></a>
                    Make something awesome.
                </div>
            </div>
        </div> <!-- close .footer-sub -->

    </div> <!-- close .container -->
</footer>--%> <!-- close .footer-global -->

<script>
    (function (window) {
        var currentUser = {
            id: 766708
        };

        // attach any properties needed
        //
        // ex:
        //
        // currentUser.fullName = 'Shi sheng';

        window.currentUser = currentUser;
    })(window);
</script>
<!--<script src="js/global-11cefe86ab47658815b807bc1fdddf1be8832c46b2cf6b516d97d73b9fdf373d.js"></script>
<script src="js/uploaders-7662daade56961ed5512519d9ae33bd18ac55090ceb4c8f61bc18ad9f491d6b2.js"></script>
<script src="js/dropzone.js"></script>
<script src="js/jquery-2.1.1.js"></script>-->

<script src="<%=basePath%>js/custom-file-input.js"></script>
<script src="<%=basePath%>js/global-11cefe86ab47658815b807bc1fdddf1be8832c46b2cf6b516d97d73b9fdf373d.js"></script>
<script src="<%=basePath%>js/uploaders-7662daade56961ed5512519d9ae33bd18ac55090ceb4c8f61bc18ad9f491d6b2.js"></script>
<script src="<%=basePath%>js/dropzone.js"></script>
<script src="<%=basePath%>js/jquery-2.1.1.js"></script>
<script src="<%=basePath%>js/imagesloaded.pkgd.min.js"></script>
<script src="<%=basePath%>js/masonry.pkgd.min.js"></script>
<script src="<%=basePath%>js/classie.js"></script>
<script src="<%=basePath%>js/cbpGridGallery.js"></script>
<script>
    new CBPGridGallery( document.getElementById( 'grid-gallery' ) );
</script>


<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-36049670-4', 'auto');
    ga('send', 'pageview');
</script>


<script>
    // Snowplow analytics (warehousing)
    ;(function(p,l,o,w,i,n,g){if(!p[i]){p.GlobalSnowplowNamespace=p.GlobalSnowplowNamespace||[];
        p.GlobalSnowplowNamespace.push(i);p[i]=function(){(p[i].q=p[i].q||[]).push(arguments)
        };p[i].q=p[i].q||[];n=l.createElement(o);g=l.getElementsByTagName(o)[0];n.async=1;
        n.src=w;g.parentNode.insertBefore(n,g)}}(window,document,"script",'//d1fc8wv8zag5ca.cloudfront.net/2.5.2/sp.js','snowplow'));

    window.snowplow('newTracker', 'sn-unsp-0', 'logger.unsplash.com', {
        platform: 'web',
        cookieDomain: '.unsplash.com'
    });

    if (typeof currentUser === 'object') {
        window.snowplow('setUserId', currentUser.id);
    }

    window.snowplow('enableActivityTracking', 10, 10);
    window.snowplow('trackPageView');
</script>


</body>
</html>

