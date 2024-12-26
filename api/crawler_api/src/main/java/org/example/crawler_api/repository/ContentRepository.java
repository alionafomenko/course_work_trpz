package org.example.crawler_api.repository;

import org.example.crawler_api.model.Content;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;

@RepositoryRestResource
public interface ContentRepository extends JpaRepository<Content, Long> {

    @Query(value = "SELECT * FROM trpz.get_search_content(?1)", nativeQuery = true)
    List<Content> getSearchContent(String searchPhrase);



}
