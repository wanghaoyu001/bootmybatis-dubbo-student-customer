package com.boot.action;

import com.po.Clazz;
import com.po.Student;

import java.util.List;
import java.util.Map;

public interface IStudentAction {
	public int save(Student student);
	public int update(Student student);
	public int delById(Integer sid);
	public Student findById(Integer sid);
	public Map<String,Object> findPageAll(Integer page, Integer rows);
	public List<Clazz> doinit();
}
