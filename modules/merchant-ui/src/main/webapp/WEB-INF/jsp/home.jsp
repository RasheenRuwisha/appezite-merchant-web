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
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/appconfig.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/colorpicker.css"/>">

    <script src="<c:url value="/resources/javascript/font-awesome.js"/>"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/16.0.0/js/intlTelInput-jquery.js"></script>
</head>
<body>

<div class="nav">
    <div class="nav-container">
        <div class="nav-logo">
            Appezite
        </div>
        <div class="nav-user">
            ${business.email}
        </div>
    </div>
</div>

<div class="image-container">
</div>

<div class="business-section">

<%--Form section--%>
<div class="register-form">
    <div class="form-container">
<form:form modelAttribute="business"  enctype="application/json"  id="appconfig-form" action="/merchant/${business.businessId}/appconfig" method="post">


<div class="register-outer">
                <div>
                    <p>Business Details</p>
                    <div class="input-wrapper">
                        <textarea type="text" rows="4" name="description" id="business-desciption"></textarea>
                        <div class="input-placeholder"><span>Description</span></div>
                    </div>
                    <div id="email-null" class="error-message">
                        <span style="font-size: 0.6em; color: #ff647c;">
                            <i class="fal fa-exclamation-circle"></i>
                            Enter description
                        </span>
                    </div>

                    <div class="input-wrapper">
                        <form:input type="text" path="address.line1" id="business-address"/>
                        <div class="input-placeholder"><span>Address Line 1</span></div>
                    </div>
                    <div id="address-null" class="error-message">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Enter address line 1
                        </span>
                    </div>

                    <div class="input-wrapper">
                        <form:input type="text" path="address.line2" id="business-address-2"/>
                        <div class="input-placeholder"><span>Address Line 2</span></div>
                    </div>
                    <div id="address-null-2" class="error-message">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Enter address line 2
                        </span>
                    </div>

                    <div class="input-wrapper">
                        <form:input type="text" path="address.street" id="business-state"/>
                        <div class="input-placeholder"><span>State</span></div>
                    </div>
                    <div id="state-null" class="error-message">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Enter state
                        </span>
                    </div>

                    <div class="input-wrapper">
                        <form:input type="text" path="address.city" id="business-city"/>
                        <div class="input-placeholder"><span>City</span></div>
                    </div>
                    <div id="city-null" class="error-message">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Enter city
                        </span>
                    </div>

                    <div class="input-wrapper">
                        <form:input type="text" path="address.zip" id="business-zip"/>
                        <div class="input-placeholder"><span>Zip</span></div>
                    </div>
                    <div id="zip-null" class="error-message">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Enter zip
                        </span>
                    </div>

                </div>



                <div>

                    <p>Select a theme color for your business</p>

                    <div id="color-bar">
                        <form:input id="color-input" name="color" value="#18aebf" path="theme.dark"/>
                        <input type="text" id="colorps">
                    </div>
                    <form:input id="light-color-input" name="color" value="#18aebf" path="theme.light" style="display:none"/>

                    <p class="label-heading">Select a logo for your business</p>
                    <label for="logo-file" class="custom-file-upload" id="logo-image">
                        Choose Image
                    </label>
                    <input id="logo-file" type="file" accept="image/*" name="myFile" onchange="updateLogo(this);"><br><br>
                    <form:input style="display: none" id="logo-url" type="text" path="appconfig.logo"/>
                    <div id="logo-null" class="error-message-icons">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Select a logo
                        </span>
                    </div>

                    <p class="label-heading">Select a starter screen for your app</p>
                    <label for="starter-file" class="custom-file-upload" id="starter-screen-image">
                        Choose Image
                    </label>
                    <input id="starter-file" type="file" name="myFile" accept="image/*" onchange="updateStarterScreen(this);"><br><br>
                    <form:input style="display: none" type="text" id="starter-url" path="appconfig.starterScreen"/>
                    <div id="starter-null" class="error-message-icons">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Select a starter screen
                        </span>
                    </div>

                    <p class="label-heading">Select a background for your webpage</p>
                    <label for="back-file" class="custom-file-upload" id="background-image">
                        Choose Image
                    </label>
                    <input id="back-file" type="file" name="myFile" accept="image/*" onchange="updateBackground(this);"><br><br>
                    <form:input style="display: none" type="text" id="back-url" name="backgroundImage" path="appconfig.backgroundImage"/>
                    <div id="back-null" class="error-message-icons">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Select a background
                        </span>
                    </div>


                    <p class="label-heading">Select an application icon</p>
                    <label for="icon-file" class="custom-file-upload" id="icon-image">
                      Choose Image
                    </label>
                    <input  id="icon-file" type="file" name="myFile" accept="image/*" onchange="updateIcon(this); max"><br><br>
                    <form:input style="display: none" type="text" id="icon-url" path="appconfig.icon"/>
                    <div id="icon-null" class="error-message-icons">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Select an icon
                        </span>
                    </div>


                    <div class="form-button">
                        <button  type="submit"
                                class="btn btn-outline-secondary"> <span id="submit-btn">Submit</span>  <i class="fal fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
            </div>
