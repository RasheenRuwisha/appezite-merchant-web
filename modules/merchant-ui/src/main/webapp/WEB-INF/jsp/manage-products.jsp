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
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
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




<div class="content-container" id="product-container">
    <c:choose>
        <c:when test="${products.size() == 0}">
            <div class="no-products-error">
                <i style="font-size: 5em;" class="fad fa-th-large"></i>
                <p>No Products available.</p>
                <p>Lets add some!</p>
                <button data-toggle="modal" data-target="#add-product-modal" class="btn btn-outline-secondary" id="myBtn">Add Product</button>

                <form method="post" enctype="multipart/form-data"
                      action="/merchant/${businessId}/batchUploadProductCSV">

                    <label id="prd-csv" for="prd-csv-in" class="prd-image custom-file-upload">
                        Choose Image
                    </label>

                    <input id="prd-csv-in" type="file" name="file" accept=".xls,.xlsx"><br><br>
                    <input type="submit" value="Upload file" />
                </form>
            </div>
        </c:when>
        <c:otherwise>

            <div class="tabset" style="width: 100%!important;max-width: 100%">
                <!-- Tab 1 -->
                <input type="radio" name="main-tab" id="tab11" aria-controls="products" checked>
                <a href="/merchant/${business.businessId}/main">Products</a>

                <!-- Tab 2 -->
                <input type="radio" name="main-tab" id="tab12" aria-controls="categories">
                <a href="/merchant/${business.businessId}/manageCategories">Categories</a>
                <!-- Tab 3 -->
                <input type="radio" name="main-tab" id="tab13" aria-controls="settings">
                <a href="/merchant/${business.businessId}/manageSettings">Settings</a>

                <input type="radio" name="main-tab" id="tab14" aria-controls="orders">
                <a href="/merchant/${business.businessId}/manageOrders">Orders</a>


                <input type="radio" name="main-tab" id="tab15" aria-controls="images" >
                <a href="/merchant/${business.businessId}/manageImages">Images</a>


                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Dropdown button
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <a class="dropdown-item" data-toggle="modal" data-target="#add-product-modal">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </div>

                <button id="add-prd" class="add-btn btn btn-outline-secondary"  >Add Product</button>

                <form id="csv-upload" method="post" enctype="multipart/form-data"
                      action="/merchant/${businessId}/batchUploadProductCSV">
                    <label id="prd-csv1" for="prd-csv-in1" class="prd-image custom-file-upload">
                        Upload Products via CSV
                    </label>
                    <input id="prd-csv-in1" type="file" name="file" accept=".xls,.xlsx" onchange="submitCsvForm()"><br><br>
                </form>


                <form id="json-upload" method="post" enctype="multipart/form-data"
                      action="/merchant/${businessId}/batchUploadProductJSON">

                    <label id="prd-csv2" for="prd-csv-in2" class="prd-image custom-file-upload">
                        Upload products via json
                    </label>

                    <input id="prd-csv-in2" type="file" name="file" accept=".json" onchange="submitJsonForm()"><br><br>
                </form>

                <div class="tab-panels">
                    <section id="products" class="tab-panel">

                        <c:forEach items="${products}" var="prdocut">
                            <c:if test="${prdocut.visibility ==true}">
                                <div class="product-card">
                                    <div class="product-image">
                                        <img src="<c:url value="${prdocut.image}"/>" alt="logo">
                                    </div>
                                    <div class="product-card-overlay">
                                        <p class="product-name">${prdocut.name}</p>
                                        <p class="function-p"><span data-toggle="modal" data-target="#${prdocut.productId}">Edit</span> &nbsp;
                                            <span onclick="initProductRemoveModal('${prdocut.name}','<c:url value="/${business.businessId}/removeProduct?email=${business.email}&productId=${prdocut.productId}"/>')">Remove </span></p>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </section>
                    <section id="settings" class="tab-panel">

                    </section>
                </div>

            </div>

        </c:otherwise>
    </c:choose>
</div>





