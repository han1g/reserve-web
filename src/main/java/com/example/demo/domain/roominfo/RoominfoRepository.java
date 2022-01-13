package com.example.demo.domain.roominfo;



import com.example.demo.BaseRepository;

//Repository : jpa에서 DAO역할을 하는 것. JPA Repository<Entity,PK_CLASSTYPE>를 상속하면 알아서 crud 메소드가 등록됨
public interface RoominfoRepository extends BaseRepository<Roominfo,Long> {
}
