package io.appy.domain;

public class DeliveryLocation {

    String state;
    String city;
    int price;
    String deliveryTime;

    public DeliveryLocation() {
    }

    public DeliveryLocation(String state, String city, int price, String deliveryTime) {
        this.state = state;
        this.city = city;
        this.price = price;
        this.deliveryTime = deliveryTime;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }
}
