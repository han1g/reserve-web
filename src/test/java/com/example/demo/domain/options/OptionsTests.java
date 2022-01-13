package com.example.demo.domain.options;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import com.example.demo.domain.BaseConfiguration;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class OptionsTests extends BaseConfiguration{
	 @Setter(onMethod_ = @Autowired)
	 OptionsRepository p;
	 
	 @Autowired
	 ApplicationContext context;

    @Test
    public void saveAndLoad() {
    	log.info(context.getDisplayName());
        //given

        
        p.save(Options.builder()
                .item("item")
                .build());
        //when
        List<Options> postsList = p.findAll();
        //then
        Options posts = postsList.get(0);
        log.info("option[0]:" + posts.getNo());
        assertThat(posts.getCost()).isEqualTo(0L);
        assertThat(posts.getActivity()).isEqualTo("0");
        assertThat(posts.getDeleteflg()).isEqualTo("0");
        
        if(posts.getCreatedat() != null)
        	log.info(posts.getCreatedat().toString());
        if(posts.getUpdatedat() != null)
        	log.info(posts.getUpdatedat().toString());
        
    }
}
