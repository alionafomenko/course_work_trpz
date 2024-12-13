package org.example.crawler_api.template;

import org.springframework.stereotype.Component;

@Component
public class BasicCrawler extends AbstractCrawler {

    @Override
    protected int handleIOException(Exception e) {
        if (e instanceof org.jsoup.HttpStatusException) {
            return ((org.jsoup.HttpStatusException) e).getStatusCode();
        } else if (e instanceof java.net.SocketTimeoutException) {
            return 0;
        } else if (e instanceof org.jsoup.UnsupportedMimeTypeException) {
            return 415;
        } else {
            return 500;
        }
    }
}
