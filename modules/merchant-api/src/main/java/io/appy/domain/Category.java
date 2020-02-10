package io.appy.domain;

import java.util.List;

public class Category {

    String docType;
    String image;
    String name;
    String categoryId;
    Boolean visibility;

    public Category() {
    }

    public Category(String docType, String image, String name, String categoryId, Boolean visibility) {
        this.docType = docType;
        this.image = image;
        this.name = name;
        this.categoryId = categoryId;
        this.visibility = visibility;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public Boolean getVisibility() {
        return visibility;
    }

    public void setVisibility(Boolean visibility) {
        this.visibility = visibility;
    }

}
