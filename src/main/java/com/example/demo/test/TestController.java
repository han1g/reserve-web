package com.example.demo.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/test*")
public class TestController {
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home() {
		return "/test/index";
	}
	
	@RequestMapping(value = "/fileUploadTest", method = RequestMethod.GET)
	public String fileUpload() {
		return "/test/fileUploadTest";
	}
	
	@RequestMapping(value = "/carouselTest", method = RequestMethod.GET)
	public String carousel() {
		return "/test/carouselTest";
	}
	
}
