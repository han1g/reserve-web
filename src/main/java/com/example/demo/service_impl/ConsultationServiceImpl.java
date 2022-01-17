package com.example.demo.service_impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.example.demo.domain.consultation.Consultation;
import com.example.demo.domain.consultation.ConsultationDTO;
import com.example.demo.domain.consultation.ConsultationRepository;
import com.example.demo.domain.consultation.ConsultationRepositorySupport;
import com.example.demo.domain.consultation.QConsultation;
import com.example.demo.domain.etc.Criteria;
import com.example.demo.service.ConsultationService;
import com.querydsl.core.BooleanBuilder;

@Service
public class ConsultationServiceImpl implements ConsultationService {
	
	@Autowired
	ConsultationRepository repo1;
	
	@Autowired
	ConsultationRepositorySupport repo2;
	
	QConsultation qConsultation = QConsultation.consultation; //querydsl 객체

	@Override
	public Map<String,Object> getList(Criteria cri, boolean deletedList) {
		// TODO Auto-generated method stub
		
		List<Long> grnos = repo2.searchGroups(cri, false);
    	//키워드가 있는 그룹번호만 뽑아서 가져옴
    	
    	
    	BooleanBuilder exp = new BooleanBuilder();
    	exp.and(qConsultation.grno.in(grnos));
    	Pageable pageable = PageRequest.of(cri.getPageNum() - 1, cri.getAmount(),
    			Sort.by("grno").descending()
    			.and(Sort.by("grgrod").ascending()));
    	
    	Page<Consultation> pageInfo = repo1.findAll(exp,pageable);
    	
		List<ConsultationDTO> list = pageInfo.get().map(s -> s.toDTO()).collect(Collectors.toList());
		Long total = pageInfo.getTotalElements();
		
		Map<String, Object> ret = new HashMap<String, Object>();
		ret.put("list", list);
		ret.put("total",total);
		return ret;
	}

	@Override
	public void register(ConsultationDTO board) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean modify(ConsultationDTO board) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ConsultationDTO get(Long no) {
		// TODO Auto-generated method stub
		return repo1.findById(no).get().toDTO();
	}

	@Override
	public boolean restore(Long no) {
		// TODO Auto-generated method stub
		return false;
	}
	
}
