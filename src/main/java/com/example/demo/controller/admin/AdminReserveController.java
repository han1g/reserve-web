package com.example.demo.controller.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.controller.ReserveController;
import com.example.demo.domain.etc.ReserveSearchCriteria;
import com.example.demo.domain.etc.RoomSearchCriteria;
import com.example.demo.domain.reserve.ReserveDTO;
import com.example.demo.service.OptionsService;
import com.example.demo.service.ReserveService;
import com.example.demo.service.RoominfoService;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.mysema.commons.lang.URLEncoder;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/reserve*")
@Slf4j
public class AdminReserveController {
	
	@Autowired
	private ReserveService reserveService;
	@Autowired
	private OptionsService optionsService;
	
	@Autowired
	private ReserveController reserveController;
	
	
	@GetMapping("/modify")
	public String modify(ReserveDTO dto, ReserveSearchCriteria cri,
			 Long cri_roomno 
			,String cri_roomtitle 
			,String cri_name 
			,String cri_phone 
			,String cri_cancelflg 
			,String cri_paymentflg 
			,String cri_deleteflg
			,Model model) {
		// dto : no,name,phone
		ReserveDTO retDTO = reserveService.get(dto.getNo());
			
		
		cri.setRoomno(cri_roomno);
		cri.setRoomtitle(cri_roomtitle);
		cri.setName(cri_name);
		cri.setPhone(cri_phone);
		cri.setCancelflg(cri_cancelflg);
		cri.setPaymentflg(cri_paymentflg);
		cri.setDeleteflg(cri_deleteflg);
		
		model.addAttribute("cri",cri);
		
		model.addAttribute("reserve", retDTO);
		model.addAttribute("options", optionsService.getList(false, true));
		model.addAttribute("startdates", reserveService.getStartdates(retDTO.getRoomno(),retDTO.getNo()));
		model.addAttribute("enddates", reserveService.getEnddates(retDTO.getRoomno(),retDTO.getNo()));
		return "/admin/URV002U01";
	}
	
	
	@PostMapping("/modify")
	public String modify(ReserveDTO dto,RedirectAttributes rttr) {
		log.info("modify post : " + dto);
		
		
		rttr.addFlashAttribute("result", reserveService.modifyAdmin(dto));
		
		
		return "redirect:/admin/reserve/list";
	}
	@PostMapping("/cancel")
	public String cancel(ReserveDTO dto,RedirectAttributes rttr) {
		log.info("cancel post : " + dto);
		
		
		rttr.addFlashAttribute("result", reserveService.cancelAdmin(dto));
		
		
		return "redirect:/admin/reserve/list";
	}
	@PostMapping("/remove")
	public String remove(ReserveDTO dto,RedirectAttributes rttr) {
		log.info("remove post : " + dto);
		
		
		rttr.addFlashAttribute("result", reserveService.removeAdmin(dto));
		
		
		return "redirect:/admin/reserve/list";
	}
	
	@ResponseBody
	@PostMapping("/validateDate")
	public ResponseEntity<?> validateDate(@RequestBody Map<String,String> dates) {
		
		if(reserveService.validateDate(Long.parseLong(dates.get("roomno")),dates.get("startdate"),dates.get("startdate"))){
			return new ResponseEntity<>(HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
	} 

	@GetMapping("/list")
	public String list(@ModelAttribute("cri") ReserveSearchCriteria cri,Model model) {
		cri.emptyToNull();
		//파라미터 명만 적고 값을 안적으면 null이 아니라 빈 문자열이 들어오므로 빈문자열을 null로 바꿔줘야함
		
		return reserveController.list(cri,model,"/admin/URV002L01");
	}
	
	
	
}
