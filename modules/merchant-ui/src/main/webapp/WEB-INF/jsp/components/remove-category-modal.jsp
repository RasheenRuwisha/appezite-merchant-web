<%--
  Created by IntelliJ IDEA.
  User: rasheenruwisha
  Date: 2/17/20
  Time: 12:05
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="remove-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">

        <!-- Modal content -->
        <div class="modal-content">
            <div class="form-container">
                    <div class="register-outer" style="border: none !important;">
                        <form id="remove-category-form" method="post">

                        <p>Are you sure you want to remove <span id="remove-category-name"> </span></p>
                        <div class="form-button">
                            <button id="remove-cat-submit" type="submit" class="btn btn-outline-secondary">Remove</button>
                        </div>
                        </form>
                    </div>
            </div>

            <div id="add-category-modal-overlay-disable" class="modal-content disable-overlay">
            </div>
        </div>

    </div>
</div>
</div>
