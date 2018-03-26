<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/3/13
  Time: 20:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="UTF-8" />
    <script type="text/javascript">window.NREUM||(NREUM={});NREUM.info={"beacon":"bam.nr-data.net","errorBeacon":"bam.nr-data.net","licenseKey":"d44beae01c","applicationID":"5042907","transactionName":"IVtdFksMCA1XQBhYBwFbRgxNTAEFW0Y=","queueTime":4,"applicationTime":50,"agent":""}</script>
    <script type="text/javascript">window.NREUM||(NREUM={}),__nr_require=function(e,t,n){function r(n){if(!t[n]){var o=t[n]={exports:{}};e[n][0].call(o.exports,function(t){var o=e[n][1][t];return r(o||t)},o,o.exports)}return t[n].exports}if("function"==typeof __nr_require)return __nr_require;for(var o=0;o<n.length;o++)r(n[o]);return r}({1:[function(e,t,n){function r(){}function o(e,t,n){return function(){return i(e,[f.now()].concat(u(arguments)),t?null:this,n),t?void 0:this}}var i=e("handle"),a=e(2),u=e(3),c=e("ee").get("tracer"),f=e("loader"),s=NREUM;"undefined"==typeof window.newrelic&&(newrelic=s);var p=["setPageViewName","setCustomAttribute","setErrorHandler","finished","addToTrace","inlineHit","addRelease"],d="api-",l=d+"ixn-";a(p,function(e,t){s[t]=o(d+t,!0,"api")}),s.addPageAction=o(d+"addPageAction",!0),s.setCurrentRouteName=o(d+"routeName",!0),t.exports=newrelic,s.interaction=function(){return(new r).get()};var m=r.prototype={createTracer:function(e,t){var n={},r=this,o="function"==typeof t;return i(l+"tracer",[f.now(),e,n],r),function(){if(c.emit((o?"":"no-")+"fn-start",[f.now(),r,o],n),o)try{return t.apply(this,arguments)}catch(e){throw c.emit("fn-err",[arguments,this,e],n),e}finally{c.emit("fn-end",[f.now()],n)}}}};a("setName,setAttribute,save,ignore,onEnd,getContext,end,get".split(","),function(e,t){m[t]=o(l+t)}),newrelic.noticeError=function(e){"string"==typeof e&&(e=new Error(e)),i("err",[e,f.now()])}},{}],2:[function(e,t,n){function r(e,t){var n=[],r="",i=0;for(r in e)o.call(e,r)&&(n[i]=t(r,e[r]),i+=1);return n}var o=Object.prototype.hasOwnProperty;t.exports=r},{}],3:[function(e,t,n){function r(e,t,n){t||(t=0),"undefined"==typeof n&&(n=e?e.length:0);for(var r=-1,o=n-t||0,i=Array(o<0?0:o);++r<o;)i[r]=e[t+r];return i}t.exports=r},{}],4:[function(e,t,n){t.exports={exists:"undefined"!=typeof window.performance&&window.performance.timing&&"undefined"!=typeof window.performance.timing.navigationStart}},{}],ee:[function(e,t,n){function r(){}function o(e){function t(e){return e&&e instanceof r?e:e?c(e,u,i):i()}function n(n,r,o,i){if(!d.aborted||i){e&&e(n,r,o);for(var a=t(o),u=m(n),c=u.length,f=0;f<c;f++)u[f].apply(a,r);var p=s[y[n]];return p&&p.push([b,n,r,a]),a}}function l(e,t){v[e]=m(e).concat(t)}function m(e){return v[e]||[]}function w(e){return p[e]=p[e]||o(n)}function g(e,t){f(e,function(e,n){t=t||"feature",y[n]=t,t in s||(s[t]=[])})}var v={},y={},b={on:l,emit:n,get:w,listeners:m,context:t,buffer:g,abort:a,aborted:!1};return b}function i(){return new r}function a(){(s.api||s.feature)&&(d.aborted=!0,s=d.backlog={})}var u="nr@context",c=e("gos"),f=e(2),s={},p={},d=t.exports=o();d.backlog=s},{}],gos:[function(e,t,n){function r(e,t,n){if(o.call(e,t))return e[t];var r=n();if(Object.defineProperty&&Object.keys)try{return Object.defineProperty(e,t,{value:r,writable:!0,enumerable:!1}),r}catch(i){}return e[t]=r,r}var o=Object.prototype.hasOwnProperty;t.exports=r},{}],handle:[function(e,t,n){function r(e,t,n,r){o.buffer([e],r),o.emit(e,t,n)}var o=e("ee").get("handle");t.exports=r,r.ee=o},{}],id:[function(e,t,n){function r(e){var t=typeof e;return!e||"object"!==t&&"function"!==t?-1:e===window?0:a(e,i,function(){return o++})}var o=1,i="nr@id",a=e("gos");t.exports=r},{}],loader:[function(e,t,n){function r(){if(!x++){var e=h.info=NREUM.info,t=d.getElementsByTagName("script")[0];if(setTimeout(s.abort,3e4),!(e&&e.licenseKey&&e.applicationID&&t))return s.abort();f(y,function(t,n){e[t]||(e[t]=n)}),c("mark",["onload",a()+h.offset],null,"api");var n=d.createElement("script");n.src="https://"+e.agent,t.parentNode.insertBefore(n,t)}}function o(){"complete"===d.readyState&&i()}function i(){c("mark",["domContent",a()+h.offset],null,"api")}function a(){return E.exists&&performance.now?Math.round(performance.now()):(u=Math.max((new Date).getTime(),u))-h.offset}var u=(new Date).getTime(),c=e("handle"),f=e(2),s=e("ee"),p=window,d=p.document,l="addEventListener",m="attachEvent",w=p.XMLHttpRequest,g=w&&w.prototype;NREUM.o={ST:setTimeout,SI:p.setImmediate,CT:clearTimeout,XHR:w,REQ:p.Request,EV:p.Event,PR:p.Promise,MO:p.MutationObserver};var v=""+location,y={beacon:"bam.nr-data.net",errorBeacon:"bam.nr-data.net",agent:"js-agent.newrelic.com/nr-1071.min.js"},b=w&&g&&g[l]&&!/CriOS/.test(navigator.userAgent),h=t.exports={offset:u,now:a,origin:v,features:{},xhrWrappable:b};e(1),d[l]?(d[l]("DOMContentLoaded",i,!1),p[l]("load",r,!1)):(d[m]("onreadystatechange",o),p[m]("onload",r)),c("mark",["firstbyte",u],null,"api");var x=0,E=e(4)},{}]},{},["loader"]);</script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-title" content="Unsplash">

    <title>
        Edit profile | Unalbum
    </title>


    <!-- CSS
  ================================================== -->
    <link rel="stylesheet" media="all" href="<%=basePath%>css/unsplash.css" />

    <!-- favicon -->
    <link rel="shortcut icon" href="/img/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/img/favicon.ico" type="image/x-icon">

    <!-- script
    ================================================== -->
    <script src="<%=basePath%>js/modernizr.js"></script>
    <script src="<%=basePath%>js/pace.min.js"></script>

    <link rel="apple-touch-icon-precomposed" type="image/png" href="<%=basePath%>img/apple-touch-icon-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="<%=basePath%>img/apple-touch-icon-60x60-precomposed.png" sizes="60x60" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="<%=basePath%>img/apple-touch-icon-72x72-precomposed.png" sizes="72x72" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="<%=basePath%>img/apple-touch-icon-76x76-precomposed.png" sizes="76x76" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="<%=basePath%>img/apple-touch-icon-114x114-precomposed.png" sizes="114x114" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="<%=basePath%>img/apple-touch-icon-120x120-precomposed.png" sizes="120x120" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="<%=basePath%>img/apple-touch-icon-144x144-precomposed.png" sizes="144x144" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="<%=basePath%>img/apple-touch-icon-152x152-precomposed.png" sizes="152x152" />
    <meta name="msapplication-config" content="browserconfig.xml">
    <meta name="msapplication-TileColor" content="#FFFFFF">
    <meta name="msapplication-TileImage" content="/mstile-144x144.png">



