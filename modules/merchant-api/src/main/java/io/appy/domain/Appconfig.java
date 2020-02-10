package io.appy.domain;

public class Appconfig {

    String backgroundImage;
    String logo;
    String starterScreen;
    String icon;

    public Appconfig() {
    }

    public Appconfig(String backgroundImage, String logo, String starterScreen, String icon) {
        this.backgroundImage = backgroundImage;
        this.logo = logo;
        this.starterScreen = starterScreen;
        this.icon = icon;
    }

    public String getBackgroundImage() {
        return backgroundImage;
    }

    public void setBackgroundImage(String backgroundImage) {
        this.backgroundImage = backgroundImage;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getStarterScreen() {
        return starterScreen;
    }

    public void setStarterScreen(String starterScreen) {
        this.starterScreen = starterScreen;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }
}
