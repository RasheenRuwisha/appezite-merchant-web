package io.appy.domain;

import java.util.List;

public class JSONProducts {

    List<ProductJson> products;

    public JSONProducts() {
    }

    public JSONProducts(List<ProductJson> products) {
        this.products = products;
    }

    public List<ProductJson> getProducts() {
        return products;
    }

    public void setProducts(List<ProductJson> products) {
        this.products = products;
    }
}
