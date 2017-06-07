package com.asia.dao;

import com.asia.entity.Student;

public interface StudentDao {
	 	int insert(Student student);

	    int insertSelective(Student student);
}
