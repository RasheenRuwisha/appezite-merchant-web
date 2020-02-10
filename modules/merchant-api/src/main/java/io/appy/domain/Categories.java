package io.appy.domain;

import java.util.List;

public class Categories {

    List<Category> categories;

    public Categories() {
    }

    public Categories(List<Category> categories) {
        this.categories = categories;
    }

    public List<Category> getCategories() {
        return categories;
    }

    public void setCategories(List<Category> categories) {
        this.categories = categories;
    }
}
