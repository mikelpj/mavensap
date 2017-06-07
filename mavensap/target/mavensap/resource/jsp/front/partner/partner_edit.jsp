<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>编辑合作方</title>
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
		function update_partner(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/partner/update.do';
			var _cust_id=$("#_cust_id").val();//BSS客户ID
			var _acct_id=$("#_acct_id").val();//主账户ID
			var _serial_number=$("#_serial_number").val();//主号码
			var _user_id=$("#_user_id").val();//主用户
			var _cust_name=$("#_cust_name").val();//合作方名称
			var _pspt_type_code=$("#_pspt_type_code").val();//证件类型
			var _pspt_id=$("#_pspt_id").val();//证件ID
			var _pspt_end_date=$("#_pspt_end_date").val();//证件有效期
			var _pspt_addr=$("#_pspt_addr").val();//证件地址
			var _post_address=$("#_post_address").val();//通信地址
			var _post_code=$("#_post_code").val();//邮编
			var _post_person=$("#_post_person").val();//联系人
			var _phone=$("#_phone").val();//联系人电话
			var _email=$("#_email").val();//邮箱
			var _state=$("#_state").val();//状态
			var _oper_type=$("#_oper_type").val();//动作类型
			var _sync_result=$("#_sync_result").val();//同步结果说明
			var _remark=$("#_remark").val();//备注
			if(_cust_id.length<1){showmsg('BSS客户ID不能为空');return;};
			if(_acct_id.length<1){showmsg('主账户ID不能为空');return;};
			if(_serial_number.length<1){showmsg('主号码不能为空');return;};
			if(_user_id.length<1){showmsg('主用户不能为空');return;};
			if(_cust_name.length<1){showmsg('合作方名称不能为空');return;};
			if(_pspt_type_code.length<1){showmsg('证件类型不能为空');return;};
			if(_pspt_id.length<1){showmsg('证件ID不能为空');return;};
			if(_pspt_end_date.length<1){showmsg('证件有效期不能为空');return;};
			if(_pspt_addr.length<1){showmsg('证件地址不能为空');return;};
			if(_post_address.length<1){showmsg('通信地址不能为空');return;};
			if(_post_code.length<1){showmsg('邮编不能为空');return;};
			if(_post_person.length<1){showmsg('联系人不能为空');return;};
			if(_phone.length<1){showmsg('联系人电话不能为空');return;};
			if(_email.length<1){showmsg('邮箱不能为空');return;};
			if(_state.length<1){showmsg('状态不能为空');return;};
			if(_oper_type.length<1){showmsg('动作类型不能为空');return;};
			if(_sync_result.length<1){showmsg('同步结果说明不能为空');return;};
			if(_remark.length<1){showmsg('备注不能为空');return;};
			var _bugfix='';
			
			var data={
				cust_id:_cust_id,
				acct_id:_acct_id,
				serial_number:_serial_number,
				user_id:_user_id,
				cust_name:_cust_name,
				pspt_type_code:_pspt_type_code,
				pspt_id:_pspt_id,
				pspt_end_date:_pspt_end_date,
				pspt_addr:_pspt_addr,
				post_address:_post_address,
				post_code:_post_code,
				post_person:_post_person,
				phone:_phone,
				email:_email,
				state:_state,
				oper_type:_oper_type,
				sync_result:_sync_result,
				remark:_remark,
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
    						<h1>编辑合作方</h1>
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
									<li class=" w100 tr">合作方名称</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_cust_name" value="${data.cust_name}"/></li>
								
									<li class=" w100 tr">证件类型</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_pspt_type_code" value="${data.pspt_type_code}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">证件ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_pspt_id" value="${data.pspt_id}"/></li>
								
									<li class=" w100 tr">证件有效期</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_pspt_end_date" value="${data.pspt_end_date}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">证件地址</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_pspt_addr" value="${data.pspt_addr}"/></li>
								
									<li class=" w100 tr">通信地址</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_post_address" value="${data.post_address}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">邮编</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_post_code" value="${data.post_code}"/></li>
								
									<li class=" w100 tr">联系人</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_post_person" value="${data.post_person}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">联系人电话</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_phone" value="${data.phone}"/></li>
								
									<li class=" w100 tr">邮箱</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_email" value="${data.email}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">状态</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_state" value="${data.state}"/></li>
								
									<li class=" w100 tr">动作类型</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_oper_type" value="${data.oper_type}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">同步结果说明</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_sync_result" value="${data.sync_result}"/></li>
								
									<li class=" w100 tr">备注</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_remark" value="${data.remark}"/></li>
								</ul>
								
								<ul class="last row">
									<li class="w100"><button onclick="update_partner();" type="submit" class="btn btn-warning btn-sm btn-block">更新</button></li>
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
					<div class="heading">
    					<h1>流量批发记录管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/wholesalelog/list.do">流量批发记录列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/wholesalelog/add.do">添加流量批发记录</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>合作方临时资料管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/partnertemp/list.do">合作方临时资料列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/partnertemp/add.do">添加合作方临时资料</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>合作方管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/partner/list.do">合作方列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/partner/add.do">添加合作方</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>流量赠送记录管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/givinglog/list.do">流量赠送记录列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/givinglog/add.do">添加流量赠送记录</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>根据权限生成菜单TODO</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							  子菜单
						</li>
					</ul>
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
