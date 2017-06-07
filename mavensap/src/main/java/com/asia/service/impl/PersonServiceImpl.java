package com.asia.service.impl;

import org.springframework.stereotype.Service;

import com.asia.service.PersonService;

@Service
public class PersonServiceImpl implements PersonService {

	
	public String getPerson(String age, String name, String sex) {
		return "name:"+name+"**age:"+age+"**sex:"+sex;
	}
	
	

}
