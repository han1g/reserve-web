package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.options.OptionsDTO;

public interface OptionsService {


	List<OptionsDTO> getList(boolean deleted,boolean activated);

	void register(List<OptionsDTO> options);

}
