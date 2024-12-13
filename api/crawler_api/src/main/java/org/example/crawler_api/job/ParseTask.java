package org.example.crawler_api.job;

import org.example.crawler_api.composite.URLComposite;
import org.example.crawler_api.composite.URLLeaf;
import org.example.crawler_api.errorHandler.ErrorHandler;
import org.example.crawler_api.errorHandler.implError.GenericErrorHandler;
import org.example.crawler_api.errorHandler.implError.HttpStatusErrorHandler;
import org.example.crawler_api.errorHandler.implError.TimeoutErrorHandler;
import org.example.crawler_api.template.BasicCrawler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ParseTask {

    @Autowired
    private BasicCrawler crawler;

    @Scheduled(fixedDelay = 10000)
    public void parseSite() throws Exception {
        System.out.println("parseTask");
        List<org.example.crawler_api.model.Document> documentList = crawler.documentService.getAllDocs();
        System.out.println(documentList);


        URLComposite rootComposite = new URLComposite();


        for (org.example.crawler_api.model.Document document : documentList) {
            int level = document.getLevel();
            if (level < 5) {
                rootComposite.add(new URLLeaf(document.getUrl(), document.getSiteId(), level + 1, document.getId(), crawler));
            }
        }

        rootComposite.crawl();
    }
}

