package com.boot.action;

import com.alibaba.dubbo.config.annotation.Reference;

import com.biz.IStudentBiz;
import com.po.Clazz;
import com.po.Student;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class StudentAction implements IStudentAction {
	@Reference(version = "1.0")

	private IStudentBiz studentBiz;

	public IStudentBiz getStudentBiz() {
		return studentBiz;
	}

	public void setStudentBiz(IStudentBiz studentBiz) {
		this.studentBiz = studentBiz;
	}

	@Override
	@RequestMapping(value = "save_Student.do")
	public int save(Student student) {
		return studentBiz.save(student);
	}

	@Override
	@RequestMapping(value = "update_Student.do")
	public int update(Student student) {
		return studentBiz.update(student);
	}

	@Override
	@RequestMapping(value = "delById_Student.do")
	public int delById(Integer sid) {
		return studentBiz.delById(sid);
	}

	@Override
	@RequestMapping(value = "findById_Student.do")
	public Student findById(Integer sid) {
		return studentBiz.findByid(sid);
	}

	@Override
	@RequestMapping(value = "findPageAll_Student.do")
	public Map<String, Object> findPageAll(Integer page, Integer rows) {
		page=page==null||page<1?1:page;
		rows=rows==null||rows<1?5:rows;
		if(rows>20)rows=20;
		//获取总页数
		int maxpage=studentBiz.findmaxPage(rows);
		if(page>maxpage)page=maxpage;

		//获取每页记录集合
		List<Student> lsst=studentBiz.findPageAll(page, rows);

		Map<String, Object> map=new HashMap<String,Object>();
		map.put("page",page);
		map.put("rows",rows);
		map.put("lsst",lsst);
		map.put("maxpage",maxpage);

		return map;
	}

	@Override
	@RequestMapping(value = "doinit_Student.do")
	public List<Clazz> doinit() {
		System.out.println("1111111111");
		List<Clazz> lsca=studentBiz.doinit();
		return lsca;
	}
}
