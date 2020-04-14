<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: rasheenruwisha
  Date: 4/10/20
  Time: 22:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Appezite</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/register.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css"/>">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="<c:url value="/resources/javascript/font-awesome.js"/>"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>


    <script src="https://www.gstatic.com/firebasejs/7.7.0/firebase-app.js"></script>

    <script src="https://www.gstatic.com/firebasejs/7.7.0/firebase-analytics.js"></script>

    <script src="https://www.gstatic.com/firebasejs/7.7.0/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.7.0/firebase-firestore.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.7.0/firebase-messaging.js"></script>

    <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>
</head>
<body>

<div class="nav">
    <div class="nav-container">
        <div class="nav-logo" style="margin-top: 11px">
            Appezite
        </div>

        <div class="nav-user" style="text-align:  center">
            <a href='<c:url value='/j_spring_security_logout'/>'><i class="fad fa-sign-out"></i><span style="font-size: 11px"><br>Logout</span></a>
        </div>

        <c:if test="${business.apkUrl ne null}">
            <div class="nav-user" style="text-align:  center">
                <a href='${business.apkUrl}'><i class="far fa-mobile-android-alt"></i><span style="font-size: 11px"><br>Download APK</span></a>
            </div>
        </c:if>

        <div class="nav-user">
            <p>${business.email}</p>
        </div>

    </div>
</div>



<div class="content-container" id="product-container">

    <div class="tabset" style="width: 100%!important;max-width: 100%">
        <!-- Tab 1 -->
        <input type="radio" name="main-tab" id="tab11" aria-controls="products" >
        <a href="/merchant/${business.businessId}/manageProducts">Products</a>

        <!-- Tab 2 -->
        <input type="radio" name="main-tab" id="tab12" aria-controls="categories" >
        <a href="/merchant/${business.businessId}/manageCategories">Categories</a>
        <!-- Tab 3 -->
        <input type="radio" name="main-tab" id="tab13" aria-controls="settings">
        <a href="/merchant/${business.businessId}/manageSettings">Settings</a>

        <input type="radio" name="main-tab" id="tab14" aria-controls="orders">
        <a href="/merchant/${business.businessId}/manageOrders">Orders</a>

        <input type="radio" name="main-tab" id="tab15" aria-controls="images">
        <a href="/merchant/${business.businessId}/manageImages">Images</a>

        <input type="radio" name="main-tab" id="tab15" aria-controls="app" >
        <a href="/merchant/${business.businessId}/appconfig?page='appconfig'">App Setting</a>

        <input type="radio" name="main-tab" id="tab15" aria-controls="app" checked>
        <a href="/merchant/${business.businessId}/manageNotifications">Notifications</a>

        <div class="row" style="padding-top: 20px">
            <div class="col-md-4 notification-form">
                <form:form modelAttribute="notification" enctype="application/json"  id="appconfig-form" action="/merchant/${business.businessId}/sendNotification" method="post">

                    <div class="form-group" style="padding-top: 20px">
                        <label for="notitifcation-title">Title</label>
                        <form:input class="form-control" type="text" path="title" id="notitifcation-title"/>
                        <small id="title-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>  Enter title</small>
                    </div>

                    <div class="form-group">
                        <label for="notitifcation-msg">Message</label>
                        <form:input class="form-control" type="text" path="body" id="notitifcation-msg"/>
                        <small id="msg-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>  Enter Message</small>
                    </div>

                    <div class="form-button">
                        <button  type="submit"
                                 class="btn btn-outline-secondary"> <span id="submit-btn">Submit</span>  <i class="fal fa-chevron-right"></i>
                        </button>
                    </div>
                </form:form>
            </div>


            <div  class="col-md-8">
                <table >
                    <tr>
                        <th>Title</th>
                        <th>Body</th>
                        <th>Date</th>
                    </tr>
                    <c:forEach  items="${business.notifications}" var="businessNotifications">
                        <tr>
                            <td>${businessNotifications.title}</td>
                            <td>${businessNotifications.body}</td>
                            <td>${businessNotifications.dateTime}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

        </div>



    </div>



</div>








</body>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/tab-controls.css"/>">
<script src="<c:url value="/resources/javascript/image-management.js"/>"></script>
<script src="<c:url value="/resources/javascript/firebase.js"/>"></script>

</html>
