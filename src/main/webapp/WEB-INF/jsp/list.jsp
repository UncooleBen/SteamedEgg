<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <title>游戏列表 - Steamed Egg数据库</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link href="resources/bootstrap/css/style.css" rel='stylesheet' type='text/css'/>
    <link href="resources/bootstrap/css/mystyle.css" rel='stylesheet' type='text/css'/>
    <link href="resources/bootstrap/css/guojian.min.css" rel='stylesheet'/>
    <script type="application/x-javascript"> addEventListener("load", function () {
        setTimeout(hideURLbar, 0);
    }, false);

    function hideURLbar() {
        window.scrollTo(0, 1);
    } </script>
    <link href='http://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700' rel='stylesheet' type='text/css'>
    <script type="text/javascript" src="resources/bootstrap/js/jquery.mixitup.min.js"></script>
    <script type="text/javascript">
        $(function () {

            var filterList = {

                init: function () {

                    // MixItUp plugin
                    // http://mixitup.io
                    $('#portfoliolist').mixitup({
                        targetSelector: '.portfolio',
                        filterSelector: '.filter',
                        effects: ['fade'],
                        easing: 'snap',
                        // call the hover effect
                        onMixEnd: filterList.hoverEffect()
                    });

                },

                hoverEffect: function () {

                    // Simple parallax effect
                    $('#portfoliolist .portfolio').hover(
                        function () {
                            $(this).find('.label').stop().animate({bottom: 0}, 200, 'easeOutQuad');
                            $(this).find('img').stop().animate({top: -30}, 500, 'easeOutQuad');
                        },
                        function () {
                            $(this).find('.label').stop().animate({bottom: -40}, 200, 'easeInQuad');
                            $(this).find('img').stop().animate({top: 0}, 300, 'easeOutQuad');
                        }
                    );

                }

            };

            // Run the show!
            filterList.init();


        });
    </script>
    <script src="resources/bootstrap/js/echarts.min.js"></script>
    <style>
        /* Make the image fully responsive */
        .carousel-inner img {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="container">
        <div class="logo">
            <a href="index"><img src="resources/bootstrap/images/logo.png" alt=""></a>
        </div>
        <span class="menu"></span>
        <div class="navigation">
            <ul class="navig cl-effect-3">
                <li><a href="index">Home</a></li>
                <li><a href="list?page=1">Games</a></li>
                <li><a href="blogs?page=1">Blog</a></li>
                <li><a href="contact">Contact</a></li>
            </ul>
            <!-- Example split danger button -->
            <form action="search" method="get">
                <div class="btn-group">
                    <select class="form-control" name="field">
                        <option value="name">名称</option>
                        <option value="category">类别</option>
                        <option value="appid">AppID</option>
                    </select>
                </div>

                <div class="search-bar">
                    <input type="text" placeholder="search" required="" name="value" value=""/>
                    <input type="submit" value=""/>
                    <input type="text" name="page" value="1" hidden="true"/>
                </div>
            </form>
            <div class="clearfix"></div>
            <script>
                $("span.menu").click(function () {
                    $(".navigation").slideToggle("slow", function () {
                        // Animation complete.
                    });
                });
            </script>

        </div>
        <div class="clearfix"></div>
    </div>
</div>
<script type="text/javascript">
    function getHref(appId) {
        window.location = 'detail?appid=' + appId;
    }

    function gotoPage(page) {
        if (page >${totalPage}) {
            page = ${totalPage};
        }
        if (page == 0) {
            page = 1;
        }
        window.location = 'list?page=' + page;
    }
</script>
<div class="gj-wk gcl-hb">
    <!--媒体列表-->
    <div class="gj-bt">
        <h3><i class="fa fa-list-ul" aria-hidden="true"></i>${searchResult}</h3>
    </div>
    <div class="gj-body gul-tuw1">
        <c:forEach var="app" items="${appList}">
            <div class="gtw-ul gclear">
                <div class="gtw-img">
                    <a href="javascript:getHref(${app.steamAppId})"><img src="${app.headerURL}" alt="${app.name}"></a>
                </div>
                <div class="gtw-body">
                    <a href="javascript:getHref(${app.steamAppId})">
                        <h4>${app.name}</h4>
                    </a>
                    <div class="gtw-sx">
                        <p>
                        <h1>${(empty app.latestPrice) ? "免费" : "￥"}${(empty app.latestPrice) ? "" : app.latestPrice}</h1></p>
                    </div>
                    <p>
                            ${app.shortDescription}
                    </p>
                    <p>
                    <ul class="tags_links">
                        <c:forEach var="category" items="${app.categories}">
                            <li><a href="#">${category}</a></li>
                        </c:forEach>
                    </ul>
                    </p>
                </div>
            </div>
        </c:forEach>
    </div>
    <nav class="gj-page">
        <span class="pageinfo">共<strong>${totalPage}</strong>页<strong>${totalDocument}</strong>条记录</span><a
            href="javascript:gotoPage(1)" class="homepage">首页</a><a href="javascript:gotoPage(${currentPage-1})"
                                                                    class="nopage">上页</a><a href=""
                                                                                            class="listpage curpage">${currentPage}</a><a
            href="javascript:gotoPage(${currentPage+1})" class="nopage">下页</a><a
            href="javascript:gotoPage(${totalPage})" class="endpage">尾页</a></nav>
</div>

</body>
</html>