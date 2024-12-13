package org.example.crawler_api.service;

import org.example.crawler_api.model.Content;
import org.example.crawler_api.repository.ContentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContentService {

    @Autowired
    ContentRepository contentRepository;

    public ContentService() {

    }

    public List<Content> getSearchContent(String searchPhrase) {
        return contentRepository.getSearchContent(searchPhrase);
    }


}
