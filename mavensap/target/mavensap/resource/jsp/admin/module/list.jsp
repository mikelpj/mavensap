<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>模块列表</title>
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
		function save_module(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/module_save.do';
			var _module_name=$("#_module_name").val();//模块名
			var _module_memo=$("#_module_memo").val();//模块名
			var _sortnum=$("#_sortnum").val();//排序数字
			if(_module_name.length<1){showmsg('模块名不能为空');return;};
			if(_sortnum.length<1){showmsg('排序数字不能为空');return;};
			var _bugfix='';
			
			var data={
				module_name:_module_name,
				module_memo:_module_memo,
				sortnum:_sortnum,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					window.location.href='${pageContext.request.contextPath}/admin/module_list.do';
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
		}
		function edit_module(module_id){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/module_update.do';
			var _module_name=$("#_module_name_"+module_id).val();//模块名
			var _module_memo=$("#_module_memo_"+module_id).val();//模块名
			var _sortnum=$("#_sortnum_"+module_id).val();//排序数字
			if(_module_name.length<1){showmsg('模块名不能为空');return;};
			if(_sortnum.length<1){showmsg('排序数字不能为空');return;};
			var _bugfix='';
			
			var data={
				module_name:_module_name,
				module_memo:_module_memo,
				sortnum:_sortnum,
				module_id:module_id,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					window.location.href='${pageContext.request.contextPath}/admin/module_list.do';
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;权限管理&nbsp;&gt;&nbsp;模块管理</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>所有模块</li></ul>
								<!--loop start-->
								<c:if test="${not empty datalist}">
								<c:forEach var="d" items="${datalist}">
								<ul class="row">
									<li class="w70 tr">模块名</li>
									<li class="w170"><input type="text" class="form-control input-sm" id="_module_name_${d.MODULE_ID}" value="${d.MODULE_NAME}"/></li>
									<li class="w80 tr">排序数字</li>
									<li class="w80"><input type="text" class="form-control input-sm" id="_sortnum_${d.MODULE_ID}" value="${d.SORTNUM}"/></li>
									<li class="w50 tr">备注</li>
									<li class="w80"><input type="text" class="form-control input-sm" id="_module_memo_${d.MODULE_ID}" value="${d.MEMO}"/></li>
									<li>
										<a class="btn btn-warning btn-xs" onclick="edit_module('${d.MODULE_ID}');" >修改</a>
										<a class="btn btn-warning btn-xs" href="${pageContext.request.contextPath}/admin/uri_list.do?module_id=${d.MODULE_ID}" >资源路径设置</a>
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
								<ul class="title"><li>添加新模块</li></ul>
								<ul class="row">
									<li class="w70 tr">模块名</li>
									<li class="w170"><input type="text" class="form-control input-sm" id="_module_name" value="" maxlength="6"/></li>
									<li class="w80 tr">排序模块</li>
									<li class="w80"><input type="text" class="form-control input-sm" id="_sortnum" value="0"/></li>
									<li class="w50 tr">备注</li>
									<li class="w120"><input type="text" class="form-control input-sm" id="_module_memo" value=""/></li>
									<li class="w80"><button onclick="save_module();" type="submit" class="btn btn-warning btn-sm btn-block">添加模块</button></li>
								</ul>
								
								
								<div style="clear:both;">
									<input type="hidden" id="pageNumber" value="${pager.pageIndex}"/>
									<input type="hidden" id="pageCount" value="${pager.pageCount}"/>
								</div>
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
