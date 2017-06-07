<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>合作方添加</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/magic.control.Dialog.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/magic.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css"/>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.blockUI.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			$('#_pspt_end_date').datetimepicker({
				language:'zh-CN',
				weekStart: 1,
		        todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0,
			    format: 'yyyy-mm-dd'
			});
		});
		function input_focus(id,msg){
			if(msg==null){
				$("#hint"+id).html($("#hint"+id).attr('ref')).removeClass('hinterr').show();
			}else{
				$("#hint"+id).html(msg).addClass('hinterr').show();
			}
		}
		function input_blur(id){
			$("#hint"+id).hide();
		}
		function save_partnertemp(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/partnertemp_save.do';
			var _staffid=$("#_staffid").val();//用户登录名
			var _password=$("#_password").val();//密码
			var _password2=$("#_password2").val();//密码
			var _staff_name=$("#_staff_name").val();//工号名称
			var _cust_name=$("#_cust_name").val();//合作方名称
			var _pspt_type_code=$("#_pspt_type_code").val();//证件类型
			var _pspt_id=$("#_pspt_id").val();//证件号码
			var _pspt_end_date=$("#_pspt_end_date").val();//证件过期时间
			var _pspt_addr=$("#_pspt_addr").val();//证件地址
			var _post_address=$("#_post_address").val();//邮寄地址
			var _post_code=$("#_post_code").val();//邮编
			var _post_person=$("#_post_person").val();//联系人
			var _phone=$("#_phone").val();//手机号
			var industry=$("#industry").val();
			var nature=$("#nature").val();
			var site=$("#_site").val();
			var _email=$("#_email").val();//电子邮箱
			var _sex=$("#_sex").val();//电子邮箱
			var check_ok=true;

			if(_staffid.length<6||_staffid.length>20){input_focus('_staffid','用户名字符长度在6-20位长度之间');check_ok=false;};
			if(!checkUserName(_staffid)){input_focus('_staffid','用户名不符合规范,只接受数字字母及邮箱');check_ok=false;}
			if(_password.length<8||_password.length>20){input_focus('_password','密码长度在8-20位长度之间');check_ok=false;};
			
			if(_post_person.length<2||_post_person.length>20){input_focus('_post_person','请输入联系人姓名');check_ok=false;};
			if(!isChinese(_post_person)){input_focus('_post_person','请输入中文姓名');check_ok=false;};
			if(_phone.length<1){input_focus('_phone','手机号不能为空');check_ok=false;};
			if(!isMobile(_phone)){input_focus('_phone','请输入正确的手机号码');check_ok=false;};
			if(_email.length>0&&!isEmail(_email)){input_focus('_email','请输入合法的邮箱地址');check_ok=false;}

			if(_cust_name.length<2){input_focus('_cust_name','请输入公司全称');check_ok=false;};
			if(_pspt_addr.length<1){input_focus('_pspt_addr','请输入公司详情地址');check_ok=false;};
			if(_pspt_id.length<1){input_focus('_pspt_id','请输入证件号码');check_ok=false;};
			if(_pspt_end_date.length<1){input_focus('_pspt_end_date','请输入企业证件有效期');check_ok=false;};
			if(_pspt_end_date.length>0&&!isDate(_pspt_end_date)){input_focus('_pspt_end_date','证件有效期格式不正确。输入示例:2016-03-15');check_ok=false;};

			if(industry.length<1){input_focus('_industry','请输选择公司行业');check_ok=false;}else{$("#hint_industry").hide();}
			if(nature.length<1){input_focus('_nature','请输选择公司性质');check_ok=false;}else{$("#hint_nature").hide();}
			
			if(!check_ok){
				return;
			}
			var _bugfix='';
			
			var data={
				staff_id:_staffid,
				password:_password,
				cust_name:_cust_name,
				staff_name:_staff_name,
				pspt_type_code:_pspt_type_code,
				pspt_id:_pspt_id,
				pspt_end_date:_pspt_end_date,
				pspt_addr:_pspt_addr,
				post_address:_post_address,
				post_code:_post_code,
				post_person:_post_person,
				phone:_phone,
				email:_email,
				sex:_sex,
				industry:industry,
				nature:nature,
				site:site,
				regtype:1,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					magic.alert('合作方资料创建成功', '消息提示',{
	               		'label': '返回',
						'callback': function(){
	                     	
	 					}
	             	});
				}else{
					showmsg(result.errmsg);
					magic.alert(result.errmsg, '消息提示',{
	               		'label': '返回',
						'callback': function(){
	                     	
	 					}
	             	});
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
		function switch_gender(v){
			if(v=='0'){
				$('#gender_m').addClass('btn-primary').removeClass('btn-default');
				$('#gender_f').addClass('btn-default').removeClass('btn-primary');
			}else{
				$('#gender_m').addClass('btn-default').removeClass('btn-primary');
				$('#gender_f').addClass('btn-primary').removeClass('btn-default');
			}
			$('#_sex').val(v);
		}
		</script>
		<style>
		#radomcaptcha img{height:40px;width:180px;}
		.must{line-height:28px;color:red;}
		.lh50{line-height:28px;}
		.hint{border:1px solid #ccc;background:none repeat scroll 0 0 #f4f4f4;padding-left:10px;width:300px;height:28px;line-height:28px;color:#999;display:none;}
		.hinterr{border:1px solid #FFBDBE;background:none repeat scroll 0 0 #FFEBEB;padding-left:10px;width:300px;height:28px;line-height:28px;color:#f00;}
		</style>
	</head>
<body class="bodybg">
		<!-- 页头开始-->
		<jsp:include page="/jsp/common/menu_header.jsp"></jsp:include>
		<!-- 页头结束-->
         <div id="contain">
         	<div class="box">
						<div class="heading">
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/admin/partnertemp_list.do">合作商管理</a>&nbsp;&gt;&nbsp;合作商添加</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>登录资料</li></ul>
								<ul class="row">
									<li class=" w150 tr">用户名</li>
									<li class="w300"><input type="text" onfocus="input_focus('_staffid');" onblur="input_blur('_staffid')" class="form-control input-sm" id="_staffid" placeholder="手机号或邮箱" /></li>
									<li class="w20 tl must">*</li>
									<li><div class="hint" id="hint_staffid" ref="请输入手机号/邮箱/用户名"></div></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">始初密码</li>
									<li class="w300"><input type="text" onfocus="input_focus('_password');" onblur="input_blur('_password')" readonly="readonly" class="form-control input-sm" id="_password" placeholder="登录密码" value="12345678"/></li>
									<li class="w20 tl must">*</li>
									<li><div class="hint" id="hint_password" ref="8-20位字符,可使用字母.数字.特殊字符组合"></div></li>
								</ul>
								<ul class="title"><li>联系人信息</li></ul>
								<ul class="row">
									<li class=" w150 tr">联系人姓名</li>
									<li class="w300"><input type="text" onfocus="input_focus('_post_person');" onblur="input_blur('_post_person')" class="form-control input-sm" id="_post_person" placeholder="联系人姓名" /></li>
									<li class="w20 tl must">*</li>
									<li><div class="hint" id="hint_post_person" ref="2-20个字符,请输入中文"></div></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">性别</li>
									<li class="w300">
										<input type="hidden" class="form-control input-sm" id="_sex" value="0"/>
										<div class="btn-group">
											<button type="button" class="btn btn-primary btn-sm" id="gender_m" onclick="switch_gender('0');">先生</button>
											<button type="button" class="btn btn-default btn-sm" id="gender_f" onclick="switch_gender('1');">女士</button>
										</div>
									</li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">手机号</li>
									<li class="w300"><input type="text" onfocus="input_focus('_phone');" onblur="input_blur('_phone')" class="form-control input-sm" id="_phone" placeholder="您的手机号码"/></li>
									<li class="w20 tl must">*</li>
									<li><div class="hint" id="hint_phone" ref="请输入联系人的手机号码"></div></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">电子邮箱</li>
									<li class="w300"><input type="text"  onfocus="input_focus('_email');" onblur="input_blur('_email')" class="form-control input-sm" id="_email" placeholder="联系人的电子邮箱"/></li>
									<li class="w20 tl must"></li>
									<li><div class="hint" id="hint_email" ref="请输入联系人的邮箱"></div></li>
								</ul>
								<ul class="title"><li>公司信息</li></ul>
								<ul class="row">
									<li class=" w150 tr">公司名字</li>
									<li class="w300"><input type="text" class="form-control input-sm" id="_cust_name" onfocus="input_focus('_cust_name');" onblur="input_blur('_cust_name')" /></li>
									<li class="w20 tl must">*</li>
									<li><div class="hint" id="hint_cust_name" ref="请填写公司全称,分支公司填写分支名"></div></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">公司地址</li>
									<li class="w300"><input type="text" onfocus="input_focus('_pspt_addr');" onblur="input_blur('_pspt_addr')"  class="form-control input-sm" id="_pspt_addr"/></li>
									<li class="w20 tl must">*</li>
									<li><div class="hint" id="hint_pspt_addr" ref="如:郑州市中原区建设路XX号几单元几楼"></div></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">证件类型</li>
									<li class="w300"><select class="form-control input-sm" id="_pspt_type_code"><option value="1">身份证</option><option value="2">营业执照</option><option value="3" selected="selected">组织机构代码证</option></select></li>
									<li class="w20 tl must">*</li>
									<li><div class="hint" id="hint_pspt_type_code" ref="请选择证件类型"></div></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">证件号码</li>
									<li class="w300"><input type="text" onfocus="input_focus('_pspt_id');" onblur="input_blur('_pspt_id')"  class="form-control input-sm" id="_pspt_id"/></li>
									<li class="w20 tl must">*</li>
									<li><div class="hint" id="hint_pspt_id" ref="请输入企业的证件号码"></div></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">证件有效期</li>
									<li class="w300"><input type="text"  onfocus="input_focus('_pspt_end_date');" onblur="input_blur('_pspt_end_date')" class="form-control input-sm" id="_pspt_end_date"/></li>
									<li class="w20 tl must">*</li>
									<li><div class="hint" id="hint_pspt_end_date" ref="请输入企业证件有效期"></div></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">公司网址</li>
									<li class="w300"><input type="text" class="form-control input-sm" id="_site"  onfocus="input_focus('_site');" onblur="input_blur('_site')" /></li>
									<li class="w20 tl must"></li>
									<li><div class="hint" id="hint_site" ref="公司的网址首页"></div></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">公司行业</li>
									<li class="w300"><select name="industry" id="industry" tabindex="21" class="form-control"  onclick="input_focus('_industry');" onchange="input_blur('_industry')" >
                <option value="">请选择</option>
             <option value="1">计算机硬件及网络设备</option>
            <option value="2">计算机软件</option>
            <option value="3">IT服务（系统/数据/维护）/多领域经营</option>
            <option value="4">互联网/电子商务</option>
            <option value="5">网络游戏</option>
            <option value="6">通讯（设备/运营/增值服务）</option>
            <option value="7">电子技术/半导体/集成电路</option>
            <option value="8">仪器仪表及工业自动化</option>
            <option value="9">金融/银行/投资/基金/证券</option>
            <option value="10">保险</option>
            <option value="11">房地产/建筑/建材/工程</option>
            <option value="12">家居/室内设计/装饰装潢</option>
            <option value="13">物业管理/商业中心</option>
            <option value="14">广告/会展/公关/市场推广</option>
            <option value="15">媒体/出版/影视/文化/艺术</option>
            <option value="16">印刷/包装/造纸</option>
            <option value="17">咨询/管理产业/法律/财会</option>
            <option value="18">教育/培训</option>
            <option value="19">检验/检测/认证</option>
            <option value="20">中介服务</option>
            <option value="21">贸易/进出口</option>
            <option value="22">零售/批发</option>
            <option value="23">快速消费品（食品/饮料/烟酒/化妆品</option>
            <option value="24">耐用消费品（服装服饰/纺织/皮革/家具/家电）</option>
            <option value="25">办公用品及设备</option>
            <option value="26">礼品/玩具/工艺美术/收藏品</option>
            <option value="27">大型设备/机电设备/重工业</option>
            <option value="28">加工制造（原料加工/模具）</option>
            <option value="29">汽车/摩托车（制造/维护/配件/销售/服务）</option>
            <option value="30">交通/运输/物流</option>
            <option value="31">医药/生物工程</option>
            <option value="32">医疗/护理/美容/保健</option>
            <option value="33">医疗设备/器械</option>
            <option value="34">酒店/餐饮</option>
            <option value="35">娱乐/体育/休闲</option>
            <option value="36">旅游/度假</option>
            <option value="37">石油/石化/化工</option>
            <option value="38">能源/矿产/采掘/冶炼</option>
            <option value="39">电气/电力/水利</option>
            <option value="40">航空/航天</option>
            <option value="41">学术/科研</option>
            <option value="42">政府/公共事业/非盈利机构</option>
            <option value="43">环保</option>
            <option value="44">农/林/牧/渔</option>
            <option value="45">跨领域经营</option>
            <option value="46">其它</option>
            </select></li>
            <li class="w20 tl must">*</li>
            <li><div class="hint" id="hint_industry" ref="请选择公司的行业"></div></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">公司性质</li>
									<li class="w300"><select name="nature" id="nature" tabindex="22" class="form-control"  onclick="input_focus('_nature');" onchange="input_blur('_nature')" >
                <option value="">请选择</option>
             <option value="1">政府机关/事业单位</option>
            <option value="2">国营</option>
            <option value="3">私营</option>
            <option value="4">中外合资</option>
            <option value="5">外资</option>
            <option value="6">其他</option>
            </select></li><li class="w20 tl must">*</li>
             <li><div class="hint" id="hint_nature" ref="请选择公司的性质"></div></li>
								</ul>
								<ul class="last row">
									<li class=" w150 tr"></li>
									<li class="w100"><button onclick="save_partnertemp();" href="#" type="submit" class="btn btn-warning btn-sm btn-block">添加合作方</button></li>
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
