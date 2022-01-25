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
import com.example.demo.domain.etc.RoomSearchCriteria;
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
	public String list(RoomSearchCriteria cri,Model model) {
		return list(cri,false,model,"/admin/URR002L01");
	}
	
	@RequestMapping("/deletedList")
	public String deletedList(RoomSearchCriteria cri,Model model) {
		return list(cri,true,model,"/admin/URR002L02");
	}
	
	@Override
	@RequestMapping("/get")
	public String get(@RequestParam("no") Long no,@ModelAttribute("cri") RoomSearchCriteria cri,Model model) {
		// TODO Auto-generated method stub
		return get(no,cri,model,"/admin/URR002D01");
	}
	
	@RequestMapping("/getDeleted")
	public String getDeleted(@RequestParam("no") Long no,@ModelAttribute("cri") RoomSearchCriteria cri,Model model) {
		// TODO Auto-generated method stub
		return get(no,cri,model,"/admin/URR002D02");
	}

	
	@PostMapping("/modify")
	public String modify(RoominfoDTO notice, RoomSearchCriteria cri, RedirectAttributes rttr) {
		//request body �Ӹ��ƴ϶� url �Ķ���͵� ���� ����
		if(service.modify(notice)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/admin/roominfo/list" + cri.getListLink();
		
		//(board/list)��û�� �𵨿� result�� �߰���
	}
	@GetMapping("/modify")
	public String modify(@RequestParam("no") Long no, @ModelAttribute("cri") RoomSearchCriteria cri, Model model) {
		model.addAttribute("roominfo",service.get(no));
		return "/admin/URR002U01";
		//(board/list)��û�� �𵨿� result�� �߰���
	}
	
	
	@PostMapping("/remove")
	public String remove(@RequestParam("no") Long no,RoomSearchCriteria cri, RedirectAttributes rttr) {
		
		if(service.remove(no)) {//delete from db
			
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/admin/roominfo/list" + cri.getListLink();
		//��ũ�� ���� �ҷ�����
		
	}
	
	@PostMapping("/restore")
	public String restore(@RequestParam("no") Long no,RoomSearchCriteria cri, RedirectAttributes rttr) {
		
		if(service.restore(no)) {//restore from db
			
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/admin/roominfo/list";
		//��ũ�� ���� �ҷ�����
		
	}
	
	
}
