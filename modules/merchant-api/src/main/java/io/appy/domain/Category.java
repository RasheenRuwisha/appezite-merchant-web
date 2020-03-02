package io.appy.domain;

import java.util.List;

public class Category {

    String docType;
    String image;
    String name;
    String categoryId;
    Boolean visibility;
    String businessId;

    public Category() {
    }


    public Category(String docType, String image, String name, String categoryId, Boolean visibility, String businessId) {
        this.docType = docType;
        this.image = image;
        this.name = name;
        this.categoryId = categoryId;
        this.visibility = visibility;
        this.businessId = businessId;
    }

    public String getDocType() {
        return docType;
    }

    public void setDocType(String docType) {
        this.docType = docType;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
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
