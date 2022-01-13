package com.example.demo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

//must not instantiate
public interface BaseRepository<EN,PK_TYPE> extends JpaRepository<EN, PK_TYPE>, QuerydslPredicateExecutor<EN> {

}
