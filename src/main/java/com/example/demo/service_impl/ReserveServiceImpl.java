package com.example.demo.service_impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.domain.reserve.QReserve;
import com.example.demo.domain.reserve.Reserve;
import com.example.demo.domain.reserve.Reserve.ReserveBuilder;
import com.example.demo.domain.reserve.ReserveDTO;
import com.example.demo.domain.reserve.ReserveRepository;
import com.example.demo.service.ReserveService;
import com.querydsl.core.BooleanBuilder;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReserveServiceImpl implements ReserveService{
	
	@Autowired
	ReserveRepository repo1;
	
	@Override
	public List<ReserveDTO> getList(Long roomno, String phone, String name, boolean deletedList) {
		// TODO Auto-generated method stub
		QReserve qReserve = QReserve.reserve;
		
	
		BooleanBuilder builder = new BooleanBuilder();
		builder.and(qReserve.buildcd.eq("4"));
		if(deletedList) {
			builder.and(qReserve.deleteflg.eq("1"));
		} else {
			builder.and(qReserve.deleteflg.eq("0"));
		}
		if(roomno != null) {
			builder.and(qReserve.roomno.eq(roomno));
		}
		if(phone != null) {
			builder.and(qReserve.name.eq(name));
		}
		if(name != null) {
			builder.and(qReserve.phone.eq(phone));
		}
		
		List<ReserveDTO> list = new ArrayList<>();
		repo1.findAll(builder).forEach(el -> list.add(el.toDTO()));
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
	}

	@Override
	public boolean modify(ReserveDTO board) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ReserveDTO get(Long bno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean restore(Long no) {
		// TODO Auto-generated method stub
		return false;
	}
	
}
