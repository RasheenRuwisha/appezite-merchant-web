package io.appy.error;

public class ApplicationCreationException extends Exception {

    public ApplicationCreationException() {
        super();
    }

    public ApplicationCreationException(String message) {
        super(message);
    }

    public ApplicationCreationException(String message, Throwable cause) {
        super(message, cause);
    }

    public ApplicationCreationException(Throwable cause) {
        super(cause);
    }

    protected ApplicationCreationException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
