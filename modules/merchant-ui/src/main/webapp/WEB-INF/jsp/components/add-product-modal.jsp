<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="add-product-image">

            </div>
            <p style="text-align: center">Add Product</p>
            <div class="form-container">

                <div class="tabset">
                    <!-- Tab 1 -->
                    <input type="radio" name="tabset" id="tab1" aria-controls="create-basic" checked>
                    <label for="tab1">Basic</label>
                    <!-- Tab 2 -->
                    <input type="radio" name="tabset" id="tab2" aria-controls="create-addons">
                    <label for="tab2">Addons</label>
                    <!-- Tab 3 -->
                    <input type="radio" name="tabset" id="tab3" aria-controls="create-variants">
                    <label for="tab3">Variants</label>

                    <div class="tab-panels">

                        <section id="create-basic" class="tab-panel">

                            <div class="register-outer" style="border: none !important;padding: 0px!important;margin-top: 0px">

                                <div class="form-group">
                                    <label for="prd-price">Product Price</label>
                                    <input class="form-control" type="text" name="prd-price" id="prd-price">
                                    <small id="add-prd-price-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter product name.</small>
                                </div>


                                <div class="form-group">
                                    <label for="prd-nam">Product Name</label>
                                    <input class="form-control" type="text" name="prd-nam" id="prd-name">
                                    <small id="add-prd-name-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter product price.</small>
                                </div>

                                <div class="form-group">
                                    <label for="product-desciption">Description</label>
                                    <textarea class="form-control" id="product-desciption" name="=product-desciption" rows="3"></textarea>
                                </div>



                                <div class="input-placeholder"><span>Product Category</span></div>
                                <div class="input-group">
                                    <select id="cat-id" class="form-control">
                                        <c:forEach items="${categories}" var="cat">
                                            <option value="${cat.categoryId}">${cat.name}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="input-group-append">
                                        <button  onclick="addProductCategory()" class="btn btn-outline-secondary" type="button">  <i class="far fa-plus-circle"  style="font-size: 1.5rem"></i></button>
                                    </div>
                                </div>

                                <div id="product-categories" style="display:flex">

                                </div>






                                <p class="label-heading">Select a product image</p>
                                <label id="prd-image" for="prd-file" class="prd-image custom-file-upload">
                                    Choose Image
                                </label>

                                <input id="prd-file" type="file" name="myFile" accept="image/*" onchange="updateProductImage(this);"><br><br>
                                <input style="display: none" type="text" id="prd-url">
                                <div id="prd-null" class="error-message-icons">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Select a starter screen
                        </span>
                                </div>




                            </div>



                        </section>
                        <section id="create-addons" class="tab-panel">
                            <div class="addons">
                                <div >

                                    <div class="addon-group">
                                        <p>Addon Group</p>

                                        <div id="addon-group">
                                            <div class="form-group"  onclick='showAddonGroup("#addon-group-1-items")'>
                                                <input class="form-control addon-group-1-VAL" type="text">
                                            </div>
                                        </div>
                                    </div>


                                    <button class="btn btn-outline-secondary" onclick="createNewAddonGroup()">
                                        Add new group
                                    </button>
                                </div>

                                <div class="addon-setting" id="addon-setting">
                                    <p>Addon Settings</p>

                                    <div id="addon-group-1-items"  class="addongrp-items">
                                        <div class="addon-count">
                                            <span style="padding-top: 14px;">Maximum Selections Allowed</span>
                                            <div class="form-group">
                                                <input class="form-control" type="text" name="addon-group-1-COUNT" id="addon-group-1-COUNT">
                                            </div>
                                        </div>

                                        <div class="addon-count">
                                            <label> Is Addon Mandatory</label>
                                            <input type="checkbox" name="addon-group-1-Mandatory" id="addon-group-1-Mandatory">
                                        </div>



                                        <br>

                                        <div class="addon-items ">
                                            <div class="form-group">
                                                <label for="addon-group-1-item-1-name">Name</label>
                                                <input class="form-control" type="text" name="addon-group-1-item-1-name" id="addon-group-1-item-1-name">
                                            </div>

                                            <div class="form-group">
                                                <label for="addon-group-1-item-1-price">Price</label>
                                                <input class="form-control" type="text" name="addon-group-1-item-1-price" id="addon-group-1-item-1-price">
                                            </div>

                                        </div>

                                        <button class="btn btn-outline-secondary" onclick="createNewAddonItem('#addon-group-1-items',1)">
                                            Add new group
                                        </button>
                                    </div>


                                </div>
                            </div>
                        </section>
                        <section id="create-variants" class="tab-panel">
                            <div class="variant-container">
                                <p>Variant Name</p>

                                <div class="form-group">
                                    <label for="variant-name">Name</label>
                                    <input class="form-control" type="text" name="variant-name" id="variant-name">
                                </div>



                                <div id="variant-groups">

                                    <div data-index="1" class="variant-items add-product-variant-items">

                                        <div class="form-group">
                                            <label for="variant-item-1-name">Name</label>
                                            <input class="form-control" type="text" name="variant-item-1-name" id="variant-item-1-name">
                                        </div>
                                        <div class="form-group">
                                            <label for="variant-item-1-price">Price</label>
                                            <input class="form-control" type="text" name="variant-item-1-price" id="variant-item-1-price">
                                        </div>

                                    </div>

                                </div>

                                <button class="secondary-btn" onclick="createNewVariant()">
                                    Add new variant
                                </button>
                            </div>
                        </section>
                        <div class="form-button">
                            <button id="submit-prd-btn"   class="btn btn-primary add-btn" onclick="createProduct('<c:url value="/${business.businessId}/addProduct?email=${business.email}"/>','${businessId}')">Add</button>
                        </div>
                    </div>

                </div>

            </div>

            <div id="add-prd-modal-overlay-disable" class="modal-content disable-overlay">
            </div>
        </div>

    </div>
</div>