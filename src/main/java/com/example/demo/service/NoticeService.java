package com.example.demo.service;

import java.util.List;

import com.example.demo.domain.etc.Criteria;
import com.example.demo.domain.notice.NoticeDTO;

public interface NoticeService {

	public void register(NoticeDTO board);
	public boolean modify(NoticeDTO board);
	public boolean remove(Long bno);
	public NoticeDTO get(Long bno);
	public List<NoticeDTO> getList(Criteria cri);
	public int getTotal(Criteria cri);

}
