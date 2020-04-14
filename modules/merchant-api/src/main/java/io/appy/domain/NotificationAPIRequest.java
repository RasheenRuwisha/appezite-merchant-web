package io.appy.domain;

public class NotificationAPIRequest {

    String title;
    String msg;
    BusinessFullDetails businessFullDetails;

    public NotificationAPIRequest() {
    }

    public NotificationAPIRequest(String title, String msg, BusinessFullDetails businessFullDetails) {
        this.title = title;
        this.msg = msg;
        this.businessFullDetails = businessFullDetails;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public BusinessFullDetails getBusinessFullDetails() {
        return businessFullDetails;
    }

    public void setBusinessFullDetails(BusinessFullDetails businessFullDetails) {
        this.businessFullDetails = businessFullDetails;
    }
}
