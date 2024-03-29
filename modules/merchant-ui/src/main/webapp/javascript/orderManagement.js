function acceptOrder(url){

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        success: function (response, data) {
            console.log("response");
            reloadpaage();
        },
        error: function (error) {
            console.log("error")
            console.log(error)
            reloadpaage();
        }
    });
}

function completeOrder(url){

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        success: function (response, data) {
            console.log("response");
            reloadpaage();
        },
        error: function (error) {
            console.log("error")
            console.log(error)
            reloadpaage();
        }
    });
}

function rejectOrder(url){

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        success: function (response, data) {
            console.log("response");
            reloadpaage();
        },
        error: function (error) {
            console.log("error")
            console.log(error)
            reloadpaage();
        }
    });
}



function loadOrderModal(url){
    $('#view-po-loader-message').css('display','block')
    $('#order-details-container').css('display','none')
    $("#order-details-modal").modal('toggle');
    $.ajax({
        url: url,
        success: function (data) {
            setData(data);
        }
    });
}


function setData(data){
    console.log(data)
    $('#po-modal-receipt-id').text(data["purchaseId"])
    $('#po-collector-name-span').text(data["customerName"])
    $('#po-collector-number-span').text(data["customerNumber"])
    $('#po-modal-order-status-id').text(data["status"])
    if(data["deliveryType"] === "Pick Up") {
        $('#pickup-time-label').removeClass("hide")
        $('#delivery-time-label').addClass("hide")
    } else {
        $('#delivery-time-label').removeClass("hide")
        $('#pickup-time-label').addClass("hide")
    }
    $('#po-ready-time-span').text(data["orderReadyBy"])


    var htmlTemplate =
        '<div class="row item-row">' +
            '<div class="col-md-5 col-xs-5 paddingless-col">' +
                '{ITEM_NAME}<br/>' +
                '{VARIANT_NAME}<br/>' +
                    '{ADD_ONS}' +
                '</div>' +
            '<div class="col-md-4 col-xs-4 text-right paddingless-col">{ITEM_QTY}</div>' +
            '<div class="col-md-3 col-xs-3 text-right paddingless-col">{TOTAL_PRICE}</div>' +
        '</div>';

    var newHtmlTemplate = '';

    for(var itemIndex in data["products"]){
        var item = data["products"][itemIndex];

        var variantName = item["variant"]

        var addOnTemplatesCombined = "";

        var addOnTemplatesCombined = "";
        var addOnList = item["addons"]

        if(addOnList != null) {
            addOnList.forEach(function(addOn){
                var addOnTemplate = '<span>&nbsp;&nbsp;&nbsp;' + addOn["child"]  + '</span> <br/>';
                addOnTemplatesCombined = addOnTemplatesCombined + addOnTemplate
            });
        }

        var variantTemplate = '';
        if(variantName != null){
            var variantTemplate = '<span>&nbsp;&nbsp;&nbsp;' + variantName + '</span>';
        }
        newHtmlTemplate +=
            htmlTemplate.replace("{ITEM_NAME}", item["name"]).
            replace("{VARIANT_NAME}", variantTemplate).
            replace("{ADD_ONS}", addOnTemplatesCombined).
            replace("{ITEM_QTY}", item["quantity"]).
            replace("{TOTAL_PRICE}", item["price"])
    }

    $("#po-items-list").html(newHtmlTemplate);

    $('#po-sub-total-amount').text((Math.round(data["total"] * 100) / 100).toFixed(2))

    if(data["deliveryType"] === 'Delivery') {
        $('#po-delivery-charge-div').removeClass("hide")
        $('#po-grand-total-amount').text((Math.round((data["total"] + data["deliveryCharge"]) * 100) / 100).toFixed(2) )
    } else {
        $('#po-delivery-charge-div').addClass("hide")
        $('#po-grand-total-amount').text((Math.round(data["total"] * 100) / 100).toFixed(2) )
    }

    $('#po-delivery-charge-span').text((Math.round(data["deliveryCharge"] * 100) / 100).toFixed(2))

    $('#view-po-loader-message').css('display','none')
    $('#order-details-container').css('display','block')
}


function overlayAccept(){
    $("#accept-batch-overlay").addClass('batch-overlay-visible')
    $("#msg-txt").text("Accepting Order")
}

function overlayComplete(){
    $("#accept-batch-overlay").addClass('batch-overlay-visible')
    $("#msg-txt").text("Completing Order")
}

function overlayReject(){
    $("#accept-batch-overlay").addClass('batch-overlay-visible')
    $("#msg-txt").text("Rejecting Order")
}