package com.boot.bootmybatisdubbostudentcustomer;

import com.alibaba.dubbo.spring.boot.annotation.EnableDubboConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.boot.action"})
@EnableDubboConfiguration
public class BootmybatisDubboStudentCustomerApplication {

    public static void main(String[] args) {
        SpringApplication.run(BootmybatisDubboStudentCustomerApplication.class, args);
    }

}
