package io.appy.util;

import io.appy.domain.LoginAjaxRes;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CustomSuccessHandler implements AuthenticationSuccessHandler {
    @Override
    public void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {
        LoginAjaxRes loginAjaxRes = (LoginAjaxRes) authentication.getPrincipal();
        if(loginAjaxRes.getPage().equals("appconfig")){
            httpServletResponse.sendRedirect("/merchant/"+loginAjaxRes.getBusinessId()+"/appconfig");
        }else{
            httpServletResponse.sendRedirect("/merchant/"+loginAjaxRes.getBusinessId()+"/main");
        }
    }
}
