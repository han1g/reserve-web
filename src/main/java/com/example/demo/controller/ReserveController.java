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
import com.example.demo.domain.etc.ReserveSearchCriteria;
import com.example.demo.domain.etc.RoomSearchCriteria;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.reserve.ReserveDTO;
import com.example.demo.domain.roominfo.RoominfoDTO;
import com.example.demo.service.NoticeService;
import com.example.demo.service.OptionsService;
import com.example.demo.service.ReserveService;
import com.example.demo.service.RoominfoService;
import com.mysema.commons.lang.URLEncoder;

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
		model.addAttribute("startdates", reserveService.getStartdates(roomno));
		model.addAttribute("enddates", reserveService.getEnddates(roomno));
		
		return "URV001C01";
		
	}
	@PostMapping("/register")
	public String reigster(ReserveDTO dto,RedirectAttributes rttr) {
		log.info("register post : " + dto);
		reserveService.register(dto);
		if(dto.getPaymentflg().equals("1")) {
			rttr.addFlashAttribute("result", "결제 완료");
		} else {
			rttr.addFlashAttribute("result", "등록 완료");
		}
		
		return "redirect:/reserve/modify?no=" + dto.getNo() + "&name=" + URLEncoder.encodeParam(dto.getName() , "UTF-8") + "&phone=" + dto.getPhone();
		
		
	}
	
	@GetMapping("modify")
	public String modify(ReserveDTO dto,Model model) {
		return modify(dto,model,"URV001U01");
	}
	
	public String modify(ReserveDTO dto,Model model,String ret) {
		if(dto.getNo() == null) {
			return "redirect:/";
		}
		ReserveDTO retDTO = reserveService.get(dto.getNo());
		if(!retDTO.getName().equals(dto.getName()) || !retDTO.getPhone().equals(dto.getPhone())) {
			return "redirect:/";
		}
		
		
		model.addAttribute("roominfo", dto.getRoominfo());
		model.addAttribute("options", optionsService.getList(false, true));
		model.addAttribute("startdates", reserveService.getStartdates(dto.getRoomno()));
		model.addAttribute("enddates", reserveService.getEnddates(dto.getRoomno()));
		return ret;
	}
	
	@GetMapping("/list")
	public String list(ReserveSearchCriteria cri,Model model) {
		if(cri.getPhone() == null)
			cri.setPhone("");
		if(cri.getName() == null)
			cri.setName("");
		
		cri.setDeleteflg("0");
		
		return list(cri,model,"URV001L01");
	}
	public String list(ReserveSearchCriteria cri,Model model,String ret) {
		model.addAttribute("reserveList", reserveService.getList(cri));
		return ret;
	}
	
	
}
