package com.example.demo.domain.notice;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.domain.BaseConfiguration;
import com.example.demo.service.NoticeService;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class NoticeTests extends BaseConfiguration{
	 @Setter(onMethod_ = @Autowired)
	 NoticeRepository p;
	 
	 

    @Test
    public void saveAndLoad() {
    	for(int i = 0; i < 100;i++) {
    		p.saveAndFlush(Notice.builder()
                .title("title" + i)
                .contents("cont")
                .buildcd("4")
                .build());
    	}
        //when
        //List<Notice> postsList = p.findAll();
        //then
        //Notice posts = postsList.get(0);
        
    }
    @Test
    public void getList() {
    	Pageable pageable = PageRequest.of(0,10);
    	Page<Notice> result = p.findAll(pageable);
    	
    	log.info(result.toString());
    }
    @Test
    public void getSearch() {
    	Pageable pageable = PageRequest.of(0,10,Sort.by("no").descending());
    	QNotice qNotice = QNotice.notice; //querydsl 객체
    	
    	String keyword = "cont";
    	String cond = "TC";
    	BooleanBuilder builder = new BooleanBuilder();
    	
    	BooleanBuilder conditionBuilder = new BooleanBuilder();
    	
    	if(cond.contains("T")) {
	    	BooleanExpression exTitle = qNotice.title.contains(keyword); // title LIKE %1%
	    	conditionBuilder.or(exTitle);
    	}
    	if(cond.contains("C")) {
    		BooleanExpression exContents = qNotice.contents.contains(keyword); // contents LIKE %1%
    		conditionBuilder.or(exContents);
    	}
    	builder.and(conditionBuilder);
    	builder.and(qNotice.buildcd.eq("4"));//(buildcd = 4) &&(exTitle || exContents)
    	
    	Page<Notice> result = p.findAll(builder,pageable);
    	
    	log.info(result.toString());
    	
    }
}
