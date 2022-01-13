package com.example.demo.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.PageDTO;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value = "/admin/notice*")
@Slf4j
public class AdminNoticeController {
	
	@Autowired
	NoticeService service;
	
	@RequestMapping("")
	public String root() {
		return "redirect:./list";//relative path
	}
	@RequestMapping("/list")
	public String list(Criteria cri,Model model) {
		List<NoticeDTO> list = service.getList(cri);
		
		log.info("list1 ; " + list.get(0).getCreatedat().toString());
		model.addAttribute("noticeList",list);
		model.addAttribute("pageMaker",new PageDTO(cri, service.getTotal(cri)));
		List<NoticeDTO> list2 = (List<NoticeDTO>) model.getAttribute("noticeList");
		log.info("list2 ; " + list2.get(0).getCreatedat().toString());
		return "/admin/URN002L01";
	}
	
	@RequestMapping("")
	public String register() {
		
	}
}
