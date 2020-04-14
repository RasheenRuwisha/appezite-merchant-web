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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <script src="<c:url value="/resources/javascript/font-awesome.js"/>"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/16.0.0/js/intlTelInput-jquery.js"></script>

    <script src="https://www.gstatic.com/firebasejs/7.7.0/firebase-app.js"></script>

    <script src="https://www.gstatic.com/firebasejs/7.7.0/firebase-analytics.js"></script>

    <script src="https://www.gstatic.com/firebasejs/7.7.0/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.7.0/firebase-firestore.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.7.0/firebase-messaging.js"></script>

</head>
<body>

<div class="batch-overlay" id="app-batch-overlay">
    <div class="processing-container">
        <i class="fa fa-spinner fa-spin fa-2x" style="color: white;"></i>
        <span style="color: white">Updating App</span>
    </div>
</div>

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

                    <div class="form-group">
                        <label for="business-desciption">Description</label>
                        <textarea class="form-control" id="business-desciption" rows="3"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="business-address">Address Line 1</label>
                        <form:input class="form-control" type="text" path="address.line1" id="business-address"/>
                        <small id="address-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>  Enter address line 1</small>
                    </div>

                    <div class="form-group">
                        <label for="business-address-2">Address Line 2</label>
                        <form:input class="form-control" type="text" path="address.line2" id="business-address-2"/>
                        <small id="address-null-2" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>  Enter address line 1</small>
                    </div>

                    <div class="form-group">
                        <label for="business-city">City</label>
                        <form:input class="form-control"  type="text" path="address.city" id="business-city"/>
                        <small id="city-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>  Enter city</small>
                    </div>



                    <div class="form-group">
                        <label for="business-state">State</label>
                        <form:input class="form-control"  type="text" path="address.street" id="business-state"/>
                        <small id="state-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>  Enter state</small>
                    </div>


                    <div class="form-group">
                        <label for="business-state">Zip</label>
                        <form:input class="form-control"  type="text" path="address.zip" id="business-zip"/>
                        <small id="zip-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>  Enter zip</small>
                    </div>


                </div>



                <div>

                    <p>Select a theme color for your business</p>

                    <div class="form-group">
                        <label for="business-state">Dark theme</label>
                        <div class="color-bar">
                            <form:input id="color-input" name="color" value="#18aebf" path="theme.dark"/>
                            <input type="text" id="colorps">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="business-state">Text color</label>
                        <div class="color-bar">
                            <form:input id="color-light-input" name="color" value="#18aebf" path="theme.light"/>
                            <input type="text" id="colorlightps">
                        </div>
                    </div>



                    <p style="margin-top: 5px" class="label-heading">Select a logo for your business</p>
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
                                class="btn btn-outline-secondary" onclick='$("#app-batch-overlay").addClass("batch-overlay-visible")'> <span id="submit-btn">Submit</span>  <i class="fal fa-chevron-right"></i>
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

                <div class="acc-creation" style="color: white">
                    CREATE AN ACCOUNT
                </div>

                <div class="guest-login"  style="margin-top: 10px;">
                    CONTINUE AS GUEST
                </div>

                <p class="business-login">Already Have an Account? </p>

                <div class="powered-by">
                    Powered By Appezite
                </div>
            </div>

            <div id="categories" style="display: none">

                <div class="mobile-header">
                    <i class="fad fa-bars" style="margin:auto;padding-top: 26px;"></i><p style="padding-left: 10px;padding-top: 36px;">Categories</p>
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
                    <i class="fad fa-bars" style="margin:auto;padding-top: 26px;"></i><p style="padding-left: 10px;padding-top: 36px;">Coffee</p>
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
                $('.acc-creation').css('backgroundColor', '#' + hex);
                $('.acc-creation').css('borderColor', '#' + hex);
                $('.guest-login').css('borderColor', '#' + hex);
                $('.mobile-header').css('backgroundColor', '#' + hex);
            }
        });

    })

    $(function (){
        $("#colorlightps").ColorPicker({
            color: '#18aebf',
            onChange: function (hsb, hex, rgb) {
                $('#colorlightps').css('backgroundColor', '#' + hex);
                $('#color-light-input').val('#'+hex)
                $('.guest-login').css('color', '#' + hex);
            }
        });

    })

</script>
<script src="<c:url value="/resources/javascript/firebase.js"/>"></script>

</html>
