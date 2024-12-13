package org.example.crawler_api.memento;

public class PageMemento {
    private  String originalHtml;
    private  String title;

    public PageMemento(String originalHtml, String title) {
        this.originalHtml = originalHtml;
        this.title = title;
    }

    public String getOriginalHtml() {
        return originalHtml;
    }

    public String getTitle() {
        return title;
    }
}

