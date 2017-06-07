<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>添加模块</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			
		});
		function save_module(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/module_save.do';
			var _module_name=$("#_module_name").val();//模块名
			var _parentid=$("#_parentid").val();//父模块ID
			var _sortnum=$("#_sortnum").val();//排序数字
			if(_module_name.length<1){showmsg('模块名不能为空');return;};
			if(_parentid.length<1){showmsg('父模块ID不能为空');return;};
			if(_sortnum.length<1){showmsg('排序数字不能为空');return;};
			var _bugfix='';
			
			var data={
				module_name:_module_name,
				parentid:_parentid,
				sortnum:_sortnum,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					//TRUE
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
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
    						<h1>添加模块</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>示例</li></ul>
								<ul class="row gry">
									<li class=" w100 tr">证件类型</li>
									<li class="w200"><select class="form-control input-sm"><option value="1">身份证</option></select></li>
									<li class=" w100 tr">证件号码</li>
									<li class="w200"><input type="text" class="form-control input-sm"/></li>
								</ul>
								<ul class="title"><li>部分字段</li></ul>
								<ul class="row">
									<li class=" w100 tr">模块名</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_module_name"/></li>

									<li class=" w100 tr">父模块ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_parentid"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">排序数字</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_sortnum"/></li>
								</ul>
								<ul class="last row">
									<li class="w100"><button onclick="save_module();" type="submit" class="btn btn-warning btn-sm btn-block">保存</button></li>
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div style="clear:both;"></div>
							</div>
						</div>
            	</div>
         		</div>
         	</div>
         	<div class="con_side">
         		<!-- 根据用户权限生成TODO -->
         		<div class="box">
					${leftmenu}
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
