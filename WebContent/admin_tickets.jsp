<%--
  Created by IntelliJ IDEA.
  User: Kasun
  Date: 10/14/2024
  Time: 10:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="project.core.api.CoreAPI" %>
<%
    HttpSession session1 = request.getSession(false);

    if (!CoreAPI.getInstance().isUserLoggedIn(session1)) {
        response.sendRedirect("login.jsp");
        return;

    }else{

        if (!CoreAPI.getInstance().isUserLoggedInAndHasPermission(session1, "view_tickets")) {
            response.sendRedirect("errors/noperm.jsp");
            return;
        }

    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">


    <title>Open Help Desk | Tickets Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">

    <style type="text/css">
        body{margin-top:20px;
            background:#eee;
        }

        .padding {
            padding: 10px;
        }

        /* GRID */
        .col {
            padding: 10px 20px;
            margin-bottom: 10px;
            background: #fff;
            color: #666666;
            text-align: center;
            font-weight: 400;
            box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.1);
        }

        .row h3 {
            color: #666666;
        }

        .row.grid {
            margin-left: 0;
        }

        .grid {
            position: relative;
            width: 100%;
            background: #fff;
            color: #666666;
            border-radius: 2px;
            margin-bottom: 25px;
            box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.1);
        }

        .grid .grid-header {
            position: relative;
            border-bottom: 1px solid #ddd;
            padding: 15px 10px 10px 20px;
        }

        .grid .grid-header:before,
        .grid .grid-header:after {
            display: table;
            content: " ";
        }

        .grid .grid-header:after {
            clear: both;
        }

        .grid .grid-header span,
        .grid .grid-header > .fa {
            display: inline-block;
            margin: 0;
            font-weight: 300;
            font-size: 1.5em;
            float: left;
        }

        .grid .grid-header span {
            padding: 0 5px;
        }

        .grid .grid-header > .fa {
            padding: 5px 10px 0 0;
        }

        .grid .grid-header > .grid-tools {
            padding: 4px 10px;
        }

        .grid .grid-header > .grid-tools a {
            color: #999999;
            padding-left: 10px;
            cursor: pointer;
        }

        .grid .grid-header > .grid-tools a:hover {
            color: #666666;
        }

        .grid .grid-body {
            padding: 15px 20px 15px 20px;
            font-size: 0.9em;
            line-height: 1.9em;
        }

        .grid .full {
            padding: 0 !important;
        }

        .grid .transparent {
            box-shadow: none !important;
            margin: 0px !important;
            border-radius: 0px !important;
        }

        .grid.top.black > .grid-header {
            border-top-color: #000000 !important;
        }

        .grid.bottom.black > .grid-body {
            border-bottom-color: #000000 !important;
        }

        .grid.top.blue > .grid-header {
            border-top-color: #007be9 !important;
        }

        .grid.bottom.blue > .grid-body {
            border-bottom-color: #007be9 !important;
        }

        .grid.top.green > .grid-header {
            border-top-color: #00c273 !important;
        }

        .grid.bottom.green > .grid-body {
            border-bottom-color: #00c273 !important;
        }

        .grid.top.purple > .grid-header {
            border-top-color: #a700d3 !important;
        }

        .grid.bottom.purple > .grid-body {
            border-bottom-color: #a700d3 !important;
        }

        .grid.top.red > .grid-header {
            border-top-color: #dc1200 !important;
        }

        .grid.bottom.red > .grid-body {
            border-bottom-color: #dc1200 !important;
        }

        .grid.top.orange > .grid-header {
            border-top-color: #f46100 !important;
        }

        .grid.bottom.orange > .grid-body {
            border-bottom-color: #f46100 !important;
        }

        .grid.no-border > .grid-header {
            border-bottom: 0px !important;
        }

        .grid.top > .grid-header {
            border-top-width: 4px !important;
            border-top-style: solid !important;
        }

        .grid.bottom > .grid-body {
            border-bottom-width: 4px !important;
            border-bottom-style: solid !important;
        }


        /* SUPPORT TICKET */
        .support ul {
            list-style: none;
            padding: 0px;
        }

        .support ul li {
            padding: 8px 10px;
        }

        .support ul li a {
            color: #999;
            display: block;
        }

        .support ul li a:hover {
            color: #666;
        }

        .support ul li.active {
            background: #0073b7;
        }

        .support ul li.active a {
            color: #fff;
        }

        .support ul.support-label li {
            padding: 2px 0px;
        }

        .support h2,
        .support-content h2 {
            margin-top: 5px;
        }

        .support-content .list-group li {
            padding: 15px 20px 12px 20px;
            cursor: pointer;
        }

        .support-content .list-group li:hover {
            background: #eee;
        }

        .support-content .fa-padding .fa {
            padding-top: 5px;
            width: 1.5em;
        }

        .support-content .info {
            color: #777;
            margin: 0px;
        }

        .support-content a {
            color: #111;
        }

        .support-content .info a:hover {
            text-decoration: underline;
        }

        .support-content .info .fa {
            width: 1.5em;
            text-align: center;
        }

        .support-content .number {
            color: #777;
        }

        .support-content img {
            margin: 0 auto;
            display: block;
        }

        .support-content .modal-body {
            padding-bottom: 0px;
        }

        .support-content-comment {
            padding: 10px 10px 10px 30px;
            background: #eee;
            border-top: 1px solid #ccc;
        }


        /* BACKGROUND COLORS */
        .bg-red, .bg-yellow, .bg-aqua, .bg-blue, .bg-light-blue, .bg-green, .bg-navy, .bg-teal, .bg-olive, .bg-lime, .bg-orange, .bg-fuchsia, .bg-purple, .bg-maroon, bg-gray, bg-black, .bg-red a, .bg-yellow a, .bg-aqua a, .bg-blue a, .bg-light-blue a, .bg-green a, .bg-navy a, .bg-teal a, .bg-olive a, .bg-lime a, .bg-orange a, .bg-fuchsia a, .bg-purple a, .bg-maroon a, bg-gray a, .bg-black a {
            color: #f9f9f9 !important;
        }
        .bg-white, .bg-white a {
            color: #999999 !important;
        }
        .bg-red {
            background-color: #f56954 !important;
        }
        .bg-yellow {
            background-color: #f39c12 !important;
        }
        .bg-aqua {
            background-color: #00c0ef !important;
        }
        .bg-blue {
            background-color: #0073b7 !important;
        }
        .bg-light-blue {
            background-color: #3c8dbc !important;
        }
        .bg-green {
            background-color: #00a65a !important;
        }
        .bg-navy {
            background-color: #001f3f !important;
        }
        .bg-teal {
            background-color: #39cccc !important;
        }
        .bg-olive {
            background-color: #3d9970 !important;
        }
        .bg-lime {
            background-color: #01ff70 !important;
        }
        .bg-orange {
            background-color: #ff851b !important;
        }
        .bg-fuchsia {
            background-color: #f012be !important;
        }
        .bg-purple {
            background-color: #932ab6 !important;
        }
        .bg-maroon {
            background-color: #85144b !important;
        }
        .bg-gray {
            background-color: #eaeaec !important;
        }
        .bg-black {
            background-color: #222222 !important;
        }

    </style>

    <style type="text/css">
        body{
            background:#f4f3ef;
        }

        #wrapper {
            padding-left: 0;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;
        }

        #wrapper.toggled {
            padding-left: 250px;
        }

        #sidebar-wrapper {
            z-index: 1000;
            position: fixed;
            left: 250px;
            width: 0;
            height: 100%;
            margin-left: -250px;
            overflow-y: auto;
            background:#fff;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;
        }

        #sidebar-wrapper {
            box-shadow: inset -1px 0px 0px 0px #DDDDDD;
        }

        #wrapper.toggled #sidebar-wrapper {
            width: 250px;
        }

        #page-content-wrapper {
            width: 100%;
            position: absolute;
            padding: 15px;
        }

        #wrapper.toggled #page-content-wrapper {
            position: absolute;
            margin-right: -250px;
        }

        /* Sidebar Styles */

        .sidebar-nav {
            position: absolute;
            top: 0;
            width: 250px;
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .sidebar-nav li {
            text-indent: 20px;
            line-height: 40px;
        }

        .sidebar-nav li a {
            display: block;
            text-decoration: none;
            color: #999999;
        }

        .sidebar-nav li a:hover {
            text-decoration: none;
        }

        .sidebar-nav li a:active,
        .sidebar-nav li a:focus {
            text-decoration: none;
        }

        .sidebar-nav > .sidebar-brand {
            height: 65px;
            font-size: 18px;
            line-height: 60px;
        }

        .sidebar-nav > .sidebar-brand a {
            color: #999999;
        }

        .sidebar-nav > .sidebar-brand a:hover {
            color: #fff;
            background: none;
        }

        @media(min-width:768px) {
            #wrapper {
                padding-left: 250px;
            }

            #wrapper.toggled {
                padding-left: 0;
            }

            #sidebar-wrapper {
                width: 250px;
            }

            #wrapper.toggled #sidebar-wrapper {
                width: 0;
            }

            #page-content-wrapper {
                padding: 20px;
                position: relative;
            }

            #wrapper.toggled #page-content-wrapper {
                position: relative;
                margin-right: 0;
            }
        }

        #sidebar-wrapper li.active > a:after {
            border-right: 17px solid #f4f3ef;
            border-top: 17px solid transparent;
            border-bottom: 17px solid transparent;
            content: "";
            display: inline-block;
            position: absolute;
            right: -1px;
        }

        .sidebar-brand {
            border-bottom: 1px solid rgba(102, 97, 91, 0.3);
        }

        .sidebar-brand {
            padding: 18px 0px;
            margin: 0 20px;
        }

        .navbar .navbar-nav > li > a p {
            display: inline-block;
            margin: 0;
        }
        p {
            font-size: 16px;
            line-height: 1.4em;
        }

        .navbar-default {
            background-color: #f4f3ef;
            border:0px;
            border-bottom: 1px solid #DDDDDD;
        }

        btn-menu {
            border-radius: 3px;
            padding: 4px 12px;
            margin: 14px 5px 5px 20px;
            font-size: 14px;
            float: left;
        }
    </style>
