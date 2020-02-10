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




<div class="content-container" id="product-container">
    <c:choose>
        <c:when test="${products.size() == 0}">
            <div class="no-products-error">
                <i style="font-size: 5em;" class="fad fa-th-large"></i>
                <p>No Products available.</p>
                <p>Lets add some!</p>
                <button id="myBtn">Add Product</button>
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

                <input type="radio" name="main-tab" id="tab14" aria-controls="settings">
                <a href="/merchant/${business.businessId}/manageOrders">Orders</a>


                <div class="tab-panels">
                    <section id="categories" class="tab-panel">
                        <form action=""<c:url value="/${business.businessId}/manageOrders"/>"">
                        <div class="input-group">

                            <div class="input-group-append">
                                <input class="form-control" type="date" name="startDate" id="startDate">
                            </div>
                            <div class="input-group-append">
                                <input class="form-control" type="date" name="endDate" id="endDate">
                            </div>
                            <div class="input-group-append">
                                <select  class="form-control" name="status" id="status">
                                    <option>All</option>
                                    <option>Pending</option>
                                    <option>Accepted</option>
                                    <option>Completed</option>
                                </select>
                            </div>
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary" type="submit">Button</button>
                            </div>
                        </div>
                        </form>


            <c:choose>
                <c:when test="${purchaseOrders.size() == 0}">
                    <div class="no-products-error">
                        <i style="font-size: 5em;" class="fad fa-th-large"></i>
                        <p>No Orders available.</p>
                    </div>
                </c:when>
                <c:otherwise>

                        <table class="table table-striped">
                            <tr>
                                <th>Order ID</th>
                                <th>Customer Name</th>
                                <th>Ordered At</th>
                                <th>Ordered Ready By</th>
                                <th>Actions</th>
                                <th>Payment</th>
                                <th>Status</th>
                                <th>Platform</th>
                            </tr>
                            <c:forEach items="${purchaseOrders}" var="order">
                                <tr>
                                    <td>${order.purchaseId}</td>
                                    <td>${order.customerName}</td>
                                    <td>${order.orderedAt}</td>
                                    <td>${order.orderReadyBy}</td>
                                    <td>
                                        <c:if test="${order.status eq 'PENDING'}">
                                            <a href="<c:url value="/${business.businessId}/acceptOrder?orderId=${order.purchaseId}&email=${business.email}"/>">
                                                <i class="fad fa-check" ></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${order.status eq 'ACCEPTED'}">
                                            <a href="<c:url value="/${business.businessId}/completeOrder?orderId=${order.purchaseId}&email=${business.email}"/>">
                                                <i class="fad fa-check" ></i>
                                            </a>
                                        </c:if>

                                       <c:if test="${order.payment eq 'Pay At Counter'}">
                                           <a href="<c:url value="/${business.businessId}/rejectOrder?orderId=${order.purchaseId}&email=${business.email}"/>">
                                               <i class="fad fa-times-circle" ></i>
                                           </a>
                                       </c:if>
                                        <i class="fad fa-eye"></i>
                                    </td>
                                    <c:choose>
                                        <c:when test="${order.payment eq 'Pay At Counter'}">
                                            <td>${order.payment}</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>Paid</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td>${order.status}</td>
                                    <td>${order.platfrom}</td>
                                </tr>
                            </c:forEach>
                        </table>
                </c:otherwise>
            </c:choose>
                    </section>
                </div>

            </div>

        </c:otherwise>
    </c:choose>
</div>








</body>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/tab-controls.css"/>">
<script src="<c:url value="/resources/javascript/modal.js"/>"></script>
<script src="<c:url value="/resources/javascript/product.js"/>"></script>
<script src="<c:url value="/resources/javascript/category.js"/>"></script>

<script>

</script>
</html>
