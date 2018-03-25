<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/3/18
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

    <!-- favicon -->
    <link rel="shortcut icon" href="/img/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon">

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

            <form role="search" method="get" class="search-form" action="/search/pictureTag">
                <label>
                    <span class="hide-content">Search for:</span>
                    <input type="search" class="search-field" placeholder="Search for" value="" name="keyword" title="Search for:" autocomplete="off">
                </label>
                <input type="submit" class="search-submit" value="Search">
            </form>

            <a href="#" id="close-search" class="close-btn">Close</a>

        </div>

        <ul class="navbar__links-container navbar__links-container--right">
            <li class="navbar__element navbar__element--heading navbar__element--half-spacing">
                <ul class="nav">
                    <li class="navbar__element navbar__element--full-spacing">
                        <a class="btn btn-outline btn--small text-weight--medium hidden-xs" href="/picture/submit">上传图片</a>
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
                <c:forEach items="${pageUtil.list}" var="picture">
                    <li class="grid-sizer"></li><!-- for Masonry column width -->
                    <li>
                        <figure>
                            <img src="<%=basePath%>${picture.picURL}" alt="img01"/>
                        </figure>
                    </li>
                </c:forEach>
            </ul>
        </section><!-- // grid-wrap -->
        <section class="slideshow">
            <ul>
                <c:forEach items="${pageUtil.list}" var="picture">
                    <li>
                        <figure>
                            <figcaption>
                                <h3>${picture.picName}</h3>
                                <p>${picture.picProfile}</p>
                                <div class="navbar__links-container navbar__links-container--right text-center">
                                        <input type="hidden" value="${picture.id}" id="pictureId">
                                    <c:if test="${!empty USER_CONTEXT}">
                                        <input type="hidden" value="${USER_CONTEXT.id}" id="userId"/>
                                        <c:if test="${picture.isLike == 1}">
                                            <div id="unlike_div_${picture.id}">
                                                <a type="button" class="btn btn-outline btn--small text-weight--medium hidden-xs"
                                                   style="width: 70px;height: 35px;float: right;margin-bottom: 10px;margin-left: 10px;"
                                                   onclick="unlike(this)" id="unlike${picture.id}" name="unlike">取消</a>
                                            </div>
                                            <div id="like_div_${picture.id}" class="hidden">
                                                <a type="button" class="btn btn-outline btn--small text-weight--medium hidden-xs"
                                                   style="width: 70px;height: 35px;float: right;margin-bottom: 10px;margin-left: 10px;"
                                                   onclick="like(this)" id="like${picture.id}" name="like">喜欢</a>
                                            </div>
                                        </c:if>
                                        <c:if test="${picture.isLike == 0}">
                                            <div id="unlike_div_${picture.id}" class="hidden">
                                                <a type="button" class="btn btn-outline btn--small text-weight--medium hidden-xs"
                                                   style="width: 70px;height: 35px;float: right;margin-bottom: 10px;margin-left: 10px;"
                                                   onclick="unlike(this)" id="unlike${picture.id}" name="unlike">取消</a>
                                            </div>
                                            <div id="like_div_${picture.id}">
                                                <a type="button" class="btn btn-outline btn--small text-weight--medium hidden-xs"
                                                   style="width: 70px;height: 35px;float: right;margin-bottom: 10px;margin-left: 10px;"
                                                   onclick="like(this)" id="like${picture.id}" name="like">喜欢</a>
                                            </div>
                                        </c:if>
                                        <c:if test="${picture.isCollection == 1}">
                                            <div id="unollection_div_${picture.id}">
                                                <a class="btn btn-outline btn--small text-weight--medium hidden-xs"
                                                   style="width: 70px;height: 35px;float: right;margin-bottom: 10px"
                                                   onclick="uncollection(this)" id="uncollection${picture.id}" name="uncollection">移除</a>
                                            </div>
                                            <div id="collection_div_${picture.id}" class="hidden">
                                                <a class="btn btn-outline btn--small text-weight--medium hidden-xs"
                                                   style="width: 70px;height: 35px;float: right;margin-bottom: 10px"
                                                   onclick="collection(this)" id="collection${picture.id}" name="collection">收藏</a>
                                            </div>
                                        </c:if>
                                        <c:if test="${picture.isCollection == 0}">
                                            <div class="hidden" id="unollection_div_${picture.id}">
                                                <a class="btn btn-outline btn--small text-weight--medium hidden-xs"
                                                   style="width: 70px;height: 35px;float: right;margin-bottom: 10px"
                                                   onclick="uncollection(this)" id="uncollection${picture.id}" name="uncollection">移除</a>
                                            </div>
                                            <div id="collection_div_${picture.id}">
                                                <a class="btn btn-outline btn--small text-weight--medium hidden-xs"
                                                   style="width: 70px;height: 35px;float: right;margin-bottom: 10px"
                                                   onclick="collection(this)" id="collection${picture.id}" name="collection">收藏</a>
                                            </div>
                                        </c:if>



                                    </c:if>
                                </div>
                            </figcaption>
                            <img src="<%=basePath%>${picture.picURL}" alt="img01"/>
                        </figure>
                    </li>
                </c:forEach>
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
            <c:if test="${pageUtil.index == 1}">
                <span class="page-numbers prev inactive">
                    Prev
                </span>
            </c:if>
            <c:if test="${pageUtil.index != 1}">
                <a class="page-numbers prev" href="/picture/category?currIndex=${pageUtil.index-1}&categoryId=${categoryId}">
                    Prev
                </a>
            </c:if>
            <c:forEach begin="1" end="${pageUtil.pageNumber}" var="i">
                <c:if test="${pageUtil.index == i}">
                    <span class="page-numbers current">${i}</span>
                </c:if>
                <c:if test="${pageUtil.index != i}">
                    <a href="/picture/category?currIndex=${i}&categoryId=${categoryId}" class="page-numbers">${i}</a>
                </c:if>
            </c:forEach>
            <c:if test="${pageUtil.index == pageUtil.pageNumber}">
                <span class="page-numbers next inactive">
                    Next
                </span>
            </c:if>
            <c:if test="${pageUtil.index != pageUtil.pageNumber}">
                <a class="page-numbers next" href="/picture/category?currIndex=${pageUtil.index+1}&categoryId=${categoryId}">
                    Next
                </a>
            </c:if>
        </nav>

    </div>
