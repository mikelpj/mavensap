<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>添加工号</title>
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
			
		});
		function save_staff(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/staff_save.do';
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
			
			var _remark=$("#_remark").val();//备注
			if(_staff_id.length<1){showmsg('工号不能为空');return;};
			if(_pass_word.length<1){showmsg('登录密码不能为空');return;};
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
				password:_pass_word,
				eparchy_code:_eparchy_code,
				role_id:_role_id,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					magic.alert('工号添加成功!', '消息提示',{
	               		'label': '返回工号列表',
						'callback': function(){
	                     	window.location.href='${pageContext.request.contextPath}/admin/staff_list.do';
	 					}
	             	});
				}else{
					showmsg(result.errmsg);
				}
			};
			magic.confirm('确认添加该工号吗？', '提示', {
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/admin/staff_list.do">工号管理</a>&nbsp;&gt;&nbsp;添加工号</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>请输入工号信息</li></ul>
								<ul class="row">
									<li class=" w100 tr">工号</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_staff_id" maxlength="20" placeholder="登录工号"/></li>

									<li class=" w100 tr">工号密码</li>
									<li class="w200"><input type="password" class="form-control input-sm" id="_password" maxlength="20" placeholder="登录密码"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">员工性别</li>
									<li class="w200"><select class="form-control input-sm" id="_sex"><option value="0">男</option><option value="1">女</option></select></li>

									<li class=" w100 tr">姓名</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_staff_name" placeholder="员工姓名"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">手机号码</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_serial_number" maxlength="11" placeholder="手机号码"/></li>
									<li class=" w100 tr">E_MAIL地址</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_email" maxlength="40" placeholder="邮箱地址"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">职务说明</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_manager_info" placeholder="职位信息"/></li>
									<li class=" w100 tr">归属部门</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_depart_id" placeholder="归属部门ID"/></li>
								</ul>
								<ul class="row" style="display:none;">
									<li class=" w100 tr">合作商ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_partner_id"/></li>
								</ul>
								<ul class="row" id="row_ui2">
									<li class=" w100 tr">工号权限</li>
									<li class="w200" id="now_right"><a onclick="init_area('ZZZZ');" class="btn btn-primary btn-sm btn-block" role="button">省级工号</a></li>
									<li class="w200"><input type="hidden" id="_eparchy_code" value="ZZZZ"/><input type="hidden" id="_role_id" value="3"/>(点击左侧按钮设置)</li>
								</ul>
								<ul class="row" id="row_ui" style="display:none;">
									<li class=" w100 tr">工号权限</li>
									<li id="right_area" style="width:850px;"></li>
								</ul>
								<ul class="last row">
									<li class="w100"></li>
									<li class="w100"><button onclick="save_staff();" type="button" class="btn btn-warning btn-sm btn-block">保存</button></li>
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
