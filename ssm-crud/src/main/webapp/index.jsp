<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
不以/开始的相对路径，找资源以当前资源的路径为基准
以/开始的路径找资源是以服务器的路径为标准
 -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
		<!-- 修改员工的模态框 -->
		<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">修改员工</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal">
				  <div class="form-group">
				    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10">
						<p class="form-control-static" id="empName_update_static"></p>				      
						<span  class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="email_add_input" class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="email" class="form-control" name="email" id="email_update_input" placeholder="email@atguigu.com">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="gender1_add_input" class="col-sm-2 control-label">gender</label>
				    <div class="col-sm-10">
					  <label>
					    <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">男
					  </label>
					  <label>
					    <input type="radio" name="gender" id="gender2_update_input" value="F">女
					  </label>
					</div>
				  </div>
				  <div class="form-group">
				    <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
				    <div class="col-sm-4">
				    	<!-- 部门提交部门Id即可 -->
						<select class="form-control" name="dId" id="dept_update_select"></select>
					</div>
				  </div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
		      </div>
		    </div>
		  </div>
		</div>

		<!-- 新增员工的模态框 -->
		<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">新增员工</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal">
				  <div class="form-group">
				    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empNane">
				      <span  class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="email_add_input" class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="email" class="form-control" name="email" id="email_add_input" placeholder="email@atguigu.com">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="gender1_add_input" class="col-sm-2 control-label">gender</label>
				    <div class="col-sm-10">
					  <label>
					    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">男
					  </label>
					  <label>
					    <input type="radio" name="gender" id="gender2_add_input" value="F">女
					  </label>
					</div>
				  </div>
				  <div class="form-group">
				    <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
				    <div class="col-sm-4">
				    	<!-- 部门提交部门Id即可 -->
						<select class="form-control" name="dId" id="dept_add_select"></select>
					</div>
				  </div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
		      </div>
		    </div>
		  </div>
		</div>


	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-info" id="emp_add_modal_btn">新增</button>
				<button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>

		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_tabel">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>	
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			</div>

		</div>
		<!-- 显示分页 -->
		<div class="row">
			<!-- 当前第几页 -->
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
	
	var pages,currentPage;
		//1页面加载完成后发送ajax请求要到分页数据
		$(function(){
			to_page(1);
		})
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1、解析并显示员工数据
					//2、解析并显示分页信息
					build_emps_table(result);
					
					build_page_info(result);
					
					build_page_nav(result);
					
				}
			})
		}
		
		//构建表格
		function build_emps_table(result){
			//清空table表格
			$("#emps_tabel tbody").empty();
			var emps=result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptName = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加自定义属性为员工ID
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加自定义属性为员工ID
				delBtn.attr("del-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				
				//append方法执行后返回原来的元素
				$("<tr></tr>").append(checkBoxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptName)
				.append(btnTd)
				.appendTo("#emps_tabel tbody");
			})
		}
		
		//构建分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页，共"+result.extend.pageInfo.pages+"页，共"+result.extend.pageInfo.total+"条记录");
			pages = result.extend.pageInfo.pages;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//构建分页条
		function build_page_nav(result){
			$("#page_nav_area").empty();
 			var ul = $("<ul></ul>").addClass("pagination");
 			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
 			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
 			if(result.extend.pageInfo.hasPreviousPage == false){
 				firstPageLi.addClass("disabled");
 				prePageLi.addClass("disabled");
 			}else{
 	 			//添加点击翻页时间
 	 			firstPageLi.click(function(){
 	 				to_page(1);
 	 			})
 	 			prePageLi.click(function(){
 	 				to_page(result.extend.pageInfo.pageNum-1);
 	 			})
 			}
 			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
 			var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
 			if(result.extend.pageInfo.hasNextPage == false){
 				nextPageLi.addClass("disabled");
 				lastPageLi.addClass("disabled");
 			}else{
 	 			//添加点击事件
 	 			nextPageLi.click(function(){
 	 				to_page(result.extend.pageInfo.pageNum+1);
 	 			})
 	 			lastPageLi.click(function(){
 	 				to_page(result.extend.pageInfo.pages);
 	 			})
 			}
 			ul.append(firstPageLi).append(prePageLi);
 			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
 				var numLi =$("<li></li>").append($("<a></a>").append(item));
 				if(result.extend.pageInfo.pageNum==item){
 					numLi.addClass("active");
 				}
				numLi.click(function(){
					to_page(item);
				})
 				ul.append(numLi);
 			});
			ul.append(nextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul);
			$("#page_nav_area").append(navEle);
		}
		//重置模态框
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function(){
			//清除表单数据
			reset_form("#empAddModal form")
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#dept_add_select");
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			})
		})
		//查出所有部门信息
		function getDepts(ele){
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId)
						optionEle.appendTo(ele)
					});
				}
			});
		}
		//校验表单的数据
		function validate_add_form(){
			//1拿到数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			var regName = 	/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名必须为2-5位中文或6-16位英文和中文的组合！");
				show_validate_msg("#empName_add_input","error","用户名必须为2-5位中文或6-16位英文和中文的组合！");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			};
			//验证邮箱
			var email = $("#email_add_input").val();
			var regemail = 	/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
			if (!regemail.test(email)){
				//alert("邮箱格式错误！");
				show_validate_msg("#email_add_input","error","邮箱格式错误！");
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
			};
			return true;
		}
		function show_validate_msg(ele,status,msg){
			//清楚当前元素校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		//用户名input发生了变化调用
		$("#empName_add_input").change(function(){
			//发送ajax请求检验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		//点击保存按钮
		$("#emp_save_btn").click(function(){
			//提交给服务器
			//1、先对要提交给服务器的数据进行校验
			if(!validate_add_form()){
				return false;
			}
			//判断ajax用户校验是否重复了，如果重复返回false
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//2、发送ajax请求保存员工
			//alert($("#empAddModal form").serialize())
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					if(result.code==100){
						//1、保存成功后关闭模态框
						$("#empAddModal").modal('hide');
						//2、自动来到最后一页显示刚才保存的数据
						//发送ajax显示最后一页
						to_page(pages+1);
					}else{
						//显示失败信息
						if (undefined != result.extend.errorField.email){
							show_validate_msg("#email_add_input","error",result.extend.errorField.email);
						}
						if (undefined != result.extend.errorField.empName){
							show_validate_msg("#empName_add_input","error",result.extend.errorField.empName);
						}
					}
				}
			});
		});
		//点击编辑按钮1、按钮创建之前就绑定了click，所以绑定不上，所以使用on函数
		$(document).on("click",".edit_btn",function(){
			//查出部门信息
			//查处员工信息
			getEmp($(this).attr("edit-id"));
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#dept_update_select");
			//把员工ID传给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			//弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"
			})
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		//点击更新
		$("#emp_update_btn").click(function(){
			//验证是否合法
			var email = $("#email_update_input").val();
			var regemail = 	/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
			if (!regemail.test(email)){
				//alert("邮箱格式错误！");
				show_validate_msg("#email_update_input","error","邮箱格式错误！");
				return false;
			}else{
				show_validate_msg("#email_update_input","success","");
			}
			//发送ajax请求
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					$("#empUpdateModal").modal('hide');
					to_page(currentPage);
				}
			});
		});
		
		//点击单个删除按钮
		$(document).on("click",".delete_btn",function(){
			//弹出是否删除对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确认删除"+empName+"吗？")){
				//确认发送ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("del-id"),
					type:"DELETE",
					success:function(result){
						alert(result.msg)
						to_page(currentPage);
					}
				});
			}
		});
		//完成全选全不选的功能
		$("#check_all").click(function(){
			//attr获取checked是undefined
			//这些dom原生的属性 attr用来获取自定义属性的值
			//prop修改和读取dom原生属性的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		//下边全选了后上边也改变
		$(document).on("click",".check_item",function(){
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		//点击全部删除，就批量删除
		$("#emp_delete_all_btn").click(function(){
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				empNames +=$(this).parents("tr").find("td:eq(2)").text()+",";
				del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			empNames = empNames.substring(0,empNames.length-1);
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除"+empNames+"吗？")){
				//发送ajax请求
				$.ajax({
					url:"${APP_PATH}//emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_page(currentPage)
					}
				});
			}
		});
	</script>
</body>
</html>