
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8" />
    <script type="text/javascript">window.NREUM||(NREUM={});NREUM.info={"beacon":"bam.nr-data.net","errorBeacon":"bam.nr-data.net","licenseKey":"d44beae01c","applicationID":"5042907","transactionName":"IVtdFksMCA1XQBhLAQVdQBZLAhAIXVxEFgoHQw==","queueTime":2,"applicationTime":29,"agent":""}</script>
    <script type="text/javascript">window.NREUM||(NREUM={}),__nr_require=function(e,t,n){function r(n){if(!t[n]){var o=t[n]={exports:{}};e[n][0].call(o.exports,function(t){var o=e[n][1][t];return r(o||t)},o,o.exports)}return t[n].exports}if("function"==typeof __nr_require)return __nr_require;for(var o=0;o<n.length;o++)r(n[o]);return r}({1:[function(e,t,n){function r(){}function o(e,t,n){return function(){return i(e,[f.now()].concat(u(arguments)),t?null:this,n),t?void 0:this}}var i=e("handle"),a=e(2),u=e(3),c=e("ee").get("tracer"),f=e("loader"),s=NREUM;"undefined"==typeof window.newrelic&&(newrelic=s);var p=["setPageViewName","setCustomAttribute","setErrorHandler","finished","addToTrace","inlineHit","addRelease"],d="api-",l=d+"ixn-";a(p,function(e,t){s[t]=o(d+t,!0,"api")}),s.addPageAction=o(d+"addPageAction",!0),s.setCurrentRouteName=o(d+"routeName",!0),t.exports=newrelic,s.interaction=function(){return(new r).get()};var m=r.prototype={createTracer:function(e,t){var n={},r=this,o="function"==typeof t;return i(l+"tracer",[f.now(),e,n],r),function(){if(c.emit((o?"":"no-")+"fn-start",[f.now(),r,o],n),o)try{return t.apply(this,arguments)}catch(e){throw c.emit("fn-err",[arguments,this,e],n),e}finally{c.emit("fn-end",[f.now()],n)}}}};a("setName,setAttribute,save,ignore,onEnd,getContext,end,get".split(","),function(e,t){m[t]=o(l+t)}),newrelic.noticeError=function(e){"string"==typeof e&&(e=new Error(e)),i("err",[e,f.now()])}},{}],2:[function(e,t,n){function r(e,t){var n=[],r="",i=0;for(r in e)o.call(e,r)&&(n[i]=t(r,e[r]),i+=1);return n}var o=Object.prototype.hasOwnProperty;t.exports=r},{}],3:[function(e,t,n){function r(e,t,n){t||(t=0),"undefined"==typeof n&&(n=e?e.length:0);for(var r=-1,o=n-t||0,i=Array(o<0?0:o);++r<o;)i[r]=e[t+r];return i}t.exports=r},{}],4:[function(e,t,n){t.exports={exists:"undefined"!=typeof window.performance&&window.performance.timing&&"undefined"!=typeof window.performance.timing.navigationStart}},{}],ee:[function(e,t,n){function r(){}function o(e){function t(e){return e&&e instanceof r?e:e?c(e,u,i):i()}function n(n,r,o,i){if(!d.aborted||i){e&&e(n,r,o);for(var a=t(o),u=m(n),c=u.length,f=0;f<c;f++)u[f].apply(a,r);var p=s[y[n]];return p&&p.push([b,n,r,a]),a}}function l(e,t){v[e]=m(e).concat(t)}function m(e){return v[e]||[]}function w(e){return p[e]=p[e]||o(n)}function g(e,t){f(e,function(e,n){t=t||"feature",y[n]=t,t in s||(s[t]=[])})}var v={},y={},b={on:l,emit:n,get:w,listeners:m,context:t,buffer:g,abort:a,aborted:!1};return b}function i(){return new r}function a(){(s.api||s.feature)&&(d.aborted=!0,s=d.backlog={})}var u="nr@context",c=e("gos"),f=e(2),s={},p={},d=t.exports=o();d.backlog=s},{}],gos:[function(e,t,n){function r(e,t,n){if(o.call(e,t))return e[t];var r=n();if(Object.defineProperty&&Object.keys)try{return Object.defineProperty(e,t,{value:r,writable:!0,enumerable:!1}),r}catch(i){}return e[t]=r,r}var o=Object.prototype.hasOwnProperty;t.exports=r},{}],handle:[function(e,t,n){function r(e,t,n,r){o.buffer([e],r),o.emit(e,t,n)}var o=e("ee").get("handle");t.exports=r,r.ee=o},{}],id:[function(e,t,n){function r(e){var t=typeof e;return!e||"object"!==t&&"function"!==t?-1:e===window?0:a(e,i,function(){return o++})}var o=1,i="nr@id",a=e("gos");t.exports=r},{}],loader:[function(e,t,n){function r(){if(!x++){var e=h.info=NREUM.info,t=d.getElementsByTagName("script")[0];if(setTimeout(s.abort,3e4),!(e&&e.licenseKey&&e.applicationID&&t))return s.abort();f(y,function(t,n){e[t]||(e[t]=n)}),c("mark",["onload",a()+h.offset],null,"api");var n=d.createElement("script");n.src="https://"+e.agent,t.parentNode.insertBefore(n,t)}}function o(){"complete"===d.readyState&&i()}function i(){c("mark",["domContent",a()+h.offset],null,"api")}function a(){return E.exists&&performance.now?Math.round(performance.now()):(u=Math.max((new Date).getTime(),u))-h.offset}var u=(new Date).getTime(),c=e("handle"),f=e(2),s=e("ee"),p=window,d=p.document,l="addEventListener",m="attachEvent",w=p.XMLHttpRequest,g=w&&w.prototype;NREUM.o={ST:setTimeout,SI:p.setImmediate,CT:clearTimeout,XHR:w,REQ:p.Request,EV:p.Event,PR:p.Promise,MO:p.MutationObserver};var v=""+location,y={beacon:"bam.nr-data.net",errorBeacon:"bam.nr-data.net",agent:"js-agent.newrelic.com/nr-1071.min.js"},b=w&&g&&g[l]&&!/CriOS/.test(navigator.userAgent),h=t.exports={offset:u,now:a,origin:v,features:{},xhrWrappable:b};e(1),d[l]?(d[l]("DOMContentLoaded",i,!1),p[l]("load",r,!1)):(d[m]("onreadystatechange",o),p[m]("onload",r)),c("mark",["firstbyte",u],null,"api");var x=0,E=e(4)},{}]},{},["loader"]);</script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-title" content="Unsplash">

    <title>
        Join Unablum
    </title>
    <meta name="author" content="Crew">
    <meta name="csrf-param" content="authenticity_token" />
    <meta name="csrf-token" content="z/ZLz+p/Gm2wYfB2NzuDKh5GYr/J5EsMQaR+Fp3ZJRjxCp6955QP2tbSne910WDJSifTD27UxHyWZzFBh0pQhQ==" />

    <link rel="stylesheet" media="all" href="css/unsplash.css" />

    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="img/apple-touch-icon-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="img/apple-touch-icon-60x60-precomposed.png" sizes="60x60" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="img/apple-touch-icon-72x72-precomposed.png" sizes="72x72" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="img/apple-touch-icon-76x76-precomposed.png" sizes="76x76" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="img/apple-touch-icon-114x114-precomposed.png" sizes="114x114" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="img/apple-touch-icon-120x120-precomposed.png" sizes="120x120" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="img/apple-touch-icon-144x144-precomposed.png" sizes="144x144" />
    <link rel="apple-touch-icon-precomposed" type="image/png" href="img/apple-touch-icon-152x152-precomposed.png" sizes="152x152" />
    <meta name="msapplication-config" content="browserconfig.xml">
    <meta name="msapplication-TileColor" content="#FFFFFF">
    <meta name="msapplication-TileImage" content="/mstile-144x144.png">



