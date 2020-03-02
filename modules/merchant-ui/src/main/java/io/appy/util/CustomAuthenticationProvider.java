package io.appy.util;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import io.appy.api.BusinessApiClient;
import io.appy.api.impl.BusinessApiClientImpl;
import io.appy.domain.LoginAjaxRes;
import io.appy.domain.LoginDetails;
import io.appy.domain.LoginResponse;
import io.appy.domain.UserAccount;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;



public class CustomAuthenticationProvider implements AuthenticationProvider {



    BusinessApiClientImpl businessApiClient = new BusinessApiClientImpl("http://localhost:8081/");

    private static final Logger logger = LogManager.getLogger(CustomAuthenticationProvider.class.getName());

    @Override
    @Produces( MediaType.APPLICATION_JSON_VALUE)
    @Consumes( MediaType.APPLICATION_JSON_VALUE)
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String token = (String) authentication.getCredentials();
        List<GrantedAuthority> grantedAuths = new ArrayList<>();
        LoginDetails loginDetails = new LoginDetails(authentication.getPrincipal().toString(), authentication.getCredentials().toString());
        LoginAjaxRes loginAjaxRes = new LoginAjaxRes();
        LoginResponse loginResponse = businessApiClient.loginUser(loginDetails);
        loginAjaxRes.setEmail(loginResponse.getEmail());
        loginAjaxRes.setBusinessId(loginResponse.getBusinessId());
        if (loginDetails.getPassword().equals(loginResponse.getPassword())) {
            if (loginResponse.getStatus().equals("appconfig")) {
                grantedAuths.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
                loginAjaxRes.setPage("appconfig");
            } else {
                grantedAuths.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
                loginAjaxRes.setPage("appconfiged");
            }
            Authentication auth = new UsernamePasswordAuthenticationToken(loginAjaxRes, token, grantedAuths);
            return auth;
        }
        throw new BadCredentialsException("Username not found.");
    }

    @Override
    public boolean supports(Class<?> authentication) {
        boolean equals = authentication.equals(UsernamePasswordAuthenticationToken.class);
        return equals;
    }
}
