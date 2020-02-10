package io.appy.domain;

public class BusinessDetailResponse {


    String businessId;
    String name;
    String email;
    String country;
    String password;
    String phone;

    public BusinessDetailResponse() {
    }

    public BusinessDetailResponse(String businessId, String name, String email, String country, String password, String phone) {
        this.businessId = businessId;
        this.name = name;
        this.email = email;
        this.country = country;
        this.password = password;
        this.phone = phone;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
