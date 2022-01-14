package com.example.demo.controller.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.controller.NoticeController;
import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.PageDTO;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.service.NoticeService;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping(value = "/admin/notice*")
@Slf4j
public class AdminNoticeController extends NoticeController{
	
	@Override
	@RequestMapping("/list")
	public String list(Criteria cri,Model model) {
		return list(cri,model,"/admin/URN002L01");
	}
	
	@Override
	@RequestMapping("/get")
	public String get(@RequestParam("no") Long no,@ModelAttribute("cri") Criteria cri,Model model) {
		return get(no,cri,model,"/admin/URN002D01");
	}
	
	@GetMapping("/register")//admin만 가능
	public String register() {
		return "/admin/URN002C01";
	}
	@PostMapping("/register")
	public String register(NoticeDTO notice, RedirectAttributes rttr) {
		service.register(notice);
		rttr.addFlashAttribute("result", notice.getNo());
		
		return "redirect:/admin/notice/list";
	}
	
	@PostMapping(value ="/upload_image")//admin만 가능
	public @ResponseBody ResponseEntity<?> uploadFormPost(MultipartFile uploadFile) throws IOException {
		String datePath = getFolder();
		File uploadPath = new File("C:\\upload",datePath);
		if(!uploadPath.exists()) {//����� root�� C
			log.info("" + uploadPath.mkdirs());//recursive
		}
		MultipartFile multipartFile = uploadFile;
		String ext = multipartFile.getOriginalFilename();
		ext = ext.substring(ext.lastIndexOf("."));
		log.info(multipartFile.getName());//<�Ķ���͸�>
		log.info("" + multipartFile.isEmpty());//������ ����
		log.info("" + multipartFile.getSize());//����ũ��
		log.info("" + multipartFile.getBytes().length);//����Ʈ �迭�� ��ȯ
		log.info("" + multipartFile.getInputStream());//���ϵ����͸� �޴� inputstream
		log.info(ext);
		
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString();
		fileName += ext;
		File savefile = new File(uploadPath,fileName);
		log.info(savefile.getName());
		
		boolean isImage = false;
		try {
			multipartFile.transferTo(savefile);
			if(!checkImageType(savefile)) {
				savefile.delete();
				return new ResponseEntity<>(null,HttpStatus.BAD_REQUEST);
			}
		}catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>("/notice/image?fileName=" + datePath.replace(File.separator,"/") + "/" + fileName,HttpStatus.OK);
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);//CrossPlatform
		
	}
	private boolean checkImageType(File file) {
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	
	
	@PostMapping("/modify")
	public String modify(NoticeDTO notice, Criteria cri, RedirectAttributes rttr) {
		//request body �Ӹ��ƴ϶� url �Ķ���͵� ���� ����
		log.info("modifyPost : " + notice);
		if(service.modify(notice)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		/*rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());*/
		//redirect attribute�� ��ü�� ���ѱ�
		return "redirect:/admin/notice/list" + cri.getListLink();
		
		//(board/list)��û�� �𵨿� result�� �߰���
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam("no") Long no, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("modifyGet");
		model.addAttribute("notice",service.get(no));
		return "/admin/URN002U01";
		//(board/list)��û�� �𵨿� result�� �߰���
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("no") Long no,Criteria cri, RedirectAttributes rttr) {
		
		if(service.remove(no)) {//delete from db
			
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/admin/notice/list" + cri.getListLink();
		//��ũ�� ���� �ҷ�����
		
	}
}
