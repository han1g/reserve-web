package com.example.demo.service_impl;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.domain.options.Options;
import com.example.demo.domain.options.OptionsDTO;
import com.example.demo.domain.options.OptionsRepository;
import com.example.demo.service.OptionsService;

import lombok.extern.slf4j.Slf4j;

@Service//서비스는 dto를 받아 처리함,querydsl도 서비스에서 처리함
@Slf4j
public class OptionsServiceImpl implements OptionsService{

	@Autowired
	OptionsRepository repo1;
	
	@Override
	@Transactional
	public void register(List<OptionsDTO> options) {
		log.info("" + options);
		log.info("" + options.size());
		for(OptionsDTO option : options) {
			if(option.getNo() == null) {
				//insert
				log.info("insert");
				repo1.save(Options.builder()
						.item(option.getItem())
						.cost(option.getCost())
						.activity(option.getActivity())
						.build());
			} else {
				//update
				log.info("update");
				Options en = repo1.findById(option.getNo()).get();
				en.update(option);
				repo1.save(en);
			}
		}
	}

	@Override
	public List<OptionsDTO> getList() {
		// TODO Auto-generated method stub
		return repo1.findAll(Sort.by("no").descending()).stream().map(el -> el.toDTO()).collect(Collectors.toList());
	}



}
