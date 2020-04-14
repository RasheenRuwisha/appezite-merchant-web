<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Appezite</title>
    <script src="<c:url value="/resources/javascript/font-awesome.js"/>"></script>


    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    <link href='https://fonts.googleapis.com/css?family=Lato:400,100,300,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800,300' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Raleway:300,400,600,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css"  href="<c:url value="/resources/css/error.css"/>">
    <link rel="stylesheet" type="text/css"  href="<c:url value="/resources/css/main.css"/>">

</head>

<body class="grey-bg">

<%--    <jsp:include page="../includes/navbar.jsp"/>--%>

<div class="nav">
    <div class="nav-container">
        <div class="nav-logo" style="margin-top: 11px">
            Appezite
        </div>

        <div class="nav-user" style="text-align:  center">
            <a href='<c:url value='/j_spring_security_logout'/>'><i class="fad fa-sign-out"></i><span style="font-size: 11px"><br>Logout</span></a>
        </div>
    </div>
</div>

    <div class="container">
        <div class="row content-empty error-page">
            <div class="col-md-12 text-center">
                <i class="fa fa-file-archive-o fa-5x"></i>

                <h2>Oops! Page Not Found! </h2>

                <h4>Like unicorns and dragons, This page does not exist... Or at least not anymore...</h4>
            </div>
        </div>
    </div>




</body>
</html>