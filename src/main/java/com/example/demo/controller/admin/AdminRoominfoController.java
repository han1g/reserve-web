package com.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/roominfo*")
public class AdminRoominfoController {
	
	@GetMapping("/register") //registerpage
	public String register() {
		return "/admin/URR002C01";
	}
}