<c:forEach items="${products}" var="prdocut">
    <c:if test="${prdocut.visibility ==true}">
        <div class="modal fade" id="${prdocut.productId}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="add-product-image" style="background:linear-gradient(rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.45)), url('${prdocut.image}') center/cover no-repeat; !important;">
                    </div>
                    <p style="text-align: center">Edit Product</p>
                    <div class="form-container">

                        <div class="tabsetp">
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

                                        <div class="register-outer" style="border: none !important;padding: 0px!important;margin-top: 0px">

                                            <div class="form-group">
                                                <label for="prd-nam">Product Name</label>
                                                <input class="form-control" type="text" name="prd-nam"  id="${prdocut.productId}prd-name" value="${prdocut.name}">
                                                <small id="${prdocut.productId}prd-name-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter product price.</small>
                                            </div>

                                            <div class="form-group">
                                                <label for="prd-nam">Product Price</label>
                                                <input class="form-control" type="text" name="prd-nam"  id="${prdocut.productId}prd-price" value="${prdocut.price}">
                                                <small id="${prdocut.productId}prd-price-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter product price.</small>
                                            </div>



                                        <div class="form-group">
                                            <label for="product-desciption">Description</label>
                                            <textarea class="form-control" id="${prdocut.productId}-product-desciption"name="=product-desciption" rows="3"> ${prdocut.description}</textarea>
                                        </div>

                                        <div class="input-placeholder"><span>Product Category</span></div>
                                            <div class="input-group">
                                                <select class="form-control" id="${prdocut.productId}-cat-id">
                                                    <c:forEach items="${categories}" var="cate">

                                                        <c:choose>
                                                            <c:when test="${prdocut.categoryId.size() > 0}">
                                                                <c:forEach items="${prdocut.categoryId}" var="prdcat">
                                                                    <c:if test="${cate.categoryId ne prdcat && cate.visibility == true}">
                                                                        <option value="${cate.categoryId}">${cate.name}</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option value="${cate.categoryId}">${cate.name}</option>
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </c:forEach>
                                                </select>
                                                <div class="input-group-append">
                                                    <button  onclick="addEditProductCategory('${prdocut.productId}')" class="btn btn-outline-secondary" type="button">  <i class="far fa-plus-circle"  style="font-size: 1.5rem"></i></button>
                                                </div>
                                            </div>


                                            <div id="${prdocut.productId}-product-categories">
                                                <c:forEach items="${prdocut.categoryId}" var="prdcat">
                                                    <c:forEach items="${categories}" var="cate">
                                                        <c:if test="${cate.categoryId eq prdcat && cate.visibility == true}">
                                                            <h5><span name="${prdocut.productId}-categories" data-id='${cate.categoryId}' class="badge badge-secondary">${cate.name} <i class="fad fa-times" onclick="removeEditProductCategory('${prdocut.productId}','${cate.name}','${cate.categoryId}',this)"></i></span></h5>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:forEach>
                                            </div>


                                            <p class="label-heading">Select a product image</p>
                                            <label id="prd-image" for="${prdocut.productId}-file" class="prd-image custom-file-upload">
                                                Choose Image
                                            </label>
                                            <input id="${prdocut.productId}-file" type="file" name="myFile" accept="image/*" onchange="editProductImage(this,'#${prdocut.productId}-prd-url','#${prdocut.productId}-add-prd-modal-overlay-disable');"><br><br>
                                            <input style="display: none" type="text" value="${prdocut.image}" id="${prdocut.productId}prd-url">
                                            <div id="${prdocut.productId}prd-null" class="error-message-icons">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Select a product image
                        </span>
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
                                                        <div id="addon-group">
                                                            <div class="form-group"  onclick='showAddonGroup("#${prdocut.productId}-addon-group-${count.index+1}-items")'>
                                                                <input  class="form-control ${prdocut.productId}-addon-group-${count.index+1}-GROUPNAME" value="${addons.name}">
                                                            </div>
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
                                                                <div class="form-group">
                                                                    <input class="form-control" type="text"  name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-COUNT" value="${addons.maximimCount}">
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

                                                                    <div class="form-group">
                                                                        <label>Name</label>
                                                                        <input class="form-control" type="text" name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-item-${count2.index+1}-name" value="${addon.name}">
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label>Price</label>
                                                                        <input class="form-control" type="text" name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-item-${count2.index+1}-price" value="${addon.price}">
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
                                                            <i style="margin:0px 0px 15px 0px ;color:#d93025" class="fas fa-trash-alt addon-delete" onclick="removeAddonFroup('.${prdocut.productId}-addon-group-${count1.index+1}')"></i>

                                                            <div class="addon-count">
                                                                <span style="padding-top: 14px;">Maximum Selections Allowed</span>
                                                                <div class="form-group">
                                                                    <input class="form-control" type="text"  name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-COUNT" value="${addons.maximimCount}">
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
                                                                    <div class="form-group">
                                                                        <label>Name</label>
                                                                        <input class="form-control" type="text" name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-item-${count2.index+1}-name" value="${addon.name}">
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label>Price</label>
                                                                        <input class="form-control" type="text" name="prd-price" id="${prdocut.productId}-addon-group-${count1.index+1}-item-${count2.index+1}-price" value="${addon.price}">
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
                                    <div class="variant-container">
                                    <p>Variant Name</p>

                                        <div class="form-group">
                                            <label for="variant-name">Name</label>
                                            <input class="form-control" type="text" id="${prdocut.productId}-variant-name" value="${prdocut.variant.name}">
                                        </div>
                                    <div id="${prdocut.productId}-variant-groups">

                                        <c:forEach items="${prdocut.variant.variants}" var="varaint" varStatus="count">
                                            <div data-index="${count.index +1}" class="variant-items ${prdocut.productId}-variant-groups ${prdocut.productId}-variant-group-${count.index+1}">

                                                <div class="form-group">
                                                    <label for="variant-item-1-name">Name</label>
                                                    <input class="form-control" type="text" id="${prdocut.productId}-variant-item-${count.index +1}-name" value="${varaint.name}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="variant-item-1-price">Price</label>
                                                    <input class="form-control" type="text" id="${prdocut.productId}-variant-item-${count.index +1}-price" value="${varaint.price}">
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
                                    </div>
                                </section>
                            </div>
                            <div class="form-button">
                                <button id="${prdocut.productId}-submit-prd-btn"   class="btn btn-primary add-btn" onclick="updateProduct('<c:url value="/${business.businessId}/updateProduct?email=${business.email}"/>','${prdocut.productId}','${businessId}')">Update</button>
                            </div>
                        </div>

                    </div>
                    <div id="${prdocut.productId}-add-prd-modal-overlay-disable" class="modal-content disable-overlay">
                    </div>
                </div>

            </div>
        </div>
    </c:if>
</c:forEach>



<jsp:include page="components/add-category-modal.jsp"/>
<jsp:include page="components/add-product-modal.jsp"></jsp:include>
<jsp:include page="components/remove-product-modal.jsp"></jsp:include>

</body>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/tab-controls.css"/>">
<script src="<c:url value="/resources/javascript/modal.js"/>"></script>
<script src="<c:url value="/resources/javascript/product.js"/>"></script>
<script src="<c:url value="/resources/javascript/category.js"/>"></script>


</html>
