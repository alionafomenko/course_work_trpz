package org.example.crawler_api.composite;

import org.example.crawler_api.template.BasicCrawler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


public class URLLeaf implements CrawlerComponent {
    private final String url;
    private final int siteId;
    private final int level;
    private final int documentId;
    private final BasicCrawler crawler;

    public URLLeaf(String url, int siteId, int level, int documentId, BasicCrawler crawler) {
        this.url = url;
        this.siteId = siteId;
        this.level = level;
        this.documentId = documentId;
        this.crawler = crawler;
    }

    @Override
    public void crawl() throws Exception {
        crawler.crawl(url, siteId, level, documentId);
    }
}

