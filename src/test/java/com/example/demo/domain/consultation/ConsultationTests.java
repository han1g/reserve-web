package com.example.demo.domain.consultation;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.SqlResultSetMapping;

import org.junit.Test;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.domain.BaseConfiguration;
import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.RoomSearchCriteria;
import com.example.demo.domain.notice.QNotice;
import com.example.demo.service.ConsultationService;
import com.example.demo.utils.SHA256Util;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.QueryFactory;
import com.querydsl.core.types.dsl.BooleanExpression;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class ConsultationTests extends BaseConfiguration {
	 @Autowired
	 ConsultationRepository p;
	 
	 @Autowired
	 ConsultationRepositorySupport p2;
	 
	 @Autowired
	 ConsultationService service;
	 
	QConsultation qConsultation = QConsultation.consultation; //querydsl 객체

	
	@Test
	public void insertLockedDummy() throws NoSuchAlgorithmException {
		String pw = SHA256Util.encrypt("password");
		
		
		
		for(long i = 1 ;i <= 2;i++) {
	        p.save(Consultation.builder()
	                .title("locked" + i)
	                .lockflg("1")
	                .passwd(pw)
	                .grno(i + 2)
	                .grgrod(1L)
	                .depth(1L)
	                .contents("cont")
	                .name("name")
	                .buildcd("4")
	                .build());
    	}
    	for(long j = 2;j <= 20;j++) {
    		p.save(Consultation.builder()
	                .title("locked_reply" + (j - 1))
	                .lockflg("1")
	                .passwd(pw)
	                .grno(3L)
	                .grgrod(j)
	                .depth(2L)
	                .contents("cont")
	                .name("name1")
	                .buildcd("4")
	                .build());
		}
    	
    	for(long j = 2;j <= 3;j++) {
    		p.save(Consultation.builder()
	                .title("locked_reply" + (j - 1))
	                .lockflg("1")
	                .passwd(pw)
	                .grno(4L)
	                .grgrod(j)
	                .depth(2L)
	                .contents("cont")
	                .name("name2")
	                .buildcd("4")
	                .build());
		} 
	}
	
	
    @Test
    public void insertDummy() {
    	/*for(long i = 1 ;i <= 2;i++) {
	        p.save(Consultation.builder()
	                .title("title" + i)
	                .grno(i)
	                .grgrod(1L)
	                .depth(1L)
	                .contents("cont")
	                .name("name")
	                .buildcd("4")
	                .build());
    	}
    	for(long j = 2;j <= 20;j++) {
    		p.save(Consultation.builder()
	                .title("reply" + (j - 1))
	                .grno(1L)
	                .grgrod(j)
	                .depth(2L)
	                .contents("cont")
	                .name("name1")
	                .buildcd("4")
	                .build());
		}
    	
    	for(long j = 2;j <= 3;j++) {
    		p.save(Consultation.builder()
	                .title("reply" + (j - 1))
	                .grno(2L)
	                .grgrod(j)
	                .depth(2L)
	                .contents("cont")
	                .name("name2")
	                .buildcd("4")
	                .build());
		} */
    	
    	Long[] depth = {1L,2L,3L,3L,2L,3L,4L,5L,5L,3L,3L,4L};
    	for(Long i  = 0L ;i < depth.length;i++) {
    		p.save(Consultation.builder()
	                .title("wow" + (i + 1))
	                .grno(1L)
	                .grgrod(i + 1)
	                .depth(depth[i.intValue()])
	                .contents("cont")
	                .name("name2")
	                .buildcd("4")
	                .build());
    	}
    }
    
    @Test
    public void deleteAll() {
    	p.deleteAllInBatch();
    }
    
    @Test
    public void queryDSLTest() {
    	List<Consultation> postsList = p2.findByTitle("title");
    	Consultation posts = postsList.get(0);  
    }
    
    @Test
    @Transactional
    public void subQueryTest() {
    	Criteria cri = new Criteria();
    	cri.setKeyword("title");
    	cri.setType("TWC");
    	cri.setPageNum(2);
    	
    	List<Long> grnos = p2.searchGroups(cri, false);
    	//키워드가 있는 그룹번호만 뽑아서 가져옴
    	
    	
    	BooleanBuilder exp = new BooleanBuilder();
    	exp.and(qConsultation.grno.in(grnos));
    	Pageable pageable = PageRequest.of(cri.getPageNum() - 1, cri.getAmount(),
    			Sort.by("grno").descending()
    			.and(Sort.by("grgrod").ascending()));
    	
    	p.findAll(exp,pageable);
    	
    }
    
    @Test
    public void getGrnoTest() {
    	Criteria cri = new Criteria();
    	
    	p2.searchGroups(cri, false).forEach(el -> log.info("gr:" + el.toString()));
    	
    	
    }
    
    @Test
    public void getMaxGrnoTest() {
    	log.info(p2.getMaxGrno().toString());
    }
    
    @Test
    public void getMaxGrgrodTest() {
    	log.info(p2.getMaxGrgrod(1L).toString());
    	log.info(p2.getMaxGrgrod(2L).toString());
    	log.info(p2.getMaxGrgrod(3L).toString());
    	log.info(p2.getMaxGrgrod(4L).toString());
    	log.info(p2.getMaxGrgrod(5L).toString());
    }
    @Test
    public void existByGrnodTest() {
    	log.info("" + p.existsByGrno(4L));
    	log.info("" + p.existsByGrno(5L));
    }
    
    @Test
    @Transactional
    public void reisterTest() throws NoSuchAlgorithmException {
    	String pw = SHA256Util.encrypt("password");
    	
    	ConsultationDTO dto = ConsultationDTO.builder()
    	.title("locked")
    	.contents("cont")
        .name("name")
        .passwd(pw)
        .lockflg("1")
        .build();
    	
    	service.register(dto);
    }
    @Test
    @Transactional
    public void removeTest() throws NoSuchAlgorithmException  {
    	service.remove(219L);
    }
    
    @Test
    public void encryptTest() throws NoSuchAlgorithmException {
    	log.info("digest;" + SHA256Util.encrypt(""));
    }
    
    @Test
    @Transactional
    public void getReplyPositionTest() {
    	List<Consultation> list  = p.findAll(Sort.by("grgrod").ascending());
    	List<ConsultationDTO> dtoList = list.stream().map(el -> el.toDTO()).collect(Collectors.toList());
    	for(ConsultationDTO el : dtoList) {
    		log.info("el : " +  el);
    		log.info("elReplyPosition :" + p2.getReplyPosition(el.getDepth(), el.getGrno(), el.getGrgrod()));
    	}
    
    	
    }
    @Test
    public void getListLinkTest() {
    	RoomSearchCriteria cri = new RoomSearchCriteria();
    	log.info(cri.toString());
    	log.info(cri.getListLink());
    	
    }
    
}
