package io.appy.domain;

import java.util.List;

public class BusinessFullDetails {

    String docType;
    String businessId;
    String country;
    String email;
    String name;
    Theme theme;
    Appconfig appconfig;
    Contact contact;
    String currency;
    String type;
    List<OpenHours> pickUpHours;
    List<OpenHours> deliveryHours;
    String description;
    Address address;
    String paypalSecret;
    Boolean deliveryEnabled;
    Boolean pickUpEnabled;
    List<DeliveryLocation> deliveryLocation;
    int orderPreparationTime;
    List<String> images;

    public BusinessFullDetails() {
    }

    public BusinessFullDetails(String docType, String businessId, String country, String email, String name, Theme theme, Appconfig appconfig, Contact contact, String currency, String type, List<OpenHours> pickUpHours, List<OpenHours> deliveryHours, String description, Address address, String paypalSecret, Boolean deliveryEnabled, Boolean pickUpEnabled, List<DeliveryLocation> deliveryLocation, int orderPreparationTime, List<String> images) {
        this.docType = docType;
        this.businessId = businessId;
        this.country = country;
        this.email = email;
        this.name = name;
        this.theme = theme;
        this.appconfig = appconfig;
        this.contact = contact;
        this.currency = currency;
        this.type = type;
        this.pickUpHours = pickUpHours;
        this.deliveryHours = deliveryHours;
        this.description = description;
        this.address = address;
        this.paypalSecret = paypalSecret;
        this.deliveryEnabled = deliveryEnabled;
        this.pickUpEnabled = pickUpEnabled;
        this.deliveryLocation = deliveryLocation;
        this.orderPreparationTime = orderPreparationTime;
        this.images = images;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public int getOrderPreparationTime() {
        return orderPreparationTime;
    }

    public void setOrderPreparationTime(int orderPreparationTime) {
        this.orderPreparationTime = orderPreparationTime;
    }

    public Boolean getPickUpEnabled() {
        return pickUpEnabled;
    }

    public void setPickUpEnabled(Boolean pickUpEnabled) {
        this.pickUpEnabled = pickUpEnabled;
    }

    public Boolean getDeliveryEnabled() {
        return deliveryEnabled;
    }

    public void setDeliveryEnabled(Boolean deliveryEnabled) {
        this.deliveryEnabled = deliveryEnabled;
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

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Theme getTheme() {
        return theme;
    }

    public void setTheme(Theme theme) {
        this.theme = theme;
    }

    public Appconfig getAppconfig() {
        return appconfig;
    }

    public void setAppconfig(Appconfig appconfig) {
        this.appconfig = appconfig;
    }

    public Contact getContact() {
        return contact;
    }

    public void setContact(Contact contact) {
        this.contact = contact;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<OpenHours> getPickUpHours() {
        return pickUpHours;
    }

    public void setPickUpHours(List<OpenHours> pickUpHours) {
        this.pickUpHours = pickUpHours;
    }

    public List<OpenHours> getDeliveryHours() {
        return deliveryHours;
    }

    public void setDeliveryHours(List<OpenHours> deliveryHours) {
        this.deliveryHours = deliveryHours;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public List<DeliveryLocation> getDeliveryLocation() {
        return deliveryLocation;
    }

    public void setDeliveryLocation(List<DeliveryLocation> deliveryLocation) {
        this.deliveryLocation = deliveryLocation;
    }

    public String getPaypalSecret() {
        return paypalSecret;
    }

    public void setPaypalSecret(String paypalSecret) {
        this.paypalSecret = paypalSecret;
    }
}
