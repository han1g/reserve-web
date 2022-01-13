package com.example.demo.domain.reserve;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.BaseRepository;

//Repository : jpa에서 DAO역할을 하는 것. JPA Repository<Entity,PK_CLASSTYPE>를 상속하면 알아서 crud 메소드가 등록됨
public interface ReserveRepository extends BaseRepository<Reserve,Long> {

}
