package io.appy.controller;

import io.appy.api.impl.BusinessApiClientImpl;
import io.appy.domain.BusinessDetailsRequest;
import io.appy.domain.BusinessFullDetails;
import io.appy.domain.OpenHours;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Controller
public class AppConfigController {

    @Autowired
    BusinessApiClientImpl businessApiClient;

    @RequestMapping(value = "/{businessId}/appconfig", method = RequestMethod.GET)
    public ModelAndView renderAppConfig(@PathVariable String businessId){
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        ModelAndView modelAndView = new ModelAndView("home");
        modelAndView.addObject("business", businessFullDetails);
        return modelAndView;
    }


    @RequestMapping(value = "/{businessId}/appconfig", method = RequestMethod.POST)
    public ModelAndView submitAppConfig(@PathVariable String businessId,@ModelAttribute BusinessFullDetails businessFullDetailsUpdate){
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setDescription(businessFullDetailsUpdate.getDescription());
        businessFullDetails.setAppconfig(businessFullDetailsUpdate.getAppconfig());
        businessFullDetails.setAddress(businessFullDetailsUpdate.getAddress());
        businessFullDetails.setTheme(businessFullDetailsUpdate.getTheme());
        List<OpenHours> pickUpHours = new ArrayList<>();
        businessFullDetails.setDeliveryHours(pickUpHours);
        businessFullDetails.setPickUpHours(pickUpHours);
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails);
            ModelAndView modelAndView = new ModelAndView("redirect:/"+businessId+"/main");
            modelAndView.addObject("business", businessFullDetails);
            String[] cmd = {
                            "python3",
                            "/Users/rasheenruwisha/final-year-proj/build.py",
                            businessFullDetails.getName(),
                            businessFullDetails.getEmail(),
                            businessFullDetails.getBusinessId(),
                            businessFullDetails.getAppconfig().getStarterScreen(),
                            businessFullDetails.getAppconfig().getLogo(),
                            businessFullDetails.getTheme().getDark(),
                    };
            Process p = Runtime.getRuntime().exec(cmd);
            InputStream stdout = p.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(stdout, StandardCharsets.UTF_8));
            String line;
            try{
                while((line = reader.readLine()) != null){
                    System.out.println("stdout: "+ line);
                }
            }catch(IOException e){
                System.out.println("Exception in reading output"+ e.toString());
            }
            return modelAndView;
        }catch (Exception ex){
            ModelAndView modelAndView = new ModelAndView("redirect:/"+businessId+"/main");
            modelAndView.addObject("business", businessFullDetails);
            return modelAndView;
        }
    }

}
