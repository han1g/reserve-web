package com.example.demo.service_impl;

import java.security.NoSuchAlgorithmException;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import com.example.demo.domain.consultation.Consultation;
import com.example.demo.domain.consultation.ConsultationDTO;
import com.example.demo.domain.consultation.ConsultationRepository;
import com.example.demo.domain.consultation.ConsultationRepositorySupport;
import com.example.demo.domain.consultation.QConsultation;
import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.notice.Notice;
import com.example.demo.service.ConsultationService;
import com.example.demo.utils.SHA256Util;
import com.querydsl.core.BooleanBuilder;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ConsultationServiceImpl implements ConsultationService {
	
	@Autowired
	ConsultationRepository repo1;
	
	@Autowired
	ConsultationRepositorySupport repo2;
	
	QConsultation qConsultation = QConsultation.consultation; //querydsl 객체

	@Override
	@Transactional
	public GetListDTO<ConsultationDTO> getList(Criteria cri, boolean deletedList) {
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
		
		GetListDTO<ConsultationDTO> ret = new GetListDTO<ConsultationDTO>(list,total.intValue());
		return ret;
	}

	@Override
	@Transactional
	public void register(ConsultationDTO dto) throws NoSuchAlgorithmException {
		Consultation en = Consultation.builder()
				.grno(repo2.getMaxGrno() + 1)//sequence하나 새로 만드는게 나음
				.grgrod(1L)
				.depth(1L)
				.title(dto.getTitle())
				.contents(dto.getContents())
				.name(dto.getName())
				.passwd(dto.getLockflg().equals("0") ? null : SHA256Util.encrypt(dto.getPasswd()))
				.lockflg(dto.getLockflg())
				.buildcd("4")
				.build();
				
		repo1.saveAndFlush(en);
		
		dto.setNo(en.getNo());
	}
	@Override
	@Transactional
	public void registerReply(Long ref_no, ConsultationDTO dto) throws NoSuchAlgorithmException {
		ConsultationDTO refDTO = get(ref_no);
		
		Consultation en = Consultation.builder()
				.grno(refDTO.getGrno())//sequence하나 새로 만드는게 나음
				.grgrod(repo2.getMaxGrgrod(refDTO.getGrno()) + 1)
				.depth(2L)
				.title(dto.getTitle())
				.contents(dto.getContents())
				.name(dto.getName())
				.passwd(dto.getLockflg().equals("0") ? null : SHA256Util.encrypt(dto.getPasswd()))
				.lockflg(dto.getLockflg())
				.buildcd("4")
				.build();
				
		repo1.saveAndFlush(en);
		
		dto.setNo(en.getNo());
		
	}

	@Override
	@Transactional
	public boolean modify(ConsultationDTO board) throws NoSuchAlgorithmException {
		// TODO Auto-generated method stub
		Consultation en = repo1.findById(board.getNo()).get();
		if(en == null)
			return false;
		
		en.update(board.getTitle(), board.getContents(),board.getName(),board.getPasswd(),board.getLockflg());
		repo1.saveAndFlush(en);
		return true;
	}
	
	@Override
	@Transactional
	public boolean modifyAdmin(ConsultationDTO board) {
		// TODO Auto-generated method stub
		Consultation en = repo1.findById(board.getNo()).get();
		if(en == null)
			return false;
		
		en.updateAdmin(board.getTitle(), board.getContents(),board.getName());
		repo1.saveAndFlush(en);
		return true;
	}

	@Override
	@Transactional
	public boolean remove(Long no) {
		log.info("remove start");
		Consultation en = repo1.findById(no).get();
		if(en == null)
			return false;
		
		log.info("depth : " + en.getDepth());
		log.info("grno  : " + en.getGrno());
		if(en.getDepth() != 1L) {
			log.info("no");
			en.delete();
			repo1.saveAndFlush(en);
			return true;
		} else {
			log.info("deletegroup");
			repo2.deleteGroup(en.getGrno());
			return true; 
		}
		
		
	}

	@Override
	@Transactional
	public ConsultationDTO get(Long no) {
		// TODO Auto-generated method stub
		return repo1.findById(no).get().toDTO();
	}

	@Override
	@Transactional
	public boolean restore(Long no) {
		Consultation en = repo1.findById(no).get();
		if(en == null)
			return false;
		
		en.restore();
		repo1.saveAndFlush(en);
		return true;
	}

	


	
}
