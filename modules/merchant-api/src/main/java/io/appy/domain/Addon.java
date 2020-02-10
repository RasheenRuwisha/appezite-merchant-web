package io.appy.domain;

public class Addon {

    String sku;
    int price;
    String name;

    public Addon() {
    }

    public Addon(String sku, int price, String name) {
        this.sku = sku;
        this.price = price;
        this.name = name;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
