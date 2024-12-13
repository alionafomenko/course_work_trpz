package org.example.crawler_api.service;


import org.example.crawler_api.model.Picture;
import org.example.crawler_api.repository.PictureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PictureService {

    @Autowired
    PictureRepository pictureRepository;

    public PictureService() {

    }

    public void addPicture(int siteId, String link,  String parentUrl) {
        pictureRepository.addPicture(siteId, link, parentUrl);
    }

    public List<Picture> getPicturesBySiteId(int siteId, int pageNumber) {
       return pictureRepository.getPicturesBySiteId(siteId, pageNumber);
    }

    public List<Picture> getPicsFromNode(String lastSyncPicDate) {
        return pictureRepository.getPicsFromNode(lastSyncPicDate);
    }

    public String addSyncPics(int siteId, String url, String parentUrl, String insertDate) {
        return pictureRepository.addSyncPics(siteId, url, parentUrl, insertDate);
    }


}
