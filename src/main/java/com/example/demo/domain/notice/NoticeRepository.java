package com.example.demo.domain.notice;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import com.example.demo.BaseRepository;

//Repository : jpa에서 DAO역할을 하는 것. JPA Repository<Entity,PK_CLASSTYPE>를 상속하면 알아서 crud 메소드가 등록됨
//querydslPredicateExecutor<Entity> queryDSL구문을 사용하기위해 필요. findAll등의 함수에 queryDSL구문을 적용할 수 있다.
public interface NoticeRepository extends BaseRepository<Notice, Long> {
}