</form:form>>
    </div>
</div>

    <div  class="phone-container">

        <div class="iphone-container">
            <img src="<c:url value="/resources/images/iphone.png"/>" alt="">
            <div id="starter" style="display: block">
                <div class="iphone-logo">

                </div>
                <p class="business-name-custom">Welcome to <span id="business-name-change">${business.name}</span> </p>

                <div class="acc-creation">
                    CREATE AN ACCOUNT
                </div>

                <div class="guest-login">
                    CONTINUE AS GUEST
                </div>

                <p class="business-login">Already Have an Account? </p>

                <div class="powered-by">
                    Powered By Appezite
                </div>
            </div>

            <div id="categories" style="display: none">

                <div class="mobile-header">
                    <i class="fad fa-bars" style="margin:auto;padding-top: 26px;"></i><p style="padding-left: 10px;padding-top: 27px;">Categories</p>
                </div>

                <div class="category-content">
                    <div class="category-item" style="background-image: url('<c:url value="/resources/images/appconf.jpg"/>')">
                        <div class="overlay">
                            <p class="category-name">Coffee</p>
                        </div>
                    </div>

                    <div class="category-item" style="background-image: url('<c:url value="/resources/images/appconf.jpg"/>')">
                        <div class="overlay">
                            <p class="category-name">Coffee</p>
                        </div>
                    </div>

                    <div class="category-item" style="background-image: url('<c:url value="/resources/images/appconf.jpg"/>')">
                        <div class="overlay">
                            <p class="category-name">Coffee</p>
                        </div>
                    </div>

                    <div class="category-item" style="background-image: url('<c:url value="/resources/images/appconf.jpg"/>')">
                        <div class="overlay">
                            <p class="category-name">Coffee</p>
                        </div>
                    </div>

                    <div class="category-item" style="background-image: url('<c:url value="/resources/images/appconf.jpg"/>')">
                        <div class="overlay">
                            <p class="category-name">Coffee</p>
                        </div>
                    </div>
                </div>

            </div>

            <div id="products" style="display:none;">

                <div class="mobile-header">
                    <i class="fad fa-bars" style="margin:auto;padding-top: 26px;"></i><p style="padding-left: 10px;padding-top: 27px;">Coffee</p>
                </div>

                <div class="category-content">
                    <div class="product-item" >
                        <div class="product" style="background-image: url('<c:url value="/resources/images/appconf.jpg"/>')">
                            <div class="overlay">
                            </div>
                        </div>
                        <div class="product-desc">
                            <div class="product-desc-overlay">
                                <p class="product-name-info">Cinnamon Ice Tea</p>
                                <p class="product-price">$10.00</p>
                                <i class="far fa-heart product-hear"></i>
                                <i class="fas fa-share-alt product-share"></i>
                            </div>
                        </div>
                    </div>

                    <div class="product-item" >
                        <div class="product" style="background-image: url('<c:url value="/resources/images/appconf.jpg"/>')">
                            <div class="overlay">
                            </div>
                        </div>
                        <div class="product-desc">
                            <div class="product-desc-overlay">
                                <p class="product-name-info">Coffee</p>
                                <p class="product-price">$10.00</p>
                                <i class="far fa-heart product-hear"></i>
                                <i class="fas fa-share-alt product-share"></i>
                            </div>
                        </div>
                    </div>

                    <div class="product-item" >
                        <div class="product" style="background-image: url('<c:url value="/resources/images/appconf.jpg"/>')">
                            <div class="overlay">
                            </div>
                        </div>
                        <div class="product-desc">
                            <div class="product-desc-overlay">
                                <p class="product-name-info">Coffee</p>
                                <p class="product-price">$10.00</p>
                                <i class="far fa-heart product-hear"></i>
                                <i class="fas fa-share-alt product-share"></i>
                            </div>
                        </div>
                    </div>


                    <div class="product-item" >
                        <div class="product" style="background-image: url('<c:url value="/resources/images/appconf.jpg"/>')">
                            <div class="overlay">
                            </div>
                        </div>
                        <div class="product-desc">
                            <div class="product-desc-overlay">
                                <p class="product-name-info">Double Espresso</p>
                                <p class="product-price">$10.00</p>
                                <i class="far fa-heart product-hear"></i>
                                <i class="fas fa-share-alt product-share"></i>
                            </div>
                        </div>
                    </div>

                    <div class="product-item" >
                        <div class="product" style="background-image: url('<c:url value="/resources/images/appconf.jpg"/>')">
                            <div class="overlay">
                            </div>
                        </div>
                        <div class="product-desc">
                            <div class="product-desc-overlay">
                                <p class="product-name-info">Coffee</p>
                                <p class="product-price">$10.00</p>
                                <i class="far fa-heart product-hear"></i>
                                <i class="fas fa-share-alt product-share"></i>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <p class="navigation"><span><i onclick="changePage(-1)" class="fas fa-chevron-left"></i></span> &nbsp; <span id="preview-page-name">Starter Screen</span> &nbsp; <span><i onclick="changePage(+1)" class="fas fa-chevron-right"></i></span></p>


        </div>
    </div>


