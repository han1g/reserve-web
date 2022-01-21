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
	public GetListDTO<RoominfoDTO> getList(Criteria cri, boolean deletedList) {
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
	public boolean modify(RoominfoDTO board) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public RoominfoDTO get(Long bno) {
		// TODO Auto-generated method stub
		return repo1.findById(bno).get().toDTO();
	}

	@Override
	public boolean restore(Long no) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int getTotal(Criteria cri, boolean deletedList) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public static BooleanBuilder searchCondition(Criteria cri,boolean deletedList) {
		QRoominfo qRoominfo = QRoominfo.roominfo; //querydsl 객체
		
    	BooleanBuilder builder = new BooleanBuilder();
    	
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
