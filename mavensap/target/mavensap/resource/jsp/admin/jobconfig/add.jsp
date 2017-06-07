<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>添加</title>
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			
		});
		function save_jobconfig(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/jobconfig_save.do';
			var job_name=$("#job_name").val();
			var job_class=$("#job_class").val();
			var job_cronexp=$("#job_cronexp").val();
			var bootrun=$("#bootrun").val();
			var _bugfix='';
			
			var data={
				job_name:job_name,
				job_class:job_class,
				job_cronexp:job_cronexp,
				bootrun:bootrun,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					alert('success');
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
		function set_cron(s){
			if(s=='1'){
				$("#job_cronexp").val('*/5 * * * * ?');
			}else if(s=='2'){
				$("#job_cronexp").val('0 */5 * * * ?');
			}else if(s=='3'){
				$("#job_cronexp").val('0 * */5 * * ?');
			}else if(s=='4'){
				$("#job_cronexp").val('0 0 5 * * ?');
			}else if(s=='5'){
				$("#job_cronexp").val('0 0 5 1 * ?');
			}else if(s=='6'){
				$("#job_cronexp").val('0 0 23 L * ?');
			}
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
         	<div class="con_main">
         		<div class="con_main_wrap" style="height:800px;">
         			<div class="box">
						<div class="heading">
    						<h1>添加</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>添加定时任务:</li></ul>
								<ul class="row gry">
									<li class=" w100 tr">任务名:</li>
									<li class="w300"><input type="text" class="form-control input-sm" id="job_name" placeholder="xxx定时任务"/></li>
								</ul>
								<ul class="row gry">
									<li class=" w100 tr">任务类路径:</li>
									<li class="w300"><input type="text" class="form-control input-sm" id="job_class" value="com.uflow.web.job.item.任务类名"/></li>
								</ul>
								<ul class="row gry">
									<li class=" w100 tr">Cron表达式:</li>
									<li class="w300"><input type="text" class="form-control input-sm" id="job_cronexp" value=""/></li>
								</ul>
								<ul class="row gry">
									<li class=" w100 tr">Cron例子:</li>
									<li><a class="btn btn-default btn-xs" onclick="set_cron('1');">每5秒</a>&nbsp;<a class="btn btn-default btn-xs" onclick="set_cron('2');">每5分钟</a>&nbsp;<a class="btn btn-default btn-xs" onclick="set_cron('3');">每5小时</a>&nbsp;
									<a class="btn btn-default btn-xs" onclick="set_cron('4');">每天早上5点</a>&nbsp;<a class="btn btn-default btn-xs" onclick="set_cron('5');">每月1号早上5点</a>&nbsp;<a class="btn btn-default btn-xs" onclick="set_cron('6');">每月最后一天晚上23点</a>
									</li>
								</ul>
								<ul class="row gry">
									<li class=" w100 tr">自动启动:</li>
									<li class="w300"><select class="form-control" id="bootrun"><option value="0">否</option><option value="1" selected="selected">自动启动(服务重启时)</option></select></li>
								</ul>
								<ul class="title"><li>部分字段:</li></ul>
								<ul class="last row">
									<li class="w100"><button onclick="save_jobconfig();" type="submit" class="btn btn-warning btn-sm btn-block">保存</button></li>
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
			2014&copy;
		</div>
		<!-- 页脚部分结束-->
	</body>
</html>
