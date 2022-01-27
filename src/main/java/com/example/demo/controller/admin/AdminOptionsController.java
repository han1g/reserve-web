package com.example.demo.controller.admin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.etc.PageDTO;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.options.Options;
import com.example.demo.domain.options.OptionsDTO;
import com.example.demo.domain.options.OptionsDTOList;
import com.example.demo.service.ConsultationService;
import com.example.demo.service.OptionsService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value = "/admin/options*")
@Slf4j
public class AdminOptionsController {
	@Autowired
	protected OptionsService service;
	
	@RequestMapping("")
	public String root() {
		return "redirect:./list";//relative path
	}
	
	@PostMapping("/register")
	public String register(OptionsDTOList options, RedirectAttributes rttr) {
		log.info("" + options.getOptions());
		log.info("" + options.getOptions().size());
		
		service.register(options.getOptions());
		rttr.addFlashAttribute("result","success");
		
		return "redirect:/admin/options/list";
	}
	
	@RequestMapping("/list")
	public String list(Model model) {
		return list(model,"/admin/URO002L01");
	}
	public String list(Model model, String ret) {
		List<OptionsDTO> options = service.getList();
		model.addAttribute("options",options);
		return ret;
	}
	
}
