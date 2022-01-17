package com.example.demo.service;

import java.util.List;
import java.util.Map;

import com.example.demo.domain.consultation.ConsultationDTO;
import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.notice.NoticeDTO;

public interface ConsultationService {
	public Map<String, Object> getList(Criteria cri,boolean deletedList);
	public void register(ConsultationDTO board);
	public boolean modify(ConsultationDTO board);
	public boolean remove(Long bno);
	public ConsultationDTO get(Long no);
	boolean restore(Long no);
}
