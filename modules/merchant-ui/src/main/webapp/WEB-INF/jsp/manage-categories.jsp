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
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/colorpicker.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/modal.css"/>">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <script src="<c:url value="/resources/javascript/font-awesome.js"/>"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/16.0.0/js/intlTelInput-jquery.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

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

<div class="alert-container">
    <c:if test="${removefail ne null}">
        <div class="alert-container-error" style="display: block">
            <h3 class="alert-text"><i class="fa fa-check"></i>${removefail}</h3>
        </div>
    </c:if>


    <c:if test="${removesuccess ne null}">
        <div class="alert-container-success" style="display: block">
            <h3 class="alert-text"><i class="fa fa-check"></i>${removesuccess}</h3>
        </div>
    </c:if>

</div>




<div class="content-container" id="product-container">
    <c:choose>
        <c:when test="${products.size() == 0}">
            <div class="no-products-error">
                <i style="font-size: 5em;" class="fad fa-th-large"></i>
                <p>No Products available.</p>
                <p>Lets add some!</p>
                <button class="btn btn-outline-secondary" id="myBtn">Add Product</button>
            </div>
        </c:when>
        <c:otherwise>

            <div class="tabset" style="width: 100%!important;max-width: 100%">
                <!-- Tab 1 -->
                <input type="radio" name="main-tab" id="tab11" aria-controls="products" >
                <a href="/merchant/${business.businessId}/main">Products</a>

                <!-- Tab 2 -->
                <input type="radio" name="main-tab" id="tab12" aria-controls="categories" checked>
                <a href="/merchant/${business.businessId}/manageCategories">Categories</a>
                <!-- Tab 3 -->
                <input type="radio" name="main-tab" id="tab13" aria-controls="settings">
                <a href="/merchant/${business.businessId}/manageSettings">Settings</a>

                <input type="radio" name="main-tab" id="tab14" aria-controls="orders">
                <a href="/merchant/${business.businessId}/manageOrders">Orders</a>

                <input type="radio" name="main-tab" id="tab15" aria-controls="images" >
                <a href="/merchant/${business.businessId}/manageImages">Images</a>

                <button id="add-cat" class="add-btn btn btn-outline-secondary"   data-toggle="modal" data-target="#add-category-modal">Add Category</button>

                <form id="csv-upload" method="post" enctype="multipart/form-data"
                      action="/merchant/${businessId}/batchUploadCategoryCSV">
                    <label id="prd-csv1" for="prd-csv-in1" class="prd-image custom-file-upload">
                        Upload Products via CSV
                    </label>
                    <input id="prd-csv-in1" type="file" name="file" accept=".xls,.xlsx" onchange="submitCsvForm()"><br><br>
                </form>

                <form id="json-upload" method="post" enctype="multipart/form-data"
                      action="/merchant/${businessId}/batchUploadCategoryJSON">

                    <label id="prd-csv2" for="prd-csv-in2" class="prd-image custom-file-upload">
                        Upload products via json
                    </label>

                    <input id="prd-csv-in2" type="file" name="file" accept=".json" onchange="submitJsonForm()"><br><br>
                </form>

                <div class="tab-panels">
                    <section id="categories" class="tab-panel">
                        <c:forEach items="${categories}" var="category">
                            <div class="product-card" >
                                <div class="product-image">
                                    <img src="<c:url value="${category.image}"/>" alt="logo">
                                </div>
                                <div class="product-card-overlay">
                                    <p class="product-name">${category.name}</p>
                                    <p class="function-p"><span onclick="initCategoryModal('${category.name}','${category.image}','${category.categoryId}')">Edit</span> &nbsp
                                    <span onclick="initCategoryRemoveModal('${category.name}','<c:url value="/${business.businessId}/removeCategory?email=${business.email}&categoryId=${category.categoryId}"/>')">Remove </span></p>
                                </div>
                            </div>
                        </c:forEach>
                    </section>
                </div>

            </div>

        </c:otherwise>
    </c:choose>
</div>







<jsp:include page="components/add-category-modal.jsp"/>
<jsp:include page="components/edit-category-modal.jsp"/>
<jsp:include page="components/remove-category-modal.jsp"/>

    </body>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/tab-controls.css"/>">
<script src="<c:url value="/resources/javascript/modal.js"/>"></script>
<script src="<c:url value="/resources/javascript/product.js"/>"></script>
<script src="<c:url value="/resources/javascript/category.js"/>"></script>

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
