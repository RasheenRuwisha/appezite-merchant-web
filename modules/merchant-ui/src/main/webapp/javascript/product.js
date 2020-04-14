let addongroupcount = 1;
let accaddongroupcount = 1;
let addonitemcount = [{name:1,count:1}];
let variantcount = 1;

function validateName(name){
    let email = $(`#${name}prd-name`).val().trim();
    if(email === ""){
        $(`#${name}prd-name`).addClass("red-border")
        $(`#${name}prd-name-null`).css("display","block");
    }else{
        $(`#${name}prd-name`).removeClass("red-border")
        $(`#${name}prd-name-null`).css("display","none");
        return true;
    }
    return false;
}

function validatePrice(name){
    let email = $(`#${name}prd-price`).val().trim();
    if(email === ""){
        $(`#${name}prd-price`).addClass("red-border")
        $(`#${name}prd-price-null`).css("display","block");
    }else{
        $(`#${name}prd-price`).removeClass("red-border");
        $(`#${name}prd-price-null`).css("display","none");
        return true;
    }
    return false;
}

function validateImage(name){
    let email = $(`#${name}prd-url`).val().trim();
    if(email === ""){
        $(`#${name}prd-null`).css("display","block");
    }else{
        $(`#${name}prd-null`).css("display","none");
        return true;
    }
    return false;
}

function validateData(name){
    return validateName(name) && validatePrice(name) && validateImage(name);
}

function updateProductImage(input){


    var FileSize = input.files[0].size / 1024/1024; // in MB
    if (FileSize > 2) {
        alert('File size exceeds 2 mb');
        $(input).val('');
    } else {

        $(".prd-image").html("Uploading...  <label id=\"progressbar\" class=\"custom-file-upload\">\n" +
            "                                    </label>");
        $("#add-prd-modal-overlay-disable").css("display","block");


        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.add-product-image')
                    .css('background', "linear-gradient(\n" +
                        "                    rgba(0, 0, 0, 0.45),\n" +
                        "                    rgba(0, 0, 0, 0.45)\n" +
                        "            ),url("+e.target.result+")  center/cover no-repeat");
                var form = new FormData();
                form.append("image", input.files[0]);
                var settings = {
                    "xhr": function() {
                        var xhr = new window.XMLHttpRequest();
                        var progressBar = $("#progressbar");
                        //Upload progress
                        xhr.upload.addEventListener("progress", function(evt) {
                            if (evt.lengthComputable) {
                                var percentComplete = (evt.loaded/evt.total)*100;
                                percentComplete = Math.floor(percentComplete);
                                console.log(percentComplete);
                                progressBar.css("width", percentComplete + "%");
                            }
                        }, false);
                        return xhr;
                    },
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
                    $("#prd-url").val(json.data.link)
                    $(".prd-image").html("Change Image  <label id=\"progressbar\" class=\"custom-file-upload\">\n" +
                        "                                    </label>");
                    $("#progressbar").css("width","0%")
                    $("#add-prd-modal-overlay-disable").css("display","none");


                });


            };

            reader.readAsDataURL(input.files[0]);
        }


    }
}

function editProductImage(input,id,overlay){

    var FileSize = input.files[0].size / 1024/1024; // in MB
    if (FileSize > 2) {
        alert('File size exceeds 2 mb');
        $(input).val('');
    } else {

        $(".prd-image").html("Uploading...  <label id=\"progressbar\" class=\"custom-file-upload\">\n" +
            "                                    </label>");
        $(overlay).css("display","block");


        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.add-product-image')
                    .css('background', "linear-gradient(\n" +
                        "                    rgba(0, 0, 0, 0.45),\n" +
                        "                    rgba(0, 0, 0, 0.45)\n" +
                        "            ),url("+e.target.result+")  center/cover no-repeat");
                var form = new FormData();
                form.append("image", input.files[0]);
                var settings = {
                    "xhr": function() {
                        var xhr = new window.XMLHttpRequest();
                        var progressBar = $("#progressbar");
                        //Upload progress
                        xhr.upload.addEventListener("progress", function(evt) {
                            if (evt.lengthComputable) {
                                var percentComplete = (evt.loaded/evt.total)*100;
                                percentComplete = Math.floor(percentComplete);
                                console.log(percentComplete);
                                progressBar.css("width", percentComplete + "%");
                            }
                        }, false);
                        return xhr;
                    },
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
                    $(id).val(json.data.link)
                    $(".prd-image").html("Change Image  <label id=\"progressbar\" class=\"custom-file-upload\">\n" +
                        "                                    </label>");
                    $("#progressbar").css("width","0%")
                    $(overlay).css("display","none");


                });


            };

            reader.readAsDataURL(input.files[0]);
        }


    }
}

