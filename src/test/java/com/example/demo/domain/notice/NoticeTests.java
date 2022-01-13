package com.example.demo.domain.notice;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.demo.domain.BaseConfiguration;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class NoticeTests extends BaseConfiguration{
	 @Setter(onMethod_ = @Autowired)
	 NoticeRepository p;
	 

    @Test
    public void saveAndLoad() {
        p.save(Notice.builder()
                .title("title")
                .contents("cont")
                .buildcd("4")
                .build());
        //when
        List<Notice> postsList = p.findAll();
        //then
        Notice posts = postsList.get(0);
        
    }
}
