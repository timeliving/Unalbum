<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/3/15
  Time: 16:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>

    <!--- basic page needs
    ================================================== -->
    <meta charset="utf-8">

    <!-- mobile specific metas
    ================================================== -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <!-- CSS
  ================================================== -->
    <link rel="stylesheet" href="<%=basePath%>css/base.css">
    <link rel="stylesheet" href="<%=basePath%>css/vendor.css">
    <link rel="stylesheet" href="<%=basePath%>css/main.css">
    <link rel="stylesheet" href="<%=basePath%>css/unsplash.css" />

    <!-- script
    ================================================== -->
    <script src="<%=basePath%>js/modernizr.js"></script>
    <script src="<%=basePath%>js/pace.min.js"></script>


</head>

<body class="">

<!-- header
================================================== -->
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
<!-- masonry
================================================== -->
<div class="wrapper">
    <div class="container">
        <section id="bricks">

            <div class="row masonry">

                <!-- brick-wrapper -->
                <div class="bricks-wrapper">

                    <div class="grid-sizer"></div>

                    <div class="brick entry featured-grid animate-this">
                        <div class="entry-content">
                            <div id="featured-post-slider" class="flexslider">
                                <ul class="slides">

                                    <li>
                                        <div class="featured-post-slide">

                                            <div class="post-background" style="background-image:url('<%=basePath%>img/thumbs/featured/featured-1.jpg');"></div>

                                            <div class="overlay"></div>

                                            <div class="post-content">
                                                <ul class="entry-meta">
                                                    <li>August 29, 2016</li>
                                                    <li><a href="#">Sasuke Uchiha</a></li>
                                                </ul>

                                                <h1 class="slide-title">每日精选</h1>
                                            </div>
                                        </div>
                                    </li> <!-- /slide -->

                                    <li>
                                        <div class="featured-post-slide">

                                            <div class="post-background" style="background-image:url('<%=basePath%>img/thumbs/featured/featured-2.jpg');"></div>

                                            <div class="overlay"></div>

                                            <div class="post-content">
                                                <ul class="entry-meta">
                                                    <li>August 29, 2016</li>
                                                    <li><a href="#">Sasuke Uchiha</a></li>
                                                </ul>

                                                <h1 class="slide-title">每日精选</h1>
                                            </div>

                                        </div>
                                    </li> <!-- /slide -->

                                    <li>
                                        <div class="featured-post-slide">

                                            <div class="post-background" style="background-image:url('<%=basePath%>img/thumbs/featured/featured-3.jpg');;"></div>

                                            <div class="overlay"></div>

                                            <div class="post-content">
                                                <ul class="entry-meta">
                                                    <li>August 29, 2016</li>
                                                    <li><a href="#">Sasuke Uchiha</a></li>
                                                </ul>

                                                <h1 class="slide-title">每日精选</h1>
                                            </div>
                                        </div>
                                    </li> <!-- end slide -->

                                </ul> <!-- end slides -->
                            </div> <!-- end featured-post-slider -->
                        </div> <!-- end entry content -->
                    </div>
                    <c:forEach items="categoryMap" var="category">
                        <article class="brick entry format-standard animate-this">

                            <div class="entry-thumb">
                                <a href="#" class="thumb-link">
                                    <img src="<%=basePath%>${category.picURL}" alt="Shutterbug">
                                </a>
                            </div>

                            <div class="entry-text">
                                <div class="entry-header">

                                    <h1 class="entry-title">
                                        <span class="cat-links">
                                            ${category.categoryName}
                                        </span>
                                    </h1>

                                </div>
                            </div>

                        </article> <!-- end article -->
                    </c:forEach>