$('#add-product-form').on('submit', function(e) {
    e.preventDefault();
});

function createProduct(url,businessId) {
    if(validateData("")){
        $("#submit-prd-btn").attr("disabled",true);
        $("#submit-prd-btn").html("Submitting..");

        let name = $("#prd-name").val().trim();
        let price = $("#prd-price").val().trim();
        let image = $("#prd-url").val().trim();
        let description = $("#product-desciption").val().trim();
        let categoryId = [];

        let addonsgroups = [];
        let addongroup = {name:"",maximimCount:"",addonMandatory:false,addons:[]};
        let addon = {sku:"!",name:"",price:""};

        $(`span[name=categories]`).each(function() {
            categoryId.push($(this).data("id"));
        });

        alert(addonitemcount)
        if(addonitemcount.length === 1){
            if($(`.addon-group-${addonitemcount[0].name}`).val() === undefined){
                addonsgroups = null;
            }else{
                for(var i=0;i<addonitemcount.length;i++){
                    addongroup = {name:"",addons:[]};
                    addongroup.name = $(`.addon-group-${addonitemcount[i].name}`).val()
                    for(var z=1;z<=addonitemcount[i].count;z++){
                        addon = {sku:"!",name:"",price:""};
                        addon.name = $(`#addon-group-${addonitemcount[i].name}-item-${z}-name`).val();
                        addon.price = $(`#addon-group-${addonitemcount[i].name}-item-${z}-price`).val();
                        if(addon.name != undefined){
                            if( addon.name.trim() != ""){
                                addongroup.addons.push(addon);
                            }
                        }
                    }
                    addonsgroups.push(addongroup)
                }
            }
        }else{
            for(var i=0;i<addonitemcount.length;i++){
                addongroup = {name:"",addons:[]};
                addongroup.name = $(`.addon-group-${addonitemcount[i].name}-VAL`).val()
                var chkBox = document.getElementById(`addon-group-${addonitemcount[i].name}-Mandatory`);
                addongroup.addonMandatory = chkBox.checked
                addongroup.maximimCount = $(`#addon-group-${addonitemcount[i].name}-COUNT`).val()


                for(var z=1;z<=addonitemcount[i].count;z++){
                    addon = {sku:"!",name:"",price:""};
                    addon.name = $(`#addon-group-${addonitemcount[i].name}-item-${z}-name`).val();
                    addon.price = $(`#addon-group-${addonitemcount[i].name}-item-${z}-price`).val();
                    if(addon.name != undefined){
                        if( addon.name.trim() != ""){
                            addongroup.addons.push(addon);
                        }
                    }
                }
                addonsgroups.push(addongroup)
            }
        }

        let variant = {name:"",price:""};
        let variantGroup = {name:"",variants:[]};

        let variantIndex = [];

        $(`.add-product-variant-items`).each(function() {
            variantIndex.push(parseInt($(this).data("index")));
        });


        if(variantIndex.length === 1){
            let variantName = $("#variant-name").val();
            if(variantName != ""){
                variantGroup.name = variantName;
                variant.name = $(`#variant-item-1-name`).val();
                variant.price = $(`#variant-item-1-price`).val();
                variantGroup.variants.push(variant);
            }
        }else{
            let variantName = $("#variant-name").val();
            variantGroup.name = variantName;
            for(var i =1; i<=variantIndex.length;i++){
                variant.name = $(`#variant-item-${variantIndex[i-1]}-name`).val();
                variant.price = $(`#variant-item-${variantIndex[i-1]}-price`).val();
                if(variant.name != "" && variant.price != ""){
                    variantGroup.variants.push(variant);
                }
                variant = {name:"",price:""};
            }
        }

        let data = {
            businessId:businessId,
            variant:variantGroup,
            addons:addonsgroups,
            name:name,
            image:image,
            price:price,
            visibility:true,
            isAddonMandatory:false,
            categoryId:categoryId,
            description:description,
            docType:"Product"
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
}

function updateProduct(url,productId,businessId) {
    if(validateData(productId)) {
        $("#"+productId+"-submit-prd-btn").attr("disabled",true);
        $("#"+productId+"-submit-prd-btn").html("Updating..");

        let name = $("#"+productId+"prd-name").val().trim();
        let price = $("#"+productId+"prd-price").val().trim();
        let image = $("#"+productId+"prd-url").val().trim();
        let description = $("#"+productId+"-product-desciption").val().trim();

        let categoryId =[];



        $(`span[name=${productId}-categories]`).each(function() {
            categoryId.push($(this).data("id"));
        });

        let addonsgroups = [];
        let addongroup = {name:"",maximimCount:"",addonMandatory:false,addons:[]};
        let addon = {sku:"!",name:"",price:""};

        let addongroupnames = [];
        addongroupcount = 0;

        $(`.${productId}-addon-group`).each(function() {
            addongroupcount += 1;
            addongroupnames.push(this.id)
        });

        console.log(addongroupnames)
        if(addongroupcount === 1){
            if($(`.${productId}-addon-group-1`).val() === ""){
                addonsgroups = null;
            }else{
                for(var i=1;i<=addongroupnames.length;i++){
                    zindex = [];
                    addongroup = {name:"",addons:[]};
                    addongroup.name = $(`.${addongroupnames[i-1]}-GROUPNAME`).val();
                    $(`.${productId}-addon-group-items${i}`).each(function() {
                        zindex.push($(this).data("index") );
                    });
                    for(var z=1;z<=zindex.length;z++){
                        addon = {sku:"!",name:"",price:""};
                        addon.name = $(`#${addongroupnames[i-1]}-item-${zindex[z-1]}-name`).val();
                        addon.price = $(`#${addongroupnames[i-1]}-item-${zindex[z-1]}-price`).val();
                        if(addon.name.trim() !== ""){
                            addongroup.addons.push(addon);
                        }
                    }
                    addonsgroups.push(addongroup)
                }
            }
        }else{
            for(var i=1;i<=addongroupnames.length;i++){
                zindex = [];
                addongroup = {name:"",addons:[]};
                addongroup.name = $(`.${addongroupnames[i-1]}-GROUPNAME`).val();
                var chkBox = document.getElementById(`${addongroupnames[i-1]}-Mandatory`);
                addongroup.addonMandatory = chkBox.checked
                addongroup.maximimCount = $(`#${addongroupnames[i-1]}-COUNT`).val()
                let index2 = addongroupnames[i-1].split("-");
                $(`.${productId}-addon-group-items${index2[3]}`).each(function() {
                    zindex.push($(this).data("index") );
                });
                console.log(zindex);
                console.log(addongroupnames)
                for(var z=1;z<=zindex.length;z++){
                    addon = {sku:"!",name:"",price:""};
                    addon.name = $(`#${addongroupnames[i-1]}-item-${zindex[z-1]}-name`).val();
                    addon.price = $(`#${addongroupnames[i-1]}-item-${zindex[z-1]}-price`).val();
                    if(addon.name.trim() != ""){
                        addongroup.addons.push(addon);
                    }
                }
                addonsgroups.push(addongroup)
            }
        }

        let variant = {name:"",price:""};
        let variantGroup = {name:"",variants:[]};
        let variantIndex = [];

        $(`.${productId}-variant-groups`).each(function() {
            variantIndex.push(parseInt($(this).data("index")));
        });

        if(variantIndex.length === 1){
            let variantName = $(`#${productId}-variant-name`).val();
            if(variantName != ""){
                variantGroup.name = variantName;
                variant.name = $(`#${productId}-variant-item-0-name`).val();
                variant.price = $(`#${productId}-variant-item-0-price`).val();
                if(variant.name != "" && variant.price != ""){
                    alert("ass")
                    variantGroup.variants.push(variant);
                }
            }
        }else{
            let variantName = $(`#${productId}-variant-name`).val();
            variantGroup.name = variantName;
            for(var i =1; i<=variantIndex.length;i++){
                variant.name = $(`#${productId}-variant-item-${variantIndex[i-1]}-name`).val();
                variant.price = $(`#${productId}-variant-item-${variantIndex[i-1]}-price`).val();
                if(variant.name != "" && variant.price != ""){
                    variantGroup.variants.push(variant);
                }
                variant = {name:"",price:""};
            }
        }

        let data = {
            businessId:businessId,
            variant:variantGroup,
            addons:addonsgroups,
            productId:productId,
            name:name,
            image:image,
            price:price,
            visibility:true,
            isAddonMandatory:false,
            categoryId:categoryId,
            description:description,
            docType:"Product"
        };

        console.log(data)
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
}

function removeProduct(url) {
    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
    });

}

function openSelect() {
    $(this).closest(".input-wrapper").find("input").focus();

    "use strict";
        $.fn.openSelect = function() {
            return this.each(function(idx, domEl) {
                if (document.createEvent) {
                    var event = document.createEvent("MouseEvents");
                    event.initMouseEvent("mousedown", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                    domEl.dispatchEvent(event);
                } else if (element.fireEvent) {
                    domEl.fireEvent("onmousedown");
                }
            });
        }
        $("#cat-id").openSelect();
}

function openEditelect(id) {
    $(this).closest(".input-wrapper").find("input").focus();

    "use strict";
    $.fn.openSelect = function() {
        return this.each(function(idx, domEl) {
            if (document.createEvent) {
                var event = document.createEvent("MouseEvents");
                event.initMouseEvent("mousedown", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                domEl.dispatchEvent(event);
            } else if (element.fireEvent) {
                domEl.fireEvent("onmousedown");
            }
        });
    }
    $(id).openSelect();
}

function reloadpaage() {
    setTimeout(function() {
        var location = window.location;
        var neloc= location.toString().split("?");
        window.location = neloc[0];
        location.reload();
    }, 3000);
}

function createNewVariant(){
    count = 0;
    $(`.add-product-variant-items`).each(function() {
        count = parseInt($(this).data("index")) +1
    });
    $("#variant-groups").append(

        `

<div data-index="${count}" class="variant-items add-variant-group-${count} add-product-variant-items">

                                <div class="form-group">
                                    <input class="form-control" type="text" name="variant-item-${count}-name" id="variant-item-${count}-name">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" type="text" name="variant-item-${count}-price" id="variant-item-${count}-price">
                                </div>
                            <i style="color:#d93025" class="fas fa-trash-alt addon-delete" onclick="removeAddonFroup('.add-variant-group-${count}')"></i>


                            </div>
        `

    )
}

function createNewEditVariant(productId){
    count = 0;
    $(`.${productId}-variant-groups`).each(function() {
        count = parseInt($(this).data("index")) +1
    });

    $(`#${productId}-variant-groups`).append(

        `
<div data-index="${count}" class="${productId}-variant-items v-items ${productId}-variant-groups ${productId}-variant-group-${count}">
            <div class="form-group">
                                                    <label for="variant-item-1-name">Name</label>
                                                    <input class="form-control" type="text" id="${productId}-variant-item-${count}-name">
                                                </div>
                                                <div class="form-group">
                                                    <label for="variant-item-1-price">Price</label>
                                                    <input class="form-control" type="text"  id="${productId}-variant-item-${count}-price">
                                                </div>
           
                  <i style="color:#d93025" class="fas fa-trash-alt addon-delete" onclick="removeAddonFroup('.${productId}-variant-group-${count}')"></i>

                            </div>
        `

    )
}





























function createNewAddonGroup(){
    addongroupcount += 1;
    addonitemcount.push({name:addongroupcount,count: 1});

    $(".addon-group").append(`  
  <div class="addon-group-${addongroupcount}"> 
  <div class="form-group"  onclick='showAddonGroup("#addon-group-${addongroupcount}-items")'>
                                            <input class="form-control addon-group-${addongroupcount}-VAL" type="text">
                                        </div>
</div>`)

    $(".addon-setting").append(`      <div class="addongrp-items  addon-group-${addongroupcount}" id="addon-group-${addongroupcount}-items">
                                              <i style="margin:0px 0px 15px 0px;color:#d93025" class="fas fa-trash-alt" onclick="removeAddAddonGroup('.addon-group-${addongroupcount}', '${addongroupcount}')"></i>

 <div class="addon-count">
                                         <span style="padding-top: 14px;">Maximum Selections Allowed</span>

 <div class="form-group">
                                            <input class="form-control" type="text" name="addon-group-${addongroupcount}-COUNT" id="addon-group-${addongroupcount}-COUNT">
                                        </div>
        
                                    </div>

 <div class="addon-count">
                                    <label> Is Addon Mandatory</label>
                                    <input type="checkbox" name="addon-group-${addongroupcount}-Mandatory" id="addon-group-${addongroupcount}-Mandatory">
</div>
                                    <br>


      <div class="addon-items " id="addon-group-items1">
      
         <div class="form-group">
                                            <label for="addon-group-1-item-1-name">Name</label>
                                            <input class="form-control" type="text" name="addon-group-${addongroupcount}-item-1-name" id="addon-group-${addongroupcount}-item-1-name">
                                        </div>
                                     
                                      <div class="form-group">
                                            <label for="addon-group-1-item-1-price">Price</label>
                                            <input class="form-control" type="text" name="addon-group-${addongroupcount}-item-1-price" id="addon-group-${addongroupcount}-item-1-price">
                                        </div>
                                            
                                    </div>
                                      <button class="btn btn-outline-secondary" onclick="createNewAddonItem('#addon-group-${addongroupcount}-items',${addongroupcount})">
                                        Add new group
                                    </button>
                                        </div>


`)

    showAddonGroup(`#addon-group-${addongroupcount}-items`)
}


function createNewAddonItem(id,item){
    count = 0;
    for(var i =0;i<addonitemcount.length;i++){
        if(addonitemcount[i].name === item){
            addonitemcount[i].count += 1;
            count = addonitemcount[i].count;
        }
    }
    $(
            `<div class="addon-items " id="addon-group-items${count}${item}">

      <div class="form-group">
                                            <input class="form-control" type="text" name="addon-group-${item}-item-${count}-name" id="addon-group-${item}-item-${count}-name">
                                        </div>

                                        <div class="form-group">
                                            <input class="form-control" type="text" name="addon-group-${item}-item-${count}-price" id="addon-group-${item}-item-${count}-price">
                                        </div>
                               
                                 <i style="color:#d93025" class="fas fa-trash-alt addon-delete" onclick="removeAddonFroup('#addon-group-items${count}${item}')"></i>

                                    </div>
            `,
    ).insertBefore(`${id} button`)
}


function createNewEditAddonGroup(count,productId){
    $(`.${productId}-addon-group`).each(function() {
        count = parseInt($(this).data("index")) +1
    });
    $(`.${productId}-addon-groups`).append(`      
        
      <div data-index="${count+1}" id="${productId}-addon-group-${count+1}"  class="${productId}-addon-group ${productId}-addon-group-${count+1}">
                                                    <div class="input-wrapper hasValue" onclick='showAddonGroup("#${productId}-addon-group-${count+1}-items")'>
                                                        <input type="text" name="prd-price" class="${productId}-addon-group-${count+1}-GROUPNAME"">
                                                        <div class="input-placeholder" style="left: 19px !important;"><span>Addon Group Name</span></div>
                                                    </div>
                                                </div>`)

    $(`.${productId}-addon-setting`).append(`    <div id="${productId}-addon-group-${count+1}-items"  class="addongrp-items ${productId}-addon-group-${count+1}">
                                        <i style="margin:0px 0px 15px 0px;color:#d93025" class="fas fa-trash-alt addon-delete" onclick="removeAddAddonGroup('.${productId}-addon-group-${count+1}')"></i>

<div class="addon-count">
                                         <span style="padding-top: 14px;">Maximum Selections Allowed</span>
  <div class="input-wrapper hasValue">
                                        <input type="text" name="prd-price" id="${productId}-addon-group-${count+1}-COUNT">
                                        <div class="input-placeholder" style="left: 35px !important;"><span>Count</span></div>
                                    </div>
</div>
<div class="addon-count">
                                    <label> Is Addon Mandatory</label>
                                    <input type="checkbox" name="${productId}-addon-group-${count+1}-Mandatory" id="${productId}-addon-group-${count+1}-Mandatory">
</div>
                                    <br>
                                    
                                                        <div data-index="1" class="addon-items ${productId}-addon-group-items ${productId}-addon-group-items${count+1}" id="${productId}-addon-group-items1">
                                                            <div class="input-wrapper hasValue">
                                                                <input type="text" name="prd-price" id="${productId}-addon-group-${count+1}-item-1-name">
                                                                <div class="input-placeholder" style="left: 19px !important;"><span>Name</span></div>
                                                            </div>

                                                            <div class="input-wrapper hasValue">
                                                                <input type="text" name="prd-price" id="${productId}-addon-group-${count+1}-item-1-price">
                                                                <div class="input-placeholder" style="left: 35px !important;"><span>Price</span></div>
                                                            </div>
                                                        </div>
                                                         <button class="btn btn-outline-secondary" onclick="createNewEditAddonItem('#${productId}-addon-group-${count+1}-items',1,'${productId}',${count+1})">
                                                    Add new group
                                                </button>
                                                </div>
 

`)

    showAddonGroup(`#${productId}-addon-group-${count+1}-items`)
}


function createNewEditAddonItem(id,item,productId,index){
    nxCount = 1
    $(`.${productId}-addon-group-items${index}`).each(function() {
        nxCount = parseInt($(this).data("index")) +1
    });
    $(
        `
<div data-index="${nxCount}" class="addon-items ${productId}-addon-group-items ${productId}-addon-group-items${index}" id="${productId}-addon-group-items${nxCount}${index}">
                                   
                                    <div class="form-group">
                                                                        <label>Name</label>
                                                                        <input class="form-control" type="text" name="prd-price" id="${productId}-addon-group-${index}-item-${nxCount}-name">
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label>Price</label>
                                                                        <input class="form-control" type="text" name="prd-price" id="${productId}-addon-group-${index}-item-${nxCount}-price">
                                                                    </div>
                                                                    
                                    
                                    <i style="color:#d93025" class="fas fa-trash-alt addon-delete" onclick="removeAddonFroup('#${productId}-addon-group-items${nxCount}${index}')"></i>
                                    </div>
            `
    ).insertBefore(`${id} button`)
}


function showAddonGroup(id){
    $(".addongrp-items").css("display","none");
    $(id).css("display","block");
}

function removeAddonFroup(id){
    $(id).remove();
}
function removeAddAddonGroup(id,index) {
    $(id).remove();
    addonitemcount.splice(index-1,1);
    accaddongroupcount-=1;
}


function initProductRemoveModal(categoryName, url){
    $("#remove-product-name").text(categoryName);
    $("#remove-product-form").attr('action', url);
    $("#remove-product-modal").modal('toggle');
}



function submitCsvForm(){
    $("#csv-upload").submit()
    $("#product-batch-overlay").addClass('batch-overlay-visible')
}

function submitCsvForm2(){
    $("#csv-upload-2").submit()
    $("#product-batch-overlay").addClass('batch-overlay-visible')
}

function submitJsonForm(){
    $("#json-upload").submit()
    $("#product-batch-overlay").addClass('batch-overlay-visible')
}