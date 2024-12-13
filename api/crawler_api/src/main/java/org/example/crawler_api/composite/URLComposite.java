package org.example.crawler_api.composite;

import java.util.ArrayList;
import java.util.List;

public class URLComposite implements CrawlerComponent {
    private final List<CrawlerComponent> children = new ArrayList<>();

    public void add(CrawlerComponent component) {
        children.add(component);
    }

    public void remove(CrawlerComponent component) {
        children.remove(component);
    }

    @Override
    public void crawl() throws Exception {
        for (CrawlerComponent component : children) {
            component.crawl();
        }
    }
}

