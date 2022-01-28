package com.example.demo.domain.sliderimages;

import java.util.ArrayList;
import java.util.List;

import com.example.demo.domain.options.OptionsDTO;

import lombok.Data;

@Data
public class SliderimagesDTOList {
	private List<SliderimagesDTO> sliderimages;
	
	public SliderimagesDTOList() {
		sliderimages = new ArrayList<>();
	}
}