<%--

                    <article class="brick entry format-standard animate-this">

                        <div class="entry-thumb">
                            <div class="post-slider flexslider">
                                <a href="#" class="thumb-link">
                                    <img src="<%=basePath%>img/thumbs/ferris-wheel.jpg" alt="Shutterbug">
                                </a>
                            </div>
                        </div>
                        <div class="entry-text">
                            <div class="entry-header">

                                <h1 class="entry-title">
							<span class="cat-links">
								人物
               				</span>
                                </h1>

                            </div>
                        </div>


                    </article> <!-- end article -->


                    <!-- format audio here -->
                    <article class="brick entry format-standard animate-this">

                        <div class="entry-thumb">
                            <div class="post-slider flexslider">
                                <a href="#" class="thumb-link">
                                    <img src="<%=basePath%>img/thumbs/concert.jpg" alt="Shutterbug">
                                </a>
                            </div>
                        </div>
                        <div class="entry-text">
                            <div class="entry-header">

                                <h1 class="entry-title">
							<span class="cat-links">
								自然
               				</span>
                                </h1>

                            </div>
                        </div>

                    </article> <!-- /article -->

                    <article class="brick entry format-standard animate-this">

                        <div class="entry-thumb">

                            <div class="post-slider flexslider">
                                <ul class="slides">
                                    <li>
                                        <img src="<%=basePath%>img/thumbs/gallery/work1.jpg">
                                    </li>
                                </ul>
                            </div>

                        </div>

                        <div class="entry-text">
                            <div class="entry-header">

                                <div class="entry-meta">
                                    <h1 class="entry-title">
							<span class="cat-links">
								交通
               				</span>
                                    </h1>
                                </div>
                            </div>
                        </div>

                    </article> <!-- end article -->


                    <article class="brick entry format-standard animate-this">

                        <div class="entry-thumb">
                            <a href="#" class="thumb-link">
                                <img src="<%=basePath%>img/thumbs/shutterbug.jpg" alt="Shutterbug">
                            </a>

                        </div>
                        <div class="entry-text">
                            <div class="entry-header">

                                <h1 class="entry-title">
							<span class="cat-links">
								建筑
               				</span>
                                </h1>

                            </div>
                        </div>

                    </article> <!-- end article -->

                    <article class="brick entry format-standard animate-this" >

                        <div class="entry-thumb">
                            <a href="#" class="thumb-link">
                                <img src="<%=basePath%>img/thumbs/usaf-rocket.jpg" alt="USAF rocket">
                            </a>
                        </div>

                        <div class="entry-text">
                            <div class="entry-header">

                                <h1 class="entry-title">
                                    <span class="cat-links">
                                        自然
                                    </span>
                                </h1>

                            </div>
                        </div>
                    </article> <!-- end article -->




                    <article class="brick entry format-standard animate-this">

                        <div class="entry-thumb">
                            <a href="#" class="thumb-link">
                                <img src="<%=basePath%>img/thumbs/diagonal-pattern.jpg" alt="Pattern">
                            </a>
                        </div>
                        <div class="entry-text">
                            <div class="entry-header">

                                <h1 class="entry-title">
							<span class="cat-links">
								车辆
               				</span>
                                </h1>

                            </div>
                        </div>

                    </article> <!-- end article -->

                    <article class="brick entry format-standard animate-this">

                        <div class="entry-thumb video-image">
                            <a href="#" class="thumb-link">
                                <img src="<%=basePath%>img/thumbs/ottawa-bokeh.jpg" alt="bokeh">
                            </a>
                        </div>

                        <div class="entry-text">
                            <div class="entry-header">

                                <h1 class="entry-title">
							<span class="cat-links">
								道路
               				</span>
                                </h1>

                            </div>
                        </div>

                    </article> <!-- end article -->

                    <article class="brick entry format-standard animate-this">

                        <div class="entry-thumb">
                            <a href="#" class="thumb-link">
                                <img src="<%=basePath%>img/thumbs/lighthouse.jpg" alt="Lighthouse">
                            </a>
                        </div>
                        <div class="entry-text">
                            <div class="entry-header">

                                <h1 class="entry-title">
							<span class="cat-links">
								标志
               				</span>
                                </h1>

                            </div>
                        </div>

                    </article> <!-- end article -->
--%>

                    <%--<article class="brick entry animate-this">

                        <div class="entry-thumb">
                            <a href="#" class="thumb-link">
                                <img src="img/thumbs/liberty.jpg" alt="Liberty">
                            </a>
                        </div>
                        <div class="entry-text">
                            <div class="entry-header">

                                <h1 class="entry-title">
							<span class="cat-links">
								爱
               				</span>
                                </h1>

                            </div>
                        </div>
                    </article> --%><!-- end article -->

                </div> <!-- end brick-wrapper -->

            </div> <!-- end row -->

            <%--<div class="row">

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

            </div>--%>

        </section> <!-- end bricks -->
    </div>
</div>


<script>
    (function (window) {
        var currentUser = {
            id: 766708
        };

        window.currentUser = currentUser;
    })(window);
</script>

<script src="<%=basePath%>js/global-11cefe86ab47658815b807bc1fdddf1be8832c46b2cf6b516d97d73b9fdf373d.js"></script>
<script src="<%=basePath%>js/uploaders-a5c2699a466616babf78a14d3dfb0f31b5f377456f87e138566fb676904129aa.js"></script>

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

<!-- Java Script
================================================== -->
<script src="<%=basePath%>js/jquery-2.1.3.min.js"></script>
<script src="<%=basePath%>js/plugins.js"></script>
<script src="<%=basePath%>js/main.js" type="text/javascript" charset="utf-8"></script>

</body>

</html>