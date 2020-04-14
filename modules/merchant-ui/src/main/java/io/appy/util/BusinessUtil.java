package io.appy.util;

import io.appy.api.BusinessApiClient;
import io.appy.api.impl.BusinessApiClientImpl;
import io.appy.domain.BusinessFullDetails;
import io.appy.domain.Category;
import io.appy.domain.Product;
import io.appy.domain.ProductJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.security.SecureRandom;
import java.util.List;
import java.util.stream.Collectors;

public class BusinessUtil {

    public static String generateRandomString(int length, String prefix) {
        if (length < 1) throw new IllegalArgumentException();
        SecureRandom random = new SecureRandom();
        final String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
        final String CHAR_UPPER = CHAR_LOWER.toUpperCase();
        final String NUMBER = "0123456789";

        final String DATA_FOR_RANDOM_STRING = CHAR_LOWER + CHAR_UPPER + NUMBER;
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {

            // 0-62 (exclusive), random returns 0-61
            int rndCharAt = random.nextInt(DATA_FOR_RANDOM_STRING.length());
            char rndChar = DATA_FOR_RANDOM_STRING.charAt(rndCharAt);

            // debug
            System.out.format("%d\t:\t%c%n", rndCharAt, rndChar);

            sb.append(rndChar);

        }

        return prefix + sb.toString();

    }

    /**
     * This function checks for duplicate categories from the businesss categories
     * @param businessFullDetails
     * @param businessId
     * @param categories
     * @param name
     * @return boolean
     */
    public boolean findDuplicateCategories(BusinessFullDetails businessFullDetails, String businessId, List<Category> categories, String name){
        for (Category category: categories){
            if(category.getName().equals(name)){
                return false;
            }
        }
        return true;
    }



    /**
     * This function creates a new product object from the passed details
     * @param product
     * @param jsonProduct
     * @param businessId
     * @return Product product
     */
    public Product genProductObject(Product product, ProductJson jsonProduct, String businessId){
        product.setProductId(generateRandomString(10,"PRD_"));
        product.setAddons(jsonProduct.getAddons());
        product.setVisibility(true);
        product.setDocType("Product");
        product.setDescription(jsonProduct.getDescription());
        product.setVariant(jsonProduct.getVariant());
        product.setName(jsonProduct.getName());
        product.setImage(jsonProduct.getImage());
        product.setPrice(jsonProduct.getPrice());
        product.setBusinessId(businessId);
        return product;
    }


}
