package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.options.OptionsDTO;
import com.example.demo.domain.sliderimages.SliderimagesDTO;

public interface SliderimagesService {


	List<SliderimagesDTO> getList(boolean deleted);

	void register(List<SliderimagesDTO> images);

}
