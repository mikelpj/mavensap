<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>修改密码</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/magic.control.Dialog.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/magic.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			
		});
		function update_password(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/staff/update_password.do';
			var oldpass=$("#oldpass").val();
			var password=$.trim($("#pazzword").val());
			var password2=$("#pazzword2").val();
			
			if(oldpass.length<1){showmsg('原密码不能为空');return;};
			if(password.length<8||password.length>20){showmsg('密码长度在8-20位长度之间');return;};
			if(password2.length<8){showmsg('请再次确认密码');return;};
			if(password!=password2){showmsg('两次输入的密码不一致');return;};
			var _bugfix='';
			
			var data={
				oldpass:oldpass,
				password:password
			};
			var callback=function(result){
				if(result.msg){
					magic.alert('更新密码成功!', '消息提示',{
	               		'label': '返回',
						'callback': function(){
							//
	 					}
	             	});
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
		<jsp:include page="/jsp/common/menu_header.jsp"></jsp:include>
		<!-- 页头结束-->
         <div id="contain">
         	<div class="box">
						<div class="heading">
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;用户服务&nbsp;&gt;&nbsp;修改密码</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>请输入原密码</li></ul>
								<ul class="row gry">
									<li class=" w150 tr">原密码</li>
									<li class="w200"><input type="password" class="form-control input-sm" id="oldpass" value="" maxlength="20"/></li>
								</ul>
								<ul class="title"><li>请输入新密码</li></ul>
								<ul class="row">
									<li class=" w150 tr">新密码</li>
									<li class="w200"><input type="password" class="form-control input-sm" id="pazzword" value="" maxlength="20"/></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">再次输入新密码</li>
									<li class="w200"><input type="password" class="form-control input-sm" id="pazzword2" value="" maxlength="20"/></li>
								</ul>
								<ul class="last row">
									<li class="w150"></li>
									<li class="w100"><button onclick="update_password();" type="button" class="btn btn-warning btn-sm btn-block">更新密码</button></li>
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div style="clear:both;"></div>
							</div>
						</div>
            	</div>
         </div>
		<!-- 页脚部分-->
		<div id="footer">
			2014&copy; China Unicom 中国联通.版权所有
		</div>
		<!-- 页脚部分结束-->
	</body>
</html>
