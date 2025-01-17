<%--
  Created by IntelliJ IDEA.
  User: Kasun
  Date: 10/15/2024
  Time: 12:55 AM
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


  <title>Open Help Desk | Admin Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
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
        <a href="#">Dashboard</a>
      </li>
      <li>
        <a href="#">Shortcuts</a>
      </li>
      <li>
        <a href="#">Overview</a>
      </li>
      <li>
        <a href="#">Events</a>
      </li>
      <li class="active">
        <a href="#">About</a>
      </li>
      <li>
        <a href="#">Services</a>
      </li>
      <li>
        <a href="#">Contact</a>
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
              <a href="/UserControllerServlet?command=LOGOUT" class="dropdown-toggle" data-toggle="dropdown">
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
          <h1>Sidebar Menu</h1>

          <!-- Insert Your Shit Here -->

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
