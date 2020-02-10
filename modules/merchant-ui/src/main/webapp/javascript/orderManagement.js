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

