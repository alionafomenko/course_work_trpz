package org.example.crawler_api.errorHandler.implError;

import org.example.crawler_api.errorHandler.ErrorHandler;

public class GenericErrorHandler implements ErrorHandler {
    @Override
    public void handleError(Exception e) {
        System.out.println("Generic error: " + e.getMessage());
    }
}
