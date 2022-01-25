package com.example.demo.domain.etc;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO<T extends Criteria> {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private T cri;
	
	public PageDTO(T cri, int total) {
		this.cri = cri;
		this.total = total;
		
		endPage = cri.getPageNum()/10 * 10 + (cri.getPageNum()%10 == 0 ? 0 : 10);
		startPage = endPage - 9;
		int realEnd = total/cri.getAmount() + (total % cri.getAmount() == 0 ? 0 : 1);
		if(endPage > realEnd) {
			endPage = realEnd;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
