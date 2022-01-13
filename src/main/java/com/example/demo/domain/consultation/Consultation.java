package com.example.demo.domain.consultation;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.example.demo.domain.base.BuildingEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;


@DynamicInsert//null인 경우 삽입할 때 insert문에서 빼버림
@DynamicUpdate//null인 경우 업데이트할 때 update문에서 빼버림
@Getter//entity에는 setter를 만들지 않고 값 변경이 필요한 상황에 필요한 메소드를 추가한다
@NoArgsConstructor
@Entity//jpa annotation DB의 테이블로 매핑됨
public class Consultation extends BuildingEntity{
    @Id// 이 필드가 pk임을 나타냄
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CONSULTATION_SEQ_GENERATOR") //pk 생성 규칙 (identity -> auto increment)
    @SequenceGenerator(sequenceName = "CONSULTATION_SEQ", name = "CONSULTATION_SEQ_GENERATOR", allocationSize = 1)
    private Long no;
    //성능문제, 구현이 복잡해지므로 pk는 웬만하면 Long 타입의 auto-increment로 해놓고 unique키를 추가하는 것을 추천함
    
    @Column(nullable = true)
    private Long grno;
    
    @Column(nullable = true)
    private Long grgrod;
    
    @Column(nullable = true)
    private Long depth;
    
    @Column(length = 100, nullable = false)
    private String title;
    
    @Column(length = 4000, nullable = false)
    private String contents;
    
    @Column(length = 20, nullable = false)
    private String name;
    
    @Column(length = 20, nullable = true)
    private String passwd;
    
    @Column(length = 1, nullable = true)
    private String lockflg;
    
    
    @Builder
	public Consultation(String deleteFlg, String buildcd, Long grno, Long grgrod, Long depth, String title,
			String contents, String name, String passwd, String lockflg) {
		super(deleteFlg, buildcd);
		this.grno = grno;
		this.grgrod = grgrod;
		this.depth = depth;
		this.title = title;
		this.contents = contents;
		this.name = name;
		this.passwd = passwd;
		this.lockflg = lockflg;
	}
}
