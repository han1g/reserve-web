package com.example.demo.service;

import java.util.List;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.etc.GetListDTO;
import com.example.demo.domain.etc.RoomSearchCriteria;
import com.example.demo.domain.notice.NoticeDTO;
import com.example.demo.domain.roominfo.RoominfoDTO;

public interface RoominfoService {

	public GetListDTO<RoominfoDTO> getList(RoomSearchCriteria cri,boolean deletedList);
	public void register(RoominfoDTO board);
	public boolean modify(RoominfoDTO board);
	public boolean remove(Long bno);
	public RoominfoDTO get(Long bno);
	boolean restore(Long no);
	
	

}