</head>
<body>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<div id="wrapper" class="wrapper-content">
    <div id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <li class="sidebar-brand">
                <a href="#">
                    Open Help Desk
                </a>
            </li>
            <li>
                <a href="/dashboard.jsp">Dashboard</a>
            </li>
            <li class="active">
                <a href="#">Tickets</a>
            </li>
        </ul>
    </div>
    <div id="page-content-wrapper">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button class="btn-menu btn btn-success btn-toggle-menu" type="button">
                        <i class="fa fa-bars"></i>
                    </button>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="${pageContext.request.contextPath}/UserControllerServlet?command=LOGOUT" >
                                <i class="ti-panel"></i>
                                <p>Logout</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">

                    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
                    <div class="container">
                        <section class="content">
                            <div class="row">

                                <div class="col-md-3">
                                    <div class="grid support">
                                        <div class="grid-body">
                                            <h2>Browse</h2>
                                            <hr>
                                            <ul>
                                                <li class="active"><a href="#">Everyone's Issues<span class="pull-right">142</span></a></li>
                                                <li><a href="#">Created by you<span class="pull-right">52</span></a></li>
                                                <li><a href="#">Mentioning you<span class="pull-right">18</span></a></li>
                                            </ul>
                                            <hr>
                                            <p><strong>Labels</strong></p>
                                            <ul class="support-label">
                                                <li><a href="#"><span class="bg-blue">&nbsp;</span>&nbsp;&nbsp;&nbsp;application<span class="pull-right">2</span></a></li>
                                                <li><a href="#"><span class="bg-red">&nbsp;</span>&nbsp;&nbsp;&nbsp;css<span class="pull-right">7</span></a></li>
                                                <li><a href="#"><span class="bg-yellow">&nbsp;</span>&nbsp;&nbsp;&nbsp;design<span class="pull-right">128</span></a></li>
                                                <li><a href="#"><span class="bg-black">&nbsp;</span>&nbsp;&nbsp;&nbsp;html<span class="pull-right">41</span></a></li>
                                                <li><a href="#"><span class="bg-light-blue">&nbsp;</span>&nbsp;&nbsp;&nbsp;javascript<span class="pull-right">22</span></a></li>
                                                <li><a href="#"><span class="bg-green">&nbsp;</span>&nbsp;&nbsp;&nbsp;management<span class="pull-right">87</span></a></li>
                                                <li><a href="#"><span class="bg-purple">&nbsp;</span>&nbsp;&nbsp;&nbsp;mobile<span class="pull-right">92</span></a></li>
                                                <li><a href="#"><span class="bg-teal">&nbsp;</span>&nbsp;&nbsp;&nbsp;php<span class="pull-right">140</span></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>


                                <div class="col-md-9">
                                    <div class="grid support-content">
                                        <div class="grid-body">
                                            <h2>Issues</h2>
                                            <hr>
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-default active">162 Open</button>
                                                <button type="button" class="btn btn-default">95,721 Closed</button>
                                            </div>
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"> Sort: <strong>Newest</strong> <span class="caret"></span></button>
                                                <ul class="dropdown-menu fa-padding" role="menu">
                                                    <li><a href="#"><i class="fa fa-check"></i> Newest</a></li>
                                                    <li><a href="#"><i class="fa"> </i> Oldest</a></li>
                                                    <li><a href="#"><i class="fa"> </i> Recently updated</a></li>
                                                    <li><a href="#"><i class="fa"> </i> Least recently updated</a></li>
                                                    <li><a href="#"><i class="fa"> </i> Most commented</a></li>
                                                    <li><a href="#"><i class="fa"> </i> Least commented</a></li>
                                                </ul>
                                            </div>

                                            <button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#newIssue">New Issue</button>
                                            <div class="modal fade" id="newIssue" tabindex="-1" role="dialog" aria-labelledby="newIssue" aria-hidden="true">
                                                <div class="modal-wrapper">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header bg-blue">
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                <h4 class="modal-title"><i class="fa fa-pencil"></i> Create New Issue</h4>
                                                            </div>
                                                            <form action="#" method="post">
                                                                <div class="modal-body">
                                                                    <div class="form-group">
                                                                        <input name="subject" type="text" class="form-control" placeholder="Subject">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <input name="department" type="text" class="form-control" placeholder="Department">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <textarea name="message" class="form-control" placeholder="Please detail your issue or question" style="height: 120px;"></textarea>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <input type="file" name="attachment">
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>
                                                                    <button type="submit" class="btn btn-primary pull-right"><i class="fa fa-pencil"></i> Create</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="padding"></div>
                                            <div class="row">

                                                <div class="col-md-12">
                                                    <ul class="list-group fa-padding">
                                                        <li class="list-group-item" data-toggle="modal" data-target="#issue">
                                                            <div class="media">
                                                                <i class="fa fa-cog pull-left"></i>
                                                                <div class="media-body">
                                                                    <strong>Add drag and drop config import closes</strong> <span class="label label-danger">IMPORTANT</span><span class="number pull-right"># 13698</span>
                                                                    <p class="info">Opened by <a href="#">jwilliams</a> 5 hours ago <i class="fa fa-comments"></i> <a href="#">2 comments</a></p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="list-group-item" data-toggle="modal" data-target="#issue">
                                                            <div class="media">
                                                                <i class="fa fa-file-o pull-left"></i>
                                                                <div class="media-body">
                                                                    <strong>Document that Helvetica Neue can cause problems on Windows</strong> <span class="label label-success">SUCCESS</span><span class="number pull-right"># 13697</span>
                                                                    <p class="info">Opened by <a href="#">lgardner</a> 12 hours ago <i class="fa fa-comments"></i> <a href="#">7 comments</a></p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="list-group-item" data-toggle="modal" data-target="#issue">
                                                            <div class="media">
                                                                <i class="fa fa-code-fork pull-left"></i>
                                                                <div class="media-body">
                                                                    <strong>Manually triggering dropdown not working</strong> <span class="label label-primary">NOT IMPORTANT</span><span class="number pull-right"># 13695</span>
                                                                    <p class="info">Opened by <a href="#">ehernandez</a> 19 hours ago <i class="fa fa-comments"></i> <a href="#">14 comments</a></p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="list-group-item" data-toggle="modal" data-target="#issue">
                                                            <div class="media">
                                                                <i class="fa fa-code pull-left"></i>
                                                                <div class="media-body">
                                                                    <strong>Add classes for respective directions to affix</strong> <span class="label label-primary">NOT IMPORTANT</span><span class="number pull-right"># 13691</span>
                                                                    <p class="info">Opened by <a href="#">tmckenzie</a> 1 day ago <i class="fa fa-comments"></i> <a href="#">20 comments</a></p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="list-group-item" data-toggle="modal" data-target="#issue">
                                                            <div class="media">
                                                                <i class="fa fa-code pull-left"></i>
                                                                <div class="media-body">
                                                                    <strong>Responsive tables of the horizontal scroll bar</strong> <span class="label label-danger">IMPORTANT</span><span class="number pull-right"># 13680</span>
                                                                    <p class="info">Opened by <a href="#">tmckenzie</a> 2 days ago <i class="fa fa-comments"></i> <a href="#">5 comments</a></p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="list-group-item" data-toggle="modal" data-target="#issue">
                                                            <div class="media">
                                                                <i class="fa fa-cog pull-left"></i>
                                                                <div class="media-body">
                                                                    <strong>Make autoprefixer browsers fixed</strong> <span class="label label-warning">URGENT</span><span class="number pull-right"># 13679</span>
                                                                    <p class="info">Opened by <a href="#">lgardner</a> 2 days ago <i class="fa fa-comments"></i> <a href="#">29 comments</a></p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="list-group-item" data-toggle="modal" data-target="#issue">
                                                            <div class="media">
                                                                <i class="fa fa-code pull-left"></i>
                                                                <div class="media-body">
                                                                    <strong>Popover doesn't move when tied element moves</strong> <span class="label label-primary">NOT IMPORTANT</span><span class="number pull-right"># 13678</span>
                                                                    <p class="info">Opened by <a href="#">lgardner</a> 3 days ago <i class="fa fa-comments"></i> <a href="#">21 comments</a></p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="list-group-item" data-toggle="modal" data-target="#issue">
                                                            <div class="media">
                                                                <i class="fa fa-file-o pull-left"></i>
                                                                <div class="media-body">
                                                                    <strong>Glyphicon chevron left/right vertical alignment</strong> <span class="label label-info">INFO</span><span class="number pull-right"># 13658</span>
                                                                    <p class="info">Opened by <a href="#">lgardner</a> 5 days ago <i class="fa fa-comments"></i> <a href="#">9 comments</a></p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="list-group-item" data-toggle="modal" data-target="#issue">
                                                            <div class="media">
                                                                <i class="fa fa-file-o pull-left"></i>
                                                                <div class="media-body">
                                                                    <strong>Horizontal to vertical navbar/offcanvas</strong> <span class="label label-primary">NOT IMPORTANT</span><span class="number pull-right"># 13630</span>
                                                                    <p class="info">Opened by <a href="#">tmckenzie</a> 5 days ago <i class="fa fa-comments"></i> <a href="#">10 comments</a></p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="list-group-item" data-toggle="modal" data-target="#issue">
                                                            <div class="media">
                                                                <i class="fa fa-code pull-left"></i>
                                                                <div class="media-body">
                                                                    <strong>Changing container padding</strong> <span class="label label-danger">IMPORTANT</span><span class="number pull-right"># 13627</span>
                                                                    <p class="info">Opened by <a href="#">ehernandez</a> 1 week ago <i class="fa fa-comments"></i> <a href="#">82 comments</a></p>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>

                                                    <div class="modal fade" id="issue" tabindex="-1" role="dialog" aria-labelledby="issue" aria-hidden="true">
                                                        <div class="modal-wrapper">
                                                            <div class="modal-dialog">
                                                                <div class="modal-content">
                                                                    <div class="modal-header bg-blue">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                        <h4 class="modal-title"><i class="fa fa-cog"></i> Add drag and drop config import closes</h4>
                                                                    </div>
                                                                    <form action="#" method="post">
                                                                        <div class="modal-body">
                                                                            <div class="row">
                                                                                <div class="col-md-2">
                                                                                    <img src="assets/img/user/avatar01.png" class="img-circle" alt width="50">
                                                                                </div>
                                                                                <div class="col-md-10">
                                                                                    <p>Issue <strong>#13698</strong> opened by <a href="#">jqilliams</a> 5 hours ago</p>
                                                                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                                                                    <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row support-content-comment">
                                                                                <div class="col-md-2">
                                                                                    <img src="assets/img/user/avatar02.png" class="img-circle" alt width="50">
                                                                                </div>
                                                                                <div class="col-md-10">
                                                                                    <p>Posted by <a href="#">ehernandez</a> on 16/06/2014 at 14:12</p>
                                                                                    <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                                                                    <a href="#"><span class="fa fa-reply"></span> &nbsp;Post a reply</a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Close</button>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </section>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript">




    $(function(){
        $(".btn-toggle-menu").click(function() {
            $("#wrapper").toggleClass("toggled");
        });
    })
</script>
</body>
</html>
