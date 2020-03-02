function updateCategoryImage(input){


        var FileSize = input.files[0].size / 1024/1024; // in MB
        if (FileSize > 2) {
            alert('File size exceeds 2 mb');
            $(input).val('');
        } else {
            $("#cat-image").text("Uploading...");
            $("#add-category-modal-overlay-disable").css("display","block");



            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('.add-category-image')
                        .css('background', "linear-gradient(\n" +
                            "                    rgba(0, 0, 0, 0.45),\n" +
                            "                    rgba(0, 0, 0, 0.45)\n" +
                            "            ),url("+e.target.result+")  center/cover no-repeat");
                    var form = new FormData();
                    form.append("image", input.files[0]);
                    var settings = {
                        "async": true,
                        "crossDomain": true,
                        "url": "http://localhost:5005/upload",
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
                        $("#cat-url").val(json.data.link)
                        $("#cat-image").text("Change Image")
                        $("#add-category-modal-overlay-disable").css("display","none");
                    });


                };
                reader.readAsDataURL(input.files[0]);
            }


        }
}

function editCategoryImage(input){


    var FileSize = input.files[0].size / 1024/1024; // in MB
    if (FileSize > 2) {
        alert('File size exceeds 2 mb');
        $(input).val('');
    } else {

        $("#edit-category-modal-overlay-disable").css("display","block");
        $("#edit-cat-img").text('Uploading...');


        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.add-category-image')
                    .css('background', "linear-gradient(\n" +
                        "                    rgba(0, 0, 0, 0.45),\n" +
                        "                    rgba(0, 0, 0, 0.45)\n" +
                        "            ),url("+e.target.result+")  center/cover no-repeat");
                var form = new FormData();
                form.append("image", input.files[0]);
                var settings = {
                    "async": true,
                    "crossDomain": true,
                    "url": "http://localhost:5005/upload",
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
                    $("#edit-category-modal-overlay-disable").css("display","none");
                    $("#edit-cat-img").text('Change Image');
                    $("#edit-category-url").val(json.data.link)
                });


            };

            reader.readAsDataURL(input.files[0]);
        }


    }
}

function createCategory(url) {
    let name = $("#cat-name").val().trim();
    let image = $("#cat-url").val().trim();

    let data = {
        name:name,
        image:image,
    };


    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(data),
        dataType: 'json',
        success: function (response,data) {
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

function reloadpaage() {
    setTimeout(function() {
        var location = window.location;
        var neloc= location.toString().split("?");
        window.location = neloc[0];
        location.reload();
    }, 3000);
}


function removeCategory(url) {
    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
    });

}


function addProductCategory(){
    if($("#cat-id :selected").text() == ""){
        alert("No more categories")
    }else{
        $("#product-categories").append(`<h5><span name="categories" data-id='${$("#cat-id :selected").val()}' class="badge badge-secondary">${$("#cat-id :selected").text()} <i class="fad fa-times" onclick="removeProductCategory('${$("#cat-id :selected").text()}','${$("#cat-id :selected").val()}',this)"></i></span></h5>`)
        $("#cat-id :selected").remove();
        $("#prd-category").val($("#cat-id :selected").text())
    }
}


function removeProductCategory(category,val,th){
    $('#cat-id')
        .append($('<option>', { value : val })
            .text(category));
    $(th).parent().remove();
}

function addEditProductCategory(productId){
    if($("#"+productId+"-cat-id :selected").text() == ""){
        alert("No more categories")
    }else{
        $("#"+productId+"-product-categories").append(`<h5><span name="${productId}-categories" data-id='${$("#"+productId+"-cat-id :selected").val()}' class="badge badge-secondary">${$("#"+productId+"-cat-id :selected").text()} <i class="fad fa-times" onclick="removeEditProductCategory('${productId}','${$("#"+productId+"-cat-id :selected").text()}','${$("#"+productId+"-cat-id :selected").val()}',this)"></i></span></h5>`)
        $("#"+productId+"-cat-id :selected").remove();
        $("#"+productId+"-prd-category").val($("#"+productId+"-cat-id :selected").text())
    }
}


function removeEditProductCategory(productId,category,val,th){
    $('#'+productId+"-cat-id")
        .append($('<option>', { value : val })
            .text(category));
    $(th).parent().remove();
}

function initCategoryModal(name, url,categoryId){
    $("#edit-category-name").val(name);
    $("#edit-category-url").val(url);
    $("#edit-categoryId").val(categoryId);
    $('.add-category-image')
        .css('background', "linear-gradient(\n" +
            "                    rgba(0, 0, 0, 0.45),\n" +
            "                    rgba(0, 0, 0, 0.45)\n" +
            "            ),url("+url+")  center/cover no-repeat");
    $("#edit-category-modal").modal('toggle');
}


function initCategoryRemoveModal(categoryName, url){
    $("#remove-category-name").text(categoryName);
    $("#remove-category-form").attr('action', url);
    $("#remove-category-modal").modal('toggle');
}


function validateCatName(){
    let email = $("#cat-name").val().trim();
    if(email === ""){
        $("#cat-name").addClass("red-border")
        $("#cat-name-null").css("display","block");
    }else{
        $("#cat-name").removeClass("red-border")
        $("#cat-name-null").css("display","none");
        return true;
    }
    return false;
}




function validateCatImage(){
    let email = $("#cat-url").val().trim();
    if(email === ""){
        $("#cat-null").css("display","block");
    }else{
        $("#cat-null").css("display","none");
        return true;
    }
    return false;
}


function validateCatFields(){
    let validData = false;
    validData = validateCatName();
    validData= validateCatImage();
    return validData;
}

document.getElementById( 'add-category-form' ).addEventListener('submit', function(e) {
    if(!validateCatFields()){
        e.preventDefault();
    }else{
        $("#add-cat-submit").attr("disabled",true);
        $("#add-cat-submit").html("Submitting..");
    }
});



