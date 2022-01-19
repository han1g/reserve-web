package com.example.demo.service;

import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

import com.example.demo.domain.consultation.ConsultationDTO;
import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.notice.NoticeDTO;

public interface ConsultationService {
	public GetListDTO<ConsultationDTO> getList(Criteria cri,boolean deletedList);
	public void register(ConsultationDTO board) throws NoSuchAlgorithmException;
	public void registerAdmin(ConsultationDTO dto);
	
	public boolean modify(ConsultationDTO board) throws NoSuchAlgorithmException;
	public boolean modifyAdmin(ConsultationDTO board) throws NoSuchAlgorithmException;
	public boolean remove(Long bno) throws NoSuchAlgorithmException;
	public ConsultationDTO get(Long no);
	boolean restore(Long no);
	public void registerReply(Long ref_no, ConsultationDTO dto) throws NoSuchAlgorithmException;
	public void registerReplyAdmin(Long ref_no, ConsultationDTO dto);
	
}
