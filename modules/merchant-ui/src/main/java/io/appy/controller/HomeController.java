package io.appy.controller;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import io.appy.api.impl.BusinessApiClientImpl;
import io.appy.domain.*;
import io.appy.util.BusinessUtil;
import io.appy.util.UserDetailService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.util.*;

@Controller
public class HomeController {
    @Autowired
    BusinessApiClientImpl businessApiClient;

    BusinessUtil businessUtil = new BusinessUtil();

    @RequestMapping(value = "/{businessId}/main", method = RequestMethod.GET)
    public ModelAndView renderMain(Authentication authentication,@PathVariable String businessId){
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

    @RequestMapping(value = "/{businessId}/manageCategories", method = RequestMethod.GET)
    public ModelAndView renderCategories(Authentication authentication,@PathVariable String businessId){
        ModelAndView modelAndView = new ModelAndView("manage-categories");
        String email = UserDetailService.getUserId(authentication);
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<Product> products = businessApiClient.getBusinessProducts(email,businessId);
        List<Category>   categories = businessApiClient.getBusinessCategories(email,businessId);
        modelAndView.addObject("products",products);
        modelAndView.addObject("categories",categories);
        modelAndView.addObject("business",businessFullDetails);
        return modelAndView;
    }

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

    @RequestMapping(value = "/{businessId}/addCategory", method = RequestMethod.POST)
    public String addCategory(@ModelAttribute Category category, @PathVariable String businessId,Authentication authentication){
        String email = UserDetailService.getUserId(authentication);
        try {
            category.setCategoryId(businessUtil.generateRandomString(10,"CAT_"));
            businessApiClient.addCategory(category,email, businessId);
        }catch (Exception ex){
            return "fail";
        }
        return "redirect:manageCategories";
    }

    @RequestMapping(value = "/{businessId}/updateCategory", method = RequestMethod.POST)
    public String updateCategory(Authentication authentication,@ModelAttribute Category category, @PathVariable String businessId){
        String email = UserDetailService.getUserId(authentication);
        try {
            businessApiClient.updateCategory(category,email, businessId);
        }catch (Exception ex){
            return "fail";
        }
        return "redirect:manageCategories";
    }

    @RequestMapping(value = "/{businessId}/addProduct", method = RequestMethod.POST)
    public String addProduct(Authentication authentication,@RequestBody Product product, @PathVariable String businessId){
        String email = UserDetailService.getUserId(authentication);
        try {
            if(product.getAddons() == null){
                List<AddonGroup> addons = new ArrayList<AddonGroup>();
                product.setAddons(addons);
            }

            if(product.getVariant() == null){
                product.setVariant(new VariantGroup());
            }
            product.setProductId(businessUtil.generateRandomString(10,"PRD_"));
            businessApiClient.addProduct(product,email, businessId);
        }catch (Exception ex){
            return "fail";
        }
        return "success";
    }

    @RequestMapping(value = "/{businessId}/removeProduct", method = RequestMethod.POST)
    public ModelAndView removeProduct(Authentication authentication,@RequestParam String productId,@PathVariable String businessId,ModelAndView modelAndView){
        String email = UserDetailService.getUserId(authentication);
        modelAndView.setViewName("redirect:main");
        modelAndView.addObject("assss","Category removed successfully");

        try {
            businessApiClient.removeProduct(productId,email, businessId);
            modelAndView.addObject("removesuccess","Category removed successfully");
        }catch (Exception ex){
            modelAndView.addObject("removefail","Category not removed");
        }
        return modelAndView;
    }


    @RequestMapping(value = "/{businessId}/updateProduct", method = RequestMethod.POST)
    public String updateProduct(Authentication authentication,@RequestBody Product product, @PathVariable String businessId){
        String email = UserDetailService.getUserId(authentication);
        try {
            if(product.getAddons() == null){
                List<AddonGroup> addons = new ArrayList<AddonGroup>();
                product.setAddons(addons);
            }

            if(product.getVariant() == null){
                product.setVariant(new VariantGroup());
            }
            businessApiClient.updateProduct(product,email, businessId);
        }catch (Exception ex){
            return "fail";
        }
        return "success";
    }


    @RequestMapping(value = "/{businessId}/updatePickupHours", method = RequestMethod.POST)
    public ModelAndView submitAppConfig(Authentication authentication,@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setPickUpHours(businessFullDetailsUpdate.getPickUpHours());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            ModelAndView modelAndView = new ModelAndView("redirect:/"+businessId+"/main");
            modelAndView.addObject("business", businessFullDetails);
            return modelAndView;
        }catch (Exception ex){
            ModelAndView modelAndView = new ModelAndView("redirect:/"+businessId+"/main");
            modelAndView.addObject("business", businessFullDetails);
            return modelAndView;
        }
    }


