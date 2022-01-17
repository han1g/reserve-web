package com.example.demo.domain.notice;

import java.sql.Date;
import java.time.LocalDateTime;

import javax.persistence.Column;

import com.example.demo.domain.base.BaseDTO;
import com.example.demo.domain.base.BuildingDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
public class NoticeDTO extends BuildingDTO{
    private Long no;
    
    private String title;
    
    private String contents;

    @Builder
	public NoticeDTO(String deleteflg, Date createdat, Date updatedat,String buildcd, Long no, String title,
			String contents) {
		super(deleteflg, createdat, updatedat, buildcd);
		this.no = no;
		this.title = title;
		this.contents = contents;
	}
    
    
}
