package com.example.demo.domain.notice;

import java.sql.Date;
import java.time.LocalDateTime;

import javax.persistence.Column;

import com.example.demo.domain.base.BaseDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
public class NoticeDTO extends BaseDTO{
    private Long no;
    
    private String title;
    
    private String contents;

    @Builder
	public NoticeDTO(String deleteflg, Date createdat, Date updatedat, Long no, String title,
			String contents) {
		super(deleteflg, createdat, updatedat);
		this.no = no;
		this.title = title;
		this.contents = contents;
	}
    
    
}
