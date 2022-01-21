package com.example.demo.domain.roominfo;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

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
public class Roominfo extends BuildingEntity implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id// 이 필드가 pk임을 나타냄
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ROOMINFO_SEQ_GENERATOR") //pk 생성 규칙 (identity -> auto increment)
    @SequenceGenerator(sequenceName = "ROOMINFO_SEQ", name = "ROOMINFO_SEQ_GENERATOR", allocationSize = 1)
    private Long no;
    //성능문제, 구현이 복잡해지므로 pk는 웬만하면 Long 타입의 auto-increment로 해놓고 unique키를 추가하는 것을 추천함

    @Column(length = 4,nullable = false)
    private String roomnum;
    
    @Column(length = 100,nullable = false)
    private String roomtitle;
    
    @Column(length = 4000,nullable = false)
    private String explanation;
    
    @Column(length = 10,nullable = true)
    private String maxpeople;

    @Column(nullable = false)
    private Long adultcost;
    
    @Column(nullable = false)
    private Long childcost;
    
    @Column(length = 2000, nullable = true)
    private String images;
    
    @Column(length = 7,nullable = true)
    private String colorcd;

    @Builder
    public Roominfo(String deleteFlg, String buildcd, String roomnum, String roomtitle, String explanation,
			String maxpeople, Long adultcost,Long childcost, String images, String colorcd) {
		super(deleteFlg, buildcd);
		this.roomnum = roomnum;
		this.roomtitle = roomtitle;
		this.explanation = explanation;
		this.maxpeople = maxpeople;
		this.adultcost = adultcost;
		this.childcost = childcost;
		this.images = images;
		this.colorcd = colorcd;
	}
    public RoominfoDTO toDTO() {
    	return new RoominfoDTO(
    			no,
    			this.getDeleteflg(),
    			this.getBuildcd(),
    			new Date(Timestamp.valueOf(getCreatedat()).getTime()),
    			new Date(Timestamp.valueOf(getUpdatedat()).getTime()),
    			roomnum,
    			roomtitle,
    			explanation,
    			maxpeople, 
    			adultcost,
    			childcost, 
    			images, 
    			colorcd);
    }

}
