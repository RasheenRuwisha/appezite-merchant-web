package io.appy.controller;

import com.google.gson.Gson;
import io.appy.api.impl.BusinessApiClientImpl;
import io.appy.domain.*;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class HomeController {
    @Autowired
    BusinessApiClientImpl businessApiClient;

    @RequestMapping(value = "/{businessId}/main", method = RequestMethod.GET)
    public ModelAndView renderMain(@PathVariable String businessId){
        ModelAndView modelAndView = new ModelAndView("manage-products");
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<Product> products = businessApiClient.getBusinessProducts(businessFullDetails.getEmail(),businessId);
        List<Category>   categories = businessApiClient.getBusinessCategories(businessFullDetails.getEmail(),businessId);
        modelAndView.addObject("products",products);
        modelAndView.addObject("categories",categories);
        modelAndView.addObject("business",businessFullDetails);
        return modelAndView;
    }

    @RequestMapping(value = "/{businessId}/manageCategories", method = RequestMethod.GET)
    public ModelAndView renderCategories(@PathVariable String businessId){
        ModelAndView modelAndView = new ModelAndView("manage-categories");
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<Product> products = businessApiClient.getBusinessProducts(businessFullDetails.getEmail(),businessId);
        List<Category>   categories = businessApiClient.getBusinessCategories(businessFullDetails.getEmail(),businessId);
        modelAndView.addObject("products",products);
        modelAndView.addObject("categories",categories);
        modelAndView.addObject("business",businessFullDetails);
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
    public String addCategory(@ModelAttribute Category category,@RequestParam String email, @PathVariable String businessId){
        try {
            businessApiClient.addCategory(category,email, businessId);
        }catch (Exception ex){
            return "fail";
        }
        return "redirect:manageCategories";
    }

    @RequestMapping(value = "/{businessId}/updateCategory", method = RequestMethod.POST)
    public String updateCategory(@ModelAttribute Category category,@RequestParam String email, @PathVariable String businessId){
        try {
            businessApiClient.updateCategory(category,email, businessId);
        }catch (Exception ex){
            return "fail";
        }
        return "redirect:manageCategories";
    }

    @RequestMapping(value = "/{businessId}/addProduct", method = RequestMethod.POST)
    public String addProduct(@RequestBody Product product, @RequestParam String email, @PathVariable String businessId){
        try {
            if(product.getAddons() == null){
                List<AddonGroup> addons = new ArrayList<AddonGroup>();
                product.setAddons(addons);
            }

            if(product.getVariant() == null){
                product.setVariant(new VariantGroup());
            }
            businessApiClient.addProduct(product,email, businessId);
        }catch (Exception ex){
            return "fail";
        }
        return "success";
    }

    @RequestMapping(value = "/{businessId}/removeProduct", method = RequestMethod.POST)
    public String removeProduct(@RequestParam String productId, @RequestParam String email, @PathVariable String businessId){
        try {
            businessApiClient.removeProduct(productId,email, businessId);
        }catch (Exception ex){
            return "fail";
        }
        return "success";
    }


    @RequestMapping(value = "/{businessId}/updateProduct", method = RequestMethod.POST)
    public String updateProduct(@RequestBody Product product, @RequestParam String email, @PathVariable String businessId){
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
    public ModelAndView submitAppConfig(@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setPickUpHours(businessFullDetailsUpdate.getPickUpHours());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails);
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
    public String submitDeliveryInfo(@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setDeliveryHours(businessFullDetailsUpdate.getDeliveryHours());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails);
            return "Success";
        }catch (Exception ex){
            return "Fail";
        }
    }

    @RequestMapping(value = "/{businessId}/updateDeliveryConfig", method = RequestMethod.POST)
    public String submitDeliveryLocationInfo(@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setDeliveryLocation(businessFullDetailsUpdate.getDeliveryLocation());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails);
            return "Success";
        }catch (Exception ex){
            return "Fail";

        }
    }

    @RequestMapping(value = "/{businessId}/updatePaypalSecret", method = RequestMethod.POST)
    public String submitPaypalSecret(@PathVariable String businessId,@RequestBody BusinessFullDetails businessFullDetailsUpdate){
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setPaypalSecret(businessFullDetailsUpdate.getPaypalSecret());
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails);
            return "Success";
        }catch (Exception ex){
            return "Fail";
        }
    }


    @RequestMapping(value = "/{businessId}/manageOrders", method = RequestMethod.GET)
    public ModelAndView renderOrders(@PathVariable String businessId,@RequestParam (required = false) String startDate, @RequestParam (required = false) String endDate, @RequestParam (required = false) String status){
        ModelAndView modelAndView = new ModelAndView("manage-orders");
        String startDateFormat = "";
        String endDateFormat = "";
        Date date = new Date();
        if(startDate != null){
            DateTimeFormatter formatter = DateTimeFormat.forPattern("YYYY-MM-DD");

            DateTime userStartDate = formatter.parseDateTime(startDate).withTime(0,0,0,0);
            DateTime userEndDate = formatter.parseDateTime(endDate).withTime(23,59,0,0);
            startDateFormat = userStartDate.toString("DD-MM-YYYY HH:mm");
            endDateFormat = userEndDate.toString("DD-MM-YYYY HH:mm");
        }else{
            DateTime startDateIfNotExist = new DateTime(date).withTime(0,0,0,0);
            DateTime endDateIfNotExist = new DateTime(date).withTime(23,59,0,0);
            startDateIfNotExist = startDateIfNotExist.plusDays(-1);
            startDateFormat = startDateIfNotExist.toString("DD-MM-YYYY HH:mm");
            endDateFormat = endDateIfNotExist.toString("DD-MM-YYYY HH:mm");
        }

        List<String> statusList = new ArrayList<>();
        if(status == null){
            status = "All";
        }

        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        List<PurchaseOrders>   purchaseOrders = businessApiClient.getPurchaseOrder(businessFullDetails.getEmail(),businessId,startDateFormat,endDateFormat,status);
        modelAndView.addObject("business",businessFullDetails);
        modelAndView.addObject("purchaseOrders",purchaseOrders);
        return modelAndView;
    }


    @RequestMapping(value = "/{businessId}/acceptOrder", method = RequestMethod.GET)
    public String acceptOrder(@PathVariable String businessId, @RequestParam String orderId, @RequestParam String email){
        OrderUpdate orderUpdate = new OrderUpdate();
        orderUpdate.setStatus("ACCEPTED");
        orderUpdate.setOrderId(orderId);
        PurchaseOrders  purchaseOrders = businessApiClient.updatePurchaseOrderStatus(email,businessId,orderUpdate);
        return "redirect:manageOrders";
    }



    @RequestMapping(value = "/{businessId}/completeOrder", method = RequestMethod.GET)
    public String completeOrder(@PathVariable String businessId, @RequestParam String orderId, @RequestParam String email){
        OrderUpdate orderUpdate = new OrderUpdate();
        orderUpdate.setStatus("COMPLETED");
        orderUpdate.setOrderId(orderId);
        PurchaseOrders  purchaseOrders = businessApiClient.updatePurchaseOrderStatus(email,businessId,orderUpdate);
        return "redirect:manageOrders";
    }

    @RequestMapping(value = "/{businessId}/rejectOrder", method = RequestMethod.GET)
    public String rejectOrder(@PathVariable String businessId, @RequestParam String orderId, @RequestParam String email){
        OrderUpdate orderUpdate = new OrderUpdate();
        orderUpdate.setStatus("REJECTED");
        orderUpdate.setOrderId(orderId);
        PurchaseOrders  purchaseOrders = businessApiClient.updatePurchaseOrderStatus(email,businessId,orderUpdate);
        return "redirect:manageOrders";
    }

}
