function submitForm(){

}


function validateFields(){
    let validData = false;
    validData = validateEmail();
    validData= validatePassword();
    return validData;
}

function validateEmail(){
    let email = $("#business-email").val().trim();
    if(email === ""){
        $("#business-email").addClass("red-border")
        $("#email-null").css("display","block");
    }else{
        $("#business-email").removeClass("red-border")
        $("#email-null").css("display","none");
        return true;
    }
    return false;
}

function validatePassword(){
    let password = $("#business-password").val().trim();
    if(password === ""){
        $("#business-password").addClass("red-border")
        $("#password-null").css("display","block");
    }else{
        $("#business-password").removeClass("red-border")
        $("#password-null").css("display","none");
        return true;
    }
    return false;
}

function createBusiness(url){
    $("#business-email").removeClass("red-border")
    $("#email-exist").css("display","none");
    if(validateFields()){
        login(url)
    }
}

document.getElementById( 'login-form' ).addEventListener('submit', function(e) {
    if(!validateFields()){
        e.preventDefault();
    }else{
        $("#login-overlay").css("visibility","visible")
    }
});


function login(url){
    let email = $("#business-email").val().trim();
    let password = $("#business-password").val().trim();

    let data = {
        j_username:email,
        j_password:password,
    };


    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(data),
        dataType: 'json',
        success: function (response,data) {
                window.location = response.page
        },
        error: function (error) {
            console.log("error")

            console.log(error)
                window.location = response.page
        }
    });

}