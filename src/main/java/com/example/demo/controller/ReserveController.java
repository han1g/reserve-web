package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.etc.PageDTO;
import com.example.demo.domain.etc.RoomSearchCriteria;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.reserve.ReserveDTO;
import com.example.demo.domain.roominfo.RoominfoDTO;
import com.example.demo.service.NoticeService;
import com.example.demo.service.OptionsService;
import com.example.demo.service.ReserveService;
import com.example.demo.service.RoominfoService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/reserve*")
@Slf4j
public class ReserveController {
	@Autowired
	RoominfoService roominfoService;
	@Autowired
	ReserveService reserveService;
	@Autowired
	OptionsService optionsService;
	
	
	@RequestMapping("")
	public String root() {
		return "redirect:./list";//relative path
	}

	@GetMapping("/register")
	public String reigster(@RequestParam(name = "roomno",required = true)Long roomno,@ModelAttribute RoomSearchCriteria cri,Model model) {
		log.info("register-roomno :" + roomno);
		log.info("register-cri :" + cri.getListLink());
		
		model.addAttribute("roominfo", roominfoService.get(roomno));
		model.addAttribute("options", optionsService.getList(false, true));
		
		return "URV001C01";
		
	}
	@PostMapping("/register")
	public String reigster(ReserveDTO dto,RedirectAttributes rttr) {
		
		/*if(dto.getPaymentflg().equals("0")) {
			
			
			rttr.addAttribute("result", "success");
			return "redirect:/reserve/modify?no=" + dto.getNo() + "&name=" + dto.getName() + "&phone=" + dto.getPhone();
		}*/
		log.info("register post : " + dto);
		return "home";
		
		
	}
	@GetMapping("modify")
	public String modify(ReserveDTO dto,Model model) {
		return "URV001U01";
		
	}
	
}
