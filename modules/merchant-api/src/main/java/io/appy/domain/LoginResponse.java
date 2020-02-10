package io.appy.domain;

public class LoginResponse {

    String businessId;
    String email;
    String phone;
    String password;
    String status;

    public LoginResponse() {
    }

    public LoginResponse(String businessId, String email, String phone, String password, String status) {
        this.businessId = businessId;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.status = status;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
