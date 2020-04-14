package io.appy.error;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.UNAUTHORIZED)
public class HttpUnauthorizedException extends RuntimeException {

    public HttpUnauthorizedException() {
        super();
    }

    public HttpUnauthorizedException(String message) {
        super(message);
    }

    public HttpUnauthorizedException(String message, Throwable cause) {
        super(message, cause);
    }

    public HttpUnauthorizedException(Throwable cause) {
        super(cause);
    }

    protected HttpUnauthorizedException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}