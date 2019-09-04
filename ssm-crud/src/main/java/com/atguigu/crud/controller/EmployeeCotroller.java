package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工CRUD请求
 * @author Chofn-商标内部
 *
 */
@Controller
public class EmployeeCotroller {

	@Autowired
	EmployeeService employeeService;
	/**
	 * 单个和批量删除
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			for (String string:str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
			return Msg.success();
		}else {		
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
			return Msg.success();
		}
	}
	
	
	
	/**
	 * 
	 * 如果直接发送AJAX为put的请求除了路径上的EMPID
	 * 员工更新
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		System.out.println(employee.toString());
		employeeService.update(employee);
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	
	/**
	 *检查用户名是否可用 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuse(@RequestParam("empName")String empName) {
		//判断用户名是否是合法表达式；
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名必须为2-5位中文或6-16位英文和中文的组合！");
		}
		//数据库用户名重复校验
		boolean b = employeeService.checkUser(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	
	
	/**
	 * 员工保存
	 * @return
	 * 1、支持JSR303校验
	 * 2、导入
	 */
	@ResponseBody
	@RequestMapping(value="/emp",method = RequestMethod.POST)
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		System.out.println(result.toString());
		if(result.hasErrors()) {
			//在模态框返回失败信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError: errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorField", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}

	}
	
	/**
	 * 导入jackson包
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		//这不是分页查询
				//引入PageHelper分页插件
				//在查询之前只需要调用,传入页码，以及每页数量
				PageHelper.startPage(pn,5);
				//紧跟的查询就是一个分页查询
				List<Employee> emps = employeeService.getAll();
				//使用pegeinfo包装查询后的结果，只需要将pageinfo交给页面即可
				//封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("pageInfo",page);
	}
	
	
	
	/** 
	 * 查询员工数据
	 * @return
	 */
	
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,
			Model model) {
		
		//这不是分页查询
		//引入PageHelper分页插件
		//在查询之前只需要调用,传入页码，以及每页数量
		PageHelper.startPage(pn,5);
		//紧跟的查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		//使用pegeinfo包装查询后的结果，只需要将pageinfo交给页面即可
		//封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		
		return "list";
	}
}
