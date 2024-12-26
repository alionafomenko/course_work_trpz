package org.example.crawler_api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class CrawlerApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(CrawlerApiApplication.class, args);
	}

}