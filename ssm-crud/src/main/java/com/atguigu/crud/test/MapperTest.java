package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.DepartmentExample;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

/**
 * 测试dao层的工作
 * @author Chofn-商标内部
 *1、导入springtest
 *2、@ContextConfiguration指定Spring配置文件的位置
 *3、直接autowired要使用的组件即可
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	
	@Test
	public void testCRUD() {
//		//1、创建springioc容器
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2、从容器中获取mapper
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		
		System.out.println(departmentMapper);
		
		//1、插入几个部门
		
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
		
//		employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@guigu.com",1));
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i=0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0,5)+""+i;
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@atguigu.com",1));
		}
		System.out.println("批量完成！！！");
		
	}
}
