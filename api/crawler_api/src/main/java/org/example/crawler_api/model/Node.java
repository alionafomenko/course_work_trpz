package org.example.crawler_api.model;


import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

import java.util.Date;

@Data
@Entity
public class Node {

    @Id
    private  int id;
    private  String ip;
    private  String port;
    private Date syncDocDate;
    private  String status;
    private Date syncPicDate;
    private Date syncContentDate;
    private Date syncSiteDate;

    public Date getSyncSiteDate() {
        return syncSiteDate;
    }

    public void setSyncSiteDate(Date syncSiteDate) {
        this.syncSiteDate = syncSiteDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public Date getSyncDocDate() {
        return syncDocDate;
    }

    public void setSyncDocDate(Date syncDocDate) {
        this.syncDocDate = syncDocDate;
    }

    public Date getSyncPicDate() {
        return syncPicDate;
    }

    public void setSyncPicDate(Date syncPicDate) {
        this.syncPicDate = syncPicDate;
    }

    public Date getSyncContentDate() {
        return syncContentDate;
    }

    public void setSyncContentDate(Date syncContentDate) {
        this.syncContentDate = syncContentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


}
