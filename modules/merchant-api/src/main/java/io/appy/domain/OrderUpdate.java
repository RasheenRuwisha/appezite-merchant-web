package io.appy.domain;

public class OrderUpdate {
    String status;
    String orderId;
    String businessName;

    public OrderUpdate() {
    }

    public OrderUpdate(String status, String orderId, String businessName) {
        this.status = status;
        this.orderId = orderId;
        this.businessName = businessName;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBusinessName() {
        return businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }
}
