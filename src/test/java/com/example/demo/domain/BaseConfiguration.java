package com.example.demo.domain;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration//xml리소스가 servletContextResource로 로드됨 안달면  ClassPathResource에서 로드됨 
//Caused by: java.io.FileNotFoundException: class path resource [WEB-INF/spring/database.properties] cannot be opened because it does not exist
//Caused by: java.io.FileNotFoundException: Could not open ServletContext resource [/WEB-INF/spring/database.propertiess]
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
public abstract class BaseConfiguration {
	
}
