package io.appy.controller;

import io.appy.api.impl.BusinessApiClientImpl;
import io.appy.domain.BusinessDetailsRequest;
import io.appy.domain.BusinessFullDetails;
import io.appy.domain.OpenHours;
import io.appy.util.UserDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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
    public ModelAndView submitAppConfig(Authentication authentication, @PathVariable String businessId, @ModelAttribute BusinessFullDetails businessFullDetailsUpdate){
        String email = UserDetailService.getUserId(authentication);


        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setDescription(businessFullDetailsUpdate.getDescription());
        businessFullDetails.setAppconfig(businessFullDetailsUpdate.getAppconfig());
        businessFullDetails.setAddress(businessFullDetailsUpdate.getAddress());
        businessFullDetails.setTheme(businessFullDetailsUpdate.getTheme());
        List<OpenHours> pickUpHours = new ArrayList<>();
        businessFullDetails.setDeliveryHours(pickUpHours);
        businessFullDetails.setPickUpHours(pickUpHours);
        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            ModelAndView modelAndView = new ModelAndView("redirect:/"+businessId+"/main");
            modelAndView.addObject("business", businessFullDetails);
            Runnable r = new Runnable() {
                public void run() {
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
                    Process p = null;
                    try {
                        p = Runtime.getRuntime().exec(cmd);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
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
                }
            };

            new Thread(r).start();

            return modelAndView;
        }catch (Exception ex){
            ModelAndView modelAndView = new ModelAndView("redirect:/"+businessId+"/main");
            modelAndView.addObject("business", businessFullDetails);
            return modelAndView;
        }
    }

}
