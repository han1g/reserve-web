package com.example.demo.domain.sliderimages;

import java.sql.Date;
import java.sql.Timestamp;

import com.example.demo.domain.base.BuildingDTO;
import com.example.demo.domain.options.OptionsDTO;
import com.example.demo.domain.options.OptionsDTO.OptionsDTOBuilder;

import lombok.Builder;
import lombok.Data;

@Data
public class SliderimagesDTO extends BuildingDTO{
	private Long no;
    private String filename;
    private String sortno;
    private String activity;
    
    public SliderimagesDTO() {
    	activity = "0";
    }

    @Builder
    public SliderimagesDTO(Long no, String deleteflg, Date createdAt, Date updatedAt,String filename, String sortno, String activity) {
    	super(deleteflg,createdAt,updatedAt,"4");
    	this.no = no;
    	this.filename = filename;
		this.sortno = sortno;
		this.activity = activity;	
	}
    
    
}
