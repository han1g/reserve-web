package com.example.demo.domain.roominfo;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.demo.domain.BaseConfiguration;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class RoominfoTests extends BaseConfiguration{
	 @Setter(onMethod_ = @Autowired)
	 RoominfoRepository p;

    @Test
    public void saveAndLoad() {

        
        p.save(Roominfo.builder()
                .roomnum("1234")
                .roomtitle("titlie")
                .explanation("ex")
                .buildcd("4")
                .build());
        //when
        List<Roominfo> postsList = p.findAll();
        //then
        Roominfo posts = postsList.get(0);
        
        assertThat(posts.getRoomnum()).isEqualTo("1234");
        assertThat(posts.getRoomtitle()).isEqualTo("titlie");
        assertThat(posts.getExplanation()).isEqualTo("ex");
        assertThat(posts.getBuildcd()).isEqualTo("4");
        if(posts.getCreatedat() != null)
        	log.info(posts.getCreatedat().toString());
        if(posts.getUpdatedat() != null)
        	log.info(posts.getUpdatedat().toString());
        log.info("NO" + posts.getNo());
        
    }
}
