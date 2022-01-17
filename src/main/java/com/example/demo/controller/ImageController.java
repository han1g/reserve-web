package com.example.demo.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ImageController {
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
		return new ResponseEntity<>("/image?fileName=" + datePath.replace(File.separator,"/") + "/" + fileName,HttpStatus.OK);
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
	
	@GetMapping("/image") 
	public @ResponseBody ResponseEntity<byte[]> getThumb(String fileName) {
		log.info(fileName);
		fileName = fileName.replace("/", File.separator);
		File file = new File("C:\\upload",fileName);
		log.info(fileName);
		
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			log.info(Files.probeContentType(file.toPath()));
			header.add("Content-Type",Files.probeContentType(file.toPath()));//�̹����� MIME
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();// TODO: handle exception
		}
	
		return result;	
	}
}