    @RequestMapping(value = "/{businessId}/updateDeliveryHours", method = RequestMethod.POST)
    public String submitDeliveryInfo(Authentication authentication,@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setDeliveryHours(businessFullDetailsUpdate.getDeliveryHours());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            return "Fail";
        }
    }

    @RequestMapping(value = "/{businessId}/updateDeliveryConfig", method = RequestMethod.POST)
    public String submitDeliveryLocationInfo(Authentication authentication,@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setDeliveryLocation(businessFullDetailsUpdate.getDeliveryLocation());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            return "Fail";

        }
    }

    @RequestMapping(value = "/{businessId}/updatePaypalSecret", method = RequestMethod.POST)
    public String submitPaypalSecret(Authentication authentication,@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setPaypalSecret(businessFullDetailsUpdate.getPaypalSecret());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            return "Success";
        }catch (Exception ex){
            return "Fail";
        }
    }


    @RequestMapping(value = "/{businessId}/manageOrders", method = RequestMethod.GET)
    public ModelAndView renderOrders(Authentication authentication,@PathVariable String businessId,@RequestParam (required = false) String startDate, @RequestParam (required = false) String endDate, @RequestParam (required = false) String status){
        String email = UserDetailService.getUserId(authentication);

        ModelAndView modelAndView = new ModelAndView("manage-orders");
        String startDateFormat = "";
        String endDateFormat = "";
        Date date = new Date();
        if(startDate != null){
            DateTimeFormatter formatter = DateTimeFormat.forPattern("YYYY-MM-dd");

            DateTime userStartDate = formatter.parseDateTime(startDate).withTime(0,0,0,0);
            DateTime userEndDate = formatter.parseDateTime(endDate).withTime(23,59,0,0);
            startDateFormat = userStartDate.toString("dd-MM-YYYY HH:mm");
            endDateFormat = userEndDate.toString("dd-MM-YYYY HH:mm");
        }else{
            DateTime startDateIfNotExist = new DateTime(date).withTime(0,0,0,0);
            DateTime endDateIfNotExist = new DateTime(date).withTime(23,59,0,0);
            startDateIfNotExist = startDateIfNotExist.plusDays(-1);
            startDateFormat = startDateIfNotExist.toString("dd-MM-YYYY HH:mm");
            endDateFormat = endDateIfNotExist.toString("dd-MM-YYYY HH:mm");
        }

        List<String> statusList = new ArrayList<>();
        if(status == null){
            status = "All";
        }

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<PurchaseOrders>   purchaseOrders = businessApiClient.getPurchaseOrder(email,businessId,startDateFormat,endDateFormat,status);
        modelAndView.addObject("business",businessFullDetails);
        modelAndView.addObject("purchaseOrders",purchaseOrders);
        return modelAndView;
    }


    @RequestMapping(value = "/{businessId}/acceptOrder", method = RequestMethod.GET)
    public String acceptOrder(@PathVariable String businessId, @RequestParam String orderId,Authentication authentication){
        String email = UserDetailService.getUserId(authentication);
        OrderUpdate orderUpdate = new OrderUpdate();
        orderUpdate.setStatus("ACCEPTED");
        orderUpdate.setOrderId(orderId);
        PurchaseOrders  purchaseOrders = businessApiClient.updatePurchaseOrderStatus(email,businessId,orderUpdate);
        return "redirect:manageOrders";
    }



    @RequestMapping(value = "/{businessId}/completeOrder", method = RequestMethod.GET)
    public String completeOrder(@PathVariable String businessId, @RequestParam String orderId, Authentication authentication){
        String email = UserDetailService.getUserId(authentication);
        OrderUpdate orderUpdate = new OrderUpdate();
        orderUpdate.setStatus("COMPLETED");
        orderUpdate.setOrderId(orderId);
        PurchaseOrders  purchaseOrders = businessApiClient.updatePurchaseOrderStatus(email,businessId,orderUpdate);
        return "redirect:manageOrders";
    }

    @RequestMapping(value = "/{businessId}/rejectOrder", method = RequestMethod.GET)
    public String rejectOrder(@PathVariable String businessId, @RequestParam String orderId, Authentication authentication){
        String email = UserDetailService.getUserId(authentication);
        OrderUpdate orderUpdate = new OrderUpdate();
        orderUpdate.setStatus("REJECTED");
        orderUpdate.setOrderId(orderId);
        PurchaseOrders  purchaseOrders = businessApiClient.updatePurchaseOrderStatus(email,businessId,orderUpdate);
        return "redirect:manageOrders";
    }


    @RequestMapping(value = "/{businessId}/removeCategory", method = RequestMethod.POST)
    public ModelAndView removeCategory(@RequestParam String categoryId, Authentication authentication, @PathVariable String businessId, ModelAndView modelAndView){
        String email = UserDetailService.getUserId(authentication);
        modelAndView.setViewName("redirect:manageCategories");
        try {
            businessApiClient.removeCategory(categoryId,email, businessId);
            modelAndView.addObject("removesuccess","Category removed successfully");
        }catch (Exception ex){
            modelAndView.addObject("removefail","Category not removed");
        }
        return modelAndView;
    }


    @RequestMapping(value = "/{businessId}/toggleDelivery", method = RequestMethod.POST)
    public String toggleDelivery(Authentication authentication,@PathVariable String businessId){
        String email = UserDetailService.getUserId(authentication);

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
            return "Fail";
        }
    }

    @RequestMapping(value = "/{businessId}/togglePickup", method = RequestMethod.POST)
    public String togglePickup(Authentication authentication,@PathVariable String businessId){
        String email = UserDetailService.getUserId(authentication);

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
            return "Fail";
        }
    }


    @RequestMapping(value = "/{businessId}/orderDetails/{orderId}", method = RequestMethod.GET)
    public  @ResponseBody
    PurchaseOrders getOrder(Authentication authentication,@PathVariable String businessId, @PathVariable String orderId, ModelAndView modelAndView){
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        PurchaseOrders purchaseOrders = businessApiClient.getPurchaseOrder(email, businessId, orderId);
        return  purchaseOrders;
    }

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


    @RequestMapping(value = "/{businessId}/batchUploadProductCSV", method = RequestMethod.POST)
    public String uploadProductCSV(Authentication authentication,@PathVariable String businessId,@RequestParam("file")  MultipartFile file) throws IOException {
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        String email = UserDetailService.getUserId(authentication);

        String fileLocation;
        InputStream in = file.getInputStream();
        List<Product> products = new ArrayList<>();
        List<Category> newCategories = new ArrayList<>();

        List<String> images = new ArrayList<>();
        if(businessFullDetails.getImages() != null){
            images = businessFullDetails.getImages();
        }

        Workbook workbook = new XSSFWorkbook(in);
        Sheet dataSheet = workbook.getSheetAt(0);
        Iterator<Row> iterator = dataSheet.iterator();
        int count =0;
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
                    switch (cellNum){
                        case 0:
                            product.setName(currentCell.getStringCellValue());
                            break;
                        case 1:
                            product.setPrice((int)currentCell.getNumericCellValue());
                            break;
                        case 2:
                            product.setImage(currentCell.getStringCellValue());
                            images.add(currentCell.getStringCellValue());
                            break;
                        case 3:
                            product.setDescription(currentCell.getStringCellValue());
                            break;
                        case 4:
                            List<String> categories = new ArrayList<>();
                            if(currentCell.getStringCellValue().contains(",")){
                                Cell imageCell = cellIterator.next();
                                String[] categoryNames  = currentCell.getStringCellValue().split(",");
                                for(String catName : categoryNames){
                                    Category category = getCategory(businessFullDetails,businessId,catName,newCategories,isNew,imageCell.getStringCellValue(),email);
                                    images.add(imageCell.getStringCellValue());
                                    categories.add(category.getCategoryId());
                                    product.setCategoryId(categories);
                                }
                            }else {
                                String catName = currentCell.getStringCellValue();
                                currentCell = cellIterator.next();
                                Category category = getCategory(businessFullDetails, businessId, catName, newCategories, isNew, currentCell.getStringCellValue(),email);
                                images.add(currentCell.getStringCellValue());
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
                product.setProductId(businessUtil.generateRandomString(10,"PRD_"));
                product.setVisibility(true);
                product.setDocType("Product");
                product.setBusinessId(businessId);
                products.add(product);
            }

            System.out.println();

        }
        businessFullDetails.setImages(images);
        businessApiClient.updateBusinessDetails(businessFullDetails,email);
        businessApiClient.batchUploadProduct(email, businessId, products);
        return  "redirect:main";
    }



    @RequestMapping(value = "/{businessId}/batchUploadProductJSON", method = RequestMethod.POST)
    public String uploadProductJSON(Authentication authentication,@PathVariable String businessId,@RequestParam("file")  MultipartFile file) throws IOException {
        String email = UserDetailService.getUserId(authentication);


        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        ObjectMapper objectMapper = new ObjectMapper();
        InputStream in = file.getInputStream();
        boolean isNew = true;

        List<Category> newCategories = new ArrayList<>();
        List<Product> productList = new ArrayList<>();
        List<String> images = new ArrayList<>();
        if(businessFullDetails.getImages() != null){
            images = businessFullDetails.getImages();
        }
        try{
            List<ProductJson> products = Arrays.asList(objectMapper.readValue(in, ProductJson[].class));
            for(ProductJson product: products){
                Product product1 = new Product();
                List<String> categories = new ArrayList<>();
                images.add(product1.getImage());
                for(JsonCategories categorie : product.getCategories()){
                    Category category = getCategory(businessFullDetails,businessId,categorie.getName(),newCategories,isNew,categorie.getImage(),email);
                    categories.add(category.getCategoryId());
                    product1.setCategoryId(categories);
                    images.add(categorie.getImage());
                }
                productList.add(genProductObject(product1,product,businessId));
            }

            businessFullDetails.setImages(images);
            businessApiClient.batchUploadProduct(email, businessId, productList);
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
        }catch (Exception ex){
            System.out.println("Ads");
        }

        return "redirect:main";
    }



    @RequestMapping(value = "/{businessId}/batchUploadCategoryCSV", method = RequestMethod.POST)
    public String uploadCategoryCSV(Authentication authentication,@PathVariable String businessId,@RequestParam("file")  MultipartFile file) throws IOException {
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<Category> categories = businessApiClient.getBusinessCategories(email,businessId);

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
                            images.add(currentCell.getStringCellValue());
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
                if(findDuplicateCategories(businessFullDetails,businessId,categories, category.getName())){
                    newCategories.add(category);
                }
            }

            System.out.println();

        }
        businessFullDetails.setImages(images);
        businessApiClient.batchUploadCategory(email, businessId, newCategories);
        businessApiClient.updateBusinessDetails(businessFullDetails,email);
        return  "redirect:manageCategories";
    }


    @RequestMapping(value = "/{businessId}/batchUploadCategoryJSON", method = RequestMethod.POST)
    public String uploadCategoryJSON(Authentication authentication,@PathVariable String businessId,@RequestParam("file")  MultipartFile file) throws IOException {
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        ObjectMapper objectMapper = new ObjectMapper();
        InputStream in = file.getInputStream();
        List<Category> categories = businessApiClient.getBusinessCategories(email,businessId);
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
                images.add(category.getImage());
                category = getCategory(businessFullDetails,businessId,categoryJson.getName(),newCategories,isNew,categoryJson.getImage(),email);
                if(findDuplicateCategories(businessFullDetails,businessId,categories, categoryJson.getName())){
                    newCategories.add(category);
                }
            }
            businessFullDetails.setImages(images);
            businessApiClient.batchUploadCategory(email, businessId, newCategories);
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
        }catch (Exception ex){
            System.out.println("Ads");
        }

        return "redirect:manageCategories";
    }

    public boolean findDuplicateCategories(BusinessFullDetails businessFullDetails,String businessId, List<Category> categories, String name){
        for (Category category: categories){
            if(category.getName().equals(name)){
                return false;
            }
        }
        return true;
    }

    public Category getCategory(BusinessFullDetails businessFullDetails, String businessId, String catName, List<Category> newCategories, boolean isNew,String image, String email ){
        Category category = businessApiClient.getCategoryByName(email, businessId,catName);
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

    public Product genProductObject(Product product, ProductJson jsonProduct, String businessId){
        product.setProductId(businessUtil.generateRandomString(10,"PRD_"));
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

    @RequestMapping(value = "/{businessId}/manageImages", method = RequestMethod.GET)
    public ModelAndView renderImages(@PathVariable String businessId){
        ModelAndView modelAndView = new ModelAndView("manage-images");
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        modelAndView.addObject("business",businessFullDetails);
        return modelAndView;
    }

    @RequestMapping(value = "/{businessId}/uploadImage", method = RequestMethod.POST)
    public String uploadImage(Authentication authentication,@PathVariable String businessId, @RequestParam String url){
        String email = UserDetailService.getUserId(authentication);

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<String> images = new ArrayList<>();
        if(businessFullDetails.getImages() != null){
            images = businessFullDetails.getImages();
        }
        images.add(url);
        businessFullDetails.setImages(images);
        businessApiClient.updateBusinessDetails(businessFullDetails,email);
        return "redirect:manageImages";
    }










}
