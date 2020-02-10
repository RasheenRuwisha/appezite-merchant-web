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

<button id="add-prd" onclick="displayCatModal()" class="btn btn-outline-secondary">Add Category</button>
<button id="add-cat" onclick="displayPrdModal()" class="btn btn-outline-secondary">Add Product</button>



<div class="content-container" id="product-container">
<c:choose>
    <c:when test="${business.products.size() == 0}">
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
            <input type="radio" name="main-tab" id="tab11" aria-controls="products" checked>
            <label for="tab11">Products</label>
            <!-- Tab 2 -->
            <input type="radio" name="main-tab" id="tab12" aria-controls="categories">
            <a href="/merchant/${business.businessId}/manageCategories">Categories</a>
            <!-- Tab 3 -->
            <input type="radio" name="main-tab" id="tab13" aria-controls="settings">
            <label for="tab13">Settings</label>

            <div class="tab-panels">
                <section id="products" class="tab-panel">
                    <c:forEach items="${business.products}" var="prdocut">
                        <c:if test="${prdocut.visibility ==true}">
                            <div class="product-card">
                                <div class="product-image">
                                    <img src="<c:url value="${prdocut.image}"/>" alt="logo">
                                </div>
                                <div class="product-card-overlay">
                                    <p class="product-name">${prdocut.name}</p>
                                    <p class="function-p"><span data-toggle="modal" data-target="#${prdocut.productId}">Edit</span> &nbsp; <span onclick="removeProduct('<c:url value="/${business.businessId}/removeProduct?email=${business.email}&productId=${prdocut.productId}"/>')">Remove </span></p>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </section>
                <section id="categories" class="tab-panel">
                    <c:forEach items="${business.categories}" var="category">
                                <div class="product-card">
                                    <div class="product-image">
                                        <img src="<c:url value="${category.image}"/>" alt="logo">
                                    </div>
                                    <div class="product-card-overlay">
                                        <p class="product-name">${category.name}</p>
                                    </div>
                                </div>
                    </c:forEach>
                </section>
                <section id="settings" class="tab-panel">

                </section>
            </div>

        </div>

    </c:otherwise>
</c:choose>
</div>





