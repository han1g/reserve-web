package com.example.demo.service;

import java.util.List;

import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.etc.ReserveSearchCriteria;
import com.example.demo.domain.reserve.ReserveDTO;
import com.example.demo.domain.roominfo.RoominfoDTO;

public interface ReserveService {

	public List<ReserveDTO> getList(ReserveSearchCriteria cri);
	
	public List<String> getStartdates(Long roomno,Long reserveno);
	public List<String> getEnddates(Long roomno,Long reserveno);
	
	public void register(ReserveDTO board);
	
	public String modify(ReserveDTO board);
	
	public boolean remove(Long bno);
	
	public ReserveDTO get(Long bno);
	
	public boolean restore(Long no);
}
