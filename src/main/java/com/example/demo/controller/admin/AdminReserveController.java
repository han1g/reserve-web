package com.example.demo.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.controller.ReserveController;
import com.example.demo.domain.etc.ReserveSearchCriteria;
import com.example.demo.domain.etc.RoomSearchCriteria;
import com.example.demo.domain.reserve.ReserveDTO;
import com.example.demo.service.OptionsService;
import com.example.demo.service.ReserveService;
import com.example.demo.service.RoominfoService;
import com.mysema.commons.lang.URLEncoder;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/reserve*")
@Slf4j
public class AdminReserveController extends ReserveController{
	
	@Override
	public String reigster(@RequestParam(name = "roomno",required = true)Long roomno,@ModelAttribute RoomSearchCriteria cri,Model model) {
		return root();
	}
	@Override
	public String reigster(ReserveDTO dto,RedirectAttributes rttr) {
		return root();
	}
	////admin doesn't register
	
	@Override
	@GetMapping("modify")
	public String modify(ReserveDTO dto,Model model) {
		return "/admin/URV002U01";
	}
	
	@Override
	@GetMapping("/list")
	public String list(ReserveSearchCriteria cri,Model model) {
		cri.emptyToNull();
		return list(cri,model,"/admin/URV002L01");
	}
	
	
	
}