</div>
</div>
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
<script src="<%=basePath%>js/custom-file-input.js"></script>
<script src="<%=basePath%>js/global-11cefe86ab47658815b807bc1fdddf1be8832c46b2cf6b516d97d73b9fdf373d.js"></script>
<script src="<%=basePath%>js/uploaders-7662daade56961ed5512519d9ae33bd18ac55090ceb4c8f61bc18ad9f491d6b2.js"></script>
<script src="<%=basePath%>js/dropzone.js"></script>
<script src="<%=basePath%>js/jquery-2.1.1.js"></script>
<script src="<%=basePath%>js/imagesloaded.pkgd.min.js"></script>
<script src="<%=basePath%>js/masonry.pkgd.min.js"></script>
<script src="<%=basePath%>js/classie.js"></script>
<script src="<%=basePath%>js/cbpGridGallery.js"></script>
<script src="<%=basePath%>js/plugins.js"></script>
<script src="<%=basePath%>js/main.js" type="text/javascript" charset="utf-8"></script>
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
    function like(obj) {
        var userId = $(obj).parent().prev().prev().val();
        var pictureId = $(obj).parent().prev().prev().prev().val();
        var div_unlike_id = $(obj).parent().prev().attr("id");
        var div_like_id = $(obj).parent().attr("id");
        var data={};
        data["pictureId"] = pictureId;
        data["userId"] = userId;
        data["div_unlike_id"] =div_unlike_id;
        data["div_like_id"] = div_like_id;
        $.ajax({
            type: "POST",
            url: "/picture/saveLike",
            contentType:"application/json",
            data: JSON.stringify(data),//参数列表
            dataType:"json",
            success: function(data){
                //请求正确之后的操作
                console.log(data);

                if (Object.keys(data).length === 0) {
                    alert("操作失败，请重试");
                }
                updateLikeButton(data);
            }
        });
    }

    function unlike(obj) {
        var userId = $(obj).parent().prev().val();
        var pictureId = $(obj).parent().prev().prev().val();
        var div_unlike_id = $(obj).parent().attr("id");
        var div_like_id = $(obj).parent().next().attr("id");
        var data={};
        data["pictureId"] = pictureId;
        data["userId"] = userId;
        data["div_unlike_id"] =div_unlike_id;
        data["div_like_id"] = div_like_id;
        $.ajax({
            type: "POST",
            url: "/picture/deleteLike",
            contentType:"application/json;charset=utf-8",
            data: JSON.stringify(data),//参数列表
            dataType:"json",
            success: function(result){
                //请求正确之后的操作
                console.log(data);
                if (Object.keys(data).length === 0) {
                    alert("操作失败，请重试");
                }
                updateUnLikeButton(data);
            }
        });
    }

    function collection(obj) {
        var userId = $(obj).parent().prev().prev().prev().prev().val();
        var pictureId = $(obj).parent().prev().prev().prev().prev().prev().val();
        var div_uncollection_id = $(obj).parent().prev().attr("id");
        var div_collection_id = $(obj).parent().attr("id");
        var data={};
        data["pictureId"] = pictureId;
        data["userId"] = userId;
        data["div_uncollection_id"] =div_uncollection_id;
        data["div_collection_id"] = div_collection_id;
        $.ajax({
            type: "POST",
            url: "/picture/saveCollection",
            contentType:"application/json",
            data: JSON.stringify(data),//参数列表
            dataType:"json",
            success: function(data){
                //请求正确之后的操作
                console.log(data);

                if (Object.keys(data).length === 0) {
                    alert("操作失败，请重试");
                }
                updateCollectionButton(data);
            }
        });
    }

    function uncollection(obj) {
        var userId = $(obj).parent().prev().prev().prev().val();
        var pictureId = $(obj).parent().prev().prev().prev().prev().val();
        var div_uncollection_id = $(obj).parent().attr("id");
        var div_collection_id = $(obj).parent().next().attr("id");
        var data={};
        data["pictureId"] = pictureId;
        data["userId"] = userId;
        data["div_uncollection_id"] =div_uncollection_id;
        data["div_collection_id"] = div_collection_id;
        $.ajax({
            type: "POST",
            url: "/picture/deleteCollection",
            contentType:"application/json;charset=utf-8",
            data: JSON.stringify(data),//参数列表
            dataType:"json",
            success: function(result){
                //请求正确之后的操作
                console.log(data);
                if (Object.keys(data).length === 0) {
                    alert("操作失败，请重试");
                }
                updateUnCollectionButton(data);
            }
        });
    }

    function updateLikeButton(data) {
        var div_like_id = data.div_like_id;
        var div_unlike_id = data.div_unlike_id;
        div_like_id = document.getElementById(div_like_id);
        addClass(div_like_id, "hidden");
        div_unlike_id = document.getElementById(div_unlike_id);
        removeClass(div_unlike_id, "hidden");
    }
    function updateUnLikeButton(data) {
        var div_like_id = data.div_like_id;
        var div_unlike_id = data.div_unlike_id;
        div_unlike_id = document.getElementById(div_unlike_id);
        addClass(div_unlike_id, "hidden");
        div_like_id = document.getElementById(div_like_id);
        removeClass(div_like_id, "hidden");
    }

    function updateCollectionButton(data) {
        var div_collection_id = data.div_collection_id;
        var div_uncollection_id = data.div_uncollection_id;
        div_collection_id = document.getElementById(div_collection_id);
        addClass(div_collection_id, "hidden");
        div_uncollection_id = document.getElementById(div_uncollection_id);
        removeClass(div_uncollection_id, "hidden");
    }
    function updateUnCollectionButton(data) {
        var div_collection_id = data.div_collection_id;
        var div_uncollection_id = data.div_uncollection_id;
        div_uncollection_id = document.getElementById(div_uncollection_id);
        addClass(div_uncollection_id, "hidden");
        div_collection_id = document.getElementById(div_collection_id);
        removeClass(div_collection_id, "hidden");
    }


    function hasClass(element,cName){        //检查class是否存在
        return !!element.className.match(new RegExp('(\\s|^)'+cName+'(\\s|$)'));
    }
    function addClass(element,cName){        //添加一个class
        if(!hasClass(element,cName)){
            element.className +=' '+cName;
        }
    }
    function removeClass(element,cName){        //移除一个class
        if(hasClass(element,cName)){
            element.className = element.className.replace(new RegExp('(\\s|^)'+cName+'(\\s|$)'),' ');
        }
    }


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

