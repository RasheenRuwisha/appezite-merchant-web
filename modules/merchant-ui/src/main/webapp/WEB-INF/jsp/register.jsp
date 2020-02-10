<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: rasheenruwisha
  Date: 12/13/19
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Appezite</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/16.0.0/css/intlTelInput.css">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/register.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css"/>">

    <script src="<c:url value="/resources/javascript/font-awesome.js"/>"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"   integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="   crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/16.0.0/js/intlTelInput-jquery.js"></script>
</head>
<body>


<div class="register-form">
    <div class="form-container">
    <form:form commandName="filledDetails" enctype="application/json"  id="register-form" action="/merchant/createBusiness" method="post">

        <div class="register-outer">

            <div class="form-logo">
                <img src="<c:url value="/resources/images/logo2.png"/>" alt="logo">
            </div>
            <div class="register-message">
                <span>Let's Get you started.</span>
            </div>



            <c:if test="${error ne null}">
                <div class="error-message" style="display: block">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                    ${error}
                </span>
                </div>
            </c:if>

            <c:if test="${filledDetails.name eq null}">
                <div class="input-wrapper">
                    <input type="text" name="name" id="business-name">
                    <div class="input-placeholder"><span>Business Name</span></div>
                </div>
            </c:if>
            <c:if test="${filledDetails.name ne null}">
                <div class="input-wrapper hasValue">
                    <input type="text" name="name" id="business-name" value="${filledDetails.name}">
                    <div class="input-placeholder"><span>Business Name</span></div>
                </div>
            </c:if>

            <div id="business-name-null" class="error-message">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                   Enter business name
                </span>
            </div>



            <c:if test="${filledDetails.email eq null}">
                <div class="input-wrapper">
                    <input type="email" name="email" id="business-email">
                    <div class="input-placeholder"><span>Email</span></div>
                </div>
            </c:if>

            <c:if test="${filledDetails.email ne null}">
                <div class="input-wrapper hasValue">
                    <input type="email" name="email" id="business-email" value="${filledDetails.email}">
                    <div class="input-placeholder"><span>Email</span></div>
                </div>
            </c:if>
            <div id="email-null" class="error-message">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                    Enter email
                </span>
            </div>
            <div id="email-exist" class="error-message">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                    Email already in use
                </span>
            </div>

            <c:if test="${filledDetails.password eq null}">
                <div class="input-wrapper">
                    <input type="password" name="password" id="business-password">
                    <div class="input-placeholder"><span>Password</span></div>
                </div>
                <div class="input-wrapper">
                    <input type="password" name="business-confirm-password" id="business-confirm-password">
                    <div class="input-placeholder"><span>Confirm Password</span></div>
                </div>
            </c:if>
            <c:if test="${filledDetails.password ne null}">
                <div class="input-wrapper hasValue">
                    <input type="password" name="password" id="business-password" value="${filledDetails.password}">
                    <div class="input-placeholder"><span>Password</span></div>
                </div>
                <div class="input-wrapper hasValue">
                    <input type="password" name="business-confirm-password" id="business-confirm-password" value="${filledDetails.password}">
                    <div class="input-placeholder"><span>Confirm Password</span></div>
                </div>
            </c:if>

            <div id="password-null" class="error-message">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                    Enter password
                </span>
            </div>


            <div id="confrim-pass-null" class="error-message">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                     Confirm your password!
                </span>
            </div>

            <div id="password-mismatch" class="error-message">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                     Passwords do not match. Try again.
                </span>
            </div>


            <div class="input-wrapper">
                <input type="number" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" name="phone" id="business-phone" placeholder="Phone">
            </div>

            <input style="display: none" name="country" id="country">
            <input style="display: none" name="countryCode" id="countryCode">

            <div id="phone-null" class="error-message">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                    Enter Phone number
                </span>
            </div>

            <div class="form-button btn btn-outline-secondary">
                <button style="float: right;width: 24%;" type="submit" class="btn btn-outline-secondary">Register</button>
            </div>

        </div>


</form:form>
    </div>
</div>


</body>
<script src="<c:url value="/resources/javascript/register.js"/>"></script>

<script>

    $(document).ready(function () {
        $("#business-phone").intlTelInput({
            formatOnDisplay: true,
            nationalMode: true,
            autoPlaceholder: 'aggressive',
            separateDialCode: true,
            initialCountry:"lk"
        });
    });

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
