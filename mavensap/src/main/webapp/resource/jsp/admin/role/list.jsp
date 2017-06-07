<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>角色列表</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.pager.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css"/>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			
		});
		function save_role(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/role_save.do';
			var _role_name=$("#_role_name").val();//角色名
			var _sortnum=$("#_sortnum").val();//排序数字
			var _role_type=1;//角色类型
			if(_role_name.length<1){showmsg('角色名不能为空');return;};
			if(_sortnum.length<1){showmsg('排序数字不能为空');return;};
			var _bugfix='';
			
			var data={
				role_name:_role_name,
				sortnum:_sortnum,
				role_type:_role_type,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					//TRUE
					window.location.href='${pageContext.request.contextPath}/admin/role_list.do';
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;权限管理&nbsp;&gt;&nbsp;角色管理</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>所有角色</li></ul>
								<!--loop start-->
								<c:if test="${not empty datalist}">
								<c:forEach var="d" items="${datalist}">
								<ul class="row">
									<li class="w70 tr">角色名</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_role_name_${d.ROLE_ID}" value="${d.ROLE_NAME}"/></li>
									<li class=" w100 tr">排序数字</li>
									<li class="w80"><input type="text" class="form-control input-sm" id="_sortnum_${d.ROLE_ID}" value="${d.SORTNUM}"/></li>
									<li>
										<a class="btn btn-default btn-sm" onclick="edit_role('${d.ROLE_ID}');" >修改</a>
										<a class="btn btn-default btn-sm" href="${pageContext.request.contextPath}/admin/roleuri_list.do?role_id=${d.ROLE_ID}">权限查看/设置</a>
									</li>
								</ul>
								</c:forEach>
								</c:if>
								<div id="pager">
								</div>
								<c:if test="${empty datalist}">
								<ul class="row"><li class="w400" style="text-align:left;">未查询到数据</li></ul>
								</c:if>
								<!--loop end-->
								<ul class="title"><li>添加新角色</li></ul>
								<ul class="row">
									<li class="w70 tr">角色名</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_role_name"/></li>
									<li class=" w100 tr">排序数字</li>
									<li class="w80"><input type="text" class="form-control input-sm" id="_sortnum"/></li>
									<li class="w80"><button onclick="save_role();" type="submit" class="btn btn-warning btn-sm btn-block">添加角色</button></li>
								</ul>
								<div style="clear:both;">
									<input type="hidden" id="pageNumber" value="${pager.pageIndex}"/>
									<input type="hidden" id="pageCount" value="${pager.pageCount}"/>
								</div>
							</div>
						</div>
            	</div>
         	<!--
         	<div class="con_side">
         		<div class="box">
					${leftmenu}
            	</div>
         	</div>
         	 -->
         </div>
		<!-- 页脚部分-->
		<div id="footer">
			2014&copy; China Unicom 中国联通.版权所有
		</div>
		<!-- 页脚部分结束-->
	</body>
</html>
