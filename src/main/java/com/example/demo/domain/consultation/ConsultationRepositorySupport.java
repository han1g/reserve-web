package com.example.demo.domain.consultation;

import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.PersistenceContext;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;
import org.springframework.stereotype.Repository;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.notice.Notice;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.notice.QNotice;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ConsultationRepositorySupport extends QuerydslRepositorySupport{
	
	private final JPAQueryFactory queryFactory;
	
	
	private static QConsultation qConsultation = QConsultation.consultation;
	
	public ConsultationRepositorySupport(JPAQueryFactory queryFactory) {
		super(Consultation.class);
		this.queryFactory = queryFactory;
		
	}//생성자주입을 통해 (root-context.xml)jpaQueryFactory가 주입됨
	
	public List<Consultation> findByTitle(String title) {
		
		return queryFactory.selectFrom(qConsultation).where(qConsultation.title.contains(title)).fetch();
	}
	public List<Long> searchGroups(Criteria cri, boolean deletedList) {
		
		return queryFactory.selectDistinct(qConsultation.grno)
				.from(qConsultation)
				.where(searchCondition(cri, deletedList)).fetch();
				
	}
	public Long getMaxGrno() {
		BooleanBuilder exp = new BooleanBuilder(qConsultation.depth.eq(1L));
		exp.and(qConsultation.buildcd.eq("4"));
		if(queryFactory.selectFrom(qConsultation).fetchCount() == 0L) {
			return 0L;
		}
		return queryFactory.select(qConsultation.grno).from(qConsultation).where(exp).orderBy(qConsultation.grno.desc()).fetchFirst();
	}
	public Long getMaxGrgrod(Long grno) {
		BooleanBuilder exp = new BooleanBuilder(qConsultation.grno.eq(grno)); 
		exp.and(qConsultation.buildcd.eq("4"));
		return queryFactory.select(qConsultation.grgrod).from(qConsultation).where(exp).orderBy(qConsultation.grgrod.desc()).fetchFirst();
	}
	
	public Long deleteGroup(Long grno) {
		BooleanBuilder exp = new BooleanBuilder(qConsultation.grno.eq(grno)); 
		exp.and(qConsultation.buildcd.eq("4"));
		return queryFactory.update(qConsultation).where(exp).set(qConsultation.deleteflg,"1").execute();
	}

	public static BooleanBuilder searchCondition(Criteria cri,boolean deletedList) {

		String keyword = cri.getKeyword();
    	String cond = cri.getType();
    	BooleanBuilder builder = new BooleanBuilder();
    	
    	BooleanBuilder conditionBuilder = new BooleanBuilder();
    	
    	if(keyword != null) {
	    	if(cond != null && cond.contains("T")) {
		    	BooleanExpression exTitle = qConsultation.title.contains(keyword); // title LIKE %1%
		    	conditionBuilder.or(exTitle);
	    	}
	    	if(cond != null && cond.contains("C")) {
	    		BooleanExpression exContents = qConsultation.contents.contains(keyword); // contents LIKE %1%
	    		conditionBuilder.or(exContents);
	    	}
	    	if(cond != null && cond.contains("W")) {
	    		BooleanExpression exContents = qConsultation.name.contains(keyword); // contents LIKE %1%
	    		conditionBuilder.or(exContents);
	    	}
    	}
    	builder.and(conditionBuilder);
    	if(deletedList) {
    		builder.and(qConsultation.deleteflg.eq("1"));//deleted
    	}
    	else {
    		builder.and(qConsultation.deleteflg.eq("0"));//not deleted
    	}
    	builder.and(qConsultation.buildcd.eq("4"));//(buildcd = 4) &&(exTitle || exContents)
		return builder;
		
	}
	
	

}
