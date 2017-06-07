<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>添加号段</title>
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
		function save_numberseg(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/numberseg_save.do';
			var _serialnumber_s=$("#_serialnumber_s").val();//开始号段
			var _serialnumber_e=$("#_serialnumber_e").val();//结束号段
			var _eparch_code=$("#_eparch_code").val();//号段对应的地市
			var _eparch_name=$("#_eparch_name").val();//号段对应的地市名
			var _use_tag=$("#_use_tag").val();//启用状态 0
			if(_serialnumber_s.length<1){showmsg('开始号段不能为空');return;};
			if(_serialnumber_e.length<1){showmsg('结束号段不能为空');return;};
			if(_eparch_code.length<1){showmsg('号段对应的地市不能为空');return;};
			if(_eparch_name.length<1){showmsg('号段对应的地市名不能为空');return;};
			var _bugfix='';
			
			var data={
				serialnumber_s:_serialnumber_s,
				serialnumber_e:_serialnumber_e,
				eparch_code:_eparch_code,
				eparch_name:_eparch_name,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					magic.alert('号段添加成功', '消息提示',{
	               		'label': '返回',
						'callback': function(){
	                     	
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
		function switch_usetag(v){
			if(v=='0'){
				$('#_use_tag_no').addClass('btn-primary').removeClass('btn-default');
				$('#_use_tag_yes').addClass('btn-default').removeClass('btn-primary');
			}else{
				$('#_use_tag_no').addClass('btn-default').removeClass('btn-primary');
				$('#_use_tag_yes').addClass('btn-primary').removeClass('btn-default');
			}
			$('#_use_tag').val(v);
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/admin/numberseg_list.do">号段管理</a>&nbsp;&gt;&nbsp;添加号段</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>请输入号段信息</li></ul>
								<ul class="row">
									<li class=" w100 tr">开始号段</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_serialnumber_s"/></li>

									<li class=" w100 tr">结束号段</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_serialnumber_e"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">地市代码</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_eparch_code"/></li>

									<li class=" w100 tr">地市名称</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_eparch_name"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">启用状态 </li>
									<li class="w200">
										<input type="hidden" class="form-control input-sm" id="_use_tag" value="1"/>
										<div class="btn-group">
											<button type="button" class="btn btn-primary btn-sm" id="_use_tag_yes" onclick="switch_usetag('1');">启用</button>
											<button type="button" class="btn btn-default btn-sm" id="_use_tag_no" onclick="switch_usetag('0');">不启用</button>
										</div>
									</li>
								</ul>
								<ul class="last row">
									<li class="w100"><button onclick="save_numberseg();" type="submit" class="btn btn-warning btn-sm btn-block">保存</button></li>
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
