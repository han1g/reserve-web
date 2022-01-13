package com.example.demo.domain.consultation;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.demo.domain.BaseConfiguration;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class ConsultationTests extends BaseConfiguration{
	 @Setter(onMethod_ = @Autowired)
	 ConsultationRepository p;
	 

    @Test
    public void saveAndLoad() {

        
        p.save(Consultation.builder()
                .title("title")
                .contents("cont")
                .name("name")
                .buildcd("4")
                .build());
        //when
        List<Consultation> postsList = p.findAll();
        //then
        Consultation posts = postsList.get(0);
        
    }
}
