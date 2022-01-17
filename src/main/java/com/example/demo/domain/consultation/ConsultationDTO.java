package com.example.demo.domain.consultation;

import java.sql.Date;

import javax.persistence.Column;

import com.example.demo.domain.base.BuildingDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
public class ConsultationDTO extends BuildingDTO{

	private Long no;
    //성능문제, 구현이 복잡해지므로 pk는 웬만하면 Long 타입의 auto-increment로 해놓고 unique키를 추가하는 것을 추천함
    private Long grno;

    private Long grgrod;

    private Long depth;

    private String title;
    
    private String contents;
    
    private String name;

    private String passwd;
    
    private String lockflg;

    @Builder
	public ConsultationDTO(String deleteflg, Date createdat, Date updatedat, String buildcd, Long no, Long grno,
			Long grgrod, Long depth, String title, String contents, String name, String passwd, String lockflg) {
		super(deleteflg, createdat, updatedat, buildcd);
		this.no = no;
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
