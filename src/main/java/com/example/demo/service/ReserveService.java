package com.example.demo.service;

import java.util.List;

import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.reserve.ReserveDTO;
import com.example.demo.domain.roominfo.RoominfoDTO;

public interface ReserveService {

	public List<ReserveDTO> getList(Long roomno,String phone,String name,boolean deletedList);
	
	public List<String> getStartdates(Long roomno);
	public List<String> getEnddates(Long roomno);
	
	public void register(ReserveDTO board);
	
	public boolean modify(ReserveDTO board);
	
	public boolean remove(Long bno);
	
	public ReserveDTO get(Long bno);
	
	public boolean restore(Long no);
}
