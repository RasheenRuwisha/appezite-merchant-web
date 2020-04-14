package io.appy.domain;

public class CartAddons {
    String parent;
    String child;
    Double price;


    public CartAddons() {
    }

    public CartAddons(String parent, String child, Double price) {
        this.parent = parent;
        this.child = child;
        this.price = price;
    }

    public String getParent() {
        return parent;
    }

    public void setParent(String parent) {
        this.parent = parent;
    }

    public String getChild() {
        return child;
    }

    public void setChild(String child) {
        this.child = child;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}