</div>

</body>
<script src="<c:url value="/resources/javascript/home.js"/>"></script>
<script src="<c:url value="/resources/javascript/colorpicker.js"/>"></script>
<script>

    var index = 0;
    function changePage(i){
        if(index == 2){
            if(i === -1){
                index += i;
            }
        }else{
            index += i;
        }
        if(index === 0){
            if(i === +1){
                index+= i;
            }
        }
        if(index == 0){
            $("#preview-page-name").html("Starter Screen")
            $(".iphone-container").removeClass("white-back");
            $("#categories").css("display","none");
            $("#starter").css("display","block")
            $("#products").css("display","none");
        }
        if(index == 1){
            $("#preview-page-name").html("Categories")
            $(".iphone-container").addClass("white-back");
            $("#categories").css("display","block");
            $("#starter").css("display","none")
            $("#products").css("display","none");
        }
        if(index == 2){
            $("#preview-page-name").html("Products")
            $(".iphone-container").addClass("white-back");
            $("#products").css("display","block");
            $("#categories").css("display","none");
            $("#starter").css("display","none")
        }
    }

    $(function (){
        $("#colorps").ColorPicker({
            color: '#18aebf',
            onChange: function (hsb, hex, rgb) {
                $('#colorps').css('backgroundColor', '#' + hex);
                $('#color-input').val('#'+hex)
                $('#light-color-input').val('#'+hex)
                $('.acc-creation').css('backgroundColor', '#' + hex);
                $('.acc-creation').css('borderColor', '#' + hex);
                $('.guest-login').css('borderColor', '#' + hex);
                $('.guest-login').css('color', '#' + hex);
                $('.mobile-header').css('backgroundColor', '#' + hex);
            }
        });

    })
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
        $(".input-wrapper textarea").on("keyup", function () {
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
