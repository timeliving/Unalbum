<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/4/3
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <script type="text/javascript">window.NREUM||(NREUM={});NREUM.info={"beacon":"bam.nr-data.net","errorBeacon":"bam.nr-data.net","licenseKey":"d44beae01c","applicationID":"5042907","transactionName":"IVtdFksMCA1XQBhdARFXQQtJFwsTQR1FWAoGW14=","queueTime":3,"applicationTime":646,"agent":""}</script>
    <script type="text/javascript">window.NREUM||(NREUM={}),__nr_require=function(e,t,n){function r(n){if(!t[n]){var o=t[n]={exports:{}};e[n][0].call(o.exports,function(t){var o=e[n][1][t];return r(o||t)},o,o.exports)}return t[n].exports}if("function"==typeof __nr_require)return __nr_require;for(var o=0;o<n.length;o++)r(n[o]);return r}({1:[function(e,t,n){function r(){}function o(e,t,n){return function(){return i(e,[f.now()].concat(u(arguments)),t?null:this,n),t?void 0:this}}var i=e("handle"),a=e(2),u=e(3),c=e("ee").get("tracer"),f=e("loader"),s=NREUM;"undefined"==typeof window.newrelic&&(newrelic=s);var p=["setPageViewName","setCustomAttribute","setErrorHandler","finished","addToTrace","inlineHit","addRelease"],d="api-",l=d+"ixn-";a(p,function(e,t){s[t]=o(d+t,!0,"api")}),s.addPageAction=o(d+"addPageAction",!0),s.setCurrentRouteName=o(d+"routeName",!0),t.exports=newrelic,s.interaction=function(){return(new r).get()};var m=r.prototype={createTracer:function(e,t){var n={},r=this,o="function"==typeof t;return i(l+"tracer",[f.now(),e,n],r),function(){if(c.emit((o?"":"no-")+"fn-start",[f.now(),r,o],n),o)try{return t.apply(this,arguments)}catch(e){throw c.emit("fn-err",[arguments,this,e],n),e}finally{c.emit("fn-end",[f.now()],n)}}}};a("setName,setAttribute,save,ignore,onEnd,getContext,end,get".split(","),function(e,t){m[t]=o(l+t)}),newrelic.noticeError=function(e){"string"==typeof e&&(e=new Error(e)),i("err",[e,f.now()])}},{}],2:[function(e,t,n){function r(e,t){var n=[],r="",i=0;for(r in e)o.call(e,r)&&(n[i]=t(r,e[r]),i+=1);return n}var o=Object.prototype.hasOwnProperty;t.exports=r},{}],3:[function(e,t,n){function r(e,t,n){t||(t=0),"undefined"==typeof n&&(n=e?e.length:0);for(var r=-1,o=n-t||0,i=Array(o<0?0:o);++r<o;)i[r]=e[t+r];return i}t.exports=r},{}],4:[function(e,t,n){t.exports={exists:"undefined"!=typeof window.performance&&window.performance.timing&&"undefined"!=typeof window.performance.timing.navigationStart}},{}],ee:[function(e,t,n){function r(){}function o(e){function t(e){return e&&e instanceof r?e:e?c(e,u,i):i()}function n(n,r,o,i){if(!d.aborted||i){e&&e(n,r,o);for(var a=t(o),u=m(n),c=u.length,f=0;f<c;f++)u[f].apply(a,r);var p=s[y[n]];return p&&p.push([b,n,r,a]),a}}function l(e,t){v[e]=m(e).concat(t)}function m(e){return v[e]||[]}function w(e){return p[e]=p[e]||o(n)}function g(e,t){f(e,function(e,n){t=t||"feature",y[n]=t,t in s||(s[t]=[])})}var v={},y={},b={on:l,emit:n,get:w,listeners:m,context:t,buffer:g,abort:a,aborted:!1};return b}function i(){return new r}function a(){(s.api||s.feature)&&(d.aborted=!0,s=d.backlog={})}var u="nr@context",c=e("gos"),f=e(2),s={},p={},d=t.exports=o();d.backlog=s},{}],gos:[function(e,t,n){function r(e,t,n){if(o.call(e,t))return e[t];var r=n();if(Object.defineProperty&&Object.keys)try{return Object.defineProperty(e,t,{value:r,writable:!0,enumerable:!1}),r}catch(i){}return e[t]=r,r}var o=Object.prototype.hasOwnProperty;t.exports=r},{}],handle:[function(e,t,n){function r(e,t,n,r){o.buffer([e],r),o.emit(e,t,n)}var o=e("ee").get("handle");t.exports=r,r.ee=o},{}],id:[function(e,t,n){function r(e){var t=typeof e;return!e||"object"!==t&&"function"!==t?-1:e===window?0:a(e,i,function(){return o++})}var o=1,i="nr@id",a=e("gos");t.exports=r},{}],loader:[function(e,t,n){function r(){if(!x++){var e=h.info=NREUM.info,t=d.getElementsByTagName("script")[0];if(setTimeout(s.abort,3e4),!(e&&e.licenseKey&&e.applicationID&&t))return s.abort();f(y,function(t,n){e[t]||(e[t]=n)}),c("mark",["onload",a()+h.offset],null,"api");var n=d.createElement("script");n.src="https://"+e.agent,t.parentNode.insertBefore(n,t)}}function o(){"complete"===d.readyState&&i()}function i(){c("mark",["domContent",a()+h.offset],null,"api")}function a(){return E.exists&&performance.now?Math.round(performance.now()):(u=Math.max((new Date).getTime(),u))-h.offset}var u=(new Date).getTime(),c=e("handle"),f=e(2),s=e("ee"),p=window,d=p.document,l="addEventListener",m="attachEvent",w=p.XMLHttpRequest,g=w&&w.prototype;NREUM.o={ST:setTimeout,SI:p.setImmediate,CT:clearTimeout,XHR:w,REQ:p.Request,EV:p.Event,PR:p.Promise,MO:p.MutationObserver};var v=""+location,y={beacon:"bam.nr-data.net",errorBeacon:"bam.nr-data.net",agent:"js-agent.newrelic.com/nr-1071.min.js"},b=w&&g&&g[l]&&!/CriOS/.test(navigator.userAgent),h=t.exports={offset:u,now:a,origin:v,features:{},xhrWrappable:b};e(1),d[l]?(d[l]("DOMContentLoaded",i,!1),p[l]("load",r,!1)):(d[m]("onreadystatechange",o),p[m]("onload",r)),c("mark",["firstbyte",u],null,"api");var x=0,E=e(4)},{}]},{},["loader"]);</script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-title" content="Unsplash">

    <title>
        Add Tag
    </title>

    <meta name="description" content="
    Do whatever you want free high-resolution photos. Download 10 new free photos every 10 days.
