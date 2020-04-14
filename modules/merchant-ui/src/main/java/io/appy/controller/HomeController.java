package io.appy.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import io.appy.api.impl.BusinessApiClientImpl;
import io.appy.domain.*;
import io.appy.util.BusinessUtil;
import io.appy.util.UserDetailService;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class HomeController {
    @Autowired
    BusinessApiClientImpl businessApiClient;

    BusinessUtil businessUtil = new BusinessUtil();

    private static Logger logger = Logger.getLogger(LoginController.class);

    /**
     * This function retreives the businessDetails, products, and the categories from the blockchain and then renders the ProductManagement page
     * @param authentication
     * @param businessId
     * @return modelAndView
     */
    @RequestMapping(value = "/{businessId}/manageProducts", method = RequestMethod.GET)
    public ModelAndView renderProducts(Authentication authentication,@PathVariable String businessId){
        ModelAndView modelAndView = new ModelAndView("manage-products");
        String email = UserDetailService.getUserId(authentication);
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<Product> products = businessApiClient.getBusinessProducts(email,businessId);
        List<Category>   categories = businessApiClient.getBusinessCategories(email,businessId);
        modelAndView.addObject("products",products);
        modelAndView.addObject("categories",categories);
        modelAndView.addObject("business",businessFullDetails);
        return modelAndView;
    }


    /**
     * This function retreives the businessDetails and the categories from the blockchain and then renders the CategoryManagement page
     * @param authentication
     * @param businessId
     * @return modelAndView
     */
    @RequestMapping(value = "/{businessId}/manageCategories", method = RequestMethod.GET)
    public ModelAndView renderCategories(Authentication authentication,@PathVariable String businessId){
        ModelAndView modelAndView = new ModelAndView("manage-categories");
        String email = UserDetailService.getUserId(authentication);
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<Category>   categories = businessApiClient.getBusinessCategories(email,businessId);
        modelAndView.addObject("categories",categories);
        modelAndView.addObject("business",businessFullDetails);
        return modelAndView;
    }

    /**
     * This function retreives the businessDetails from the blockchain and renders the Settings page
     * @param businessId
     * @return modelAndView
     */
    @RequestMapping(value = "/{businessId}/manageSettings", method = RequestMethod.GET)
    public ModelAndView renderSetting(@PathVariable String businessId){
        ModelAndView modelAndView = new ModelAndView("manage-setting");
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        Gson gson = new Gson();
        modelAndView.addObject("shopOpenHours",gson.toJson(businessFullDetails.getPickUpHours()));
        modelAndView.addObject("deliveryHours",gson.toJson(businessFullDetails.getDeliveryHours()));
        modelAndView.addObject("business",businessFullDetails);
        return modelAndView;
    }

    /**
     * This function retreives the email from the authenticated user, then it creates a new category and sends a request to create the category request
     * @param category
     * @param businessId
     * @param authentication
     * @return string categories (redirect request)
     */
    @RequestMapping(value = "/{businessId}/addCategory", method = RequestMethod.POST)
    public String addCategory(@ModelAttribute Category category, @PathVariable String businessId,Authentication authentication){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New category creation request by " + email);
        try {
            // Generate a custom ID for the category
            category.setCategoryId(businessUtil.generateRandomString(10,"CAT_"));
            // Set the doctype of the category which will be used when retreiveing categoroies
            category.setDocType("Category");
            // Setting the visibility of the category so only visible categories wil lbe shown to the user.
            category.setVisibility(true);
            businessApiClient.addCategory(category,email, businessId);
        }catch (Exception ex){
            logger.error("Category creation exception", ex);
            return "fail";
        }
        return "redirect:manageCategories";
    }

    /**
     * This function retreives the email from the authenticated user, then it sends a request to update the category name
     * @param authentication
     * @param category
     * @param businessId
     * @return string categories (redirect request)
     */
    @RequestMapping(value = "/{businessId}/updateCategory", method = RequestMethod.POST)
    public String updateCategory(Authentication authentication,@ModelAttribute Category category, @PathVariable String businessId){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New category update request by " + email);
        try {
            businessApiClient.updateCategory(category,email, businessId);
        }catch (Exception ex){
            logger.error("Category update exception", ex);
            return "fail";
        }
        return "redirect:manageCategories";
    }

    /**
     * This function retreives the email from the authenticated user, then is sends a request to add a new product
     * @param authentication
     * @param product
     * @param businessId
     * @return string msg (success || fail)
     */
    @RequestMapping(value = "/{businessId}/addProduct", method = RequestMethod.POST)
    public String addProduct(Authentication authentication,@RequestBody Product product, @PathVariable String businessId){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New product creation request by " + email);
        try {
            // Check wether the product has any addons if not a new AddonArray list is created and set as the addon object
            if(product.getAddons() == null){
                List<AddonGroup> addons = new ArrayList<AddonGroup>();
                product.setAddons(addons);
            }

            // Check wether the product has any variants if not a new VariantGroup class instance is created and set as the product variant
            if(product.getVariant() == null){
                product.setVariant(new VariantGroup());
            }

            // Generate a custom ID for the product
            product.setProductId(businessUtil.generateRandomString(10,"PRD_"));
            businessApiClient.addProduct(product,email, businessId);
        }catch (Exception ex){
            logger.error("Product creation exception", ex);
            return "fail";
        }
        return "success";
    }

    /**
     * This function retreives the email from the authenticated user, and sends a request to remove a product
     * @param authentication
     * @param productId
     * @param businessId
     * @param modelAndView
     * @return modelAndView
     */
    @RequestMapping(value = "/{businessId}/removeProduct", method = RequestMethod.POST)
    public ModelAndView removeProduct(Authentication authentication,@RequestParam String productId,@PathVariable String businessId,ModelAndView modelAndView){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New product remove request by " + email);
        modelAndView.setViewName("redirect:manageProducts");
        try {
            businessApiClient.removeProduct(productId,email, businessId);
            modelAndView.addObject("removesuccess","Category removed successfully");
        }catch (Exception ex){
            logger.error("Product remove exception", ex);
            modelAndView.addObject("removefail","Category not removed");
        }
        return modelAndView;
    }


    /**
     * This function retreives the email from the authenticated user, then it gets the updated product object and send a request to update the product
     * @param authentication
     * @param product
     * @param businessId
     * @return string msg (success || fail)
     */
    @RequestMapping(value = "/{businessId}/updateProduct", method = RequestMethod.POST)
    public String updateProduct(Authentication authentication,@RequestBody Product product, @PathVariable String businessId){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New product update request by " + email);
        try {
            // Check wether the product has any addons if not a new AddonArray list is created and set as the addon object
            if(product.getAddons() == null){
                List<AddonGroup> addons = new ArrayList<AddonGroup>();
                product.setAddons(addons);
            }

            // Check wether the product has any variants if not a new VariantGroup class instance is created and set as the product variant
            if(product.getVariant() == null){
                product.setVariant(new VariantGroup());
            }
            businessApiClient.updateProduct(product,email, businessId);
        }catch (Exception ex){
            logger.error("Product update exception", ex);
            return "fail";
        }
        return "success";
    }


    /**
     * This function retreives the email from the authenticated user, then it gets the businessDetails object passed from the client app and gets the pickuphours
     * and sets it as the new pickupHours of the business and passes a request to update the business with the new pickupHours
     * @param authentication
     * @param businessId
     * @param businessFullDetailsUpdate
     * @return string msg (success || fail)
     */
    @RequestMapping(value = "/{businessId}/updatePickupHours", method = RequestMethod.POST)
    @ResponseBody
    public String submitAppConfig(Authentication authentication,@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New pickup hours update request by " + email);
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setPickUpHours(businessFullDetailsUpdate.getPickUpHours());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            logger.error("Pickup hours update exception", ex);
            return "Fail";
        }
    }


    /**
     * This function retreives the email from the authenticated user, then it gets the businessDetails object passed from the client app and gets the deliveryHours
     * and sets it as the new deliveryHours of the business and passes a request to update the business with the new deliveryHours
     * @param authentication
     * @param businessId
     * @param businessFullDetailsUpdate
     * @return string msg (success || fail)
     */
    @RequestMapping(value = "/{businessId}/updateDeliveryHours", method = RequestMethod.POST)
    @ResponseBody
    public String submitDeliveryInfo(Authentication authentication,@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New delivery hours update request by " + email);
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setDeliveryHours(businessFullDetailsUpdate.getDeliveryHours());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            logger.error("Delivery hours update exception", ex);
            return "Fail";
        }
    }

    /**
     * This function retreives the email from the authenticated user, then it gets the businessDetails object passed from the client app and gets the deliveryLocations
     * and sets it as the new deliveryLocations of the business and passes a request to update the business with the new deliveryLocations
     * @param authentication
     * @param businessId
     * @param businessFullDetailsUpdate
     * @return string msg (success || fail)
     */
    @RequestMapping(value = "/{businessId}/updateDeliveryConfig", method = RequestMethod.POST)
    @ResponseBody
    public String submitDeliveryLocationInfo(Authentication authentication,@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New  delivery location update request by " + email);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setDeliveryLocation(businessFullDetailsUpdate.getDeliveryLocation());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            logger.error("Delivery location update exception", ex);
            return "Fail";

        }
    }

    /**
     * This function retreives the email from the authenticated user, then it gets the businessDetails object passed from the client app and gets the paypalsecret
     * and sets it as the new paypalsecret of the business and passes a request to update the business with the new paypalsecret
     * @param authentication
     * @param businessId
     * @param businessFullDetailsUpdate
     * @return string msg (success || fail)
     */
    @RequestMapping(value = "/{businessId}/updatePaypalSecret", method = RequestMethod.POST)
    @ResponseBody
    public String submitPaypalSecret(Authentication authentication,@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New paypal secret update request by " + email);
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setPaypalSecret(businessFullDetailsUpdate.getPaypalSecret());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            logger.error("Paypal secret update exception", ex);
            return "Fail";
        }
    }


    /**
     * This function retreives the email from the authenticated user, then it checks wether startDate and endDate is passed as request params if they are passed
     * the startDate and endDate will be used to get orders for that business if not the orders will be retreived for the current date and one date earlier
     * @param authentication
     * @param businessId
     * @param startDate
     * @param endDate
     * @param status
     * @return modelAndView
     */
    @RequestMapping(value = "/{businessId}/manageOrders", method = RequestMethod.GET)
    public ModelAndView renderOrders(Authentication authentication,@PathVariable String businessId,@RequestParam (required = false) String startDate, @RequestParam (required = false) String endDate, @RequestParam (required = false) String status){
        String email = UserDetailService.getUserId(authentication);

        ModelAndView modelAndView = new ModelAndView("manage-orders");
        String startDateFormat = "";
        String endDateFormat = "";
        Date date = new Date();

        // Check wether start date is passed
        if(startDate != null){
            DateTimeFormatter formatter = DateTimeFormat.forPattern("YYYY-MM-dd");

            DateTime userStartDate = formatter.parseDateTime(startDate).withTime(0,0,0,0);
            DateTime userEndDate = formatter.parseDateTime(endDate).withTime(23,59,0,0);
            // Format the startDate and End Date
            startDateFormat = userStartDate.toString("dd-MM-YYYY HH:mm");
            endDateFormat = userEndDate.toString("dd-MM-YYYY HH:mm");
        }else{
            DateTime startDateIfNotExist = new DateTime(date).withTime(0,0,0,0);
            DateTime endDateIfNotExist = new DateTime(date).withTime(23,59,0,0);
            // Set the startDate to the previous date
            startDateIfNotExist = startDateIfNotExist.plusDays(-1);
            // Format the startDate and End Date
            startDateFormat = startDateIfNotExist.toString("dd-MM-YYYY HH:mm");
            endDateFormat = endDateIfNotExist.toString("dd-MM-YYYY HH:mm");
        }

        List<String> statusList = new ArrayList<>();
        // Check wether status is passed if not set the status to All to retreive all the orders.
        if(status == null){
            status = "All";
        }

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<PurchaseOrders>   purchaseOrders = businessApiClient.getPurchaseOrder(email,businessId,startDateFormat,endDateFormat,status);

        DateTimeFormatter formatterParam = DateTimeFormat.forPattern("dd-MM-YYYY HH:mm");
        DateTime userStartDateParam = formatterParam.parseDateTime(startDateFormat);
        String startParam = userStartDateParam.toString("YYYY-MM-dd");
        DateTime userEndDateParam = formatterParam.parseDateTime(endDateFormat);
        String endParam = userEndDateParam.toString("YYYY-MM-dd");

        modelAndView.addObject("business",businessFullDetails);
        modelAndView.addObject("purchaseOrders",purchaseOrders);
        modelAndView.addObject("startDate", startParam);
        modelAndView.addObject("endDate", endParam);
        modelAndView.addObject("status", status);
        return modelAndView;
    }


    /**
     * This function retreives the email from the authenticated user, then it creates a new OrderUpdate object and set the status of the object to ACCEPTED
     * and send a request to update the order
     * @param businessId
     * @param orderId
     * @param authentication
     * @return string orders (redirect manageOrders)
     */
    @RequestMapping(value = "/{businessId}/acceptOrder", method = RequestMethod.GET)
    public String acceptOrder(@PathVariable String businessId, @RequestParam String name, @RequestParam String orderId,Authentication authentication,@RequestParam (required = false) String startDate, @RequestParam (required = false) String endDate, @RequestParam (required = false) String status){
        String email = UserDetailService.getUserId(authentication);
        OrderUpdate orderUpdate = new OrderUpdate();
        orderUpdate.setStatus("ACCEPTED");
        orderUpdate.setOrderId(orderId);
        orderUpdate.setBusinessName(name);
        PurchaseOrders  purchaseOrders = businessApiClient.updatePurchaseOrderStatus(email,businessId,orderUpdate);
        logger.info("New order accept request by " + email+ "for order " + orderId);
        return "redirect:manageOrders?startDate="+startDate+"&endDate="+endDate+"&status="+status;
    }


    /**
     * This function retreives the email from the authenticated user, then it creates a new OrderUpdate object and set the status of the object to COMPLETED
     * and send a request to update the order
     * @param businessId
     * @param orderId
     * @param authentication
     * @return string orders (redirect manageOrders)
     */
    @RequestMapping(value = "/{businessId}/completeOrder", method = RequestMethod.GET)
    public String completeOrder(@PathVariable String businessId, @RequestParam String name, @RequestParam String orderId, Authentication authentication,@RequestParam (required = false) String startDate, @RequestParam (required = false) String endDate, @RequestParam (required = false) String status){
        String email = UserDetailService.getUserId(authentication);
        OrderUpdate orderUpdate = new OrderUpdate();
        orderUpdate.setStatus("COMPLETED");
        orderUpdate.setOrderId(orderId);
        orderUpdate.setBusinessName(name);
        PurchaseOrders  purchaseOrders = businessApiClient.updatePurchaseOrderStatus(email,businessId,orderUpdate);
        logger.info("New order complete request by " + email+ "for order " + orderId);
        return "redirect:manageOrders?startDate="+startDate+"&endDate="+endDate+"&status="+status;
    }

    /**
     * This function retreives the email from the authenticated user, then it creates a new OrderUpdate object and set the status of the object to REJECTED
     * and send a request to update the order
     * @param businessId
     * @param orderId
     * @param authentication
     * @return string orders (redirect manageOrders)
     */
    @RequestMapping(value = "/{businessId}/rejectOrder", method = RequestMethod.GET)
    public String rejectOrder(@PathVariable String businessId, @RequestParam String name, @RequestParam String orderId, Authentication authentication,@RequestParam (required = false) String startDate, @RequestParam (required = false) String endDate, @RequestParam (required = false) String status){
        String email = UserDetailService.getUserId(authentication);
        OrderUpdate orderUpdate = new OrderUpdate();
        orderUpdate.setStatus("REJECTED");
        orderUpdate.setOrderId(orderId);
        orderUpdate.setBusinessName(name);
        PurchaseOrders  purchaseOrders = businessApiClient.updatePurchaseOrderStatus(email,businessId,orderUpdate);
        logger.info("New order reject request by " + email + "for order " + orderId);
        return "redirect:manageOrders?startDate="+startDate+"&endDate="+endDate+"&status="+status;
    }


    /**
     * This function retreives the email from the authenticated user, then it send a request with the category id to remove the category
     * @param categoryId
     * @param authentication
     * @param businessId
     * @param modelAndView
     * @return modelAndView
     */
    @RequestMapping(value = "/{businessId}/removeCategory", method = RequestMethod.POST)
    public ModelAndView removeCategory(@RequestParam String categoryId, Authentication authentication, @PathVariable String businessId, ModelAndView modelAndView){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New category remove request by " + email);
        modelAndView.setViewName("redirect:manageCategories");
        try {
            businessApiClient.removeCategory(categoryId,email, businessId);
            modelAndView.addObject("removesuccess","Category removed successfully");
        }catch (Exception ex){
            modelAndView.addObject("removefail","Category not removed");
            logger.error("Category remove exception", ex);
        }
        return modelAndView;
    }


    /**
     * This function retreives the email from the authenticated user, Then it gets the businessDetails and then checks for the status of the delivery and
     * toggles the status of the delivery.
     * @param authentication
     * @param businessId
     * @return string msg (success || fail)
     */
    @RequestMapping(value = "/{businessId}/toggleDelivery", method = RequestMethod.POST)
    public String toggleDelivery(Authentication authentication,@PathVariable String businessId){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New delivery toggle request by " + email);
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        if(businessFullDetails.getDeliveryEnabled() == null){
            businessFullDetails.setDeliveryEnabled(true);
        }else{
            businessFullDetails.setDeliveryEnabled(!businessFullDetails.getDeliveryEnabled());
        }
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            logger.error("Delivery toggle exception", ex);
            return "Fail";
        }
    }

    /**
     * This function retreives the email from the authenticated user, then it gets the businessDetails and then checks for the status of the pickup and
     * toggles the status of the pickup.
     * @param authentication
     * @param businessId
     * @return string msg (success || fail)
     */
    @RequestMapping(value = "/{businessId}/togglePickup", method = RequestMethod.POST)
    public String togglePickup(Authentication authentication,@PathVariable String businessId){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New Pickup toggle request by " + email);
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        if(businessFullDetails.getPickUpEnabled() == null){
            businessFullDetails.setPickUpEnabled(true);
        }else{
            businessFullDetails.setPickUpEnabled(!businessFullDetails.getPickUpEnabled());
        }
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            logger.error("Pickup toggle exception", ex);
            return "Fail";
        }
    }


    /**
     * This function retreives the email from the authenticated user, and retreives the order details from the blockchain using the order id
     * @param authentication
     * @param businessId
     * @param orderId
     * @param modelAndView
     * @return PurchaseOrder purchaseOrders
     */
    @RequestMapping(value = "/{businessId}/orderDetails/{orderId}", method = RequestMethod.GET)
    public  @ResponseBody
    PurchaseOrders getOrder(Authentication authentication,@PathVariable String businessId, @PathVariable String orderId, ModelAndView modelAndView){
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        PurchaseOrders purchaseOrders = businessApiClient.getPurchaseOrder(email, businessId, orderId);
        return  purchaseOrders;
    }

    /**
     * This function retreives the email from the authenticated user, then it send a request with the updated orderPrepTime to update the business
     * @param authentication
     * @param businessId
     * @param orderPrepTime
     * @return string msg (success || fail)
     */
    @RequestMapping(value = "/{businessId}/updateOrderPrepTime", method = RequestMethod.POST)
    public String submitOrderPrep(Authentication authentication,@PathVariable String businessId,@RequestParam int orderPrepTime){
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setOrderPreparationTime(orderPrepTime);
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            return "Fail";
        }
    }


    /**
     * This function retreives the email from the authenticated user, then it gets the CSV passed by the client and using the WorkBook the file which is read
     * is taken as a xlxs file and an iterator is set to iterate through the row, once the iterator is a loop is executed till the rows exist and then another
     * iterator is used to iterate though the columns and using the column indexes are taken and the data is set for the product object.
     * @param authentication
     * @param businessId
     * @param file
     * @return string manageProducts (redirect manageProducts)
     * @throws IOException
     */
    @RequestMapping(value = "/{businessId}/batchUploadProductCSV", method = RequestMethod.POST)
    public String uploadProductCSV(Authentication authentication,@PathVariable String businessId,@RequestParam("file")  MultipartFile file) throws IOException {
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        String email = UserDetailService.getUserId(authentication);
        logger.info("New batch upload product request by " + email);
        ObjectMapper objectMapper = new ObjectMapper();
        List<Category> linkedCategories = businessApiClient.getBusinessCategories(email,businessId);
        List<Category> existingCategories = objectMapper.convertValue(linkedCategories, new TypeReference<List<Category>>() { });


        String fileLocation;
        // Read the file
        InputStream in = file.getInputStream();
        List<Product> products = new ArrayList<>();
        List<Category> newCategories = new ArrayList<>();

        // Create a new arraylist for the images and set the current business images as the list if not null
        List<String> images = new ArrayList<>();
        if(businessFullDetails.getImages() != null){
            images = businessFullDetails.getImages();
        }

        Workbook workbook = new XSSFWorkbook(in);
        Sheet dataSheet = workbook.getSheetAt(0);
        Iterator<Row> iterator = dataSheet.iterator();
        int count =0;
        // Loop through the sheet
        while (iterator.hasNext()) {
            Row currentRow = iterator.next();
            Iterator<Cell> cellIterator = currentRow.iterator();
            count++;
            boolean isNew = true;
            Product product = new Product();
            while (cellIterator.hasNext()) {
                Cell currentCell = cellIterator.next();
                int cellNum = ((XSSFCell) currentCell).getColumnIndex();
                if(count > 1){
                    // Check for the cellNum to set the specific product details
                    switch (cellNum){
                        case 0:
                            product.setName(currentCell.getStringCellValue());
                            break;
                        case 1:
                            int price = (int)currentCell.getNumericCellValue();
                            product.setPrice((double)price);
                            break;
                        case 2:
                            product.setImage(currentCell.getStringCellValue());
                            if(!images.contains(product.getImage())){
                                images.add(product.getImage());
                            }
                            break;
                        case 3:
                            product.setDescription(currentCell.getStringCellValue());
                            break;
                        case 4:
                            List<String> categories = new ArrayList<>();
                            // Check if there are multipe categories
                            if(currentCell.getStringCellValue().contains(",")){
                                Cell imageCell = cellIterator.next();
                                String[] categoryNames  = currentCell.getStringCellValue().split(",");
                                /* Loop through the category list and then update the category if the categoruy does not exist and set the category id
                                   as the category id for the product
                                */
                                for(String catName : categoryNames){
                                    Category category = getCategory(businessFullDetails,businessId,catName,newCategories,isNew,imageCell.getStringCellValue(),email,existingCategories);
                                    images.add(imageCell.getStringCellValue());
                                    categories.add(category.getCategoryId());
                                    product.setCategoryId(categories);
                                }
                            }else {
                                String catName = currentCell.getStringCellValue();
                                currentCell = cellIterator.next();
                                Category category = getCategory(businessFullDetails, businessId, catName, newCategories, isNew, currentCell.getStringCellValue(),email,existingCategories);
                                if(!images.contains(currentCell.getStringCellValue())){
                                    images.add(currentCell.getStringCellValue());
                                }
                                categories.add(category.getCategoryId());
                                product.setCategoryId(categories);
                            }
                            break;
                        default:
                            break;
                    }
                }
            }

            if(count > 1) {
                // Fill in the rest of the product object and add it to the product List
                product.setProductId(businessUtil.generateRandomString(10,"PRD_"));
                product.setVisibility(true);
                product.setDocType("Product");
                product.setBusinessId(businessId);
                List<AddonGroup> addons = new ArrayList<AddonGroup>();
                product.setAddons(addons);
                product.setVariant(new VariantGroup());
                products.add(product);
            }
        }

        // Set the new image list as the business images
        businessFullDetails.setImages(images);

        try{
            // Update the business with the images
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            // Add the product list to the business
            businessApiClient.batchUploadProduct(email, businessId, products);
        }catch (Exception ex){
            logger.error("Batch upload product exception", ex);
        }
        return  "redirect:manageProducts";
    }


    /**
     * This function retreives the email from the authenticated user, then it gets the JSON file passed by the client and then using the object mapper
     * the json file is deseerialized as a List and the items in the list is iterated and the products are added to a list which is then used to upload
     * the products to the blockchain.
     * @param authentication
     * @param businessId
     * @param file
     * @return string manageProducts (redirect manageProducts)
     * @throws IOException
     */
    @RequestMapping(value = "/{businessId}/batchUploadProductJSON", method = RequestMethod.POST)
    public String uploadProductJSON(Authentication authentication,@PathVariable String businessId,@RequestParam("file")  MultipartFile file) throws IOException {
        String email = UserDetailService.getUserId(authentication);
        logger.info("New batch upload product request by " + email);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);

        ObjectMapper objectMapper = new ObjectMapper();
        List<Category> linkedCategories = businessApiClient.getBusinessCategories(email,businessId);
        List<Category> existingCategories = objectMapper.convertValue(linkedCategories, new TypeReference<List<Category>>() { });


        InputStream in = file.getInputStream();
        boolean isNew = true;

        List<Category> newCategories = new ArrayList<>();
        List<Product> productList = new ArrayList<>();
        List<String> images = new ArrayList<>();
        if(businessFullDetails.getImages() != null){
            images = businessFullDetails.getImages();
        }
        try{
            // Deserialize the json file
            List<ProductJson> products = Arrays.asList(objectMapper.readValue(in, ProductJson[].class));
            // Loop though the product List
            for(ProductJson product: products){
                Product product1 = new Product();
                List<String> categories = new ArrayList<>();
                if(!images.contains(product.getImage())){
                    images.add(product.getImage());
                }
                /* Loop through the category list and then update the category if the categoruy does not exist and set the category id
                   as the category id for the product
                 */
                for(JsonCategories categorie : product.getCategories()){
                    Category category = getCategory(businessFullDetails,businessId,categorie.getName(),newCategories,isNew,categorie.getImage(),email,existingCategories);
                    if(!existingCategories.contains(category)){
                        existingCategories.add(category);
                    }
                    categories.add(category.getCategoryId());
                    product1.setCategoryId(categories);
                    if(!images.contains(category.getImage())){
                        images.add(category.getImage());
                    }
                }
                productList.add(businessUtil.genProductObject(product1,product,businessId));
            }

            businessFullDetails.setImages(images);
            businessApiClient.batchUploadProduct(email, businessId, productList);
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
        }catch (Exception ex){
            logger.error("Batch upload product exception", ex);
        }

        return "redirect:manageProducts";
    }



    /**
     * This function retreives the email from the authenticated user, then it gets the CSV passed by the client and using the WorkBook the file which is read
     * is taken as a xlxs file and an iterator is set to iterate through the row, once the iterator is a loop is executed till the rows exist and then another
     * iterator is used to iterate though the columns and using the column indexes are taken and the data is set for the category object.
     * @param authentication
     * @param businessId
     * @param file
     * @return string manageProducts (redirect manageCategories)
     * @throws IOException
     */
    @RequestMapping(value = "/{businessId}/batchUploadCategoryCSV", method = RequestMethod.POST)
    public String uploadCategoryCSV(Authentication authentication,@PathVariable String businessId,@RequestParam("file")  MultipartFile file) throws IOException {
        String email = UserDetailService.getUserId(authentication);
        logger.info("New batch upload category request by " + email);
        ObjectMapper objectMapper = new ObjectMapper();
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<Category> linkedCategories = businessApiClient.getBusinessCategories(email,businessId);
        List<Category> categories = objectMapper.convertValue(linkedCategories, new TypeReference<List<Category>>() { });

        String fileLocation;
        InputStream in = file.getInputStream();
        List<Category> newCategories = new ArrayList<>();
        List<String> images = new ArrayList<>();
        if(businessFullDetails.getImages() != null){
            images = businessFullDetails.getImages();
        }

        Workbook workbook = new XSSFWorkbook(in);
        Sheet dataSheet = workbook.getSheetAt(0);
        Iterator<Row> iterator = dataSheet.iterator();
        int count =0;
        // Loop through the rows to create the category object
        while (iterator.hasNext()) {
            Row currentRow = iterator.next();
            Iterator<Cell> cellIterator = currentRow.iterator();
            count++;
            boolean isNew = true;
            Category category = new Category();
            while (cellIterator.hasNext()) {
                Cell currentCell = cellIterator.next();
                int cellNum = ((XSSFCell) currentCell).getColumnIndex();
                if(count > 1){
                    switch (cellNum){
                        case 0:
                            category.setName(currentCell.getStringCellValue());
                            break;
                        case 1:
                            category.setImage(currentCell.getStringCellValue());
                            if(!images.contains(category.getImage())){
                                images.add(category.getImage());
                            }
                            break;
                        default:
                            break;
                    }
                }
            }

            if(count > 1) {
                category.setCategoryId(businessUtil.generateRandomString(10,"CAT_"));
                category.setVisibility(true);
                category.setDocType("Category");
                category.setBusinessId(businessId);
                // Check wether the category is duplicate
                if(businessUtil.findDuplicateCategories(businessFullDetails,businessId,categories, category.getName())){
                    newCategories.add(category);
                }
            }

            System.out.println();

        }
        businessFullDetails.setImages(images);
        try{
            businessApiClient.batchUploadCategory(email, businessId, newCategories);
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
        }catch (Exception ex){
            logger.error("Batch upload category exception", ex);
        }

        return  "redirect:manageCategories";
    }


    /**
     * This function retreives the email from the authenticated user, then it gets the JSON file passed by the client and then using the object mapper
     * the json file is deseerialized as a List and the items in the list is iterated and the categories are checked for duplications and if they are not duplicate
     * they are added to the category list which is then used to add the caategory.
     * @param authentication
     * @param businessId
     * @param file
     * @return string manageProducts (redirect manageProducts)
     * @throws IOException
     */
    @RequestMapping(value = "/{businessId}/batchUploadCategoryJSON", method = RequestMethod.POST)
    public String uploadCategoryJSON(Authentication authentication,@PathVariable String businessId,@RequestParam("file")  MultipartFile file) throws IOException {
        String email = UserDetailService.getUserId(authentication);
        logger.info("New batch upload category request by " + email);
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        ObjectMapper objectMapper = new ObjectMapper();
        InputStream in = file.getInputStream();
        List<Category> linkedCategories = businessApiClient.getBusinessCategories(email,businessId);
        List<Category> categories = objectMapper.convertValue(linkedCategories, new TypeReference<List<Category>>() { });

        boolean isNew = true;
        List<String> images = new ArrayList<>();
        if(businessFullDetails.getImages() != null){
            images = businessFullDetails.getImages();
        }

        List<Category> newCategories = new ArrayList<>();
        try{
            List<CategoryJson> categoryJsonList = Arrays.asList(objectMapper.readValue(in, CategoryJson[].class));
            for(CategoryJson categoryJson: categoryJsonList){
                Category category = new Category();
                if(!images.contains(category.getImage())){
                    images.add(category.getImage());
                }
                category = getCategory(businessFullDetails,businessId,categoryJson.getName(),newCategories,isNew,categoryJson.getImage(),email,categories);
                if(businessUtil.findDuplicateCategories(businessFullDetails,businessId,categories, categoryJson.getName())){
                    newCategories.add(category);
                }
            }
            businessFullDetails.setImages(images);
            businessApiClient.batchUploadCategory(email, businessId, newCategories);
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
        }catch (Exception ex){
            logger.error("Batch upload category exception", ex);
        }

        return "redirect:manageCategories";
    }

    /**
     * This function renders the image management page
     * @param businessId
     * @return modelAndView
     */
    @RequestMapping(value = "/{businessId}/manageImages", method = RequestMethod.GET)
    public ModelAndView renderImages(@PathVariable String businessId){
        ModelAndView modelAndView = new ModelAndView("manage-images");
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        modelAndView.addObject("business",businessFullDetails);
        return modelAndView;
    }

    /**
     * This function retreives the email from the authenticated user, then it gets the url of the new image, and using that the business details is retreived
     * and the new image is added to the image list and a request is sent to update the business.
     * @param authentication
     * @param businessId
     * @param url
     * @return
     */
    @RequestMapping(value = "/{businessId}/uploadImage", method = RequestMethod.POST)
    public String uploadImage(Authentication authentication,@PathVariable String businessId, @RequestParam String url){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New image upload request by " + email);
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<String> images = new ArrayList<>();
        if(businessFullDetails.getImages() != null){
            images = businessFullDetails.getImages();
        }
        if(!images.contains(url)){
            images.add(url);
        }
        businessFullDetails.setImages(images);
        businessApiClient.updateBusinessDetails(businessFullDetails,email);
        return "redirect:manageImages";
    }


    @RequestMapping(value = "/{businessId}/manageNotifications", method = RequestMethod.GET)
    public ModelAndView renderNotifications(@PathVariable String businessId){
        ModelAndView modelAndView = new ModelAndView("manage-notifications");
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        modelAndView.addObject("business",businessFullDetails);
        modelAndView.addObject("notification",new NotificationRequest());
        return modelAndView;
    }

    @RequestMapping(value = "/{businessId}/sendNotification", method = RequestMethod.POST)
    public ModelAndView sendPushNotification(Authentication authentication,@PathVariable String businessId,@ModelAttribute NotificationRequest newNotification, ModelAndView modelAndView){
        String email = UserDetailService.getUserId(authentication);
        logger.info("New  notification update request by " + email);

        List<NotificationRequest>  notificationList = new ArrayList<>();

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        if(businessFullDetails.getNotifications() != null){
            notificationList = businessFullDetails.getNotifications();
        }
        newNotification.setDateTime(new Date());
        notificationList.add(newNotification);
        businessFullDetails.setNotifications(notificationList);

        NotificationAPIRequest notificationAPIRequest = new NotificationAPIRequest();
        notificationAPIRequest.setTitle(newNotification.getTitle());
        notificationAPIRequest.setMsg(newNotification.getBody());
        notificationAPIRequest.setBusinessFullDetails(businessFullDetails);
        businessApiClient.sendNotification(notificationAPIRequest,email);
        modelAndView.setViewName("redirect:manageNotifications");
        return modelAndView;
    }


    @RequestMapping(value = "/{businessId}/addNotificationToken", method = RequestMethod.POST)
    public String addNotificationToken(Authentication authentication,@PathVariable String businessId,@RequestParam String token){
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<String> busNot = new ArrayList<>();
        if(businessFullDetails.getBusinessNotification() != null){
            busNot = businessFullDetails.getBusinessNotification();
        }
        if(!busNot.contains(token)){
            busNot.add(token);
        }
        businessFullDetails.setBusinessNotification(busNot);
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            return "Fail";
        }
    }


    /**
     * This function gets the category and check wether the category is new and if its new it creates a new category object and returns it
     * @param businessFullDetails
     * @param businessId
     * @param catName
     * @param newCategories
     * @param isNew
     * @param image
     * @param email
     * @param categories
     * @return Category category
     */
    public Category getCategory(BusinessFullDetails businessFullDetails, String businessId, String catName, List<Category> newCategories, boolean isNew,String image, String email,List<Category> categories ){
        Category category = new Category();
        List<Category> existingList = categories.stream().filter(u -> u.getName().equals(catName)).collect(Collectors.toList());
        if(existingList.size() > 0){
            category = existingList.get(0);
        }

        if(category.getCategoryId() == null){
            for(Category category1 : newCategories){
                if(category1.getName().equals(catName)){
                    isNew = false;
                }
            }
            if(isNew){
                category.setCategoryId(businessUtil.generateRandomString(10,"CAT_"));
                category.setName(catName);
                category.setVisibility(true);
                category.setImage(image);
                category.setDocType("Category");
                category.setBusinessId(businessId);
                businessApiClient.addCategory(category,email, businessId);
                newCategories.add(category);
            }
        }

        return  category;
    }
}
