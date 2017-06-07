<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>部门列表</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.pager.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css"/>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			
		});
		function query_department(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/department/query.do';
			var _partner_id=$("#partner_id").val();//合作方ID
			var _partner_id=$("#partner_id").val();//合作方ID
			var _cust_id=$("#cust_id").val();//BSS客户ID
			var _cust_id=$("#cust_id").val();//BSS客户ID
			var _depart_name=$("#depart_name").val();//部门名称
			var _depart_name=$("#depart_name").val();//部门名称
			var _super_depart_id=$("#super_depart_id").val();//上级部门
			var _super_depart_id=$("#super_depart_id").val();//上级部门
			var _state=$("#state").val();//生失效标志
			var _state=$("#state").val();//生失效标志
			var _remark=$("#remark").val();//备注
			var _remark=$("#remark").val();//备注
			var page=$("#pageNumber").val();
			var startDate=$("#startDate").val();
			var endDate=$("#endDate").val();
			
			var data={
				partner_id:_partner_id,
				partner_id:_partner_id,
				cust_id:_cust_id,
				cust_id:_cust_id,
				depart_name:_depart_name,
				depart_name:_depart_name,
				super_depart_id:_super_depart_id,
				super_depart_id:_super_depart_id,
				state:_state,
				state:_state,
				remark:_remark,
				remark:_remark,
				startDate:startDate,
				endDate:endDate,
				page:page
			};
			var callback=function(result){
				if(result.msg){
					if(result.pager){
						$("#pageNumber").val(result.pager.pageIndex);
						$("#pageCount").val(100);
						showPager();
					}
					if(result.data){
						showDataList(result.data);
					}
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
		}
		function showDataList(datalist){
			var html='';
			for(var i=0;i<datalist.length;i++){
				html+='<ul class="row"><li class="w100">';
					html+='<li class="w100">'+datalist[i].PSPT_ID+'</li>';
					html+='<li class="w100">'+datalist[i].PSPT_ID+'</li>';
					html+='<li class="w100">'+datalist[i].PARTNER_ID+'</li>';
					html+='<li class="w100">'+datalist[i].PARTNER_ID+'</li>';
					html+='<li class="w100">'+datalist[i].CUST_ID+'</li>';
					html+='<li class="w100">'+datalist[i].CUST_ID+'</li>';
					html+='<li class="w100">'+datalist[i].DEPART_NAME+'</li>';
					html+='<li class="w100">'+datalist[i].DEPART_NAME+'</li>';
					html+='<li class="w100">'+datalist[i].SUPER_DEPART_ID+'</li>';
					html+='<li class="w100">'+datalist[i].SUPER_DEPART_ID+'</li>';
					html+='<li class="w100">'+datalist[i].STATE+'</li>';
					html+='<li class="w100">'+datalist[i].STATE+'</li>';
					html+='<li class="w100">'+datalist[i].REMARK+'</li>';
					html+='<li class="w100">'+datalist[i].REMARK+'</li>';
				html+='</ul>';
			}
			$("#datalist").html(html);
		}
		function showPager(){
			var pageNumber = $("#pageNumber").val();
			var pageCount = $("#pageCount").val();
			$("#pager").pager({
					pagenumber : pageNumber,
					pagecount : pageCount,
					buttonClickCallback : function(pnumber) {
					$("#pageNumber").val(pnumber);
					query_department();
				}
			});
		}
		function ajaxQuery(url,type,dataType,data,callback){
			$.ajax({url : url,type : type,dataType : dataType,data : data,
				success : callback,
				failure : function(error) {
					showmsg(error);
				}
			});
		}
		function showmsg(s){
			$("#show_error").show();
			$("#show_error_text").html(s);
		}
		</script>
		<style type="text/css">
		</style>
	</head>
<body class="bodybg">
		<!-- 页头开始-->
		<div class="hd">
			<div class="logo"><img src="${pageContext.request.contextPath}/img/logo.gif" height="83"/><div id="greeting"><c:if test="${not empty login_staff_id}">您好,<b>${login_staff_id}!</b>欢迎您登录联通流量后向计费平台</c:if></div><div id="addfav"><span class="glyphicon glyphicon-heart"></span><a href="javascript:void(0);" onclick="AddFavorite('http://www.test.com','河南联通流量批发平台');">收藏本站</a></div></div>
		</div>
		<!-- 页头结束-->
		<div class="navi">
            	<div class="nav-li">
                	<div class="c">
                    	<ul style="width:850px" class="cats">
                    		<li class="index cur"><a href="${pageContext.request.contextPath}/welcome.do"><b>首页</b></a></li>
                        	<li class=""><a href="${pageContext.request.contextPath}/staff/edit_password.do"><b>修改密码</b></a></li>
	                    </ul>
	                    <div style="width:100px" class="tools">
                        	<a href="${pageContext.request.contextPath}/logout.do" class=""><b>退出系统</b></a>
						</div>
                	</div>
            	</div>
         </div>
         <div id="contain">
         	<div class="con_main">
         		<div class="con_main_wrap" style="height:800px;">
         			<div class="box">
						<div class="heading">
    						<h1>部门列表</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>查询部门</li></ul>
								<ul class="row">
									<li class="w100">参数一</li>
									<li class="w200"><input type="text" id="username" class="form-control input-sm"/></li>
									<li class=" w100 tr">参数一</li>
									<li class="w200"><input type="text" class="form-control input-sm"/></li>
								</ul>
								<ul class="title"><li>查询结果</li></ul>
								<ul class="row">
									<li class="w20">&nbsp;</li>
									<li class="w100">合作方ID</li>
									<li class="w100">合作方ID</li>
									<li class="w100">BSS客户ID</li>
									<li class="w100">BSS客户ID</li>
									<li class="w100">部门名称</li>
									<li class="w100">部门名称</li>
									<li class="w100">上级部门</li>
									<li class="w100">上级部门</li>
									<li class="w100">生失效标志</li>
									<li class="w100">生失效标志</li>
									<li class="w100">备注</li>
									<li class="w100">备注</li>
									<li>操作</li>
								</ul>
								<!--loop start-->
								<c:if test="${not empty datalist}">
								<c:forEach var="d" items="${datalist}">
								<ul class="row">
									<li class="w20"><input type="checkbox" value="1"/></li>
									<li class="w100">${d.PARTNER_ID}</li>
									<li class="w100">${d.PARTNER_ID}</li>
									<li class="w100">${d.CUST_ID}</li>
									<li class="w100">${d.CUST_ID}</li>
									<li class="w100">${d.DEPART_NAME}</li>
									<li class="w100">${d.DEPART_NAME}</li>
									<li class="w100">${d.SUPER_DEPART_ID}</li>
									<li class="w100">${d.SUPER_DEPART_ID}</li>
									<li class="w100">${d.STATE}</li>
									<li class="w100">${d.STATE}</li>
									<li class="w100">${d.REMARK}</li>
									<li class="w100">${d.REMARK}</li>
									<li>
										<a class="btn btn-default btn-xs" >查看</a>
										<a class="btn btn-default btn-xs" >修改</a>
										<a class="btn btn-default btn-xs" >删除</a>
									</li>
								</ul>
								</c:forEach>
								</c:if>
								<div id="pager">
								</div>
								<c:if test="${empty datalist}">
								<ul class="row"><li style="text-align:center;">未查询到数据<li></ul>
								</c:if>
								<!--loop end-->
								<ul class="last row">
									<li class="w100"><button onclick="apply_partner();" type="submit" class="btn btn-warning btn-sm btn-block">批量操作1</button></li>
									<li class="w100"><button onclick="apply_partner();" type="submit" class="btn btn-warning btn-sm btn-block">批量操作2</button></li>
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div style="clear:both;">
									<input type="hidden" id="pageNumber" value="${pager.pageIndex}"/>
									<input type="hidden" id="pageCount" value="${pager.pageCount}"/>
								</div>
							</div>
						</div>
            	</div>
         		</div>
         	</div>
         	<div class="con_side">
         		<!-- 根据用户权限生成TODO -->
         		<div class="box">
					<div class="heading">
    					<h1>流量批发记录管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/wholesalelog_list.do">流量批发记录列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/wholesalelog_add.do">添加流量批发记录</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>资源路径管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/uri_list.do">资源路径列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/uri_add.do">添加资源路径</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>工号管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/staff_list.do">工号列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/staff_add.do">添加工号</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>角色资源URI管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/roleuri_list.do">角色资源URI列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/roleuri_add.do">添加角色资源URI</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>角色管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/role_list.do">角色列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/role_add.do">添加角色</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>产品参数管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/product_list.do">产品参数列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/product_add.do">添加产品参数</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>合作方临时资料管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/partnertemp_list.do">合作方临时资料列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/partnertemp_add.do">添加合作方临时资料</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>合作方管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/partner_list.do">合作方列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/partner_add.do">添加合作方</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>号段管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/numberseg_list.do">号段列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/numberseg_add.do">添加号段</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>模块管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/module_list.do">模块列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/module_add.do">添加模块</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>流量赠送记录管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/givinglog_list.do">流量赠送记录列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/givinglog_add.do">添加流量赠送记录</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>部门管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/department_list.do">部门列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/admin/department_add.do">添加部门</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>根据权限生成菜单TODO</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							  子菜单
						</li>
					</ul>
            	</div>
            	<!-- 根据用户权限生成OVER -->
         	</div>
         </div>
		<!-- 页脚部分-->
		<div id="footer">
			2014&copy; China Unicom 中国联通.版权所有
		</div>
		<!-- 页脚部分结束-->
	</body>
</html>
