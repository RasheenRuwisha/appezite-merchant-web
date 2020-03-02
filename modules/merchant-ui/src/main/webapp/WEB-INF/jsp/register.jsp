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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
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
                <div class="form-group">
                    <label>Business Name</label>
                    <input class="form-control" type="text" name="name" id="business-name">
                    <small id="business-name-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter business name.</small>
                </div>
            </c:if>
            <c:if test="${filledDetails.name ne null}">
                <div class="form-group">
                    <label>Business Name</label>
                    <input class="form-control" type="text" name="name" id="business-name" value="${filledDetails.name}">
                    <small id="business-name-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter business name.</small>
                </div>
            </c:if>

            <c:if test="${filledDetails.email eq null}">
                <div class="form-group">
                    <label>Business Email</label>
                    <input class="form-control" type="email" name="email" id="business-email">
                    <small id="email-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter email.</small>
                    <small id="email-exist" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Email already in use.</small>

                </div>
            </c:if>

            <c:if test="${filledDetails.email ne null}">
                <div class="form-group">
                    <label>Business Email</label>
                    <input class="form-control" type="email" name="email" id="business-email" value="${filledDetails.email}">
                    <small id="email-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter email.</small>
                    <small id="email-exist" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Email already in use.</small>

                </div>
            </c:if>


            <c:if test="${filledDetails.password eq null}">
                <div class="form-group">
                    <label>Password</label>
                    <input class="form-control" type="password" name="password" id="business-password">
                    <small id="password-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter password.</small>
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <input class="form-control" type="password" name="business-confirm-password" id="business-confirm-password">
                    <small id="confrim-pass-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Confirm your password!</small>
                    <small id="password-mismatch" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>       Passwords do not match. Try again!</small>
                </div>
            </c:if>
            <c:if test="${filledDetails.password ne null}">
                <div class="form-group">
                    <label>Password</label>
                    <input class="form-control" type="password" name="password" id="business-password" value="${filledDetails.email}">
                    <small id="password-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter password.</small>
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <input class="form-control" type="password" name="business-confirm-password" id="business-confirm-password" value="${filledDetails.email}">
                    <small id="confrim-pass-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Confirm your password!</small>
                    <small id="password-mismatch" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>       Passwords do not match. Try again!</small>
                </div>
            </c:if>




            <div class="form-group">
                <label>Phone</label>
                <input class="form-control" type="number" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" name="phone" id="business-phone" placeholder="Phone">
                <small id="phone-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>   Enter Phone number</small>
            </div>



            <input style="display: none" name="country" id="country">
            <input style="display: none" name="countryCode" id="countryCode">


     <div class="form-button">
            <button  style="float: right;width: 24%;" type="submit" class="btn btn-outline-secondary">Register</button>
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
