package com.example.demo.service_impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.domain.etc.ReserveSearchCriteria;
import com.example.demo.domain.reserve.QReserve;
import com.example.demo.domain.reserve.Reserve;
import com.example.demo.domain.reserve.Reserve.ReserveBuilder;
import com.example.demo.domain.reserve.ReserveDTO;
import com.example.demo.domain.reserve.ReserveRepository;
import com.example.demo.service.ReserveService;
import com.querydsl.core.BooleanBuilder;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class ReserveServiceImpl implements ReserveService{
	
	@Autowired
	ReserveRepository repo1;
	
	@Override
	public List<ReserveDTO> getList(ReserveSearchCriteria cri) {
		// TODO Auto-generated method stub
		QReserve qReserve = QReserve.reserve;
		
		log.info("roomtitle : " + cri.getRoomtitle());
		log.info("name : " + cri.getName());
		log.info("phone : " + cri.getPhone());
		log.info("cancel : " + cri.getPhone());
		log.info("payment : " + cri.getPhone());
		log.info("delete : " + cri.getPhone());
		
		BooleanBuilder builder = new BooleanBuilder();
		builder.and(qReserve.buildcd.eq("4"));
		if(cri.getRoomtitle() != null) {
			builder.and(qReserve.roominfo.roomtitle.eq(cri.getRoomtitle()));//hibernate가 알아서 joinquery생성
		}
		if(cri.getName() != null) {
			builder.and(qReserve.name.eq(cri.getName()));
		}
		if(cri.getPhone()  != null) {
			builder.and(qReserve.phone.eq(cri.getPhone()));
		}
		if(cri.getCancelflg()  != null) {
			builder.and(qReserve.cancelflg.eq(cri.getCancelflg()));
		}
		if(cri.getPaymentflg()  != null) {
			builder.and(qReserve.paymentflg.eq(cri.getPaymentflg()));
		}
		if(cri.getDeleteflg()  != null) {
			builder.and(qReserve.deleteflg.eq(cri.getDeleteflg()));
		}
		//안적어서 보내면 null, 파라미터 적어놓고 밸류 안넣으면 ""
		
		
		List<ReserveDTO> list = new ArrayList<>();
		repo1.findAll(builder,Sort.by("startdate")).forEach(el -> list.add(el.toDTO()));
		return list;
	}

	@Override
	public void register(ReserveDTO dto) {
		ReserveBuilder builder = Reserve.builder()
				.adult(dto.getAdult())
				.buildcd("4")
				.cancelflg("0")
				.child(dto.getChild())
				.deleteFlg("0")
				.enddate(dto.getEnddate())
				.name(dto.getName())
				.options(dto.getOptions())
				.paymentflg(dto.getPaymentflg())
				.phone(dto.getPhone())
				.roomno(dto.getRoomno())
				.startdate(dto.getStartdate())
				.totalcost(dto.getTotalcost());
		
		if(dto.getPaymentflg().equals("1")) { //결제 완료
			builder.bankbranchcd(dto.getBankbranchcd())
			.bankname(dto.getBankname())
			.bankno(dto.getBankno());
		}
		Reserve en = builder.build();
		repo1.save(en);
		dto.setNo(en.getNo());
	}

	@Override
	public String modify(ReserveDTO dto) {
		Reserve en = repo1.findById(dto.getNo()).get();
		if(dto.getCancelflg().equals("1")) {
			//execute only if cancel
			en.cancel();
			repo1.save(en);
			return "취소완료";
		} else {
			en.update(dto);
			repo1.save(en);
			if(dto.getPaymentflg().equals("1")) {
				return "결제완료";
			} else {
				return "수정완료";
			} 
		}
		
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ReserveDTO get(Long bno) {
		// TODO Auto-generated method stub
		return repo1.findById(bno).get().toDTO();
	}

	@Override
	public boolean restore(Long no) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<String> getStartdates(Long roomno,Long reserveno) {
		// TODO Auto-generated method stub
		QReserve qReserve = QReserve.reserve;
		
		
		BooleanBuilder builder = new BooleanBuilder();
		builder.and(qReserve.buildcd.eq("4"));
		builder.and(qReserve.deleteflg.eq("0"));
		builder.and(qReserve.cancelflg.eq("0"));
		
		if(roomno != null) {
			builder.and(qReserve.roomno.eq(roomno));
		}
		if(reserveno != null) {
			builder.and(qReserve.no.ne(reserveno));
		}// 수정페이지에서 이 예약으로 인해 예약된 날짜는 선택 가능해야 함
		
		List<String> list = new ArrayList<>();
		repo1.findAll(builder).forEach(el -> list.add("'" + el.toDTO().getStartdate() + "'"));
		return list;
	}

	@Override
	public List<String> getEnddates(Long roomno,Long reserveno) {
		// TODO Auto-generated method stub
		QReserve qReserve = QReserve.reserve;
		
		
		BooleanBuilder builder = new BooleanBuilder();
		builder.and(qReserve.buildcd.eq("4"));
		builder.and(qReserve.deleteflg.eq("0"));
		builder.and(qReserve.cancelflg.eq("0"));
		
		if(roomno != null) {
			builder.and(qReserve.roomno.eq(roomno));
		}
		if(reserveno != null) {
			builder.and(qReserve.no.ne(reserveno));
		}// 수정페이지에서 이 예약으로 인해 예약된 날짜는 선택 가능해야 함
		
		List<String> list = new ArrayList<>();
		repo1.findAll(builder).forEach(el -> list.add("'" + el.toDTO().getEnddate() + "'"));
		return list;
	}
	
}
