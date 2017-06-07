<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>编辑工号</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/magic.control.Dialog.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/magic.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			$("#_sex").val('${data.SEX}');
			var eparchy_code='${data.RSRV_VALUE1}';
			if(eparchy_code!=null&&eparchy_code.length>2){
				add_area(eparchy_code);
			}
		});
		function update_staff(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/staff_update.do';
			var _staff_id=$("#_staff_id").val();//登陆名称
			var _staff_name=$("#_staff_name").val();//登陆名称
			var _pass_word=$("#_password").val();//密码
			var _depart_id=$("#_depart_id").val();//归属部门
			var _partner_id=$("#_partner_id").val();//合作商ID
			var _manager_info=$("#_manager_info").val();//职务说明
			var _sex=$("#_sex").val();//员工性别
			var _email=$("#_email").val();//E_MAIL地址
			var _serial_number=$("#_serial_number").val();//手机号码
			var _eparchy_code=$("#_eparchy_code").val();
			var _role_id=$("#_role_id").val();
			
			if(_staff_id.length<1){showmsg('工号不能为空');return;};
			if(_staff_name.length<1){showmsg('姓名不能为空');return;};
			if(_sex.length<1){showmsg('员工性别不能为空');return;};
			if(_serial_number.length<1){showmsg('手机号码不能为空');return;};
			if(_email.length<1){showmsg('E_MAIL地址不能为空');return;};
			if(_manager_info.length<1){showmsg('职务说明不能为空');return;};
			if(_eparchy_code.length<1){showmsg('请设置工号权限');return;};
			if(_role_id.length<1){showmsg('请设置工号权限');return;};
			
			var _bugfix='';
			
			var data={
					staff_id:_staff_id,
					staff_name:_staff_name,
					depart_id:_depart_id,
					partner_id:_partner_id,
					manager_info:_manager_info,
					sex:_sex,
					email:_email,
					serial_number:_serial_number,
					eparchy_code:_eparchy_code,
					role_id:_role_id,
					bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					magic.alert('工号修改成功!', '消息提示',{
	               		'label': '返回工号列表',
						'callback': function(){
	                     	window.location.href='${pageContext.request.contextPath}/admin/staff_list.do';
	 					}
	             	});
				}else{
					showmsg(result.errmsg);
				}
			};

			magic.confirm('确认更新工号信息吗？', '提示', {
                'label': '确定',
                'callback': function(){
					ajaxQuery(url,'post','json',data,callback);
                }
            }, {
                'label': '取消',
                'callback': function(){
                    return;
                }
        	});
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
		function get_areaname(code){
			var area_codes='ZZZZ,0371,0370,0372,0373,0374,0375,0376,0377,0378,0379,0391,0392,0393,0394,0395,0396,0398,0399'.split(',');
			var area_names='省级工号,(郑州)地市工号,(商丘)地市工号,(安阳)地市工号,(新乡)地市工号,(许昌)地市工号,(平顶山)地市工号,(信阳)地市工号,(南阳)地市工号,(开封)地市工号,(洛阳)地市工号,(焦作)地市工号,(鹤壁)地市工号,(濮阳)地市工号,(周口)地市工号,(漯河)地市工号,(驻马店)地市工号,(三门峡)地市工号,(济源)地市工号'.split(',');
			for(var i=0;i<area_codes.length;i++){
				if(area_codes[i]==code){
					return area_names[i];
				}
			}
			return '未知';
		}
		var now_ids='';
		var now_staffid='';
		function get_available_area(ss){
			var area_codes='ZZZZ,0371,0370,0372,0373,0374,0375,0376,0377,0378,0379,0391,0392,0393,0394,0395,0396,0398,0399'.split(',');
			var area_names='省级工号,郑州,商丘,安阳,新乡,许昌,平顶山,信阳,南阳,开封,洛阳,焦作,鹤壁,濮阳,周口,漯河,驻马店,三门峡,济源'.split(',');
			var html='';
			for(var i=0;i<area_codes.length;i++){
				if(area_codes[i]==ss){
					html+='<a role="button" class="btn btn-primary btn-sm" onclick="add_area(\''+area_codes[i]+'\');">'+area_names[i]+'</a>&nbsp;';
				}else{
					html+='<a role="button" class="btn btn-default btn-sm" onclick="add_area(\''+area_codes[i]+'\');">'+area_names[i]+'</a>&nbsp;';
				}
			}
			return html;
		}

		function init_area(a){
			$("#right_area").html(get_available_area(a));
			$("#row_ui").show();
			$("#row_ui2").hide();
		}

		function add_area(a){
			$("#_eparchy_code").val(a);
			$("#now_right").html('<a onclick="init_area(\''+a+'\');" class="btn btn-primary btn-sm btn-block" role="button">'+get_areaname(a)+'</a>');
			$("#row_ui").hide();
			$("#row_ui2").show();
			if(a=='ZZZZ'){
				$("#_role_id").val('3');
			}else{
				$("#_role_id").val('4');
			}
		}
		function get_supply_area_html(area_ids){
			var html='';
			if(area_ids.length>3){
				var ids=area_ids.split(',');
				for(var i=0;i<ids.length;i++){
					var area_name=get_areaname(ids[i]);
					html+='<a role="button" class="btn btn-primary btn-sm" onclick="init_area(\''+ids[i]+'\');">'+area_name+'</a>&nbsp;';
				}
			}
			return html;
		}
		</script>
	</head>
