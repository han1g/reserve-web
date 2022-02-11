package com.example.demo.domain.reserve;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.example.demo.domain.BaseConfiguration;
import com.example.demo.service.ReserveService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ReserveTests extends BaseConfiguration {
	@Setter(onMethod_ = @Autowired)
	ReserveRepository p;
	
	@Setter(onMethod_ = @Autowired)
	JpaTransactionManager tm;
	
	@Autowired
	ReserveService rc;
	
	
	@Test
	public void ppp() {
		log.info(p.getClass().toString());
	}

	@Test
	public void save() {
		TransactionStatus status = tm.getTransaction(TransactionDefinition.withDefaults());
		try {
		 p.saveAndFlush(Reserve.builder()
	                .roomno(2L)
	                .name("name")
	                .phone("01012345678")
	                .adult("1")
	                .child("2")
	                .startdate("2022/01/06")
	                .enddate("2022/01/17")
	                .totalcost(10L)
	                .bankname("bank")
	                .bankbranchcd("bcd")
	                .bankno("bankno")
	                .buildcd("4")
	                .build());
		 tm.commit(status);
		} catch(Exception e) {
			tm.rollback(status);
		}
	}
	
	@Test
	public void load() {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setReadOnly(true);
		TransactionStatus status = tm.getTransaction(def);
		try {
			List<Reserve> postsList = p.findAll();
        
			for(Reserve pp : postsList) {
				log.info(pp.getName());
				log.info(pp.getRoominfo().getRoomnum());
			}
		tm.commit(status);
		} catch(Exception e) {
			tm.rollback(status);
		}
	}
	
    @Test
    public void saveAndLoad() { 
    	//save랑 load에 transactional어노테이션 붙여도 내부에서 호출하면 적용이 안됨
    	//bean에다 등록한 transactionmanager받아와서 코드로 설정
    	save();
    	log.info("saved");
    	load();
    }
    
    @Test
    public void deleteAll() {
    	p.deleteAllInBatch();
    }
    
    @Test
    @Transactional
    public void validateDateTest() {
    	assertTrue(rc.validateDate(64L, "2022-03-02", "2022-03-02"));
    }
    
}
