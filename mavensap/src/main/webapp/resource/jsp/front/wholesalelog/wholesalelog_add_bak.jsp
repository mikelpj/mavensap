<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<%@page import="com.uflow.entity.Partner"%>
<%@page import="com.uflow.web.core.ActionBase" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>流量批发受理</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="/jsp/common/commonResInclude.jsp"/>
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/magic.control.Dialog.css" rel="stylesheet"/>		
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/magic.js"></script>
		<script type="text/javascript">
		
		$(document).ready(function(){
			getPartnerDes();			
		});
		
		//查询产品信息
		function loadProductList(){	
		
			var url='${pageContext.request.contextPath}/admin/product_queryProduct.do';
			
			var data={
				state:'P'
			};
			
			var callback=function(result){
				if(result.msg){
					showDataList(result.productList);
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
		}
		
		function showDataList(datalist){		
			var html="<option value=0>请选择产品</option>";
			var inputHtml="";
			var productId = $("#_p_product_id");
			var proudctCooseDiv = $("#proudctCooseDiv");
			for(var i=0;i<datalist.length;i++){
			
				html+="<option value='"+datalist[i].PRODUCT_ID+"'>"+datalist[i].PRODUCT_NAME+"</option>";
				inputHtml+="<input type='hidden' id='price"+datalist[i].PRODUCT_ID+"' value='"+datalist[i].FEE+"' />"
				+"<input type='hidden' id='flow"+datalist[i].PRODUCT_ID+"' value='"+datalist[i].DATA_FLOW+"' />"
				+"<input type='hidden' id='prodname"+datalist[i].PRODUCT_ID+"' value='"+datalist[i].PRODUCT_NAME+"' />";
				
			}
				
			productId.html(html);	
			proudctCooseDiv.html(inputHtml);
			
			$("#_p_product_id").removeAttr("disabled");
		}
		
		function save_wholesalelog(){
			
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/wholesalelog/save.do';
			
			var _cust_id=$("#_cust_id").val();//合作方ID	
			var user_id = $("#_user_id").val();
			var acct_id = $("#_acct_id").val();
			var serial_number = $("#serial_number").val();
			var _p_product_id=$("#_p_product_id").val();//订购产品
			var _product_name=$("#_product_name").val();//订购产品名	
			var _fee=$("#_fee").val();//价格(单位:元)			
			var _p_data_flow=$("#_p_data_flow").val();//产品流量(单位:M);
			var _remark = $("#_remark").val();
			var _cust_name = $("#_cust_name").val();
			var phone = $("#phone").val();
			//var _residual_flow=$("#_residual_flow").val();//剩余流量(单位:M)
			//var _eparchy_code=$("#_eparchy_code").val();//地市编码
			if(_cust_id.length<1){showmsg('请输入号码认证');return;};
			if(_p_product_id.length<1){showmsg('订购产品不能为空');return;};
			if(_p_product_id == 0){showmsg('订购产品不能为空');return;};
			if(_fee.length<1){showmsg('价格(单位:元)不能为空');return;};
			if(_p_data_flow.length<1){showmsg('产品流量(单位:M)不能为空');return;};
			//if(_residual_flow.length<1){showmsg('剩余流量(单位:M)不能为空');return;};
			//if(_eparchy_code.length<1){showmsg('地市编码不能为空');return;};
			var _bugfix='';
			
			var data={
				cust_id:_cust_id,
				user_id:user_id,
				acct_id:acct_id,
				cust_name:_cust_name,
				serial_number:serial_number,
				p_product_id:_p_product_id,
				product_name:_product_name,
				fee:_fee,
				p_data_flow:_p_data_flow,
				remark:_remark,
				//residual_flow:_residual_flow,
				//eparchy_code:_eparchy_code,
				bugfix:_bugfix,
				phone: phone
			};
			var callback=function(result){
				unblockUI();
				if(result.msg){					
					magic.alert('流量添加成功!', '消息提示',{
		               		'label': '返回',
							'callback': function(){
		                     	window.location.reload();
		 					}
		             	});
					
				}else{
					//showmsg(result.respDesc);	
					showmsg("购买异常,请重新订购!");				
				}
			};
			if(confirm("是否提交")){
				ajaxQuery(url,'post','json',data,callback);
				blockUI();
			}else{
				return false;
			}
			
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
		function getProdutDes(val){
			var _fee = $("#_fee");
			var _p_data_flow = $("#_p_data_flow");
			
			var feeId = "#price"+val;
			var flowId = "#flow"+val;
			var productName = "#prodname"+val;
					
			_fee =  $(feeId).val();
			_p_data_flow = $(flowId).val();
			_product_name = $(productName).val();
			$("#_fee").val(_fee);			
			$("#_p_data_flow").val(_p_data_flow);
			$("#_residual_flow").val(_p_data_flow);
			$("#_product_name").val(_product_name);
		
		}
		//查询合作方信息
		function getPartnerDes(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/wholesalelog/getPartnerDes.do';
			
			$("#phone").val(phone);
			
			var data={
						
			};
			var callback=function(result){
				if(result.msg){				
					showPartnerDes(result.partnerDes,result.residualFlows);
					showDataList(result.productList);				
				}else{
					alert(result.reson);
					window.location.reload();
					//showmsg(result.respDesc);				
				}
			};		
			ajaxQuery(url,'post','json',data,callback);			
		}
		function showPartnerDes(partnerDes,residualFlows){
			
			var cust_name = $("#_cust_name");
			var link_phone = $("#_link_phone");
			var post_person = $("#_post_person");
			var cust_id = $("#_cust_id");
			var user_id = $("#_user_id");
			var acct_id = $("#_acct_id");
			var residual_flows = $("#_residual_flows");
			var serial_number = $("#serial_number");
			cust_name.val(partnerDes.CUST_NAME);
			link_phone.val(partnerDes.PHONE);
			post_person.val(partnerDes.POST_PERSON);
			cust_id.val(partnerDes.CUST_ID);
			user_id.val(partnerDes.USER_ID);
			acct_id.val(partnerDes.ACCT_ID);
			serial_number.val(partnerDes.SERIAL_NUMBER);
			residual_flows.val(residualFlows);			
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/admin/wholesalelog_list.do">流量批发管理</a>&nbsp;&gt;&nbsp;流量批发受理</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>合作方认证/查询</li></ul>
								<ul class="row">
									<li class=" w100 tr">电话号码</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_phone" /></li>
									<li class="w100"><button type="submit" type="submit" class="btn btn-warning btn-sm btn-block" onclick="getPartnerDes();">查询</button></li>
								</ul>
								<ul class="title"><li>合作方基本信息</li></ul>
								<ul class="row">
									<li class=" w100 tr">企业名称</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_cust_name"  disabled="disabled"/></li>
									<li class=" w100 tr">联系电话</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_link_phone"  disabled="disabled"/></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">联系人</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_post_person"  disabled="disabled"/></li>
									<li class=" w100 tr">剩余流量</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_residual_flows"  disabled="disabled"/></li>
								</ul>
								<ul class="title"><li>流量购买</li></ul>
								<ul class="row">
									<!-- <li class=" w100 tr">合作方ID:</li>-->
									<input type="hidden" class="form-control input-sm" id="_cust_id" disabled="disabled"/>
									
									<!-- </li>-->

									<li class=" w100 tr">订购产品</li>
									<li class="w200"><select class="form-control input-sm" id="_p_product_id" onchange="getProdutDes(this.value)" disabled="disabled";></select></li>
									<li class=" w100 tr">价格(单位:元)</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_fee" disabled="disabled"/></li>
								</ul>
								<ul class="row">
									

									<li class=" w100 tr">产品流量</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_p_data_flow" disabled="disabled"/></li>
									<li class=" w100 tr">订单备注</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_remark"/></li>
								</ul>
								<!--   
								<ul class="row">
									<li class=" w100 tr">剩余流量(单位:M):</li>
									
									<li class="w200">--> 
									
									<input type="hidden" class="form-control input-sm" id="_residual_flow" disabled="disabled"/>
								<!--  </li>
									<li class=" w100 tr">地市编码:</li>
									
									<li class="w200">-->	
									<input type="hidden" class="form-control input-sm" id="_eparchy_code"/>
								<!-- </li></ul> -->
									<input type="hidden" class="form-control input-sm" id="_product_name"/>
									<input type="hidden" class="form-control input-sm" id="_user_id"/>
									<input type="hidden" class="form-control input-sm" id="_acct_id"/>
									<input type="hidden" class="form-control input-sm" id="serial_number"/>
									<input type="hidden" class="form-control input-sm" id="phone"/>
									
								<ul class="last row">
									<li class="w100"><button onclick="save_wholesalelog();" type="submit" class="btn btn-warning btn-sm btn-block">提交</button></li>
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div id="proudctCooseDiv"></div>
								<div style="clear:both;"></div>
							</div>
						</div>
            	</div>
         	
         </div>
		<!-- 页脚部分-->
		<div id="footer">
			2014© China Unicom 中国联通.版权所有 
		</div>
		<!-- 页脚部分结束-->
	</body>
</html>
