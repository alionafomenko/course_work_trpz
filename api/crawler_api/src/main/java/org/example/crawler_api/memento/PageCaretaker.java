package org.example.crawler_api.memento;
import java.util.Stack;

public class PageCaretaker {
    private final Stack<PageMemento> history = new Stack<>();

    public void save(PageMemento memento) {
        history.push(memento);
    }

    public PageMemento undo() {
        if (!history.isEmpty()) {
            return history.pop();
        }
        return null;
    }
}