">
    <meta name="author" content="Crew">
    <meta name="csrf-param" content="authenticity_token" />
    <meta name="csrf-token" content="TMZAg7ZzCSvi6HAvClAcSTetoufgvyIpyyWxRS2BGdJPNYhcA6MC588hXtD36bCtd7QbmmspRbbHZ5L1x4rN/g==" />

    <link rel="stylesheet" media="all" href="/css/unsplash.css" />

    <link rel="shortcut icon" href="/img/favicon.ico" type="image/x-icon">
    <link rel="apple-touch-icon-precomposed" type="image/png" href="/img/apple-touch-icon-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="/img/apple-touch-icon-60x60-precomposed.png" sizes="60x60" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="/img/apple-touch-icon-72x72-precomposed.png" sizes="72x72" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="/img/apple-touch-icon-76x76-precomposed.png" sizes="76x76" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="/img/apple-touch-icon-114x114-precomposed.png" sizes="114x114" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="/img/apple-touch-icon-120x120-precomposed.png" sizes="120x120" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="/img/apple-touch-icon-144x144-precomposed.png" sizes="144x144" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="/img/apple-touch-icon-152x152-precomposed.png" sizes="152x152" />
    <meta name="msapplication-config" content="browserconfig.xml">
    <meta name="msapplication-TileColor" content="#FFFFFF">
    <meta name="msapplication-TileImage" content="/mstile-144x144.png">
    <script src="/js/jquery-3.3.1.min.js"></script>


