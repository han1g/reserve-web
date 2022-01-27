package com.example.demo.domain.options;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class OptionsDTOList {
	private List<OptionsDTO> options;
	
	public OptionsDTOList() {
		options = new ArrayList<>();
	}
}
