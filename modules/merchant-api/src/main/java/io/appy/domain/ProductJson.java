package io.appy.domain;

import java.util.List;

public class ProductJson {

    String productId;
    String name;
    List<JsonCategories> categories;
    String image;
    Boolean visibility;
    Double price;
    VariantGroup variant;
    List<AddonGroup> addons;
    String description;
    String businessId;
    String docType;


    public ProductJson() {
    }

    public ProductJson(String productId, String name, List<JsonCategories> categories, String image, Boolean visibility, Double price, VariantGroup variant, List<AddonGroup> addons, String description, String businessId, String docType) {
        this.productId = productId;
        this.name = name;
        this.categories = categories;
        this.image = image;
        this.visibility = visibility;
        this.price = price;
        this.variant = variant;
        this.addons = addons;
        this.description = description;
        this.businessId = businessId;
        this.docType = docType;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<JsonCategories> getCategories() {
        return categories;
    }

    public void setCategories(List<JsonCategories> categories) {
        this.categories = categories;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Boolean getVisibility() {
        return visibility;
    }

    public void setVisibility(Boolean visibility) {
        this.visibility = visibility;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public VariantGroup getVariant() {
        return variant;
    }

    public void setVariant(VariantGroup variant) {
        this.variant = variant;
    }

    public List<AddonGroup> getAddons() {
        return addons;
    }

    public void setAddons(List<AddonGroup> addons) {
        this.addons = addons;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }

    public String getDocType() {
        return docType;
    }

    public void setDocType(String docType) {
        this.docType = docType;
    }
}