</head>
<body class="">


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
                <a href="/home">主页</a>
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
        <div class="sheet sheet--padding">
            <div class="row">
                <div class="col-xs-12 col-sm-4 col-md-3">
                    <ul class="nav nav--stacked">
                        <h3 class="nav__heading delta text-sans text-weight--bold">个人设置</h3>

                        <li class="active">
                            <a href="<c:url value="/user/account" />">修改个人资料</a>
                        </li>
                        <li class="">
                            <a href="<c:url value="/user/pictures" />">相片/相册管理</a>
                        </li>
                        <li class="">
                            <a href="<c:url value="/user/account/profile" />">修改头像</a>
                        </li>
                        <li class="">
                            <a href="<c:url value="/user/account/password" />">修改密码</a>
                        </li>
                    </ul>

                </div>

                <div class="col-xs-12 col-sm-8 col-md-9">
                    <h1 class="heading--margin-small delta text-sans text-weight--bold">修改个人资料</h1>



                    <div class="form">
                        <form class="edit_user" id="edit_user_766708" action="<c:url value="/user/account" />" accept-charset="UTF-8" method="post">
                            <input name="utf8" type="hidden" value="&#x2713;" />
                            <input type="hidden" name="id" value="${user.id}" />
                            <div class="row">
                                <div class="col-xs-12 col-sm-4 text-center">
                                    <a href="#" class="upload-circular-container profile-image-container js-general-uploader-pseudo-file-field">
                                        <div class="upload-circular">
                                            <img ix-src="<%=basePath %>${USER_CONTEXT.photo}" sizes="128px" class="upload-circular__image upload-circular__image--large js-general-uploader-new-upload-target" />
                                            <div class="upload-circular__progress js-general-uploader-progress-target">
                                            </div> <!-- close .__progress -->
                                        </div> <!-- close .upload-circular -->
                                    </a> <!-- close .js -->


                                </div>


                                <div class="col-xs-12 col-sm-8">
                                    <div class="form-group">
                                        <label for="user_first_name">用户名</label>
                                        <input class="form-control" type="text" value="${user.userName}" name="userName" id="user_first_name" />

                                    </div> <!-- close .form-group -->
                                </div> <!-- close .col -->

                                <div class="col-xs-12 col-sm-8">
                                    <div class="form-group">
                                        <label for="user_last_name">个人喜好</label><span class="text-secondary">(最多5个，以空格分隔)</span>
                                        <input class="form-control" type="text" value="${user.userInterests}" name="userInterests" id="user_last_name"/>

                                    </div> <!-- close .form-group -->
                                </div> <!-- close .col -->
                            </div> <!-- close .row -->

                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="form-group">
                                        <label for="user_bio">个人简介</label>
                                        <div class="input-with-counter js-character-count-container">
                                            <textarea class="form-control" rows="3" data-character-count="250" name="userProfile" id="user_bio">${user.userProfile}</textarea>
                                            <div class="character-count character-count--textarea js-character-count">250</div>
                                        </div>
                                    </div> <!-- close .form-group -->
                                </div> <!-- close .col -->

                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <input type="submit" name="commit" value="确认修改" class="btn btn-default btn-block-level" data-disable-with="..." />
                                    </div> <!-- close .form-group -->
                                </div> <!-- close .col -->

                            </div> <!-- close .row -->
                        </form></div> <!-- close .form -->
                </div>
            </div> <!-- close .row -->
        </div> <!-- close .sheet -->
    </div> <!-- close .container -->

    <div class="push-footer"></div>
