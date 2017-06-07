<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>编辑流量批发记录</title>
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
		function update_wholesalelog(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/wholesalelog_update.do';
			var _cust_id=$("#_cust_id").val();//BSS客户ID
			var _acct_id=$("#_acct_id").val();//主账户ID
			var _serial_number=$("#_serial_number").val();//主号码
			var _user_id=$("#_user_id").val();//主用户
			var _use_depart_id=$("#_use_depart_id").val();//使用部门
			var _use_staff_id=$("#_use_staff_id").val();//使用工号
			var _p_product_id=$("#_p_product_id").val();//产品
			var _fee=$("#_fee").val();//单位元
			var _p_data_flow=$("#_p_data_flow").val();//单位M
			var _residual_flow=$("#_residual_flow").val();//剩余流量，单位M
			var _eparchy_code=$("#_eparchy_code").val();//合作方归属地市
			if(_cust_id.length<1){showmsg('BSS客户ID不能为空');return;};
			if(_acct_id.length<1){showmsg('主账户ID不能为空');return;};
			if(_serial_number.length<1){showmsg('主号码不能为空');return;};
			if(_user_id.length<1){showmsg('主用户不能为空');return;};
			if(_use_depart_id.length<1){showmsg('使用部门不能为空');return;};
			if(_use_staff_id.length<1){showmsg('使用工号不能为空');return;};
			if(_p_product_id.length<1){showmsg('产品不能为空');return;};
			if(_fee.length<1){showmsg('单位元不能为空');return;};
			if(_p_data_flow.length<1){showmsg('单位M不能为空');return;};
			if(_residual_flow.length<1){showmsg('剩余流量，单位M不能为空');return;};
			if(_eparchy_code.length<1){showmsg('合作方归属地市不能为空');return;};
			var _bugfix='';
			
			var data={
				cust_id:_cust_id,
				acct_id:_acct_id,
				serial_number:_serial_number,
				user_id:_user_id,
				use_depart_id:_use_depart_id,
				use_staff_id:_use_staff_id,
				p_product_id:_p_product_id,
				fee:_fee,
				p_data_flow:_p_data_flow,
				residual_flow:_residual_flow,
				eparchy_code:_eparchy_code,
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
         	<div class="box">
						<div class="heading">
    						<h1>编辑流量批发记录</h1>
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
									<li class=" w100 tr">BSS客户ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_cust_id" value="${data.cust_id}"/></li>
								
									<li class=" w100 tr">主账户ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_acct_id" value="${data.acct_id}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">主号码</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_serial_number" value="${data.serial_number}"/></li>
								
									<li class=" w100 tr">主用户</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_user_id" value="${data.user_id}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">使用部门</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_use_depart_id" value="${data.use_depart_id}"/></li>
								
									<li class=" w100 tr">使用工号</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_use_staff_id" value="${data.use_staff_id}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">产品</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_p_product_id" value="${data.p_product_id}"/></li>
								
									<li class=" w100 tr">单位元</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_fee" value="${data.fee}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">单位M</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_p_data_flow" value="${data.p_data_flow}"/></li>
								
									<li class=" w100 tr">剩余流量，单位M</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_residual_flow" value="${data.residual_flow}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">合作方归属地市</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_eparchy_code" value="${data.eparchy_code}"/></li>
								
								<ul class="last row">
									<li class="w100"><button onclick="update_wholesalelog();" type="submit" class="btn btn-warning btn-sm btn-block">更新</button></li>
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
