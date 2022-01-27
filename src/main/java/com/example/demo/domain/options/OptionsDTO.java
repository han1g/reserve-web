package com.example.demo.domain.options;

import java.sql.Date;

import javax.persistence.Column;

import com.example.demo.domain.base.BaseDTO;
import com.example.demo.domain.options.Options.OptionsBuilder;

import lombok.Builder;
import lombok.Data;


@Data
public class OptionsDTO extends BaseDTO{
	private Long no;
    private String item;
    private Long cost;
    private String activity;
    
    public OptionsDTO() {
    	
    }
    
    @Builder
    public OptionsDTO(Long no, String deleteflg, Date createdAt, Date updatedAt,String item, Long cost, String activity) {
    	super(deleteflg,createdAt,updatedAt);
    	this.no = no;
    	this.item = item;
		this.cost = cost;
		this.activity = activity;	
	}
}
