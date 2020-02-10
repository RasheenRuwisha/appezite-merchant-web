package io.appy.domain;

public class LoginAjaxRes {

    String email;
    String businessId;
    String page;

    public LoginAjaxRes() {
    }

    public LoginAjaxRes(String email, String businessId, String page) {
        this.email = email;
        this.businessId = businessId;
        this.page = page;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }

    public String getPage() {
        return page;
    }

    public void setPage(String page) {
        this.page = page;
    }
}
