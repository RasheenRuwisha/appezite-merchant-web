function validateAddress1(){
    let name = $("#business-address").val().trim();
    if(name === ""){
        $("#business-address").addClass("red-border")
        $("#address-null").css("display","block");
    }else{
        $("#business-address").removeClass("red-border")
        $("#address-null").css("display","none");
        return true;
    }
    return false;
}

function validateAddress2(){
    let name = $("#business-address-2").val().trim();
    if(name === ""){
        $("#business-address-2").addClass("red-border")
        $("#address-null-2").css("display","block");
    }else{
        $("#business-address-2").removeClass("red-border")
        $("#address-null-2").css("display","none");
        return true;
    }
    return false;
}

function validateState(){
    let name = $("#business-state").val().trim();
    if(name === ""){
        $("#business-state").addClass("red-border")
        $("#state-null").css("display","block");
    }else{
        $("#business-state").removeClass("red-border")
        $("#state-null").css("display","none");
        return true;
    }
    return false;
}

function validateCity(){
    let name = $("#business-city").val().trim();
    if(name === ""){
        $("#business-city").addClass("red-border")
        $("#city-null").css("display","block");
    }else{
        $("#business-city").removeClass("red-border")
        $("#city-null").css("display","none");
        return true;
    }
    return false;
}

function validateLogo(){
    let name = $("#logo-url").val().trim();
    if(name === ""){
        $("#logo-null").css("display","block");
    }else{
        $("#logo-null").css("display","none");
        return true;
    }
    return false;
}

function validateStarter(){
    let name = $("#starter-url").val().trim();
    if(name === ""){
        $("#starter-null").css("display","block");
    }else{
        $("#starter-null").css("display","none");
        return true;
    }
    return false;
}

function validateBackground(){
    let name = $("#back-url").val().trim();
    if(name === ""){
        $("#back-null").css("display","block");
    }else{
        $("#back-null").css("display","none");
        return true;
    }
    return false;
}

function validateIcon(){
    let name = $("#icon-url").val().trim();
    if(name === ""){
        $("#icon-null").css("display","block");
    }else{
        $("#icon-null").css("display","none");
        return true;
    }
    return false;
}

function validateFields(){
    return validateAddress1() && validateAddress2() && validateState()  && validateCity()&& validateLogo() && validateStarter() && validateBackground() && validateIcon();
}

function updateLogo(input){
    var FileSize = input.files[0].size / 1024 / 1024; // in MB
    if (FileSize > 2) {
        alert('File size exceeds 2 MB');
        $(input).val('');
    } else {

        $("#logo-image").text("Uploading...");

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.iphone-logo')
                    .css('background-image', "url("+e.target.result+")");
                var form = new FormData();
                form.append("image", input.files[0]);
                var settings = {
                    "async": true,
                    "crossDomain": true,
                    "url": "http://localhost:5005/ipfs/upload",
                    "method": "POST",
                    "headers": {
                        "Authorization": "Client-ID f1cbaf75fd23eec",
                        "cache-control": "no-cache",
                        "Postman-Token": "efee33ba-00f9-46d9-a3fd-58e868c80ae8"
                    },
                    "processData": false,
                    "contentType": false,
                    "mimeType": "multipart/form-data",
                    "data": form
                }

                $.ajax(settings).done(function (response) {
                    console.log(response);
                    let json = JSON.parse(response)
                    $("#logo-url").val(json.data.link)
                });
            };
            $("#logo-image").text("Change Image");

            reader.readAsDataURL(input.files[0]);
        }

    }

}

function updateStarterScreen(input){
    var FileSize = input.files[0].size / 1024 / 1024; // in MB
    if (FileSize > 2) {
        alert('File size exceeds 2 MB');
        $(input).val('');
    } else {
        $("#starter-screen-image").text("Uploading...");

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.iphone-container')
                    .css('background', "linear-gradient(\n" +
                        "                    rgba(0, 0, 0, 0.45),\n" +
                        "                    rgba(0, 0, 0, 0.45)\n" +
                        "            ),url("+e.target.result+")  center/cover no-repeat");

                var form = new FormData();
                form.append("image", input.files[0]);
                var settings = {
                    "async": true,
                    "crossDomain": true,
                    "url": "http://localhost:5005/ipfs/upload",
                    "method": "POST",
                    "headers": {
                        "Authorization": "Client-ID f1cbaf75fd23eec",
                        "cache-control": "no-cache",
                        "Postman-Token": "efee33ba-00f9-46d9-a3fd-58e868c80ae8"
                    },
                    "processData": false,
                    "contentType": false,
                    "mimeType": "multipart/form-data",
                    "data": form
                }

                $.ajax(settings).done(function (response) {
                    console.log(response);
                    let json = JSON.parse(response)
                    $("#starter-url").val(json.data.link)
                });
            };
            $("#starter-screen-image").text("Change Image");

            reader.readAsDataURL(input.files[0]);
        }

    }


}

