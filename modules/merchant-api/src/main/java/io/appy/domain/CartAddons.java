package io.appy.domain;

public class CartAddons {
    String parent;
    String child;
    int price;


    public CartAddons() {
    }

    public CartAddons(String parent, String child, int price) {
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

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
}

