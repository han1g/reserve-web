package com.example.demo.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.PageDTO;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value= "/notice*")
@Slf4j
public class NoticeController {
	
	@Autowired
	protected NoticeService service;
	
	@RequestMapping("")
	public String root() {
		return "redirect:./list";//relative path
	}

	
	@RequestMapping("/list")
	public String list(Criteria cri,Model model) {
		return list(cri,false,model,"URN001L01");
	}
	public String list(Criteria cri,boolean deletedList,Model model, String ret) {
		List<NoticeDTO> list = service.getList(cri,deletedList);
		model.addAttribute("noticeList",list);
		model.addAttribute("pageMaker",new PageDTO(cri, service.getTotal(cri,deletedList)));
		return ret;
	}
	
	
	@RequestMapping("/get")
	public String get(@RequestParam("no") Long no,@ModelAttribute("cri") Criteria cri,Model model) {
		// TODO Auto-generated method stub
		return get(no,cri,model,"URN001D01");
	}
	public String get(Long no,Criteria cri,Model model,String ret) {
		model.addAttribute("notice",service.get(no));
		return ret;
	}
	
	
	
	
	
	
	
	
}
