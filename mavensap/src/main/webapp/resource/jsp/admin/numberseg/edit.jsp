<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>编辑号段</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			
		});
		function update_numberseg(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/numberseg_update.do';
			var _serialnumber_s=$("#_serialnumber_s").val();//开始号段
			var _serialnumber_e=$("#_serialnumber_e").val();//结束号段
			var _eparch_code=$("#_eparch_code").val();//号段对应的地市
			var _eparch_name=$("#_eparch_name").val();//号段对应的地市名
			var _use_tag=$("#_use_tag").val();//启用状态 0
			if(_serialnumber_s.length<1){showmsg('开始号段不能为空');return;};
			if(_serialnumber_e.length<1){showmsg('结束号段不能为空');return;};
			if(_eparch_code.length<1){showmsg('号段对应的地市不能为空');return;};
			if(_eparch_name.length<1){showmsg('号段对应的地市名不能为空');return;};
			if(_use_tag.length<1){showmsg('启用状态 0不能为空');return;};
			var _bugfix='';
			
			var data={
				serialnumber_s:_serialnumber_s,
				serialnumber_e:_serialnumber_e,
				eparch_code:_eparch_code,
				eparch_name:_eparch_name,
				use_tag:_use_tag,
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
	</head>
<body class="bodybg">
		<!-- 页头开始-->
		<jsp:include page="/jsp/common/menu_header.jsp"></jsp:include>
		<!-- 页头结束-->
         <div id="contain">
         	<div class="con_main">
         		<div class="con_main_wrap" style="height:800px;">
         			<div class="box">
						<div class="heading">
    						<h1>编辑号段</h1>
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
									<li class=" w100 tr">开始号段</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_serialnumber_s" value="${data.serialnumber_s}"/></li>
								
									<li class=" w100 tr">结束号段</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_serialnumber_e" value="${data.serialnumber_e}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">号段对应的地市</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_eparch_code" value="${data.eparch_code}"/></li>
								
									<li class=" w100 tr">号段对应的地市名</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_eparch_name" value="${data.eparch_name}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">启用状态 0</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_use_tag" value="${data.use_tag}"/></li>
								
								<ul class="last row">
									<li class="w100"><button onclick="update_numberseg();" type="submit" class="btn btn-warning btn-sm btn-block">更新</button></li>
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
