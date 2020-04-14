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

    /**
     * This functions renders the app configuration page
     * @param businessId
     * @return modelAndView
     */
    @RequestMapping(value = "/{businessId}/appconfig", method = RequestMethod.GET)
    public ModelAndView renderAppConfig(ModelAndView modelAndView,@PathVariable String businessId, @RequestParam (required = false) String page){
        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        if(page == null){
            modelAndView.setViewName("home");
        }else{
            modelAndView.setViewName("manage-app");
        }
        modelAndView.addObject("business", businessFullDetails);
        return modelAndView;
    }


    /**
     * This function sets the app configuration for the business and updates them, once the update is done the python script will be executed in a seperate thread
     * @param modelAndView
     * @param authentication
     * @param businessId
     * @param businessFullDetailsUpdate
     * @param page
     * @return
     */
    @RequestMapping(value = "/{businessId}/appconfig", method = RequestMethod.POST)
    public ModelAndView submitAppConfig(ModelAndView modelAndView,Authentication authentication, @PathVariable String businessId, @ModelAttribute BusinessFullDetails businessFullDetailsUpdate, @RequestParam (required = false) String page){
        String email = UserDetailService.getUserId(authentication);


        BusinessFullDetails businessFullDetails = businessApiClient.getBusinessDetails(businessId);
        businessFullDetails.setDescription(businessFullDetailsUpdate.getDescription());
        businessFullDetails.setAppconfig(businessFullDetailsUpdate.getAppconfig());
        businessFullDetails.setAddress(businessFullDetailsUpdate.getAddress());
        businessFullDetails.setTheme(businessFullDetailsUpdate.getTheme());
        if(page == null){
            List<OpenHours> pickUpHours = new ArrayList<>();
            businessFullDetails.setDeliveryHours(pickUpHours);
            businessFullDetails.setPickUpHours(pickUpHours);
        }

        try{
            businessApiClient.updateBusinessDetails(businessFullDetails,email);
            if(page == null){
                modelAndView.setViewName("redirect:/"+businessId+"/manageProducts");
            }else{
                modelAndView.setViewName("redirect:/"+businessId+"/appconfig?page=appconfig");
            }
            modelAndView.addObject("business", businessFullDetails);
            Runnable r = new Runnable() {
                public void run() {
                    String[] cmd;
                    if(page == null){
                        cmd = new String[]{
                                "python3",
                                "/Users/rasheenruwisha/final-year-proj/build.py",
                                businessFullDetails.getName(),
                                businessFullDetails.getEmail(),
                                businessFullDetails.getBusinessId(),
                                businessFullDetails.getAppconfig().getStarterScreen(),
                                businessFullDetails.getAppconfig().getLogo(),
                                businessFullDetails.getTheme().getDark(),
                                businessFullDetails.getAppconfig().getIcon(),
                        };
                    }else{
                        cmd = new String[]{
                                "python3",
                                "/Users/rasheenruwisha/final-year-proj/build.py",
                                businessFullDetails.getName(),
                                businessFullDetails.getEmail(),
                                businessFullDetails.getBusinessId(),
                                businessFullDetails.getAppconfig().getStarterScreen(),
                                businessFullDetails.getAppconfig().getLogo(),
                                businessFullDetails.getTheme().getDark(),
                                businessFullDetails.getAppconfig().getIcon(),
                                businessFullDetails.getAppId()
                        };
                    }

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
            if(page == null){
                modelAndView.setViewName("redirect:/"+businessId+"/manageProducts");
            }else{
                modelAndView.setViewName("redirect:/"+businessId+"/appconfig?page=appconfig");
            }
            modelAndView.addObject("business", businessFullDetails);
            return modelAndView;
        }
    }

}
