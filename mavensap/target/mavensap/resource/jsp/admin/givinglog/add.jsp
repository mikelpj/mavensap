<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>添加流量赠送记录</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			
		});
		function save_givinglog(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/givinglog_save.do';
			var _user_id=$("#_user_id").val();//受赠的用户ID
			var _cust_id=$("#_cust_id").val();//合作方BSS客户ID
			var _acct_id=$("#_acct_id").val();//主账户ID
			var _p_serial_number=$("#_p_serial_number").val();//主号码
			var _p_user_id=$("#_p_user_id").val();//主用户
			var _serial_number=$("#_serial_number").val();//受赠号码
			var _batch_id=$("#_batch_id").val();//批发时的批次
			var _f_flow=$("#_f_flow").val();//原始流量
			var _is_over=$("#_is_over").val();//是否使用完
			var _e_flow=$("#_e_flow").val();//剩余流量
			var _u_product_id=$("#_u_product_id").val();//必须是BSS的资费ID
			var _fee=$("#_fee").val();//这一批次的总金额，单位元
			var _u_data_flow=$("#_u_data_flow").val();//单位M
			var _unit_price=$("#_unit_price").val();//单位元每兆
			var _eparchy_code=$("#_eparchy_code").val();//归属地市
			var _state=$("#_state").val();//成功状态
			var _sync_state=$("#_sync_state").val();//同步状态
			var _sync_result=$("#_sync_result").val();//同步结果说明
			var _fail_reason=$("#_fail_reason").val();//备用字段1
			var _start_time=$("#_start_time").val();//操作时间
			var _end_time=$("#_end_time").val();//操作时间
			if(_user_id.length<1){showmsg('受赠的用户ID不能为空');return;};
			if(_cust_id.length<1){showmsg('合作方BSS客户ID不能为空');return;};
			if(_acct_id.length<1){showmsg('主账户ID不能为空');return;};
			if(_p_serial_number.length<1){showmsg('主号码不能为空');return;};
			if(_p_user_id.length<1){showmsg('主用户不能为空');return;};
			if(_serial_number.length<1){showmsg('受赠号码不能为空');return;};
			if(_batch_id.length<1){showmsg('批发时的批次不能为空');return;};
			if(_f_flow.length<1){showmsg('原始流量不能为空');return;};
			if(_is_over.length<1){showmsg('是否使用完不能为空');return;};
			if(_e_flow.length<1){showmsg('剩余流量不能为空');return;};
			if(_u_product_id.length<1){showmsg('必须是BSS的资费ID不能为空');return;};
			if(_fee.length<1){showmsg('这一批次的总金额，单位元不能为空');return;};
			if(_u_data_flow.length<1){showmsg('单位M不能为空');return;};
			if(_unit_price.length<1){showmsg('单位元每兆不能为空');return;};
			if(_eparchy_code.length<1){showmsg('归属地市不能为空');return;};
			if(_state.length<1){showmsg('成功状态不能为空');return;};
			if(_sync_state.length<1){showmsg('同步状态不能为空');return;};
			if(_sync_result.length<1){showmsg('同步结果说明不能为空');return;};
			if(_fail_reason.length<1){showmsg('备用字段1不能为空');return;};
			if(_start_time.length<1){showmsg('操作时间不能为空');return;};
			if(_end_time.length<1){showmsg('操作时间不能为空');return;};
			var _bugfix='';
			
			var data={
				user_id:_user_id,
				cust_id:_cust_id,
				acct_id:_acct_id,
				p_serial_number:_p_serial_number,
				p_user_id:_p_user_id,
				serial_number:_serial_number,
				batch_id:_batch_id,
				f_flow:_f_flow,
				is_over:_is_over,
				e_flow:_e_flow,
				u_product_id:_u_product_id,
				fee:_fee,
				u_data_flow:_u_data_flow,
				unit_price:_unit_price,
				eparchy_code:_eparchy_code,
				state:_state,
				sync_state:_sync_state,
				sync_result:_sync_result,
				fail_reason:_fail_reason,
				start_time:_start_time,
				end_time:_end_time,
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
    						<h1>添加流量赠送记录</h1>
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
									<li class=" w100 tr">受赠的用户ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_user_id"/></li>

									<li class=" w100 tr">合作方BSS客户ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_cust_id"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">主账户ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_acct_id"/></li>

									<li class=" w100 tr">主号码</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_p_serial_number"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">主用户</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_p_user_id"/></li>

									<li class=" w100 tr">受赠号码</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_serial_number"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">批发时的批次</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_batch_id"/></li>

									<li class=" w100 tr">原始流量</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_f_flow"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">是否使用完</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_is_over"/></li>

									<li class=" w100 tr">剩余流量</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_e_flow"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">必须是BSS的资费ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_u_product_id"/></li>

									<li class=" w100 tr">这一批次的总金额，单位元</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_fee"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">单位M</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_u_data_flow"/></li>

									<li class=" w100 tr">单位元每兆</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_unit_price"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">归属地市</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_eparchy_code"/></li>

									<li class=" w100 tr">成功状态</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_state"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">同步状态</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_sync_state"/></li>

									<li class=" w100 tr">同步结果说明</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_sync_result"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">备用字段1</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_fail_reason"/></li>

									<li class=" w100 tr">操作时间</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_start_time"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">操作时间</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_end_time"/></li>
								<ul class="last row">
									<li class="w100"><button onclick="save_givinglog();" type="submit" class="btn btn-warning btn-sm btn-block">保存</button></li>
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
