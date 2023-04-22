package com.willneiman.HealthfulPeacieNation;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class HealthfulPeacieNationApplication {

	public static void main(String[] args) {
		SpringApplication.run(HealthfulPeacieNationApplication.class, args);
		System.out.println("hello spring boot!");
	}

}
