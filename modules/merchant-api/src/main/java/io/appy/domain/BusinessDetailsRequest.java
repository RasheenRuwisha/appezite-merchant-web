package io.appy.domain;

public class BusinessDetailsRequest {

    String businessId;

    public BusinessDetailsRequest() {
    }

    public BusinessDetailsRequest(String businessId) {
        this.businessId = businessId;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }
}
