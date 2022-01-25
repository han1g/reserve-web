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
import org.springframework.transaction.annotation.Transactional;

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
@Transactional
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

		//Long ret = queryFactory.select(qConsultation.grno).from(qConsultation).where(exp).orderBy(qConsultation.grno.desc()).fetchFirst();
		Long ret = queryFactory.select(qConsultation.grno.max()).from(qConsultation).where(exp).fetchOne();
		if(ret == null) {
			return 0L;
		}
		return ret;
		
	}
	public Long getMaxGrgrod(Long grno) {
		BooleanBuilder exp = new BooleanBuilder(qConsultation.grno.eq(grno)); 
		exp.and(qConsultation.buildcd.eq("4"));
		return queryFactory.select(qConsultation.grgrod.max()).from(qConsultation).where(exp).fetchOne();
	}
	
	public Long deleteGroup(Long grno) {
		BooleanBuilder exp = new BooleanBuilder(qConsultation.grno.eq(grno)); 
		exp.and(qConsultation.buildcd.eq("4"));
		return queryFactory.update(qConsultation).where(exp).set(qConsultation.deleteflg,"1").execute();
	}
	
	public Long getReplyPosition(Long ref_depth, Long ref_grno, Long ref_grgrod) {
		Long grgrod;
		BooleanBuilder exp = new BooleanBuilder(qConsultation.grno.eq(ref_grno));
		exp.and(qConsultation.depth.loe(ref_depth));
		exp.and(qConsultation.grgrod.gt(ref_grgrod));
		exp.and(qConsultation.buildcd.eq("4"));
		
		Long ret = queryFactory.select(qConsultation.grgrod.min()).from(qConsultation).where(exp).fetchOne();
		if(ret == null) {
			BooleanBuilder exp2 = new BooleanBuilder(qConsultation.grno.eq(ref_grno));
			exp2.and(qConsultation.buildcd.eq("4"));
			ret = queryFactory.select(qConsultation.grgrod.max()).from(qConsultation).where(exp2).fetchOne() + 1L;
			/*rollback when ret is null -> null + 1 makes exception */
			/*select max(grgrod) from Consultation where grno= ref_grno and buildcd = "4"*/
		}	
		return ret;
		
	}//insert될 reply의 grgrod를 구함
	
	public Long updateGrgrod(Long newReplyPosition,Long grno ) {
		BooleanBuilder exp = new BooleanBuilder(qConsultation.grno.eq(grno));
		exp.and(qConsultation.buildcd.eq("4"));
		exp.and(qConsultation.grgrod.goe(newReplyPosition));
		
		return queryFactory.update(qConsultation).where(exp).set(qConsultation.grgrod, qConsultation.grgrod.add(1L)).execute();
		
	}// 끼워넣으면서 영향받는 row들의 grgrod를 바꿔줌

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
