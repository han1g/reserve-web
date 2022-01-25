package com.example.demo.domain.consultation;

import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PreUpdate;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.example.demo.domain.base.BuildingEntity;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.utils.SHA256Util;

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
    
    @Column(length = 255, nullable = true)
    private String passwd;
    
    @Column(length = 1, nullable = true)
    private String lockflg;
    
    
    public ConsultationDTO toDTO() {
    	return ConsultationDTO.builder()
    			.createdat(new Date(Timestamp.valueOf(getCreatedat()).getTime()))//localDateTime -> Timestamp -> long -> Date
    			.updatedat(new Date(Timestamp.valueOf(getUpdatedat()).getTime()))
    			.deleteflg(getDeleteflg())
    			.buildcd(getBuildcd())
    			.contents(contents)
    			.depth(depth)
    			.grgrod(grgrod)
    			.grno(grno)
    			.lockflg(lockflg)
    			.name(name)
    			.no(no)
    			.passwd(passwd)
    			.title(title)
    			.build();
    }
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
    
    @Override
    @PreUpdate
    public void updatedAt() {
    	//자동업데이트 ㄴㄴ
    }
    
	public void update(String title, String contents,String name,String passwd,String lockflg) throws NoSuchAlgorithmException {
		this.title = title;
		this.contents = contents;
		this.name = name;
		this.passwd = SHA256Util.encrypt(passwd);
		this.lockflg = lockflg;
		super.updatedAt();
	}
	
	public void updateAdmin(String title, String contents,String name, String passwd, String lockflg) throws NoSuchAlgorithmException {
		this.title = title;
		this.contents = contents;
		this.name = name;
		this.lockflg = lockflg;
		if(passwd != null && !passwd.equals(""))
			this.passwd = SHA256Util.encrypt(passwd);
		//null이면 pw 유지
		if(name.contains("운영자"))
			this.passwd = null;
		super.updatedAt();
			
	}
	
    
    
}
