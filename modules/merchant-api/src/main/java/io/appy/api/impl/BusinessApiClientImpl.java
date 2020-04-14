package io.appy.api.impl;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.jaxrs.json.JacksonJaxbJsonProvider;
import io.appy.api.BusinessApiClient;
import io.appy.domain.*;
import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.client.ClientProperties;
import org.glassfish.jersey.client.HttpUrlConnectorProvider;
import org.slf4j.LoggerFactory;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;
import java.io.File;
import java.net.URI;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

public class BusinessApiClientImpl implements BusinessApiClient {
    private final Client client;
    private final String MERCHANT_ID_HEADER = "X-Merchant-Id";
    private String merchantApiBaseUrl;

    public BusinessApiClientImpl(String merchantApiBaseUrl) {
        this.merchantApiBaseUrl = merchantApiBaseUrl;
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        JacksonJaxbJsonProvider jacksonProvider = new JacksonJaxbJsonProvider();
        jacksonProvider.setMapper(objectMapper);
        client = ClientBuilder.newClient(new ClientConfig(jacksonProvider)).property(HttpUrlConnectorProvider.SET_METHOD_WORKAROUND, true);
        client.property(ClientProperties.SUPPRESS_HTTP_COMPLIANCE_VALIDATION, true);
    }

    @Override
    public BusinessDetailResponse createBusiness(BusinessDetails businessDetails) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/createBusiness");
        URI uri = builder.build();
        WebTarget webResource = client.target(uri);
        BusinessDetailResponse response = webResource.request(MediaType.APPLICATION_JSON).post(Entity.entity(businessDetails, MediaType.APPLICATION_JSON), BusinessDetailResponse.class);
        return response;
    }

    @Override
    public LoginResponse loginUser(LoginDetails loginDetails) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/queryUser");
        URI uri = builder.build();
        LoginResponse response = new LoginResponse();
        try{
            WebTarget webResource = client.target(uri);
            response =  webResource.request(MediaType.APPLICATION_JSON).post(Entity.entity(loginDetails, MediaType.APPLICATION_JSON), LoginResponse.class);
        }catch (Exception ex){

        }

        return response;
    }

    @Override
    public BusinessFullDetails getBusinessDetails(String businessId) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/getBusiness");
        URI uri = builder.build();
        BusinessFullDetails response = new BusinessFullDetails();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            response =  webResource.request(MediaType.APPLICATION_JSON).get(BusinessFullDetails.class);
        }catch (Exception ex){
            System.out.printf("as");
        }
        return response;
    }

    @Override
    public BusinessFullDetails updateBusinessDetails(BusinessFullDetails businessFullDetails, String email) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/updateBusiness");
        URI uri = builder.build();
        BusinessFullDetails response = new BusinessFullDetails();
        try{
            WebTarget webResource = client.target(uri);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).post(Entity.entity(businessFullDetails, MediaType.APPLICATION_JSON), BusinessFullDetails.class);
        }catch (Exception ex){

        }
        return response;
    }

    @Override
    public Category addCategory(Category category, String email, String businessId) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/createCategory");
        URI uri = builder.build();
        Category response = new Category();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).post(Entity.entity(category, MediaType.APPLICATION_JSON), Category.class);
        }catch (Exception ex){

        }
        return response;
    }

    @Override
    public Category updateCategory(Category category, String email, String businessId) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/updateCategory");
        URI uri = builder.build();
        Category response = new Category();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).post(Entity.entity(category, MediaType.APPLICATION_JSON), Category.class);
        }catch (Exception ex){

        }
        return response;
    }

    @Override
    public Product addProduct(Product product, String email, String businessId) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/createProduct");
        URI uri = builder.build();
        Product response = new Product();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).post(Entity.entity(product, MediaType.APPLICATION_JSON), Product.class);
        }catch (Exception ex){

        }
        return response;
    }

    @Override
    public Product removeProduct(String productId, String email, String businessId) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/removeProduct");
        URI uri = builder.build();
        Product response = new Product();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            webResource = webResource.queryParam("productId",productId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).get(Product.class);
        }catch (Exception ex){

        }
        return response;
    }

    @Override
    public Product updateProduct(Product product, String email, String businessId) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/updateProduct");
        URI uri = builder.build();
        Product response = new Product();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).post(Entity.entity(product, MediaType.APPLICATION_JSON), Product.class);
        }catch (Exception ex){

        }
        return response;
    }

    @Override
    public List<Product> getBusinessProducts(String email, String businessId) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/queryAllProducts");
        URI uri = builder.build();
        List<Product> response = new ArrayList<>();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).get(List.class);
        }catch (Exception ex){
            System.out.printf("as");
        }
        return response;
    }

    @Override
    public List<Category>  getBusinessCategories(String email, String businessId) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/queryAllCategories");
        URI uri = builder.build();
        List<Category>  response = new ArrayList<>();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).get(List.class);
        }catch (Exception ex){
            System.out.printf("as");
        }
        return response;
    }

    @Override
    public List<PurchaseOrders> getPurchaseOrder(String email, String businessId, String startDate, String endDate, String statusList) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/getBusinessOrder");
        URI uri = builder.build();
        List<PurchaseOrders>  response = new ArrayList<>();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            webResource = webResource.queryParam("startDate",startDate);
            webResource = webResource.queryParam("endDate",endDate);
            webResource = webResource.queryParam("status",statusList);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).get(List.class);
        }catch (Exception ex){
            System.out.printf("as");
        }
        return response;
    }

    @Override
    public PurchaseOrders updatePurchaseOrderStatus(String email, String businessId, OrderUpdate orderUpdate) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/updateOrderStatus");
        URI uri = builder.build();
        PurchaseOrders response = new PurchaseOrders();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).post(Entity.entity(orderUpdate, MediaType.APPLICATION_JSON),PurchaseOrders.class);
        }catch (Exception ex){

        }
        return response;
    }

    @Override
    public Category removeCategory(String categoryId, String email, String businessId) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/removeCategory");
        URI uri = builder.build();
        Category response = new Category();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            webResource = webResource.queryParam("categoryId",categoryId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).get(Category.class);
        }catch (Exception ex){

        }
        return response;
    }

    @Override
    public PurchaseOrders getPurchaseOrder(String email, String businessId, String purchaseOrderID) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/getOrder");
        URI uri = builder.build();
        PurchaseOrders  response = new PurchaseOrders();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            webResource = webResource.queryParam("orderId",purchaseOrderID);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).get(PurchaseOrders.class);
        }catch (Exception ex){
            System.out.printf("as");
        }
        return response;
    }

    @Override
    public Products batchUploadProduct(String email, String businessId, List<Product> products) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/batchUploadProduct");
        URI uri = builder.build();
        Products response = new Products();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).post(Entity.entity(products, MediaType.APPLICATION_JSON),Products.class);
        }catch (Exception ex){

        }
        return response;
    }

    @Override
    public Category getCategoryByName(String email, String businessId, String catName) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/getCategoryByName");
        URI uri = builder.build();
        Category  response = new Category();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            webResource = webResource.queryParam("name",catName);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).get(Category.class);
        }catch (Exception ex){
            System.out.printf("as");
        }
        return response;
    }


    @Override
    public Categories batchUploadCategory(String email, String businessId, List<Category> categories) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/batchUploadCategory");
        URI uri = builder.build();
        Categories response = new Categories();
        try{
            WebTarget webResource = client.target(uri);
            webResource = webResource.queryParam("businessId",businessId);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).post(Entity.entity(categories, MediaType.APPLICATION_JSON),Categories.class);
        }catch (Exception ex){

        }
        return response;
    }

    @Override
    public BusinessFullDetails sendNotification(NotificationAPIRequest notificationAPIRequest, String email) {
        UriBuilder builder = UriBuilder
                .fromPath(merchantApiBaseUrl)
                .path("/sendNotifications");
        URI uri = builder.build();
        BusinessFullDetails response = new BusinessFullDetails();
        try{
            WebTarget webResource = client.target(uri);
            response =  webResource.request(MediaType.APPLICATION_JSON).header("x-merchant-id",email).post(Entity.entity(notificationAPIRequest, MediaType.APPLICATION_JSON), BusinessFullDetails.class);
        }catch (Exception ex){

        }
        return response;
    }

}
