package io.appy.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;
import java.util.List;

public class PurchaseOrders {

    String purchaseId;
    String businessId;
    String customerEmail;
    List<CartProduct> products;
    @JsonFormat(pattern="dd-MM-yyyy HH:mm")
    Date orderedAt;
    @JsonFormat(pattern="dd-MM-yyyy HH:mm")
    Date orderReadyBy;
    String deliveryType;
    String notes;
    String deliveryAddress;
    String customerName;
    String platfrom;
    String status;
    String customerNumber;
    Double total;
    Double deliveryCharge;
    public PurchaseOrders() {
    }

    public PurchaseOrders(String purchaseId, String businessId, String customerEmail, List<CartProduct> products, Date orderedAt, Date orderReadyBy, String deliveryType, String notes, String deliveryAddress, String customerName, String platfrom, String status, String customerNumber, Double total, Double deliveryCharge) {
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
        this.customerNumber = customerNumber;
        this.total = total;
        this.deliveryCharge = deliveryCharge;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getDeliveryCharge() {
        return deliveryCharge;
    }

    public void setDeliveryCharge(Double deliveryCharge) {
        this.deliveryCharge = deliveryCharge;
    }

    public String getCustomerNumber() {
        return customerNumber;
    }

    public void setCustomerNumber(String customerNumber) {
        this.customerNumber = customerNumber;
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

    public Date getOrderedAt() {
        return orderedAt;
    }

    public void setOrderedAt(Date orderedAt) {
        this.orderedAt = orderedAt;
    }

    public Date getOrderReadyBy() {
        return orderReadyBy;
    }

    public void setOrderReadyBy(Date orderReadyBy) {
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
