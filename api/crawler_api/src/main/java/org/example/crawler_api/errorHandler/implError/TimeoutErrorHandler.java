package org.example.crawler_api.errorHandler.implError;

import org.example.crawler_api.errorHandler.ErrorHandler;

import java.net.SocketTimeoutException;

public class TimeoutErrorHandler implements ErrorHandler {
    private ErrorHandler nextHandler;

    public void setNextHandler(ErrorHandler nextHandler) {
        this.nextHandler = nextHandler;
    }

    @Override
    public void handleError(Exception e) {
        if (e instanceof SocketTimeoutException) {
            System.out.println("Handling timeout error: " + e.getMessage());
        } else if (nextHandler != null) {
            nextHandler.handleError(e);
        }
    }
}
