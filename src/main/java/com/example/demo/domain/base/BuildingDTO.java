package com.example.demo.domain.base;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BuildingDTO extends BaseDTO{
	private String buildcd;

	public BuildingDTO(String deleteflg, Date createdat, Date updatedat, String buildcd) {
		super(deleteflg, createdat, updatedat);
		this.buildcd = buildcd;
	}
	
}
