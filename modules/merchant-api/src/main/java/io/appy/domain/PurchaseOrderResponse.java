package io.appy.domain;

import java.util.Date;
import java.util.List;

public class PurchaseOrderResponse {

    String purchaseId;
    String businessId;
    String customerEmail;
    List<CartProduct> products;
    String orderedAt;
    String orderReadyBy;
    String deliveryType;
    String notes;
    String deliveryAddress;
    String customerName;
    String platfrom;
    String status;


    public PurchaseOrderResponse() {
    }

    public PurchaseOrderResponse(String purchaseId, String businessId, String customerEmail, List<CartProduct> products, String orderedAt, String orderReadyBy, String deliveryType, String notes, String deliveryAddress, String customerName, String platfrom, String status) {
        this.purchaseId = purchaseId;
        this.businessId = businessId;
        this.customerEmail = customerEmail;
        this.products = products;
        this.orderedAt = orderedAt;
        this.orderReadyBy = orderReadyBy;
        this.deliveryType = deliveryType;
        this.notes = notes;
        this.deliveryAddress = deliveryAddress;
        this.customerName = customerName;
        this.platfrom = platfrom;
        this.status = status;
    }

    public String getPurchaseId() {
        return purchaseId;
    }

    public void setPurchaseId(String purchaseId) {
        this.purchaseId = purchaseId;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public List<CartProduct> getProducts() {
        return products;
    }

    public void setProducts(List<CartProduct> products) {
        this.products = products;
    }

    public String getOrderedAt() {
        return orderedAt;
    }

    public void setOrderedAt(String orderedAt) {
        this.orderedAt = orderedAt;
    }

    public String getOrderReadyBy() {
        return orderReadyBy;
    }

    public void setOrderReadyBy(String orderReadyBy) {
        this.orderReadyBy = orderReadyBy;
    }

    public String getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(String deliveryType) {
        this.deliveryType = deliveryType;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPlatfrom() {
        return platfrom;
    }

    public void setPlatfrom(String platfrom) {
        this.platfrom = platfrom;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