<c:forEach items="${business.products}" var="prdocut">
    <c:if test="${prdocut.visibility ==true}">
        <div class="modal fade" id="${prdocut.productId}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="add-product-image" style="background:linear-gradient(rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.45)), url('${prdocut.image}') center/cover no-repeat; !important;">
                    </div>
                    <p style="text-align: center">Edit Product</p>
                    <div class="form-container">

                        <div class="tabset">
                            <!-- Tab 1 -->
                            <input checked type="radio" name="${prdocut.productId}" id="${prdocut.productId}tab1" aria-controls="${prdocut.productId}-basic" >
                            <label for="${prdocut.productId}tab1">Basic</label>
                            <!-- Tab 2 -->
                            <input type="radio" name="${prdocut.productId}" id="${prdocut.productId}tab2" aria-controls="${prdocut.productId}-addons">
                            <label for="${prdocut.productId}tab2">Addons</label>
                            <!-- Tab 3 -->
                            <input type="radio" name="${prdocut.productId}" id="${prdocut.productId}tab3" aria-controls="${prdocut.productId}-variants">
                            <label for="${prdocut.productId}tab3">Variants</label>

                            <div class="tab-panels">
                                <section id="${prdocut.productId}-basic" class="tab-panel">
                                    <form id="add-product-form" action="">

                                        <div class="register-outer" style="border: none !important;">

                                            <div class="input-wrapper hasValue">
                                                <input type="text" name="prd-nam" id="${prdocut.productId}prd-name" value="${prdocut.name}">
                                                <div class="input-placeholder"><span>Product Name</span></div>
                                            </div>
                                            <div id="${prdocut.productId}prd-name-null" class="error-message">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                    Enter product name
                </span>
                                            </div>

                                            <div class="input-wrapper hasValue">
                                                <input type="text" name="prd-price" id="${prdocut.productId}prd-price" value="${prdocut.price}">
                                                <div class="input-placeholder"><span>Product Price</span></div>
                                            </div>
                                            <div id="${prdocut.productId}prd-price-null" class="error-message">
                <span style="font-size: 0.6em; color: #ff647c;">
                    <i class="fal fa-exclamation-circle"></i>
                    Enter product price
                </span>
                                            </div>



                                            <div class="input-wrapper hasValue">
                                                <c:forEach items="${business.categories}" var="cate">
                                                    <c:if test="${cate.categoryId eq prdocut.categoryId && cate.visibility == true}">
                                                        <input onfocus="openSelect()" value="${cate.name}" type="text" name="prd-category" id="${prdocut.productId}-prd-category">
                                                    </c:if>
                                                </c:forEach>
                                                <div class="input-placeholder"><span>Product Category</span></div>
                                                <select id="${prdocut.productId}-cat-id">
                                                    <c:forEach items="${business.categories}" var="cat">
                                                        <option value="${cat.categoryId}">${cat.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>



                                            <p class="label-heading">Select a product image</p>
                                            <label id="prd-image" for="${prdocut.productId}-file" class="prd-image custom-file-upload">
                                                Choose Image
                                            </label>
                                            <input id="${prdocut.productId}-file" type="file" name="myFile" accept="image/*" onchange="editProductImage(this,'#${prdocut.productId}-prd-url');"><br><br>
                                            <input style="display: none" type="text" value="${prdocut.image}" id="${prdocut.productId}-prd-url">
                                            <div id="prd-null" class="error-message-icons">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Select a product image
                        </span>
                                            </div>


                                            <div class="form-button">
                                                <button id="${prdocut.productId}-submit-prd-btn"   class="btn btn-outline-secondary" onclick="updateProduct('<c:url value="/${business.businessId}/updateProduct?email=${business.email}"/>','${prdocut.productId}')">Update</button>
                                            </div>

                                        </div>



                                    </form>
                                </section>
                                <section id="${prdocut.productId}-addons" class="tab-panel">
                                    <div class="addons">
                                        <div>


                                            <div  class="${prdocut.productId}-addon-groups addon-group-prds" >
                                                <p>  Addon Group</p>

                                                <c:forEach items="${prdocut.addons}" var="addons" varStatus="count">
                                                    <div data-index="${count.index+1}" id="${prdocut.productId}-addon-group-${count.index+1}" class="${prdocut.productId}-addon-group  ${prdocut.productId}-addon-group-${count.index+1}">
                                                        <div  class="input-wrapper hasValue" onclick='showAddonGroup("#${prdocut.productId}-addon-group-${count.index+1}-items")'>
                                                            <input type="text" name="prd-price" class="${prdocut.productId}-addon-group-${count.index+1}-GROUPNAME" value="${addons.name}">
                                                            <div class="input-placeholder" style="left: 19px !important;"><span>Addon Group Name</span></div>
                                                        </div>
                                                    </div>
                                                </c:forEach>

                                            </div>


                                            <button class="btn btn-outline-secondary" onclick="createNewEditAddonGroup(${prdocut.addons.size()},'${prdocut.productId}')">
                                                Add new group
                                            </button>
                                        </div>

                                        <div class="${prdocut.productId}-addon-setting addon-setting-prds" id="addon-setting">
                                           <p>Addon Settings</p>

                                            <c:forEach items="${prdocut.addons}" var="addons" varStatus="count1">
                                                <c:choose>
                                                    <c:when test="${count1.index == 0}">
                                                        <div id="${prdocut.productId}-addon-group-${count1.index+1}-items"  class="addongrp-items">


                                                            <div class="addon-count">
                                                                <span style="padding-top: 14px;">Maximum Selections Allowed</span>
                                                                <div class="input-wrapper hasValue">
                                                                    <input type="text" name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-COUNT" value="${addons.maximimCount}">
                                                                    <div class="input-placeholder" style="left: 35px !important;"><span>Count</span></div>
                                                                </div>
                                                            </div>

                                                            <div class="addon-count">
                                                                <label> Is Addon Mandatory</label>


                                                                <c:choose>
                                                                    <c:when test="${addons.addonMandatory == true}">
                                                                        <input type="checkbox" name="addon-group-1-Mandatory" id="${prdocut.productId}-addon-group-${count1.index+1}-Mandatory" checked>Mandatory Addon<br>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <input type="checkbox" name="addon-group-1-Mandatory" id="${prdocut.productId}-addon-group-${count1.index+1}-Mandatory">
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <br>

                                                            <c:forEach items="${addons.addons}" var="addon" varStatus="count2">
                                                                <div data-index="${count2.index+1}" class="addon-items ${prdocut.productId}-addon-group-items   ${prdocut.productId}-addon-group-items${count1.index+1}" id="${prdocut.productId}-addon-group-items${count2.index+1}${count1.index+1}" >
                                                                    <div class="input-wrapper hasValue">
                                                                        <input type="text" name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-item-${count2.index+1}-name" value="${addon.name}">
                                                                        <div class="input-placeholder" style="left: 19px !important;"><span>Name</span></div>
                                                                    </div>

                                                                    <div class="input-wrapper hasValue">
                                                                        <input type="text" name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-item-${count2.index+1}-price" value="${addon.price}">
                                                                        <div class="input-placeholder" style="left: 35px !important;"><span>Price</span></div>
                                                                    </div>

                                                                    <i style="color:#d93025" class="fas fa-trash-alt addon-delete" onclick="removeAddonFroup('#${prdocut.productId}-addon-group-items${count2.index+1}${count1.index+1}')"></i>
                                                                </div>
                                                            </c:forEach>

                                                            <button class="btn btn-outline-secondary" onclick="createNewEditAddonItem('#${prdocut.productId}-addon-group-${count1.index+1}-items',${addons.addons.size()},'${prdocut.productId}',${count1.index+1})">
                                                                Add new group
                                                            </button>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div id="${prdocut.productId}-addon-group-${count1.index+1}-items"  class="addongrp-items ${prdocut.productId}-addon-group-${count1.index+1} " style="display:none;">
                                                            <i style="margin:0px 0px 15px 0px;color:#d93025" class="fas fa-trash-alt addon-delete" onclick="removeAddonFroup('.${prdocut.productId}-addon-group-${count1.index+1}')"></i>

                                                            <div class="addon-count">
                                                                <span style="padding-top: 14px;">Maximum Selections Allowed</span>
                                                                <div class="input-wrapper hasValue">
                                                                    <input type="text" name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-COUNT" value="${addons.maximimCount}">
                                                                    <div class="input-placeholder" style="left: 35px !important;"><span>Count</span></div>
                                                                </div>
                                                            </div>

                                                            <div class="addon-count">
                                                                <label> Is Addon Mandatory</label>


                                                                <c:choose>
                                                                    <c:when test="${addons.addonMandatory == true}">
                                                                        <input type="checkbox" name="addon-group-1-Mandatory" id="${prdocut.productId}-addon-group-${count1.index+1}-Mandatory" checked>Mandatory Addon<br>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <input type="checkbox" name="addon-group-1-Mandatory" id="${prdocut.productId}-addon-group-${count1.index+1}-Mandatory">
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>



                                                            <br>

                                                            <c:forEach items="${addons.addons}" var="addon" varStatus="count2">
                                                                <div data-index="${count2.index+1}" class="addon-items ${prdocut.productId}-addon-group-items   ${prdocut.productId}-addon-group-items${count1.index+1}" id="${prdocut.productId}-addon-group-items${count2.index+1}${count1.index+1}" >
                                                                    <div class="input-wrapper hasValue">
                                                                        <input type="text" name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-item-${count2.index+1}-name" value="${addon.name}">
                                                                        <div class="input-placeholder" style="left: 19px !important;"><span>Name</span></div>
                                                                    </div>

                                                                    <div class="input-wrapper hasValue">
                                                                        <input type="text" name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-item-${count2.index+1}-price" value="${addon.price}">
                                                                        <div class="input-placeholder" style="left: 35px !important;"><span>Price</span></div>
                                                                    </div>

                                                                    <i style="color:#d93025" class="fas fa-trash-alt addon-delete" onclick="removeAddonFroup('#${prdocut.productId}-addon-group-items${count2.index+1}${count1.index+1}')"></i>
                                                                </div>
                                                            </c:forEach>

                                                            <button class="btn btn-outline-secondary" id="add-btn" onclick="createNewEditAddonItem('#${prdocut.productId}-addon-group-${count1.index+1}-items',${addons.addons.size()},'${prdocut.productId}',${count1.index+1})">
                                                                Add new group
                                                            </button>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>


                                            </c:forEach>


                                        </div>
                                    </div>
                                </section>
                                <section id="${prdocut.productId}-variants" class="tab-panel">

                                    <p>Variant Name</p>

                                    <div class="input-wrapper hasValue">
                                        <input type="text" name="prd-price" id="${prdocut.productId}-variant-name" value="${prdocut.variant.name}">
                                        <div class="input-placeholder" style="left: 19px !important;"><span>Name</span></div>
                                    </div>
                                    <div id="${prdocut.productId}-variant-groups">

                                    <c:forEach items="${prdocut.variant.variants}" var="varaint" varStatus="count">
                                            <div data-index="${count.index +1}" class="variant-items ${prdocut.productId}-variant-groups ${prdocut.productId}-variant-group-${count.index+1}">
                                                <div class="input-wrapper hasValue">
                                                    <input type="text" name="prd-price" id="${prdocut.productId}-variant-item-${count.index +1}-name" value="${varaint.name}">
                                                    <div class="input-placeholder" style="left: 19px !important;"><span>Name</span></div>
                                                </div>

                                                <div class="input-wrapper hasValue">
                                                    <input type="text" name="prd-price" id="${prdocut.productId}-variant-item-${count.index +1}-price" value="${varaint.price}">
                                                    <div class="input-placeholder" style="left: 35px !important;"><span>Price</span></div>
                                                </div>
                                                <c:if test="${count.index >0}">
                                                    <i style="color:#d93025" class="fas fa-trash-alt addon-delete" onclick="removeAddonFroup('.${prdocut.productId}-variant-group-${count.index+1}')"></i>
                                                </c:if>
                                            </div>

                                    </c:forEach>
                                    </div>

                                    <button class="btn btn-outline-secondary" onclick="createNewEditVariant('${prdocut.productId}')">
                                        Add new variant
                                    </button>

                                </section>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
        </div>
    </c:if>
</c:forEach>




<jsp:include page="components/add-product-modal.jsp"></jsp:include>
<jsp:include page="components/add-category-modal.jsp"></jsp:include>
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
