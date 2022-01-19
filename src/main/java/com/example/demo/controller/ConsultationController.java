package com.example.demo.controller;

import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpRequest;
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
import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.etc.PageDTO;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.service.ConsultationService;
import com.example.demo.utils.SHA256Util;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/consultation*")
@Slf4j
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
		GetListDTO<ConsultationDTO> map = service.getList(cri,deletedList);
		List<ConsultationDTO> list = (List<ConsultationDTO>) map.getList();
		model.addAttribute("consultationList",list);
		model.addAttribute("pageMaker", new PageDTO(cri,map.getTotal()));
		return ret;
	}
	
	
	@GetMapping("/get")
	public String get(HttpServletRequest request,@RequestParam("no") Long no,@ModelAttribute("cri") Criteria cri, Model model) throws NoSuchAlgorithmException {
		if(model.getAttribute("consultation") != null) {
			return "URC001D01";
		}//redirected from auth
		
		ConsultationDTO dto = service.get(no);
		log.info("dto.getLockflg():" + dto.getLockflg());
		Object auth = request.getSession().getAttribute(no + "auth");
		if(dto.getLockflg().equals("0") || (auth != null && auth.equals("auth"))) {
			model.addAttribute("consultation", dto);
			return "URC001D01";
		}
		//unlocked or authenticated
		
		model.addAttribute("method", "get");
		return "URC001A01";
	}
	
	@PostMapping("/auth")
	public String get(HttpServletRequest request,@RequestParam("no") Long no,@ModelAttribute("cri") Criteria cri,
			@RequestParam("passwd") String passwd,@RequestParam("method") String method, Model model,RedirectAttributes rttr) throws NoSuchAlgorithmException {
		ConsultationDTO dto = service.get(no);
		
		if(SHA256Util.encrypt(passwd).equals(dto.getPasswd())) {
			request.getSession().setAttribute(no + "auth", "auth");
			
			rttr.addFlashAttribute("consultation", dto);
			return "redirect:/consultation/"+ method  + cri.getListLink() + "&no=" + no;
		}
		//unlocked
		
		model.addAttribute("result","패스워드 오류");
		return "URC001A02";
	}
	
	
	@GetMapping("/register") //registerpage
	public String register() {
		return "URC001C01";
	}
	@PostMapping("/register") //registermethod
	public String register(ConsultationDTO dto,RedirectAttributes rttr) throws NoSuchAlgorithmException {
		service.register(dto);
		rttr.addFlashAttribute("result", dto.getNo());
		
		return "redirect:/consultation/list";
	}
	
	@PostMapping("/modify")
	public String modify(HttpServletRequest request,@RequestParam("lockflg_bef") String lockflg_bef ,ConsultationDTO dto,Criteria cri,Model model, RedirectAttributes rttr) throws NoSuchAlgorithmException {
		//request body �Ӹ��ƴ϶� url �Ķ���͵� ���� ����
		Object auth = request.getSession().getAttribute(dto.getNo() + "auth");
		if(lockflg_bef.equals("0") || (auth != null && auth.equals("auth"))) {
			log.info("modifyPost : " + dto);
			if(service.modify(dto)) {
				rttr.addFlashAttribute("result", "success");
			}
			
			return "redirect:/consultation/list" + cri.getListLink();
		}
		
		model.addAttribute("result","세션이 없거나 만료되었습니다.");
		return "URC001A02";
	}
	@GetMapping("/modify")
	public String modify(HttpServletRequest request,@RequestParam("no") Long no, @ModelAttribute("cri") Criteria cri, Model model) {
		if(model.getAttribute("consultation") != null) {
			return "URC001U01";
		}//redirected from auth
		
		ConsultationDTO dto = service.get(no);
		Object auth = request.getSession().getAttribute(no + "auth");
		if(dto.getLockflg().equals("0") || (auth != null && auth.equals("auth"))) {
			model.addAttribute("consultation", dto);
			return "URC001U01";
		}
		//unlocked or authenticated
		
		model.addAttribute("method", "modify");
		return "URC001A01";
	}
	
	
	@PostMapping("/registerReply")
	public String reply(@RequestParam("ref_no") Long ref_no,ConsultationDTO dto,Criteria cri,RedirectAttributes rttr) throws NoSuchAlgorithmException {
		service.registerReply(ref_no,dto);
		rttr.addFlashAttribute("result", dto.getNo());
		
		return "redirect:/consultation/list" + cri.getListLink();
		
	}
	@GetMapping("/registerReply")
	public String reply(@RequestParam("no") Long no, @ModelAttribute("cri") Criteria cri, Model model) {
		ConsultationDTO dto = service.get(no);
		model.addAttribute("consultation", dto);
		return "URC001C02";
	}


	@PostMapping("/remove")
	public String remove(HttpServletRequest request,@RequestParam("lockflg_bef") String lockflg_bef,@RequestParam("no") Long no,
			Criteria cri, Model model, RedirectAttributes rttr) {
		
		Object auth = request.getSession().getAttribute(no + "auth");
		if(lockflg_bef.equals("0") || (auth != null && auth.equals("auth"))) {
			if(service.remove(no)) {
				rttr.addFlashAttribute("result", "success");
			}
			return "redirect:/consultation/list" + cri.getListLink();
		}
		
		model.addAttribute("result","세션이 없거나 만료되었습니다.");
		return "URC001A02";
	}
	
}
