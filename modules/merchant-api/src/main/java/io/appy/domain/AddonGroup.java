package io.appy.domain;

import java.util.List;

public class AddonGroup {

    String name;
    int maximimCount;
    Boolean isAddonMandatory;
    List<Addon> addons;

    public AddonGroup() {
    }

    public AddonGroup(String name, int maximimCount, Boolean isAddonMandatory, List<Addon> addons) {
        this.name = name;
        this.maximimCount = maximimCount;
        this.isAddonMandatory = isAddonMandatory;
        this.addons = addons;
    }

    public int getMaximimCount() {
        return maximimCount;
    }

    public void setMaximimCount(int maximimCount) {
        this.maximimCount = maximimCount;
    }

    public Boolean getAddonMandatory() {
        return isAddonMandatory;
    }

    public void setAddonMandatory(Boolean addonMandatory) {
        isAddonMandatory = addonMandatory;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Addon> getAddons() {
        return addons;
    }

    public void setAddons(List<Addon> addons) {
        this.addons = addons;
    }
}

