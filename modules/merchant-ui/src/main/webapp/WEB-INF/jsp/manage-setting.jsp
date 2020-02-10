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
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <script src="<c:url value="/resources/javascript/moment.min.js"/>"></script>
    <script src="<c:url value="/resources/javascript/fullcalendar.min.js"/>"></script>
    <title>Appezite</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/register.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/colorpicker.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/modal.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/tab-controls.css"/>">
    <script src="<c:url value="/resources/javascript/font-awesome.js"/>"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <link rel="stylesheet" type="text/css" href="https://unpkg.com/@fullcalendar/core@4.3.1/main.min.css">
    <link rel="stylesheet" type="text/css" href="https://unpkg.com/@fullcalendar/daygrid@4.3.0/main.min.css">
    <link rel="stylesheet" type="text/css" href="https://unpkg.com/@fullcalendar/timegrid@4.3.0/main.min.css">

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
<div class="alert-container">

</div>


<div class="content-container" id="product-container">


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
            <section id="settings" class="tab-panel">

                <div class="setting-container">
                    <div class="setting-menu">
                        <div id="pickup-menu" class="setting-menu-item" onclick="showPickUp()">
                            PickUp
                        </div>
                        <hr>
                        <div id="delivery-menu" class="setting-menu-item" onclick="showDelivery()">
                            Delivery
                        </div>
                        <hr>
                        <div id="payment-menu" class="setting-menu-item" onclick="showPayment()">
                            Payment
                        </div>
                    </div>
                    <div class="setting-controls">
                        <div style="padding:0px 30px" class="pickup-panel">
                            <h3>Pickup Hours</h3>
                            <div id='calendar'></div>
                            <button class="btn btn-outline-secondary" style="width: auto;margin: 30px 0px 0px 0px;" onclick="updatePickupHours()">Update
                                PickUp Hours
                            </button>

                        </div>
                        <div style="padding:0px 30px" class="delivery-panel">

                            <div class="panel-controls">
                                <p onclick="showTime()" class="hours-panel" style="color: #18aebf">Configure Hours</p>
                                <p onclick="showLocations()" class="location-panel">Configure Locations</p>
                            </div>
                            <div class="delivery-times">
                                <h3>Delivery Hours</h3>

                                <div id='calendar-del'></div>
                                <button class="btn btn-outline-secondary" style="width: auto;margin: 30px 0px 0px 0px;" onclick="updateDeliveryHours()">
                                    Update Delivery Hours
                                </button>
                            </div>

                            <div class="delivery-states">
                                <h3>Delivery Locations</h3>

                                <button class="btn btn-outline-secondary" style="width: auto;margin: 30px 0px;" onclick="appendForm()">Add Delivery
                                    Location
                                </button>

                                <div id="state-config-form">
                                    <c:forEach items="${business.deliveryLocation}" var="location">
                                        <div class="state-form">

                                            <div style="width: 60% !important;">
                                                <select class="form-control delivery-country "  name="delivery-country">
                                                    <c:choose>
                                                        <c:when test="${location.state eq 'Central Province'}">
                                                            <option selected>Central Province</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option>Central Province</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${location.state eq 'Eastern Province'}">
                                                            <option selected>Eastern Province</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option>Eastern Province</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${location.state eq 'Northern Province'}">
                                                            <option selected>Northern Province</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option>Northern Province</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${location.state eq 'Southern Province'}">
                                                            <option selected>Southern Province</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option>Southern Province</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${location.state eq 'Western Province'}">
                                                            <option selected>Western Province</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option>Western Province</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${location.state eq 'North Western  Province'}">
                                                            <option selected>North Western Province</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option>North Western Province</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${location.state eq 'North Central Province'}">
                                                            <option selected>North Central Province</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option>North Central Province</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${location.state eq 'Uva Province'}">
                                                            <option selected>Uva Province</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option>Uva Province</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${location.state eq 'Sabaragamuwa Province'}">
                                                            <option selected>Sabaragamuwa Province</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option>Sabaragamuwa Province</option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <option>Sabaragamuwa Province</option>
                                                </select>
                                            </div>


                                            <div class="form-group">
                                                <input class="form-control delivery-city" type="text" name="delivery-city"value="${location.city}">
                                            </div>



                                            <div class="form-group">
                                                <input class="form-control delivery-price" type="text" name="delivery-price"value="${location.price}">
                                            </div>



                                            <div class="form-group">
                                                <input class="form-control delivery-duration" type="text"
                                                       name="delivery-delivery-duration" value="${location.deliveryTime}">
                                            </div>



                                            <i style="color:#d93025" class="fas fa-trash-alt addon-delete"
                                               onclick="removeStates(this)"></i>

                                        </div>
                                    </c:forEach>
                                </div>

                                <button class="btn btn-outline-secondary" style="width: auto" onclick="getStates('<c:url
                                        value="/${business.businessId}/updateDeliveryConfig?email=${business.email}"/>')">
                                    Update Delivery Location
                                </button>

                            </div>


                        </div>
                        <div class="payment-panel" style="display: none;padding:0px 30px">

                            <div class="form-group">
                                <label for="business-paypal">Paypal Secret</label>
                                <input class="form-control" type="text" name="business-paypal"  id="business-paypal" value="${business.paypalSecret}">
                                <small id="paypall-null" class="form-text text-muted error-message" style="font-size: 0.6em;color: #ff647c !important;display: none;"><i class="fal fa-exclamation-circle"></i>Paypal Secret.</small>
                            </div>



                            <button class="btn btn-outline-secondary" style="width: auto;margin: 30px 0px 0px 0px;" onclick="updatePaypal()">
                                Update Paypal Secret
                            </button>
                        </div>
                    </div>
                </div>
            </section>
        </div>

    </div>

