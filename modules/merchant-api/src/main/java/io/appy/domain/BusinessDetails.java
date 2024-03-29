package io.appy.domain;

public class BusinessDetails {

    String businessId;
    String name;
    String email;
    String country;
    String password;
    String phone;
    String countryCode;

    public BusinessDetails() {
    }

    public BusinessDetails(String businessId, String name, String email, String country, String password, String phone, String countryCode) {
        this.businessId = businessId;
        this.name = name;
        this.email = email;
        this.country = country;
        this.password = password;
        this.phone = phone;
        this.countryCode = countryCode;
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

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }
}
