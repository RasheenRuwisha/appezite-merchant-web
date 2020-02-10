package io.appy.domain;

import java.util.List;

public class VariantGroup {

    String name;
    List<Variant> variants;

    public VariantGroup() {
    }

    public VariantGroup(String name, List<Variant> variants) {
        this.name = name;
        this.variants = variants;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Variant> getVariants() {
        return variants;
    }

    public void setVariants(List<Variant> variants) {
        this.variants = variants;
    }
}
