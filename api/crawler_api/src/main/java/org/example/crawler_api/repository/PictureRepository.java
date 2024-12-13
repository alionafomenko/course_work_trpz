package org.example.crawler_api.repository;

import org.example.crawler_api.model.Picture;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;

@RepositoryRestResource
public interface PictureRepository extends JpaRepository<Picture, Long> {

    @Query(value = "SELECT * FROM trpz.add_picture(?1, ?2, ?3)", nativeQuery = true)
    void addPicture(int siteId, String link, String parentUrl);

    @Query(value = "SELECT * FROM trpz.get_site_pictures_1_page(?1, ?2)", nativeQuery = true)
    List<Picture> getPicturesBySiteId(int siteId, int pageNumber);

    @Query(value = "SELECT * from trpz.add_sync_pics(?1, ?2, ?3, ?4)", nativeQuery = true)
    String addSyncPics(int siteId, String url, String parentUrl, String insertDate);

    @Query(value = "SELECT * from trpz.get_pics_from_node(?1)", nativeQuery = true)
    List<Picture> getPicsFromNode(String lastSyncPicDate);


}