</head>
<body class="">


<div class="js-flash-container"></div>


<div class="offset-fixed-navbar js-global-nav-offset"></div>

<div class="navbar navbar--fixed js-global-nav hidden-xs">
    <div class="container-fluid">

        <div class="navbar__links-container navbar__links-container--left">
            <a href="/" title="Home &mdash; Unsplash">
                <img class="navbar__logo " src="/img/logo-black-b37a09de4a228cd8fb72adbabc95931c5090611a0cae8e76f1fd077d378ec080.svg" alt="Logo black" />
            </a>


        </div>
        <ul class="navbar__links-container navbar__links-container--center navbar__text-links">


            <li class="navbar__element navbar__element--heading navbar__element--hide-on-xs ">
                <a href="/home">主页</a>
            </li>


            <li class="navbar__element navbar__element--heading navbar__element--hide-on-xs">
                <div class="dropdown">
                    <a href="#" class="dropdown-toggle" id="super-dropdown" data-toggle="dropdown">
                        <svg class="ellipsis-icon" version="1.1" viewBox="0 0 32 32" width="32" height="32" aria-hidden="false">
                            <path d="M7 15.5c0 1.9-1.6 3.5-3.5 3.5s-3.5-1.6-3.5-3.5 1.6-3.5 3.5-3.5 3.5 1.6 3.5 3.5zm21.5-3.5c-1.9 0-3.5 1.6-3.5 3.5s1.6 3.5 3.5 3.5 3.5-1.6 3.5-3.5-1.6-3.5-3.5-3.5zm-12.5 0c-1.9 0-3.5 1.6-3.5 3.5s1.6 3.5 3.5 3.5 3.5-1.6 3.5-3.5-1.6-3.5-3.5-3.5z"></path>
                        </svg>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-left">

                        <li>
                            <a rel="nofollow" href="/search/addTag">添加标签</a>
                        </li>

                        <li>
                            <a rel="nofollow" href="https://store.unsplash.com/">我的关注</a>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>

        <ul class="navbar__links-container navbar__links-container--right">
            <li class="navbar__element navbar__element--heading navbar__element--half-spacing">
                <ul class="nav">
                    <li class="navbar__element navbar__element--full-spacing">
                        <a class="btn btn-outline btn--small text-weight--medium hidden-xs" href="/picture/submit">上传图片</a>
                    </li>
                    <a href="/user/account">
                        <img ix-src="<%=basePath %>${USER_CONTEXT.photo}" sizes="32px" class="avatar avatar--small avatar--small-mobile">
                    </a>
                </ul>

            </li>
        </ul>
    </div> <!-- close .container-fluid -->
</div> <!-- close .navbar -->




