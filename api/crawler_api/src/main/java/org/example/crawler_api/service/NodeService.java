package org.example.crawler_api.service;


import org.example.crawler_api.model.Admin;
import org.example.crawler_api.model.Node;
import org.example.crawler_api.repository.AdminRepository;
import org.example.crawler_api.repository.NodeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;


@Service
public class NodeService {

    @Autowired
    NodeRepository nodeRepository;

    public NodeService() {

    }
    public List<Node> getAllNodes() {
        return nodeRepository.getAllNodes();
    }

    public void updateDocSyncDate(int nodeId, Date lastDate) {
         nodeRepository.updateDocSyncDate(nodeId, lastDate);
    }

    public void updateSiteSyncDate(int nodeId, Date lastDate) {
        nodeRepository.updateSiteSyncDate(nodeId, lastDate);
    }

    public void updateContentSyncDate(int nodeId, Date lastDate) {
        nodeRepository.updateContentSyncDate(nodeId, lastDate);
    }
    public void updatePicSyncDate(int nodeId, Date lastDate) {
        nodeRepository.updatePicSyncDate(nodeId, lastDate);
    }



}
