package org.example.crawler_api.template;


import org.example.crawler_api.service.DocumentService;
import org.example.crawler_api.service.PictureService;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;

public abstract class AbstractCrawler {

    @Autowired
    protected PictureService pictureService;

    @Autowired
    public DocumentService documentService;



    public void crawl(String url, int siteId, int level, int documentId) throws Exception {
        StringBuilder content = new StringBuilder();
        String title = "";
        String httpStatus = String.valueOf(0);


        System.out.println(url);
        try {
            Document doc = Jsoup.connect(url)
                    .userAgent("AlionaCrawler")
                    .timeout(20000)
                    .followRedirects(true)
                    .referrer("https://google.com")
                    .get();



            Elements elements = doc.getAllElements();
            httpStatus = String.valueOf(doc.connection().response().statusCode());

            for (Element element : elements) {
                processElement(element, siteId, level, url, content);
                if ("title".equals(element.tagName())) {
                    title = element.ownText();
                }
            }

            documentService.saveContent(documentId, title, content.toString(), "scanned", httpStatus);

        } catch (IOException e) {
            httpStatus = String.valueOf(handleIOException(e));
            System.out.println("error  " + httpStatus + "  url  " + url);
            documentService.saveContent(documentId, title, "", "error", httpStatus);

        }
    }

    protected abstract int handleIOException(Exception e);

    private void processElement(Element element, int siteId, int level, String parentUrl, StringBuilder content) {
        String tagName = element.tagName();
        if ("a".equals(tagName)) {
            handleLink(element, siteId, level, parentUrl);
        } else if ("img".equals(tagName)) {
            handleImage(element, siteId, parentUrl);
        } else {
            String text = element.ownText();
            if (!text.isEmpty()) {
                content.append("<p>").append(text).append("</p>\n");
            }
        }
    }

    private void handleLink(Element element, int siteId, int level, String parentUrl) {
        String link = element.attr("href");
        if (!link.endsWith(".jpg") && !link.endsWith(".png") && !link.endsWith(".jpeg") && !link.endsWith(".svg")) {
            if (!link.endsWith(".pdf")) {
                if (!link.startsWith("http")) {
                    if (link.startsWith("/")) {
                        // System.out.println("link  " + link);
                        documentService.addDoc(siteId, link, parentUrl, "to_do", level);
                    }
                } else {
                    documentService.addDoc(siteId, link, parentUrl, "external_link", 0);
                }
            }

        } else {
            handleImage(element, siteId, parentUrl);
        }

    }

    private void handleImage(Element element, int siteId, String parentUrl) {
        String picLink = element.attr("src");
        if (picLink != null){
            pictureService.addPicture(siteId, picLink, parentUrl);
        }

    }
}
