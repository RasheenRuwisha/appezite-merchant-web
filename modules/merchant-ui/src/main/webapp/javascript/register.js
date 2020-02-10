
function validateFields(){
    if(validatePassword()){
        validData= validateConfirmPass();
    }
    return validateName() && validateEmail() && validatePhone() && validatePassword();
}

function validateName(){
    let name = $("#business-name").val().trim();
    if(name === ""){
        $("#business-name").addClass("red-border")
        $("#business-name-null").css("display","block");
    }else{
        $("#business-name").removeClass("red-border")
        $("#business-name-null").css("display","none");
        return true;
    }
    return false;
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

function validateConfirmPass(){
    let password = $("#business-password").val().trim();
    let confirmPassword = $("#business-confirm-password").val().trim();
    if(confirmPassword === ""){
        $("#business-confirm-password").addClass("red-border")
        $("#confrim-pass-null").css("display","block");
    }else{
        $("#business-confirm-password").removeClass("red-border")
        $("#confrim-pass-null").css("display","none");
        if(password !== confirmPassword){
            $("#business-confirm-password").addClass("red-border");
            $("#password-mismatch").css("display","block");
        }else{
            $("#business-confirm-password").removeClass("red-border");
            $("#password-mismatch").css("display","none");
            return true;
        }
    }
    return false;
}

function validatePhone(){
    let phone = $("#business-phone").val().trim();
    if(phone === ""){
        $("#business-phone").addClass("red-border")
        $("#phone-null").css("display","block");
    }else{
        $("#business-phone").removeClass("red-border")
        $("#phone-null").css("display","none");
        return true;
    }
    return false;
}





document.getElementById( 'register-form' ).addEventListener('submit', function(e) {
    let country = $("#business-phone").intlTelInput("getSelectedCountryData").name;
    let countryCode = $("#business-phone").intlTelInput("getSelectedCountryData").dialCode;

    $("#country").val(country);
    $("#countryCode").val(countryCode);
    $("#business-email").removeClass("red-border")
    $("#email-exist").css("display","none");
    if(!validateFields()){
        e.preventDefault();
    }
});
