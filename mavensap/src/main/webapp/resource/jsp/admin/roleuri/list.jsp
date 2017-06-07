<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>角色资源URI列表</title>
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
			$('.usetag').each(function(){
				var uri_id=$(this).attr('id');
				var uri_submenu=$(this).val();
				if(uri_submenu=='1'){
					$("#"+uri_id+"_ok").addClass('btn-primary');
				}else{
					$("#"+uri_id+"_no").addClass('btn-primary');
				}
			});
		});
		function switch_usetag(uri_id,usetag,moduleid){
			if(usetag=='1'){
				$('#usetag_'+uri_id+'_ok').addClass('btn-primary').removeClass('btn-default');
				$('#usetag_'+uri_id+'_no').addClass('btn-default').removeClass('btn-primary');
			}else{
				$('#usetag_'+uri_id+'_no').addClass('btn-primary').removeClass('btn-default');
				$('#usetag_'+uri_id+'_ok').addClass('btn-default').removeClass('btn-primary');
			}
			$('#usetag_'+uri_id).val(usetag);
			save_roleuri(uri_id,usetag,moduleid);
		}
		function save_roleuri(uri_id,usetag,moduleid){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/roleuri_save.do';
			var roleid=$("#role_id").val();
			var data={
				uri_id:uri_id,
				use_tag:usetag,
				roleid:roleid,
				moduleid:moduleid
			};
			var callback=function(result){
				if(result.msg){
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
		}
		function refresh_roleuri(){
			var url='${pageContext.request.contextPath}/admin/roleuri_refresh.do';
			var roleid=$("#role_id").val();
			var data={
				roleid:roleid
			};
			var callback=function(result){
				if(result.msg){
					 magic.alert('权限刷新成功', '消息提示',{
		               		'label': '确定',
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
         	<div class="con_main">
         		<div class="con_main_wrap" style="height:800px;">
         			<div class="box">
						<div class="heading">
    						<h1>用户资源路径设置(添加的资源路径用于权限管理)</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
									<ul>
										<li style="color:red;">${role.ROLE_NAME}</li>
									</ul><c:forEach items="${modulelist}" var="mo" varStatus="mo_index">
									<ul class="title">
										<li>${mo.MODULE_NAME}(${mo.MEMO})</li>
									</ul><c:forEach var="uri" items="${urilist}" varStatus="uri_index"><c:if test="${uri.MODULEID==mo.MODULE_ID}">
											<ul class="row">
												<li class="w50 tr"></span></li>
												<li class="w150"><input type="text" disabled="disabled" class="form-control input-sm" id="uri_name_${uri.URI_ID}" value="${uri.URI_NAME}"/></li>
												<li class="w150"><input type="text" disabled="disabled" class="form-control input-sm" id="uri_${uri.URI_ID}" value="${uri.URI}"/></li>
												<c:if test="${uri.SUBMENU==1}"><li class="w60"><button type="button" class="btn btn-default btn-xs">MENU</button></li></c:if>
												<c:if test="${uri.SUBMENU!=1}"><li class="w60">&nbsp;</li></c:if>
												<li class="w150">
													<div class="btn-group">
														<button type="button" class="btn btn-default btn-xs" id="usetag_${uri.URI_ID}_ok" onclick="switch_usetag('${uri.URI_ID}','1','${mo.MODULE_ID}');">允许访问</button>
														<button type="button" class="btn btn-default btn-xs" id="usetag_${uri.URI_ID}_no" onclick="switch_usetag('${uri.URI_ID}','0','${mo.MODULE_ID}');">限制</button>
													</div>
												</li>
											</ul></c:if></c:forEach></c:forEach>
								<!--loop end-->
								<ul class="last row">
									<li class="w100"><button onclick="refresh_roleuri();" type="submit" class="btn btn-warning btn-sm btn-block">刷新权限</button></li>
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div style="clear:both;">
									<input type="hidden" id="role_id" value="${role.ROLE_ID}"/><c:forEach items="${roleuri_list}" var="roleuri">
									<input type="hidden" class="usetag" id="usetag_${roleuri.URIID}" value="${roleuri.USE_TAG}"/></c:forEach>
								</div>
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
