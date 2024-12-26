package org.example.crawler_api.repository;

import org.example.crawler_api.model.Document;
import org.example.crawler_api.model.Site;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.Date;
import java.util.List;

@RepositoryRestResource
public interface DocumentRepository extends JpaRepository<Document, Long> {

    @Query(value = "SELECT  trpz.add_document(?1, ?2, ?3, ?4, ?5)", nativeQuery = true)
    String addDocument(int siteId, String url, String parentUrl, String status, int level);

    @Query(value = "SELECT  trpz.add_sync_document(?1, ?2, ?3, ?4, ?5, ?6, ?7)", nativeQuery = true)
    String addSyncDocument(int siteId, String url, String parentUrl, String status, int level, String insertDate, int nodeId);

    @Query(value = "SELECT * FROM trpz.get_all_documents()", nativeQuery = true)
    List<Document> getAllDocs();

    @Query(value = "SELECT * FROM trpz.get_document_from_node(?1)", nativeQuery = true)
    List<Document> getDocumentsFromNode(String lastSyncDocDate);

    @Query(value = "SELECT  trpz.add_sync_content(?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9 )", nativeQuery = true)
    String addSyncContent(String url, String title, String scanDate, String content, int siteId, String insertDate, String parentUrl, int level, int nodeId);

    @Query(value = "SELECT * FROM trpz.get_content_from_node(?1)", nativeQuery = true)
    List<Document> getContentFromNode(String lastSyncDocDate);


    @Query(value = "SELECT trpz.save_content(?1, ?2, ?3, ?4, ?5)", nativeQuery = true)
    void saveContent(int docId, String title, String content, String status, String httpStatus);

}