</div>


<script>

    var shopOpenHours = ${shopOpenHours};
    var deliveryHours = ${deliveryHours};
    var cities = [
        "Central Province",
        "Eastern Province",
        "Northern Province",
        "Southern Province",
        "Western Province",
        "North Western Province",
        "North Central Province",
        "Uva Province",
        "Sabaragamuwa Province"
    ]

    initPickupHours();
    initDeliveryHours();
    function appendForm() {
        $.get("../resources/javascript/sri-lanka-states.html", function (data) {
            $('#state-config-form').append(data);
        });
    }
    function getCalendarEvents(value) {
        var allEvents = [];
        var hours = [];
        if (value === "OPENING_HOURS") {
            hours = shopOpenHours;
        } else if (value === "DELIVERY_HOURS") {
            if (typeof (deliveryHours) !== 'undefined') {
                hours = deliveryHours;
            }
        }

        if (hours.length > 0) {
            hours.forEach(function (entry) {
                var to = entry.to;
                if (to === "00:00") {
                    to = "24:00";
                }
                if (entry.dayOfWeek === "MONDAY") {
                    var event = {
                        title: '',
                        start: '2017-07-03T' + entry.from + ':00',
                        end: '2017-07-03T' + to + ':00',
                    }
                    allEvents.push(event);
                } else if (entry.dayOfWeek === "TUESDAY") {
                    var event = {
                        title: '',
                        start: '2017-07-04T' + entry.from + ':00',
                        end: '2017-07-04T' + to + ':00',
                    }
                    allEvents.push(event);
                } else if (entry.dayOfWeek === "WEDNESDAY") {
                    var event = {
                        title: '',
                        start: '2017-07-05T' + entry.from + ':00',
                        end: '2017-07-05T' + to + ':00',
                    }
                    allEvents.push(event);
                } else if (entry.dayOfWeek === "THURSDAY") {
                    var event = {
                        title: '',
                        start: '2017-07-06T' + entry.from + ':00',
                        end: '2017-07-06T' + to + ':00',
                    }
                    allEvents.push(event);
                } else if (entry.dayOfWeek === "FRIDAY") {
                    var event = {
                        title: '',
                        start: '2017-07-07T' + entry.from + ':00',
                        end: '2017-07-07T' + to + ':00',
                    }
                    allEvents.push(event);
                } else if (entry.dayOfWeek === "SATURDAY") {
                    var event = {
                        title: '',
                        start: '2017-07-08T' + entry.from + ':00',
                        end: '2017-07-08T' + to + ':00',
                    }
                    allEvents.push(event);
                } else if (entry.dayOfWeek === "SUNDAY") {
                    var event = {
                        title: '',
                        start: '2017-07-09T' + entry.from + ':00',
                        end: '2017-07-09T' + to + ':00',
                    }
                    allEvents.push(event);
                }
            });
        }

        return allEvents;
    }
    function initPickupHours() {
        $('#calendar').fullCalendar({
            header: false,
            allDaySlot: false,
            columnFormat: 'ddd',
            selectOverlap: false,
            eventOverlap: false,
            selectConstraint: {start: '00:00', end: '24:00'},
            slotLabelFormat: 'hh:mma',
            timeFormat: 'hh:mma',
            defaultView: 'agendaWeek',
            firstDay: 1,
            defaultDate: '2017-07-03',
            navLinks: false,
            editable: true,
            selectable: true,
            selectHelper: true,
            height: 425,
            select: function (start, end) {
                var eventData = {
                    title: "",
                    start: start,
                    end: end
                };
                $('#calendar').fullCalendar('renderEvent', eventData, true);
                $('#calendar').fullCalendar('unselect');
            },
            eventRender: function (event, element, view) {
                if (view.name == 'listDay') {
                    element.find(".fc-list-item-time").append("<span class='delete-event'><i class=\"fa fa-minus-circle fa-lg\"></i></span>");
                } else {
                    element.find(".fc-content").prepend("<span class='delete-event'><i class=\"fa fa-minus-circle fa-lg\"></i></span>");
                }
                element.find(".delete-event").on('click', function () {
                    $('#calendar').fullCalendar('removeEvents', event._id);
                });
            },
            events: getCalendarEvents("OPENING_HOURS")
        });
    }
    function initDeliveryHours() {
        $('#calendar-del').fullCalendar({
            header: false,
            allDaySlot: false,
            columnFormat: 'ddd',
            selectOverlap: false,
            eventOverlap: false,
            selectConstraint: {start: '00:00', end: '24:00'},
            slotLabelFormat: 'hh:mma',
            timeFormat: 'hh:mma',
            defaultView: 'agendaWeek',
            firstDay: 1,
            defaultDate: '2017-07-03',
            navLinks: false,
            editable: true,
            selectable: true,
            selectHelper: true,
            height: 425,
            select: function (start, end) {
                var eventData = {
                    title: "",
                    start: start,
                    end: end
                };
                $('#calendar-del').fullCalendar('renderEvent', eventData, true);
                $('#calendar-del').fullCalendar('unselect');
            },
            eventRender: function (event, element, view) {
                if (view.name == 'listDay') {
                    element.find(".fc-list-item-time").append("<span class='delete-event'><i class=\"fa fa-minus-circle fa-lg\"></i></span>");
                } else {
                    element.find(".fc-content").prepend("<span class='delete-event'><i class=\"fa fa-minus-circle fa-lg\"></i></span>");
                }
                element.find(".delete-event").on('click', function () {
                    $('#calendar-del').fullCalendar('removeEvents', event._id);
                });
            },
            events: getCalendarEvents("DELIVERY_HOURS")
        });
        $(".delivery-panel").css("display", "none");

    }
    function updatePickupHours() {
        var allEvents = $('#calendar').fullCalendar('clientEvents');
        var pickupAvailableTimes = [];
        if (allEvents.length > 0) {
            allEvents.forEach(function (entry) {
                var startTime = moment(entry.start).format('HH:mm');
                var endTime = moment(entry.end).format('HH:mm');

                var event = {
                    from: startTime,
                    to: endTime,
                    remarks: null,
                    dayOfWeek: moment(entry.start).format('dddd').toUpperCase()
                }
                pickupAvailableTimes.push(event);
            });
        }
        console.log(pickupAvailableTimes);

        let data = {
            pickUpHours: pickupAvailableTimes,
        };

        console.log(data)
        $.ajax({
            url: '<c:url value="/${business.businessId}/updatePickupHours"/>',
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (response, data) {
                if (response  === "Success") {
                    $('.alert-container').html(
                        `<div class="alert-container-success">
    <h3 class="alert-text"><i class="fa fa-check"></i>Pick up times updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                } else {
                    $('.alert-container').html(
                        `<div class="alert-container-error">
    <h3 class="alert-text"><i class="fa fa-check"></i>Pick up times not updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                }
            },
            error: function (error) {
                if (error  === "Success") {
                    $('.alert-container').html(
                        `<div class="alert-container-success">
    <h3 class="alert-text"><i class="fa fa-check"></i>Pick up times updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                } else {
                    $('.alert-container').html(
                        `<div class="alert-container-error">
    <h3 class="alert-text"><i class="fa fa-check"></i>Pick up times not updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                }
            }
        });
    }
    function updateDeliveryHours() {
        var allEvents = $('#calendar-del').fullCalendar('clientEvents');
        var pickupAvailableTimes = [];
        if (allEvents.length > 0) {
            allEvents.forEach(function (entry) {
                var startTime = moment(entry.start).format('HH:mm');
                var endTime = moment(entry.end).format('HH:mm');

                var event = {
                    from: startTime,
                    to: endTime,
                    remarks: null,
                    dayOfWeek: moment(entry.start).format('dddd').toUpperCase()
                }
                pickupAvailableTimes.push(event);
            });
        }
        console.log(pickupAvailableTimes);

        let data = {
            deliveryHours: pickupAvailableTimes,
        };

        console.log(data)
        $.ajax({
            url: '<c:url value="/${business.businessId}/updateDeliveryHours"/>',
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (response, data) {
                console.log(response);
                if (response  === "Success") {
                    $('.alert-container').html(
                        `<div class="alert-container-success">
    <h3 class="alert-text"><i class="fa fa-check"></i>Delivery times updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                } else {
                    $('.alert-container').html(
                        `<div class="alert-container-error">
    <h3 class="alert-text"><i class="fa fa-check"></i>Delivery times not updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                }
            },
            error: function (error) {
                console.log(error);
                if (error  === "Success") {
                    $('.alert-container').html(
                        `<div class="alert-container-success">
    <h3 class="alert-text"><i class="fa fa-check"></i>Delivery times updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                } else {
                    $('.alert-container').html(
                        `<div class="alert-container-error">
    <h3 class="alert-text"><i class="fa fa-check"></i>Delivery times not updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                }
            }
        });
    }

    function updatePaypal(){
        let data = {
            paypalSecret: $('#business-paypal').val(),
        };

        console.log(data)
        $.ajax({
            url: '<c:url value="/${business.businessId}/updatePaypalSecret"/>',
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (response, data) {
                if (response  === "Success") {
                    $('.alert-container').html(
                        `<div class="alert-container-success">
    <h3 class="alert-text"><i class="fa fa-check"></i>Paypal Secret updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                } else {
                    $('.alert-container').html(
                        `<div class="alert-container-error">
    <h3 class="alert-text"><i class="fa fa-check"></i>Paypal Secret not updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                }
            },
            error: function (error) {
                if (error  === "Success") {
                    $('.alert-container').html(
                        `<div class="alert-container-success">
    <h3 class="alert-text"><i class="fa fa-check"></i>Paypal Secret updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                } else {
                    $('.alert-container').html(
                        `<div class="alert-container-error">
    <h3 class="alert-text"><i class="fa fa-check"></i>Paypal Secret not updated</h3>
</div>`
                    )
                    setTimeout(function () {
                        $('.alert-container').html('')
                    }, 5000);
                }
            }
        });
    }

    function showPickUp() {
        $(".delivery-panel").css("display", "none");
        $(".payment-panel").css("display", "none");
        $(".pickup-panel").css("display", "block");
        $("#pickup-menu").css("color", "#18aebf");
        $("#delivery-menu").css("color", "#000");
        $("#payment-menu").css("color", "#000");
    }
    function showDelivery() {
        $(".delivery-panel").css("display", "block");
        $(".payment-panel").css("display", "none");
        $(".pickup-panel").css("display", "none");
        $("#delivery-menu").css("color", "#18aebf");
        $("#pickup-menu").css("color", "#000");
        $("#payment-menu").css("color", "#00");
    }
    function showPayment() {
        $(".delivery-panel").css("display", "none");
        $(".payment-panel").css("display", "block");
        $(".pickup-panel").css("display", "none");
        $("#delivery-menu").css("color", "#000");
        $("#pickup-menu").css("color", "#000");
        $("#payment-menu").css("color", "#18aebf");
    }
    function showTime() {
        $(".delivery-times").css("display", "block");
        $(".delivery-states").css("display", "none");
        $(".hours-panel").css("color", "#18aebf");
        $(".location-panel").css("color", "#000");
    }
    function showLocations() {
        $(".delivery-states").css("display", "block");
        $(".delivery-times").css("display", "none");
        $(".location-panel").css("color", "#18aebf");
        $(".hours-panel").css("color", "#000");
    }
    function removeStates(div) {
        nxCount = 0;
        $(`.state-form`).each(function () {
            nxCount += 1
        });
        if (nxCount != 1) {
            div.parentNode.remove()
        }
    }
    function getStates(url) {
        let state = [];
        let city = [];
        let charge = [];
        let duration = [];

        let deliveryGroup = [];

        $(`.delivery-country`).each(function () {
            state.push($(this).val())
        });
        $(`.delivery-city`).each(function () {
            city.push($(this).val())
        });
        $(`.delivery-price`).each(function () {
            charge.push($(this).val())
        });
        $(`.delivery-duration`).each(function () {
            duration.push($(this).val())
        });
        for (var i = 0; i < state.length; i++) {
            let deliveryInfo = {state: "", city: "", price: "", deliveryTime: ""};
            deliveryInfo.state = state[i];
            deliveryInfo.city = city[i];
            deliveryInfo.price = charge[i];
            deliveryInfo.deliveryTime = duration[i];
            deliveryGroup.push(deliveryInfo)
        }

        let data = {
            deliveryLocation: deliveryGroup
        }

        $.ajax({
            url: url,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (response, data) {
                console.log("response");
            },
            error: function (error) {
                console.log("error")
                console.log(error)
            }
        });
    }
</script>


</body>
</html>
