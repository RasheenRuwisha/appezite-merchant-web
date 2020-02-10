package io.appy.api;

import io.appy.domain.*;

import java.util.Date;
import java.util.List;

public interface BusinessApiClient {

    BusinessDetailResponse createBusiness(BusinessDetails businessDetails);

    LoginResponse loginUser(LoginDetails loginDetails);

    BusinessFullDetails getBusinessDetails(String businessId);

    BusinessFullDetails updateBusinessDetails(BusinessFullDetails businessFullDetails);

    Category addCategory(Category category, String email, String businessId);

    Category updateCategory(Category category, String email, String businessId);

    Product addProduct(Product product, String email, String businessId);

    Product removeProduct(String productId, String email, String businessId);

    Product updateProduct(Product product, String email, String businessId);

    List<Product> getBusinessProducts(String email, String businessId);

    List<Category> getBusinessCategories(String email, String businessId);

    List<PurchaseOrders> getPurchaseOrder(String email, String businessId, String startDate, String endDate, String statusList);

    PurchaseOrders updatePurchaseOrderStatus(String email, String businessId, OrderUpdate orderUpdate);

}
