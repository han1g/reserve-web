package com.example.demo.controller.admin;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.controller.ConsultationController;
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
@RequestMapping("/admin/consultation*")
@Slf4j
public class AdminConsultationController extends ConsultationController{
	
	@Override
	@RequestMapping("/list")
	public String list(Criteria cri,Model model) {
		return list(cri,false,model,"/admin/URC002L01");
	}
	
	@RequestMapping("/deletedList")
	public String deletedList(Criteria cri,Model model) {
		return list(cri,true,model,"/admin/URC002L02");
	}

	@Override
	@GetMapping("/get")
	public String get(HttpServletRequest request,@RequestParam("no") Long no,@ModelAttribute("cri") Criteria cri, Model model) throws NoSuchAlgorithmException {
		ConsultationDTO dto = service.get(no);
		model.addAttribute("consultation", dto);
		return "/admin/URC002D01"; // no need to auth
	}
	
	@GetMapping("/getDeleted")
	public String getDeleted(HttpServletRequest request,@RequestParam("no") Long no,@ModelAttribute("cri") Criteria cri, Model model) throws NoSuchAlgorithmException {
		ConsultationDTO dto = service.get(no);
		model.addAttribute("consultation", dto);
		return "/admin/URC002D02"; // no need to auth
	}
	
	@Override
	public String auth(HttpServletRequest request,@RequestParam("no") Long no,@ModelAttribute("cri") Criteria cri,
			@RequestParam("passwd") String passwd,@RequestParam("method") String method, Model model,RedirectAttributes rttr) throws NoSuchAlgorithmException {
		return ""; // don't use in admin
	}
	
	@Override
	@GetMapping("/register01") //registerpage
	public String register() {
		return "/admin/URC002C01";
	}
	
	@Override
	@PostMapping("/register01") //registermethod
	public String register(ConsultationDTO dto,RedirectAttributes rttr) throws NoSuchAlgorithmException {
		service.registerAdmin(dto);
		rttr.addFlashAttribute("result", dto.getNo());
		
		return "redirect:/admin/consultation/list";
	}
	
	@Override
	@PostMapping("/modify")
	public String modify(HttpServletRequest request,@RequestParam("lockflg_bef") String lockflg_bef ,ConsultationDTO dto,Criteria cri,Model model, RedirectAttributes rttr) throws NoSuchAlgorithmException {
		if(service.modifyAdmin(dto)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/admin/consultation/list" + cri.getListLink();
	}
	
	@Override
	@GetMapping("/modify")
	public String modify(HttpServletRequest request,@RequestParam("no") Long no, @ModelAttribute("cri") Criteria cri, Model model) {
		ConsultationDTO dto = service.get(no);
		model.addAttribute("consultation", dto);
		return "/admin/URC002U01";
		//no need to auth
	}
	
	@Override
	@PostMapping("/register02")
	public String reply(@RequestParam("ref_no") Long ref_no,ConsultationDTO dto,Criteria cri,RedirectAttributes rttr) throws NoSuchAlgorithmException {
		log.info("registerRelpy : refno = " + ref_no);
		service.registerReplyAdmin(ref_no,dto);
		rttr.addFlashAttribute("result", dto.getNo());
		
		return "redirect:/admin/consultation/list" + cri.getListLink();
		
	}
	@Override
	@GetMapping("/register02")
	public String reply(@RequestParam("no") Long no, @ModelAttribute("cri") Criteria cri, Model model) {
		ConsultationDTO dto = service.get(no);
		model.addAttribute("consultation", dto);
		return "/admin/URC002C02";
	}
	
	@Override
	@PostMapping("/remove")
	public String remove(HttpServletRequest request,@RequestParam("no") Long no,@RequestParam(required = false, name="passwd") String passwd,
			Criteria cri, Model model, RedirectAttributes rttr) throws NoSuchAlgorithmException {
	
			if(service.remove(no)) {
				rttr.addFlashAttribute("result", "success");
			}
			return "redirect:/admin/consultation/list" + cri.getListLink();
	}
	
	@PostMapping("/restore")
	public String restore(@RequestParam("no") Long no,Criteria cri, RedirectAttributes rttr) {
		if(service.restore(no)) {//restore from db
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/admin/consultation/list";
		//��ũ�� ���� �ҷ�����
		
	}
	
}
