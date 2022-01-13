package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.domain.etc.Criteria;

@Controller
@RequestMapping(value= "/notice*")
public class NoticeController {
	@RequestMapping("")
	public String root() {
		return "redirect:./list";//relative path
	}
	@RequestMapping("/list")
	public String list(Criteria cri,Model model) {
		return "URN001L01";
	}
}
