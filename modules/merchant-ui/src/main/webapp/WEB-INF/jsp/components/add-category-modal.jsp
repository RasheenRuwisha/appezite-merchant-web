<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">

    <!-- Modal content -->
    <div class="modal-content">
        <div class="add-category-image">

        </div>
        <div class="form-container">
            <form:form enctype="application/json" action='/merchant/${business.businessId}/addCategory?email=${business.email}' method="post">


            <div class="register-outer" style="border: none !important;">

                <div class="form-group">
                    <label for="prd-nam">Category Name</label>
                    <input class="form-control" type="text" name="cate-name"  id="cat-name">
                    <small id="cat-name-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter category name.</small>
                </div>




                    <p class="label-heading">Select a category image</p>
                    <label id="cat-image" for="cat-file" class="custom-file-upload">
                        Choose Image
                    </label>
                    <input id="cat-file" type="file" name="myFile" accept="image/*" onchange="updateCategoryImage(this);"><br><br>
                    <input style="display: none" type="text" name="image" id="cat-url">
                    <div id="cat-null" class="error-message-icons">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Select a category image
                        </span>
                    </div>


                    <div class="form-button">
                        <button id="add-cat-submit" type="submit"   class="btn btn-outline-secondary">Add</button>
                    </div>

                </div>



            </form:form>
        </div>

        <div id="add-category-modal-overlay-disable" class="modal-content disable-overlay">
        </div>
    </div>

    </div>
</div>
</div>