function updateBackground(input){
    var FileSize = input.files[0].size / 1024 / 1024; // in MB
    if (FileSize > 2) {
        alert('File size exceeds 2 MB');
        $(input).val('');
    } else {
        $("#background-image").text("Uploading..");

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                var form = new FormData();
                form.append("image", input.files[0]);
                var settings = {
                    "async": true,
                    "crossDomain": true,
                    "url": "http://localhost:5005/ipfs/upload",
                    "method": "POST",
                    "headers": {
                        "Authorization": "Client-ID f1cbaf75fd23eec",
                        "cache-control": "no-cache",
                        "Postman-Token": "efee33ba-00f9-46d9-a3fd-58e868c80ae8"
                    },
                    "processData": false,
                    "contentType": false,
                    "mimeType": "multipart/form-data",
                    "data": form
                }

                $.ajax(settings).done(function (response) {
                    console.log(response);
                    let json = JSON.parse(response)
                    $("#back-url").val(json.data.link)
                });
            };
            $("#background-image").text("Change Image");

            reader.readAsDataURL(input.files[0]);
        }

    }


}

function updateIcon(input){

    var FileSize = input.files[0].size / 1024; // in MB
    if (FileSize > 300) {
        alert('File size exceeds 300 kb');
        $(input).val('');
    } else {

        $("#icon-image").text("Uploading");
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                var form = new FormData();
                form.append("image", input.files[0]);
                var settings = {
                    "async": true,
                    "crossDomain": true,
                    "url": "http://localhost:5005/ipfs/upload",
                    "method": "POST",
                    "headers": {
                        "Authorization": "Client-ID f1cbaf75fd23eec",
                        "cache-control": "no-cache",
                        "Postman-Token": "efee33ba-00f9-46d9-a3fd-58e868c80ae8"
                    },
                    "processData": false,
                    "contentType": false,
                    "mimeType": "multipart/form-data",
                    "data": form
                }

                $.ajax(settings).done(function (response) {
                    console.log(response);
                    let json = JSON.parse(response)
                    $("#icon-url").val(json.data.link)
                });
            };
            $("#icon-image").text("Change Image");
            reader.readAsDataURL(input.files[0]);
        }


    }


}

document.getElementById( 'appconfig-form' ).addEventListener('submit', function(e) {
    if(!validateFields()) {
        e.preventDefault();
        $("#app-batch-overlay").removeClass("batch-overlay-visible");
    }
});

function updateBusinessRequest(url){

    if(validateFields()) {
        $("#submit-btn").html("Submitting...")
        let description = $("#business-desciption").val().trim();
        let address1 = $("#business-address").val().trim();
        let address2 = $("#business-address-2").val().trim();
        let state = $("#business-state").val().trim();
        let city = $("#business-city").val().trim();
        let zip = $("#business-zip").val().trim();

        let logo = $("#logo-url").val().trim();
        let starter = $("#starter-url").val().trim();
        let icon = $("#icon-url").val().trim();
        let background = $("#back-url-url").val().trim();

        let color = $("#color-input").val().trim();


        let address = {
            line1: address1,
            line2: address2,
            street: state,
            city: city,
            zip: zip
        };

        let appconfig = {
            starterScreen: starter,
            logo: logo,
            icon:icon,
            backgroundImage: background
        };

        let theme = {
            dark: color,
            light: color
        }

        let data = {
            description: description,
            address: address,
            appconfig: appconfig,
            theme: theme
        };


        $.ajax({
            url: url,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (response, data) {
                window.location = "/merchant/" + response.responseText;
                $("#submit-btn").html("Submitted")
            },
            error: function (error) {
                window.location = "/merchant/" + error.responseText;
                $("#submit-btn").html("Submitted")
            }
        });
    }
}