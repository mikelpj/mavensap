<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>合作方临时资料详情</title>
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
			$("#industry").val($("#industry_val").val());
			$("#nature").val($("#nature_val").val());
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
	               		'label': '设置可订购产品',
						'callback': function(){
	                     	window.location.href='${pageContext.request.contextPath}/admin/product_partner.do?partner_id='+partner_id;
	 					}
	             	});
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
		}
		function product_setting(partner_id){
			window.location.href='${pageContext.request.contextPath}/admin/product_partner.do?partner_id='+partner_id;
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/admin/partnertemp_list.do">合作商管理</a>&nbsp;&gt;&nbsp;用户资料信息</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>联系人资料</li></ul>
								<ul class="row">
									<li class=" w150 tr">联系人姓名</li>
									<li class="w300"><input type="text" class="form-control input-sm" id="_staff_name" readonly="readonly" value="${data.POST_PERSON}"/></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">性别</li>
									<li class="w300">
										<select class="form-control input-sm" id="_sex" disabled="disabled">
											<option value="0">先生</option>
											<option value="1">女士</option>
										</select>
									</li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">手机号</li>
									<li class="w300"><input type="text" class="form-control input-sm" id="_phone" value="${data.PHONE}" readonly="readonly"/></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">电子邮箱</li>
									<li class="w300"><input type="text" class="form-control input-sm" id="_email" value="${data.EMAIL}" readonly="readonly"/></li>
								</ul>
								<c:if test="${data.RSRV_VALUE2=='P'}">
									<ul class="row">
										<li class=" w150 tr">证件类型</li>
										<li class="w300"><select id="_pspt_type_code" class="form-control input-sm" disabled="disabled">
											<option value="1">身份证</option>
											<option value="2">营业执照</option>
											<option value="3">组织机构代码证</option>
										</select><input type="hidden" id="_pspt_type_code_val" value="${data.PSPT_TYPE_CODE}"/></li>
									</ul>
									<ul class="row">
										<li class=" w150 tr">证件号码</li>
										<li class="w300"><input type="text" disabled="disabled" class="form-control input-sm" id="_pspt_id" value="${data.PSPT_ID}" readonly="readonly"/></li>
									</ul>
									<ul class="row">
										<li class=" w150 tr">证件有效期</li>
										<li class="w300"><input type="text" disabled="disabled" class="form-control input-sm" id="_pspt_end_date" value="${data.PSPT_END_DATE}" readonly="readonly"/></li>
									</ul>
								</c:if>
								<c:if test="${data.RSRV_VALUE2=='C'}">
									<ul class="title"><li>公司信息</li></ul>
								<ul class="row">
									<li class=" w150 tr">公司名称</li>
									<li class="w300"><input type="text" class="form-control input-sm" id="_cust_name" value="${data.CUST_NAME}" readonly="readonly"/></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">公司地址</li>
									<li class="w300"><input type="text" class="form-control input-sm" id="_pspt_addr" value="${data.PSPT_ADDR}" readonly="readonly"/></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">证件类型</li>
									<li class="w300"><select id="_pspt_type_code" class="form-control input-sm" disabled="disabled">
											<option value="1">身份证</option>
											<option value="2">营业执照</option>
											<option value="3">组织机构代码证</option>
										</select><input type="hidden" id="_pspt_type_code_val" value="${data.PSPT_TYPE_CODE}"/></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">证件号码</li>
									<li class="w300"><input type="text" disabled="disabled" class="form-control input-sm" id="_pspt_id" value="${data.PSPT_ID}" readonly="readonly"/></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">证件有效期</li>
									<li class="w300"><input type="text" disabled="disabled" class="form-control input-sm" id="_pspt_end_date" value="${data.PSPT_END_DATE}" readonly="readonly"/></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">公司网址</li>
									<li class="w300"><input type="text" disabled="disabled" class="form-control input-sm" id="_site" value="${data.RSRV_VALUE1}" readonly="readonly"/></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">公司行业</li>
									<li class="w300"><select class="form-control" tabindex="21" id="industry" name="industry" disabled="disabled">
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
            </select><input type="hidden" id="industry_val" value="${data.RSRV_NUM1}"/></li>
								</ul>
								<ul class="row">
									<li class=" w150 tr">公司性质</li>
									<li class="w300"><select class="form-control" tabindex="22" id="nature" name="nature" disabled="disabled">
                <option value="">请选择</option>
             <option value="1">政府机关/事业单位</option>
            <option value="2">国营</option>
            <option value="3">私营</option>
            <option value="4">中外合资</option>
            <option value="5">外资</option>
            <option value="6">其他</option>
            </select><input type="hidden" id="nature_val" value="${data.RSRV_NUM2}"/></li>
								</ul>
								</c:if>
								<ul class="row">
									<li class=" w150 tr">状态</li>
									<li class="w300">
										<c:if test="${data.STATE=='0'}">未审核</c:if>
										<c:if test="${data.STATE=='1'}">已审核</c:if>
										<c:if test="${data.STATE=='4'}">资料同步成功</c:if>
										<c:if test="${data.STATE=='5'}">资料同步成功</c:if>
										<c:if test="${data.STATE=='9'}">资料同步失败</c:if>
									</li>
								</ul>
								<c:if test="${data.STATE=='0'}">
								<ul class="row">
									<li class=" w100 tr">审核备注</li>
									<li class="w500"><input type="text" class="form-control input-sm" id="_remark" value="${data.REMARK}"/></li>
								</ul>
								</c:if>
								<ul class="last row">
									<c:if test="${data.STATE=='0'}">
									<li class="w100"><button onclick="update_partnertemp('1');" type="submit" class="btn btn-warning btn-sm btn-block">审核通过</button></li>
									<li class="w100"><button onclick="update_partnertemp('2');" type="submit" class="btn btn-warning btn-sm btn-block">审核不通过</button></li>
									</c:if>
									<c:if test="${data.STATE=='2'}">
									<li class="w100"><button onclick="update_partnertemp('1');" type="submit" class="btn btn-warning btn-sm btn-block">审核通过</button></li>
									</c:if>
									<c:if test="${data.STATE=='1' and data.RSRV_VALUE2=='C'}">
									<li class="w100"><button onclick="update_partnertemp('1');" type="submit" class="btn btn-warning btn-sm btn-block">设置可购产品</button></li>
									</c:if>
									<c:if test="${(data.STATE=='3'||data.STATE=='4'||data.STATE=='5') and data.RSRV_VALUE2=='C'}">
									<li class="w100"><button onclick="product_setting('${data.PARTNER_ID}');" type="submit" class="btn btn-warning btn-sm btn-block">设置可购产品</button></li>
									</c:if>
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
