<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: rasheenruwisha
  Date: 12/13/19
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Appezite</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/16.0.0/css/intlTelInput.css">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/register.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css"/>">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
 <script src="<c:url value="/resources/javascript/font-awesome.js"/>"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"   integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="   crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/16.0.0/js/intlTelInput-jquery.js"></script>
    <link href="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css" rel="stylesheet">
    <script src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

</head>
<body>


<div class="register-form">
    <div class="form-container">
        <form id="login-form" action='<c:url value='j_spring_security_check'/>' method='POST' enctype="application/json">

            <div class="register-outer" style="position: absolute;
top: 10%;
left: 50%;
transform: translate(-50%,-10%);">
                <div id="login-overlay" class="form-overlay">
                    <img style="width: 96%;padding: 0px 15px;" src="<c:url value="/resources/images/loader.gif"/>" alt="logo">
                </div>

                <div class="form-logo">
                    <img src="<c:url value="/resources/images/logo2.png"/>" alt="logo">
                </div>

                <div style="
            text-align: center;">
                    <h3>Sign in </h3>
                    <h5>continue to Appezite</h5>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input class="form-control" type="email" name="username" id="business-email">
                    <small id="email-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter email.</small>
                </div>


                <div class="form-group">
                    <label>Password</label>
                    <input class="form-control" type="password" name="password" id="business-password">
                    <p id="password-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter password.</p>
                </div>



                <div id="password-mismatch" class="error-message">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                     Passwords do not match. Try again.
                </span>
                </div>


                <div class="form-button">
                    <button  style="float: right;width: 24%;" type="submit" class="btn btn-outline-secondary">Login</button>
                </div>

            </div>



        </form>
    </div>
</div>


</body>
<script src="<c:url value="/resources/javascript/login.js"/>"></script>
<script>

    $(function () {

        $(".input-wrapper .input-placeholder").on("click", function () {
            $(this).closest(".input-wrapper").find("input").focus();
        });
        $(".input-wrapper input").on("keyup", function () {
            var value = $.trim($(this).val());
            if (value) {
                $(this).closest(".input-wrapper").addClass("hasValue");
            } else {
                $(this).closest(".input-wrapper").removeClass("hasValue");
            }
        });

    });
</script>
</html>
