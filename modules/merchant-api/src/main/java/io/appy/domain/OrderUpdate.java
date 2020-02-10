package io.appy.domain;

public class OrderUpdate {
    String status;
    String orderId;

    public OrderUpdate() {
    }

    public OrderUpdate(String status, String orderId) {
        this.status = status;
        this.orderId = orderId;
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
}
