package org.example.crawler_api.memento;

public class PageState {
    private String currentHtml;
    private String title;

    public void setState(String currentHtml, String title) {
        this.currentHtml = currentHtml;
        this.title = title;
    }

    public PageMemento saveStateToMemento() {
        return new PageMemento(currentHtml, title);
    }

    public void restoreStateFromMemento(PageMemento memento) {
        this.currentHtml = memento.getOriginalHtml();
        this.title = memento.getTitle();
    }

    public String getCurrentHtml() {
        return currentHtml;
    }

    public String getTitle() {
        return title;
    }
}

