<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>我的信息</title>
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
			$("#_pspt_type_code").val($("#_pspt_type_code_val").val());
		});
		function update_partnertemp(v){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/partnertemp_update.do';
			var partner_id=$("#partner_id").val();
			if(v=='2'){
				var remark=$.trim($("#_remark").val());
				if(remark.length<1){
					showmsg('审核不通过时，请在审核备注中填写理由');
					return;
				}
			}
			var data={
				remark:remark,
				partner_id:partner_id,
				state:v
			};
			var callback=function(result){
				if(result.msg){
					magic.alert('设置审核状态成功!', '消息提示',{
	               		'label': '返回',
						'callback': function(){
	                     	window.location.href='${pageContext.request.contextPath}/admin/partnertemp_list.do';
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
	</head>
<body class="bodybg">
		<!-- 页头开始-->
		<jsp:include page="/jsp/common/menu_header.jsp"></jsp:include>
		<!-- 页头结束-->
         <div id="contain">
         	<div class="box">
						<div class="heading">
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;用户服务&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/staff/detail.do">我的信息</a></h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<c:if test="${not empty partner}">
								<ul class="row">
									<li class=" w100 tr">充值帐号</li>
									<li class="w200">${partner.SERIAL_NUMBER}</li>
								</ul>
								</c:if>
								<ul class="title"><li>用户资料</li></ul>
								<ul class="row">
									<li class=" w100 tr">用户名称</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" id="_cust_name" value="${data.CUST_NAME}"/></li>
								
									<li class=" w100 tr">证件类型</li>
									<li class="w200">
										<select id="_pspt_type_code" class="form-control input-sm" disabled="disabled">
											<option value="1">身份证</option>
											<option value="2">营业执照</option>
										</select>
										<input type="hidden" id="_pspt_type_code_val" value="${data.PSPT_TYPE_CODE}"/>
									</li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">证件ID</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" id="_pspt_id" value="${data.PSPT_ID}"/></li>
								
									<li class=" w100 tr">证件有效期</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" id="_pspt_end_date" value="${data.PSPT_END_DATE}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">证件地址</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" id="_pspt_addr" value="${data.PSPT_ADDR}"/></li>
								
									<li class=" w100 tr">通信地址</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" id="_post_address" value="${data.POST_ADDRESS}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">邮编</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" id="_post_code" value="${data.POST_CODE}"/></li>
								
									<li class=" w100 tr">联系人</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" id="_post_person" value="${data.POST_PERSON}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">联系人电话</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" id="_phone" value="${data.PHONE}"/></li>
								
									<li class=" w100 tr">邮箱</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" id="_email" value="${data.EMAIL}"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">备注</li>
									<li class="w500"><input type="text" disabled="disabled" class="form-control input-sm" id="_remark" value="${data.REMARK}"/></li>
								</ul>
								
								<ul class="last row">
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div style="clear:both;">
									<input type="hidden" id="partner_id" value="${data.PARTNER_ID}"/>
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
