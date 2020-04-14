<%--
  Created by IntelliJ IDEA.
  User: rasheenruwisha
  Date: 2/17/20
  Time: 12:05
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="remove-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">

        <!-- Modal content -->
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Remove Product</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <div class="form-container">
                    <div style="border: none !important;">
                        <form id="remove-product-form" method="post">
                            <p>Are you sure you want to remove <span id="remove-product-name"> </span></p>
                        </form>

                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="submit" form="remove-product-form" class="btn btn-primary">Remove</button>
            </div>



            <div id="add-category-modal-overlay-disable" class="modal-content disable-overlay">
            </div>
        </div>

    </div>
</div>
</div>