<body class="bodybg">
		<!-- 页头开始-->
		<jsp:include page="/jsp/common/menu_header.jsp"></jsp:include>
		<!-- 页头结束-->
         <div id="contain">
         	<div class="con_main">
         		<div class="box">
						<div class="heading">
    						<h1>编辑工号</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="row">
									<li class=" w100 tr">工号</li>
									<li class="w200"><input type="text" readonly="readonly" class="form-control input-sm" id="_staff_id" maxlength="20" value="${data.STAFF_ID}"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">员工性别</li>
									<li class="w200"><select class="form-control input-sm" id="_sex"><option value="0">男</option><option value="1">女</option></select></li>

									<li class=" w100 tr">姓名</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_staff_name" value="${data.STAFF_NAME}"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">手机号码</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_serial_number" maxlength="11" value="${data.SERIAL_NUMBER}"/></li>
									<li class=" w100 tr">E_MAIL地址</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_email" maxlength="40" value="${data.EMAIL}"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">职务说明</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_manager_info" value="${data.MANAGER_INFO}"/></li>
									<li class=" w100 tr">归属部门</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_depart_id" value="${data.DEPART_ID}"/></li>
								</ul>
								<ul class="row" style="display:none;">
									<li class=" w100 tr">合作商ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_partner_id" value="${data.PARTNER_ID}"/></li>
								</ul>
								<c:if test="${data.ROLE_ID==3||data.ROLE_ID==4}">
								<ul class="row" id="row_ui2">
									<li class=" w100 tr">工号权限</li>
									<li class="w200" id="now_right"><a onclick="init_area('');" class="btn btn-primary btn-sm btn-block" role="button">设置工号权限</a></li>
									<li class="w200"><input type="hidden" id="_eparchy_code" value="${data.RSRV_VALUE1}"/><input type="hidden" id="_role_id" value="${data.ROLE_ID}"/>(点击左侧按钮设置)</li>
								</ul>
								<ul class="row" id="row_ui" style="display:none;">
									<li class=" w100 tr">工号权限</li>
									<li id="right_area" style="width:850px;"></li>
								</ul>
								</c:if>
								<ul class="last row">
									<li class="w100"></li>
									<li class="w100"><button onclick="update_staff();" type="submit" class="btn btn-warning btn-sm btn-block">更新</button></li>
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div style="clear:both;"></div>
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
