package com.example.demo.controller.admin;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.options.OptionsDTOList;
import com.example.demo.domain.sliderimages.Sliderimages;
import com.example.demo.domain.sliderimages.SliderimagesDTOList;
import com.example.demo.service.SliderimagesService;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/admin*")
@Slf4j
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private SliderimagesService service;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home2(Model model) {
		model.addAttribute("imagesList", service.getList(false));
		return "/admin/index";
	}
	
	@RequestMapping(value = "/sliderimages", method = RequestMethod.GET)
	public String slider(Model model) {
		model.addAttribute("imagesList", service.getList(false));
		return "/admin/URS002U01";
	}
	@RequestMapping(value = "/deletedSliderimages", method = RequestMethod.GET)
	public String slider2(Model model) {
		model.addAttribute("imagesList", service.getList(true));
		return "/admin/URS002U02";
	}
	
	
	@PostMapping(value ="/sliderimages/register")
	public String sliderRegister(SliderimagesDTOList sliderimages, RedirectAttributes rttr) {
		log.info("" + sliderimages.getSliderimages());
		log.info("" + sliderimages.getSliderimages().size());
		
		service.register(sliderimages.getSliderimages());
		rttr.addFlashAttribute("result","success");
		
		return "redirect:/admin";
	}
	
	
	
	
}
