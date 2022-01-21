package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.etc.PageDTO;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.roominfo.RoominfoDTO;
import com.example.demo.service.NoticeService;
import com.example.demo.service.RoominfoService;

@Controller
@RequestMapping("/roominfo*")
public class RoominfoController {
	@Autowired
	protected RoominfoService service;
	
	@RequestMapping("")
	public String root() {
		return "redirect:./list";//relative path
	}

	
	@RequestMapping("/list")
	public String list(Criteria cri,Model model) {
		return list(cri,false,model,"URR001L01");
	}
	public String list(Criteria cri,boolean deletedList,Model model, String ret) {
		GetListDTO<RoominfoDTO> list = service.getList(cri,deletedList);
		model.addAttribute("roominfoList",list.getList());
		model.addAttribute("pageMaker",new PageDTO(cri, list.getTotal()));
		return ret;
	}
	
	@RequestMapping("/get")
	public String get(@RequestParam("no") Long no,@ModelAttribute("cri") Criteria cri,Model model) {
		// TODO Auto-generated method stub
		return get(no,cri,model,"URR001D01");
	}
	public String get(Long no,Criteria cri,Model model,String ret) {
		model.addAttribute("roominfo",service.get(no));
		return ret;
	}
	
}
