package org.example.crawler_api.repository;

import org.example.crawler_api.model.Admin;
import org.example.crawler_api.model.Node;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.Date;
import java.util.List;

@RepositoryRestResource
public interface NodeRepository extends JpaRepository<Node, Long> {

    @Query(value = "SELECT * FROM trpz.get_all_nodes()", nativeQuery = true)
    List<Node> getAllNodes();

    @Query(value = "SELECT * FROM trpz.update_doc_sync_date(?1, ?2)", nativeQuery = true)
    void updateDocSyncDate(int nodeId, Date lastDate);

    @Query(value = "SELECT * FROM trpz.update_site_sync_date(?1, ?2)", nativeQuery = true)
    void updateSiteSyncDate(int nodeId, Date lastDate);

    @Query(value = "SELECT * FROM trpz.update_pic_sync_date(?1, ?2)", nativeQuery = true)
    void updatePicSyncDate(int nodeId, Date lastDate);

    @Query(value = "SELECT * FROM trpz.update_content_sync_date(?1, ?2)", nativeQuery = true)
    void updateContentSyncDate(int nodeId, Date lastDate);


}
