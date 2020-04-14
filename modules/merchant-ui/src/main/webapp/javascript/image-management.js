
function updloadNewBusinessImage(input){


    var FileSize = input.files[0].size / 1024/1024; // in MB
    if (FileSize > 2) {
        alert('File size exceeds 2 mb');
        $(input).val('');
    } else {

        $(".business-image").html("Uploading...  <label id=\"progressbar\" class=\"custom-file-upload\">\n" +
            "                                    </label>");
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                var form = new FormData();
                form.append("image", input.files[0]);
                var settings = {
                    "xhr": function() {
                        var xhr = new window.XMLHttpRequest();
                        var progressBar = $("#progressbar");
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
                    $("#business-image-url").val(json.data.link)
                    $(".business-image").html("Change Image  <label id=\"progressbar\" class=\"custom-file-upload\">\n" +
                        "                                    </label>");
                    submitImage()
                });


            };

            reader.readAsDataURL(input.files[0]);
        }


    }
}

function submitImage(){
    $("#image-form").submit()
}