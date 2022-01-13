package com.example.demo.domain.options;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.example.demo.domain.base.BaseEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;


@DynamicInsert//null인 경우 삽입할 때 insert문에서 빼버림
@DynamicUpdate//null인 경우 업데이트할 때 update문에서 빼버림
@Getter//entity에는 setter를 만들지 않고 값 변경이 필요한 상황에 필요한 메소드를 추가한다
@NoArgsConstructor
@Entity//jpa annotation DB의 테이블로 매핑됨
public class Options extends BaseEntity{
    @Id// 이 필드가 pk임을 나타냄
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "OPTIONS_SEQ_GENERATOR") //pk 생성 규칙 (identity -> auto increment)
    @SequenceGenerator(sequenceName = "OPTIONS_SEQ", name = "OPTIONS_SEQ_GENERATOR", allocationSize = 1)
    private Long no;
    //성능문제, 구현이 복잡해지므로 pk는 웬만하면 Long 타입의 auto-increment로 해놓고 unique키를 추가하는 것을 추천함

    @Column(length = 100,nullable = false)
    private String item;

    @Column(nullable = true)
    private Long cost;
    
    @Column(length = 1, nullable = true)
    private String activity;
    //column annotation이 없어도 컬럼이 되지만 기본 설정만 사용가능하다.

    @Builder //(lombok:builder)해당하는 생성자의 빌더 패턴을 등록해줌
    //생성자를 통해 테이블에 데이터 insert
    public Options(String item, Long cost, String activity, String deleteflg) {
    	super(deleteflg);
    	this.item = item;
		this.cost = cost;
		this.activity = activity;	
	}

}
