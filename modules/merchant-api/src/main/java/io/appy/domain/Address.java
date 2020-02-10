package io.appy.domain;

public class Address {

    String line1;
    String line2;
    String city;
    String street;
    String zip;

    public Address() {
    }

    public Address(String line1, String line2, String city, String street, String zip) {
        this.line1 = line1;
        this.line2 = line2;
        this.city = city;
        this.street = street;
        this.zip = zip;
    }

    public String getLine1() {
        return line1;
    }

    public void setLine1(String line1) {
        this.line1 = line1;
    }

    public String getLine2() {
        return line2;
    }

    public void setLine2(String line2) {
        this.line2 = line2;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getZip() {
        return zip;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }
}
