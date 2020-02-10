package io.appy.domain;

public class Theme {

    String dark;
    String light;

    public Theme() {
    }

    public Theme(String dark, String light) {
        this.dark = dark;
        this.light = light;
    }

    public String getDark() {
        return dark;
    }

    public void setDark(String dark) {
        this.dark = dark;
    }

    public String getLight() {
        return light;
    }

    public void setLight(String light) {
        this.light = light;
    }
}
