package io.appy.util;

import io.appy.domain.LoginAjaxRes;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;

public class UserDetailService {

    public static String getUserId(Authentication authentication) {
        LoginAjaxRes loginAjaxRes = (LoginAjaxRes) authentication.getPrincipal();
        return loginAjaxRes.getEmail();
    }


}
