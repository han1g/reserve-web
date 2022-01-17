package com.example.demo.controller;

import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.domain.consultation.Consultation;
import com.example.demo.domain.consultation.ConsultationDTO;
import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.PageDTO;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.service.ConsultationService;
import com.example.demo.utils.SHA256Util;

@Controller
@RequestMapping("/consultation*")
public class ConsultationController {
	
	@Autowired
	protected ConsultationService service;
	
	@RequestMapping("")
	public String root() {
		return "redirect:./list";//relative path
	}
	
	@RequestMapping("/list")
	public String list(Criteria cri,Model model) {
		return list(cri,false,model,"URC001L01");
	}
	public String list(Criteria cri,boolean deletedList,Model model, String ret) {
		Map<String,Object> map = service.getList(cri,deletedList);
		List<ConsultationDTO> list = (List<ConsultationDTO>) map.get("list");
		model.addAttribute("consultationList",list);
		model.addAttribute("pageMaker", new PageDTO(cri, ((Long) map.get("total")).intValue()));
		return ret;
	}
	
	
	@GetMapping("/get")
	public String get(@RequestParam("no") Long no,@ModelAttribute("cri") Criteria cri, Model model) throws NoSuchAlgorithmException {
		if(model.getAttribute("consultation") != null) {
			return "URC001D01";
		}//authenticated
		
		ConsultationDTO dto = service.get(no);
		if(dto.getLockflg() == "0") {
			model.addAttribute("consultation", dto);
			return "URC001D01";
		}
		//unlocked
		
		model.addAttribute("method", "get");
		return "URC001A01";
	}
	@PostMapping("/get")
	public String get(@RequestParam("no") Long no,@RequestParam("pw") String pw, @ModelAttribute("cri") Criteria cri, Model model, RedirectAttributes rttr) throws NoSuchAlgorithmException {
		ConsultationDTO dto = service.get(no);
		if(SHA256Util.encrypt(pw).equals(dto.getPasswd())) {
			rttr.addFlashAttribute("consultation", dto);
			return "redirect:/consultation/get" + cri.getListLink() + "&no=" + no;
		}
		//unlocked
		
		rttr.addFlashAttribute("result","패스워드 오류");
		return "redirect:/consultation/get" + cri.getListLink() + "&no=" + no;
	}
	
	
	@GetMapping("/register") //Todo
	public String register() {
		return null;
	}
	
	@GetMapping("/reply") //Todo
	public String reply() {
		return null;
	}
	
	@GetMapping("/remove") //Todo
	public String remove() {
		return null;
	}
	
	
}
