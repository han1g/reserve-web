package com.example.demo.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.controller.RoominfoController;
import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.PageDTO;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.roominfo.RoominfoDTO;

@Controller
@RequestMapping("/admin/roominfo*")
public class AdminRoominfoController extends RoominfoController {
	
	@GetMapping("/register") //registerpage
	public String register() {
		return "/admin/URR002C01";
	}
	
	@PostMapping("/register")
	public String register(RoominfoDTO dto, RedirectAttributes rttr) {
		service.register(dto);
		rttr.addFlashAttribute("result", dto.getNo());
		
		return "redirect:/admin/roominfo/list";
	}
	
	@Override
	@RequestMapping("/list")
	public String list(Criteria cri,Model model) {
		return list(cri,false,model,"/admin/URR002L01");
	}
	@Override
	@RequestMapping("/get")
	public String get(@RequestParam("no") Long no,@ModelAttribute("cri") Criteria cri,Model model) {
		// TODO Auto-generated method stub
		return get(no,cri,model,"/admin/URR002D01");
	}

	
	
}
