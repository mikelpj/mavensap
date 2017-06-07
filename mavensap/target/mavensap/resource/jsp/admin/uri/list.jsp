<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>资源路径列表</title>
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
			$('.uri_submenu').each(function(){
				var uri_id=$(this).attr('id');
				var uri_submenu=$(this).val();
				if(uri_submenu=='1'){
					$("#"+uri_id+"_ok").addClass('btn-primary');
				}else{
					$("#"+uri_id+"_no").addClass('btn-primary');
				}
			});
		});
		function add_uri(mid){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/uri_save.do';
			var _uri=$("#_uri_"+mid).val();//需权限控制的URI
			var _sortnum=$("#_sortnum_"+mid).val();//排序数字
			var _uri_name=$("#_uri_name_"+mid).val();//名称
			var _submenu=$("#_submenu_"+mid).val();//是否是子菜单
			if(_uri.length<1){showmsg('URI不能为空');return;};
			if(_uri_name.length<1){showmsg('名称不能为空');return;};
			var _bugfix='';
			
			var data={
				uri:_uri,
				uri_name:_uri_name,
				moduleid:mid,
				submenu:_submenu,
				sortnum:_sortnum,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					var url=window.location.href;
					window.location.href=url;
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
		}
		function edit_uri(uri_id){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/uri_update.do';
			var _uri=$("#uri_"+uri_id).val();//需权限控制的URI
			var _sortnum=$("#sortnum_"+uri_id).val();//排序数字
			var _uri_name=$("#uri_name_"+uri_id).val();//名称
			var _submenu=$("#submenu_"+uri_id).val();//是否是子菜单
			if(_uri.length<1){showmsg('URI不能为空');return;};
			if(_uri_name.length<1){showmsg('名称不能为空');return;};
			var _bugfix='';
			
			var data={
				uri:_uri,
				uri_name:_uri_name,
				uri_id:uri_id,
				sortnum:_sortnum,
				submenu:_submenu,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					var url=window.location.href;
					window.location.href=url;
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
		function _switch_submenu(mid,v){
			if(v=='1'){
				$('#_submenu_'+mid+'_ok').addClass('btn-primary').removeClass('btn-default');
				$('#_submenu_'+mid+'_no').addClass('btn-default').removeClass('btn-primary');
			}else{
				$('#_submenu_'+mid+'_no').addClass('btn-primary').removeClass('btn-default');
				$('#_submenu_'+mid+'_ok').addClass('btn-default').removeClass('btn-primary');
			}
			$('#_submenu_'+mid).val(v);
		}
		function switch_submenu(mid,v){
			if(v=='1'){
				$('#submenu_'+mid+'_ok').addClass('btn-primary').removeClass('btn-default');
				$('#submenu_'+mid+'_no').addClass('btn-default').removeClass('btn-primary');
			}else{
				$('#submenu_'+mid+'_no').addClass('btn-primary').removeClass('btn-default');
				$('#submenu_'+mid+'_ok').addClass('btn-default').removeClass('btn-primary');
			}
			$('#submenu_'+mid).val(v);
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;权限管理&nbsp;&gt;&nbsp;资源路径管理</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<c:forEach items="${modulelist}" var="mo" varStatus="mo_index">
									<ul class="title">
										<li>${mo.MODULE_NAME}(${mo.MEMO})</li>
									</ul>
									<c:forEach var="uri" items="${urilist}" varStatus="uri_index">
										<c:if test="${uri.MODULEID==mo.MODULE_ID}">
											<ul class="row">
												<li class="w50 tr"><span class="glyphicon glyphicon-arrow-right"></span></li>
												<li class="w100"><input type="text" class="form-control input-sm" id="uri_name_${uri.URI_ID}" value="${uri.URI_NAME}"/></li>
												<li class="w250"><input type="text" class="form-control input-sm" id="uri_${uri.URI_ID}" value="${uri.URI}"/></li>
												<li class="w80"><input type="text" class="form-control input-sm" id="sortnum_${uri.URI_ID}" value="${uri.SORTNUM}"/></li>
												<li class="w150">
													<div class="btn-group">
														<button type="button" class="btn btn-default btn-xs" id="submenu_${uri.URI_ID}_ok" onclick="switch_submenu('${uri.URI_ID}','1');">作为子菜单</button>
														<button type="button" class="btn btn-default btn-xs" id="submenu_${uri.URI_ID}_no" onclick="switch_submenu('${uri.URI_ID}','0');">否</button>
													</div>
												</li>
												<li>
													<input type="hidden" class="uri_submenu" id="submenu_${uri.URI_ID}" value="${uri.SUBMENU}"/>
													<a class="btn btn-default btn-xs" onclick="edit_uri('${uri.URI_ID}');">更新</a>
												</li>
											</ul>
										</c:if>
									</c:forEach>
								<ul class="row">
									<li class="w50 tr">添加</li>
									<li class="w100"><input type="text" class="form-control input-sm" id="_uri_name_${mo.MODULE_ID}" value="" placeholder="路径名"/></li>
									<li class="w250"><input type="text" class="form-control input-sm" id="_uri_${mo.MODULE_ID}" value="" placeholder="路径URI"/></li>
									<li class="w80"><input type="text" class="form-control input-sm" id="_sortnum_${mo.MODULE_ID}" value="0"/></li>
									<li class="w1150">
										<div class="btn-group">
											<button type="button" class="btn btn-default btn-xs" id="_submenu_${mo.MODULE_ID}_ok" onclick="_switch_submenu('${mo.MODULE_ID}','1');">作为子菜单</button>
											<button type="button" class="btn btn-primary btn-xs" id="_submenu_${mo.MODULE_ID}_no" onclick="_switch_submenu('${mo.MODULE_ID}','0');">否</button>
										</div>
									</li>
									<li>
										<input type="hidden" id="_submenu_${mo.MODULE_ID}" value="0"/>
										<a class="btn btn-warning btn-xs" onclick="add_uri('${mo.MODULE_ID}');" >添加</a>
									</li>
								</ul>
								</c:forEach>
								<!--loop end-->
								<ul class="last row">
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
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
