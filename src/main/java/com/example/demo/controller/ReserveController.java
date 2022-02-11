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
import org.springframework.web.bind.annotation.ResponseBody;
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
	protected RoominfoService roominfoService;
	@Autowired
	protected ReserveService reserveService;
	@Autowired
	protected OptionsService optionsService;
	
	
	
	@RequestMapping("")
	public String root() {
		return "redirect:./list";//relative path
	}

	@GetMapping("/register")
	public String reigster(@RequestParam(name = "roomno",required = true)Long roomno,@ModelAttribute("cri") RoomSearchCriteria cri,Model model) {
		log.info("register-roomno :" + roomno);
		log.info("register-cri :" + cri.getListLink());
		
		model.addAttribute("roominfo", roominfoService.get(roomno));
		model.addAttribute("options", optionsService.getList(false, true));
		model.addAttribute("startdates", reserveService.getStartdates(roomno,null));
		model.addAttribute("enddates", reserveService.getEnddates(roomno,null));
		
		return "URV001C01";
		
	}
	@PostMapping("/register")
	public String reigster(ReserveDTO dto,RedirectAttributes rttr) {
		log.info("register post : " + dto);
		reserveService.register(dto);
		if(dto.getPaymentflg().equals("1")) {
			rttr.addFlashAttribute("result", "支払い完了");
		} else {
			rttr.addFlashAttribute("result", "登録完了\n(支払い無し)");
		}
		
		return "redirect:/reserve/list?name=" + URLEncoder.encodeParam(dto.getName() , "UTF-8") + "&phone=" + dto.getPhone();
		
		
	}
		
	@GetMapping("/modify")
	public String modify(ReserveDTO dto,Model model) {
		// dto : no,name,phone
		if(dto.getNo() == null) {
			return "redirect:/";
		}
		ReserveDTO retDTO = reserveService.get(dto.getNo());
		if(retDTO == null || !retDTO.getName().equals(dto.getName()) || !retDTO.getPhone().equals(dto.getPhone())) {
			return "redirect:/";
		}
		
		
		model.addAttribute("reserve", retDTO);
		model.addAttribute("options", optionsService.getList(false, true));
		model.addAttribute("startdates", reserveService.getStartdates(retDTO.getRoomno(),retDTO.getNo()));
		model.addAttribute("enddates", reserveService.getEnddates(retDTO.getRoomno(),retDTO.getNo()));
		return "URV001U01";
	}
	
	
	@PostMapping("/modify")
	public String modify(ReserveDTO dto,RedirectAttributes rttr) {
		log.info("modify post : " + dto);
		rttr.addFlashAttribute("result", reserveService.modify(dto));
		
		
		return "redirect:/reserve/list?name=" + URLEncoder.encodeParam(dto.getName() , "UTF-8") + "&phone=" + dto.getPhone();
		
		
	}
	
	@GetMapping("/list")
	public String list(ReserveSearchCriteria cri,Model model) {
		if(cri.getPhone() == null)
			cri.setPhone("");
		if(cri.getName() == null)
			cri.setName("");
		
		cri.setDeleteflg("0");
		cri.setCancelflg("0");
		return list(cri,model,"URV001L01");
	}
	public String list(ReserveSearchCriteria cri,Model model,String ret) {
		model.addAttribute("reserveList", reserveService.getList(cri));
		return ret;
	}
	
	
}