<div class="wrapper">

    <div class="container">
        <div class="js-suggested-descriptors-container">
            <div class="sheet sheet--padding">

                <div class="arch" style="margin-bottom: 30px;">
                    <div class="arch-right">
                        <p>请给下图打标签</p>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-6">


                        <div class="js-suggested-descriptors-form-container">
                            <form class="new_suggested_photo_descriptor" id="new_suggested_photo_descriptor" action="/search/addTags" accept-charset="UTF-8" data-remote="true" method="post">
                                <input name="utf8" type="hidden" value="&#x2713;" />
                                <p style="margin-top: 0;">请用标签描述相片.（最好五个以内）</p>
                                <p class="zeta text-secondary"><em>例如: 文化, 森林, 湖泊, 景观, 动物</em></p>

                                <div class="form-group" style="padding-top: 15px;">
                                    <label for="tags">标签</label>
                                    <input class="form-control" id="tags" data-taggable="true" type="text" name="tags" />
                                </div> <!-- close .form-group -->

                                <div class="arch">
                                    <div class="arch-left" style="margin-bottom: 10px;">
                                        <input type="hidden" value="${picture.id}" id="picId" name="picId"/>
                                        <a class="zeta" style="vertical-align: -8px;" data-remote="true" onclick="random()" href="#">跳过这一张</a>
                                    </div> <!-- .arch-left -->
                                    <div class="arch-right" style="margin-bottom: 30px;">
                                        <input type="submit" name="commit" value="保存" class="btn btn-default btn-block js-descriptor-save" data-disable-with="..." data-success-text="Saved!" data-success-class="btn-success" />
                                    </div>
                                </div> <!-- close .arch -->
                            </form>
                        </div> <!-- close .js-form -->
                    </div> <!-- close .col -->

                    <div class="col-sm-6">
                        <div class="js-photo-loading-spinner" style="display: none;">
                            <div class="spinner-container--padded">
                                <div class="spinner"></div>
                            </div> <!-- close .spinner-container -->
                        </div>

                        <div class="photo js-descriptor-photo-container" style="background-color: #DAE1E5;">
                            <a target="_blank" href="/photos/lzp2B2yyek0">
                                <img src="/${picture.picURL}" class="img-responsive" id="image" sizes="50vw">
                            </a>
                        </div> <!-- close .photo -->
                    </div> <!-- close .col -->

                </div> <!-- close .row -->
            </div> <!-- close .sheet -->

        </div>
    </div> <!-- close .container -->
    <div class="push-footer"></div>
</div>

<footer class="footer-global js-global-footer">
    <div class="container">

        <div class="footer-main">
            <div class="row">
                <div class="col-sm-4">
                    <h6 class="epsilon footer-main__header text-sans text-weight--bold">Unablum</h6>
                    <p class="footer-main__paragraph">Beautiful, free photos gifted by the world’s most generous community of photographers.</p>
                </div>

            </div>
        </div> <!-- close .footer-main -->

        <div class="footer-sub">
            <div class="row">
                <div class="col-sm-12">
                    <a href="/" title="Home &mdash; Unsplash"><img class="footer-sub__logo" src="/img/logo-black-b37a09de4a228cd8fb72adbabc95931c5090611a0cae8e76f1fd077d378ec080.svg" alt="Logo black" /></a>
                    Make something awesome.
                </div>
            </div>
        </div> <!-- close .footer-sub -->

    </div> <!-- close .container -->
</footer> <!-- close .footer-global -->


<script>
    function random() {
        var picId = $("#picId").val();
        data={};
        data["picId"] = picId;
        $.ajax({
            type: "POST",
            url: "/search/random",
            contentType:"application/json",
            data: JSON.stringify(data),//参数列表
            dataType:"json",
            success: function(data){
                //请求正确之后的操作
                console.log(data);

                if (Object.keys(data).length === 0) {
                    alert("操作失败，请重试");
                }
                updateImage(data);
            }
        });
    }

    function updateImage(data) {
        var picId = data["picId"];
        var picURL = data["picURL"];
        $("#image").attr("src", "/" + picURL);
        var pic = document.getElementById("picId");
        pic.setAttribute("value", picId);
    }
</script>

<script>
    (function (window) {
        var currentUser = {
            id: 1383232
        };

        // attach any properties needed
        //
        // ex:
        //
        // currentUser.fullName = 'banch kiu';

        window.currentUser = currentUser;
    })(window);

</script>

<script src="/js/global-11cefe86ab47658815b807bc1fdddf1be8832c46b2cf6b516d97d73b9fdf373d.js"></script>
<script src="/js/special-1714f274457bf8163d970e59e436fa342480a06f62ff6849e87b069e579d160b.js"></script>


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

