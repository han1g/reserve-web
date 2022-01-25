package com.example.demo.service_impl;

import java.util.List;
import java.util.StringTokenizer;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.etc.RoomSearchCriteria;
import com.example.demo.domain.notice.Notice;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.notice.QNotice;
import com.example.demo.domain.roominfo.QRoominfo;
import com.example.demo.domain.roominfo.Roominfo;
import com.example.demo.domain.roominfo.RoominfoDTO;
import com.example.demo.domain.roominfo.RoominfoRepository;
import com.example.demo.service.RoominfoService;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class RoominfoServiceImpl implements RoominfoService{

	@Autowired
	RoominfoRepository repo1;
	
	@Override
	public GetListDTO<RoominfoDTO> getList(RoomSearchCriteria cri, boolean deletedList) {
		Pageable pageable = PageRequest.of(cri.getPageNum() - 1,cri.getAmount(),Sort.by("no").descending());
		BooleanBuilder builder = searchCondition(cri,deletedList);
		
		Page<Roominfo> result = repo1.findAll(builder,pageable);
		List<RoominfoDTO> list = result.stream().map(s->s.toDTO()).collect(Collectors.toList());
		Long total = result.getTotalElements();
		
		
		return new GetListDTO<RoominfoDTO>(list, total.intValue());
	}

	@Override
	@Transactional
	public void register(RoominfoDTO dto) {
		log.info(dto.toString());
		Roominfo en = Roominfo.builder().roomtitle(dto.getRoomtitle())
						.roomnum(dto.getRoomnum())
						.roomtitle(dto.getRoomtitle())
						.explanation(dto.getExplanation())
						.maxpeople(dto.getMaxpeople())
						.adultcost(dto.getAdultcost())
						.childcost(dto.getChildcost())
						.colorcd(dto.getColorcd())
						.images(dto.getImages())
						.buildcd("4")
						.build();
		repo1.saveAndFlush(en);
		dto.setNo(en.getNo());
	}


	@Override
	@Transactional
	public boolean modify(RoominfoDTO dto) {
		// TODO Auto-generated method stub
		Roominfo en = repo1.findById(dto.getNo()).get();
		if(en == null)
			return false;
		
		en.update(dto);
		repo1.saveAndFlush(en);
		
		return true;
	}

	@Override
	@Transactional
	public boolean remove(Long no) {
		// TODO Auto-generated method stub
		Roominfo en = repo1.findById(no).get();
		if(en == null)
			return false;
		
		en.delete();
		repo1.saveAndFlush(en);
		return true;
	}
	
	@Override
	@Transactional
	public boolean restore(Long no) {
		// TODO Auto-generated method stub
		Roominfo en = repo1.findById(no).get();
		if(en == null)
			return false;
		
		en.restore();
		repo1.saveAndFlush(en);
		return true;
	}


	@Override
	public RoominfoDTO get(Long bno) {
		// TODO Auto-generated method stub
		return repo1.findById(bno).get().toDTO();
	}

	
	public static BooleanBuilder searchCondition(RoomSearchCriteria cri,boolean deletedList) {
		QRoominfo qRoominfo = QRoominfo.roominfo; //querydsl 객체
		
    	BooleanBuilder builder = new BooleanBuilder();
    	
    	builder.and(qRoominfo.maxpeople.castToNum(Long.class).between(cri.getMaxpeople_min(), cri.getMaxpeople_max()));
    	builder.and(qRoominfo.adultcost.between(cri.getAdultcost_min(), cri.getAdultcost_max()));
    	builder.and(qRoominfo.childcost.between(cri.getChildcost_min(), cri.getChildcost_max()));
    	if(deletedList) {
    		builder.and(qRoominfo.deleteflg.eq("1"));//deleted
    	}
    	else {
    		builder.and(qRoominfo.deleteflg.eq("0"));//not deleted
    	}
    	builder.and(qRoominfo.buildcd.eq("4"));//(buildcd = 4) &&(exTitle || exContents)
		return builder;
		
	}

}