</head>
<body class="">


<div class="js-flash-container"></div>



<div class="registrations__wrapper">
    <div class="registrations__container">
        <div class="sheet sheet--inverse registrations__left-panel" style="background-image: url(img/backImage1.jpg);">
            <div class="registrations__content">
                <div>
                    <img class="registrations__logo" src="img/logo-white-d6de700c647597b70cb24484a22ea0e43a4a28c563144e4a49c38f291fc2eb61.svg" alt="Logo white" />
                </div>

                <div>
                    <h1 class="registrations__title">Join Unablum</h1>
                </div>

            </div> <!-- .content -->
        </div> <!-- close .left-panel -->

        <div class="registrations__right-panel">
            <div class="registrations__spacer"></div>
            <div class="login-form qa-primary-join-form">
                <div class="row">
                    <div class="col-xs-12">

                        <div class="form">
                            <form class="new_#&lt;User:0x007f394f409a90&gt;" id="new_#&lt;User:0x007f394f409a90&gt;" action="<c:url value="/doRegister.html" />" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
                                <input type="hidden" name="authenticity_token" value="wY7ad1clBPxmjmGpDUtiRPOL4RafzYiu8mgvVyO7TYP/cg8FWs4RSwA9DDBPoYGnp+pQpjj9B94lq2AAOSg4Hg==" />

                                <div class="form-group">
                                    <label for="user_username">
                                        Username <span class="text-secondary">(最多十个字符)</span>
                                    </label>
                                    <input class="form-control" required="required" type="text" name="userName" id="user_username" />

                                </div> <!-- close .form-group -->

                                <div class="form-group">
                                    <label for="user_password">
                                        Password <span class="text-secondary">(最少6个字符)</span>
                                    </label>
                                    <input autocomplete="off" class="form-control" required="required" type="password" name="password" id="user_password" />

                                </div> <!-- close .form-group -->

                                <input type="hidden" name="after_authorization_action" id="after_authorization_action" class="js-after-authorization-action" />
                                <input type="hidden" name="after_authorization_object_id" id="after_authorization_object_id" class="js-after-authorization-object-id" />

                                <div class="form-group">
                                    <input type="submit" name="commit" value="注册" class="btn btn-default btn-block-level" data-disable-with="..." />
                                </div> <!-- close .form-group -->


                            </form>    </div> <!-- close .form -->
                    </div> <!-- close .col -->
                </div> <!-- close .row -->

            </div> <!-- close .login-form -->
            <div class=registrations__spacer></div>
        </div> <!-- close .right-panel -->
    </div>
</div>




<script src="js/unsplash.js"></script>

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