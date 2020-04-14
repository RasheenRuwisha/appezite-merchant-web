package io.appy.controller;

import io.appy.domain.*;
import io.appy.util.BusinessUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import io.appy.api.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {

    private static final Logger logger = Logger.getLogger(LoginController.class);

    @Autowired
    BusinessApiClient businessApiClient;

    BusinessUtil businessUtil = new BusinessUtil();


    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView registerUser(){
        ModelAndView modelAndView = new ModelAndView("register");
        modelAndView.addObject("filledDetails",new BusinessDetails());
        logger.info("New register request ");
        return  modelAndView;
    }

    @RequestMapping(value = "/createBusiness", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView createBusiness(@ModelAttribute BusinessDetails businessDetails){
        try{
            businessDetails.setPhone(businessDetails.getCountryCode() + businessDetails.getPhone());
            businessDetails.setBusinessId(businessUtil.generateRandomString(10,"BIZ_"));
            BusinessDetailResponse businessDetailResponse= businessApiClient.createBusiness(businessDetails);
            ModelAndView modelAndView = new ModelAndView("redirect:/login");
            modelAndView.addObject("username",businessDetailResponse.getEmail());

            logger.info("New login request by " + businessDetailResponse.getEmail());
            return modelAndView;
        }catch (Exception ex){
            ModelAndView modelAndView = new ModelAndView("register");
            modelAndView.addObject("filledDetails",businessDetails);
            modelAndView.addObject("error","User exists");
            logger.info("New login request by existing user");
            return modelAndView;
        }
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(){
        logger.info("Login path executed!");
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public LoginAjaxRes doLogin(@RequestBody LoginDetails loginDetails,ModelAndView model){
        LoginAjaxRes loginAjaxRes = new LoginAjaxRes();
        try{
            logger.info("New login request by " + loginDetails.getEmail());

            LoginResponse loginResponse = businessApiClient.loginUser(loginDetails);
            loginAjaxRes.setEmail(loginResponse.getEmail());
            loginAjaxRes.setBusinessId(loginResponse.getBusinessId());
            if(loginDetails.getPassword().equals(loginResponse.getPassword())){
                if(loginResponse.getStatus().equals("appconfig")){
                    loginAjaxRes.setPage("register");
                }else{
                    loginAjaxRes.setPage("home");
                }
            }
        }catch (Exception ex){
            logger.error("New login exception", ex);
            System.out.println("bisssh");
        }
        return loginAjaxRes;
    }

}

