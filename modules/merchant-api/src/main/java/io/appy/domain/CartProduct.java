package io.appy.domain;

import java.util.List;

public class CartProduct {

    String name;
    String image;
    int quantity;
    Double price;
    String variant;
    Double variantPrice;
    List<CartAddons> addons;


    public CartProduct() {
    }

    public CartProduct(String name, String image, int quantity, Double price, String variant, Double variantPrice, List<CartAddons> addons) {
        this.name = name;
        this.image = image;
        this.quantity = quantity;
        this.price = price;
        this.variant = variant;
        this.variantPrice = variantPrice;
        this.addons = addons;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getVariant() {
        return variant;
    }

    public void setVariant(String variant) {
        this.variant = variant;
    }

    public Double getVariantPrice() {
        return variantPrice;
    }

    public void setVariantPrice(Double variantPrice) {
        this.variantPrice = variantPrice;
    }

    public List<CartAddons> getAddons() {
        return addons;
    }

    public void setAddons(List<CartAddons> addons) {
        this.addons = addons;
    }
}

