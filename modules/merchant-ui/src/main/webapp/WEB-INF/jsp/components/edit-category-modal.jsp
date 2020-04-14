<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade" id="edit-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">

    <!-- Modal content -->
    <div class="modal-content">
        <div class="add-category-image">

        </div>
        <div class="form-container">
            <form:form enctype="application/json" action='/merchant/${business.businessId}/updateCategory' method="post">


                <div class="register-outer" style="border: none !important;">


                    <div class="form-group">
                        <label for="prd-nam">Category Name</label>
                        <input class="form-control" type="text" name="name" id="edit-category-name">
                        <small id="cat-name-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i> Enter category name.</small>
                    </div>






                    <p class="label-heading">Select a category image</p>
                    <label for="edit-cat-file" id="edit-cat-img" class="custom-file-upload">
                        Change Image
                    </label>
                    <input id="edit-cat-file" type="file" name="myFile" accept="image/*" onchange="editCategoryImage(this);"><br><br>
                    <input style="display: none" type="text" name="image" id="edit-category-url">
                    <div id="cat-null" class="error-message-icons">
                        <span style="font-size: 0.6em; color: #ff647c;">
                        <i class="fal fa-exclamation-circle"></i>
                        Select a category image
                        </span>
                    </div>
                    <input style="display: none" type="text" name="categoryId" id="edit-categoryId">




                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-cat-submit" type="submit"   class="btn btn-outline-secondary">Update</button>
                    </div>

                </div>



            </form:form>
        </div>


        <div id="edit-category-modal-overlay-disable" class="modal-content disable-overlay">
        </div>
    </div>
    </div>
</div>