</div>


<%--<div class="hide">
    <form class="js-general-uploader-s3-form js-edit-profile-image-s3-form" data-callback-url="null" data-callback-method="POST" data-callback-param="file" enctype="multipart/form-data" action="https://s3-us-west-2.amazonaws.com/images.unsplash.com/" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
        <input type="hidden" name="key" id="key" value="profile-{timestamp}-fa35a49cce17" />
        <input type="hidden" name="acl" id="acl" value="public-read" />
        <input type="hidden" name="AWSAccessKeyId" id="AWSAccessKeyId" value="AKIAJ4ATIV7TEVKIW3RQ" />
        <input type="hidden" name="policy" id="policy" value="eyJleHBpcmF0aW9uIjoiMjAxOC0wMy0xNFQxOTozMzoxNFoiLCJjb25kaXRpb25zIjpbWyJzdGFydHMtd2l0aCIsIiR1dGY4IiwiIl0sWyJzdGFydHMtd2l0aCIsIiRrZXkiLCJwcm9maWxlIl0sWyJzdGFydHMtd2l0aCIsIiR4LXJlcXVlc3RlZC13aXRoIiwiIl0sWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsMCwyMDk3MTUyXSxbInN0YXJ0cy13aXRoIiwiJGNvbnRlbnQtdHlwZSIsIiJdLHsiYnVja2V0IjoiaW1hZ2VzLnVuc3BsYXNoLmNvbSJ9LHsiYWNsIjoicHVibGljLXJlYWQifSx7InN1Y2Nlc3NfYWN0aW9uX3N0YXR1cyI6IjIwMSJ9XX0=" /><input type="hidden" name="signature" id="signature" value="1FTmATJyB0dfTjg7PNtEvCmZu7E=" />
        <input type="hidden" name="success_action_status" id="success_action_status" value="201" />
        <input type="hidden" name="X-Requested-With" id="X-Requested-With" value="xhr" />
        <input type="file" name="file" id="file" class="js-general-uploader-s3-file-field" />
    </form>
    <form class="js-edit-profile-image-form" action="/account/profile_image" accept-charset="UTF-8" method="post">
        <input name="utf8" type="hidden" value="&#x2713;" />
        <input type="hidden" name="_method" value="put" />
        <input type="hidden" name="authenticity_token" value="ZAVNiCMfjz1xIDEGykAybKU1b4LfkwQ/e5TNfg4tSRmf9/IG9o7Kmp+Fgl3ixbIUgjQ/ByTe30P6/KtygZq5Fw==" />

        <div class="hide js-general-uploader-form">
        </div>

        <input type="submit" name="commit" value="Save" class="js-general-uploader-form-submit" />
    </form>
</div> <!-- close .hide -->

<script class="js-general-uploader-form-template" type="text/x-tmpl">
  <input name="profile_image[url]" id="profile_image_url" type="text" value="<%= file.url %>">
  <input name="profile_image[filetype]" id="profile_image_filetype" type="text" value="<%= file.filetype %>">
  <input name="profile_image[filepath]" id="profile_image_filesize" type="text" value="<%= file.filepath %>">
  <input name="profile_image[filesize]" id="profile_image_filesize" type="text" value="<%= file.filesize %>">
</script>--%>


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
                    <a href="/home" title="Home &mdash; Unalbum"><img class="footer-sub__logo" src="<%=basePath%>img/logo-black-b37a09de4a228cd8fb72adbabc95931c5090611a0cae8e76f1fd077d378ec080.svg" alt="Logo black" /></a>
                    Make something awesome.
                </div>
            </div>
        </div> <!-- close .footer-sub -->

    </div> <!-- close .container -->
</footer> <!-- close .footer-global -->




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


</body>
</html>
