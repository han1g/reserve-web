package com.example.demo.service_impl;

import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.notice.Notice;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.notice.NoticeRepository;
import com.example.demo.domain.notice.QNotice;
import com.example.demo.service.NoticeService;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;

@Service//서비스는 dto를 받아 처리함,querydsl도 서비스에서 처리함
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	NoticeRepository repo;

	@Override
	@Transactional
	public void register(NoticeDTO notice) {
		Notice en = Notice.builder().title(notice.getTitle())
						.contents(notice.getContents())
						.buildcd("4")
						.build();
		repo.saveAndFlush(en);
		notice.setNo(en.getNo());
	}

	@Override
	@Transactional
	public boolean modify(NoticeDTO board) {
		// TODO Auto-generated method stub
		Notice en = repo.findById(board.getNo()).get();
		if(en == null)
			return false;
		
		en.update(board.getTitle(), board.getContents());
		repo.saveAndFlush(en);
		
		return true;
	}

	@Override
	public boolean remove(Long no) {
		// TODO Auto-generated method stub
		repo.deleteById(no);
		return true;
	}

	@Override
	public NoticeDTO get(Long no) {
		// TODO Auto-generated method stub
		//return repo.getOne(no).toDTO(); //getOne: 데이터베이스에 접근안하고 엔티티메니저에서 바로 가져옴
		return repo.findById(no).get().toDTO();
	}

	@Override
	public List<NoticeDTO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		Pageable pageable = PageRequest.of(cri.getPageNum() - 1,cri.getAmount(),Sort.by("no").descending());
		BooleanBuilder builder = searchCondition(cri);
    	
    	Page<Notice> result = repo.findAll(builder,pageable);
    	List<NoticeDTO> ret = result.stream().map(s->s.toDTO()).collect(Collectors.toList());
    	
		return ret;
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		BooleanBuilder builder = searchCondition(cri);
		return (int) repo.count(builder);
	}
	
	private BooleanBuilder searchCondition(Criteria cri) {
		QNotice qNotice = QNotice.notice; //querydsl 객체
		
		String keyword = cri.getKeyword();
    	String cond = cri.getType();
    	BooleanBuilder builder = new BooleanBuilder();
    	
    	BooleanBuilder conditionBuilder = new BooleanBuilder();
    	
    	if(keyword != null) {
	    	if(cond != null && cond.contains("T")) {
		    	BooleanExpression exTitle = qNotice.title.contains(keyword); // title LIKE %1%
		    	conditionBuilder.or(exTitle);
	    	}
	    	if(cond != null && cond.contains("C")) {
	    		BooleanExpression exContents = qNotice.contents.contains(keyword); // contents LIKE %1%
	    		conditionBuilder.or(exContents);
	    	}
    	}
    	builder.and(conditionBuilder);
    	builder.and(qNotice.deleteflg.eq("0"));//not deleted
    	builder.and(qNotice.buildcd.eq("4"));//(buildcd = 4) &&(exTitle || exContents)
		return builder;
		
	}
	
	
}
