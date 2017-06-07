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
		<script src="${pageContext.request.contextPath}/js/accounting.js"></script>
		<script type="text/javascript">
		
		$(document).ready(function(){
			var availableBalanceInput = $("#availableBalanceInput").val();
			$("#availableBalance").val(accounting.formatNumber(parseFloat(parseFloat(availableBalanceInput).toFixed(2)/100.00),2,''));
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
		
		
		//查询列表
		function showProdList(datalist){
		
			var html='';
			var radioHtml='';
			var isPrint='';
			var datalistdiv = $("#datalist");
			for(var i=0;i<datalist.length;i++){
			
				radioHtml ="<li class='w20'></li><li class='w70'><input type='radio' name='radiocheck' value='"+i+"' onclick='radioSelect()'/></li>";
				html+="<ul class='row'>"
					   +radioHtml
					   +"<li class='w250'>"+datalist[i].PRODUCT_NAME+"</li>"
					   +"<li class='w150 tr'>"+accounting.formatNumber(parseFloat(parseFloat(datalist[i].FEE).toFixed(2)/100.00),2,'')+"元</li>"					   
					   +"<li class='w150 tr'>"+accounting.formatNumber(parseFloat(parseFloat(datalist[i].UNIT_PRICE).toFixed(2)/100.00),2,'')+"元/M</li>"					   				   
					   +"<li class='w150 tr'>"+accounting.formatNumber(datalist[i].DATA_FLOW)+"M</li>"
					   +"<input type='hidden' id='proudctId"+i+"' value='"+datalist[i].PRODUCT_ID+"'>"+"</input>"
					   +"<input type='hidden' id='fee"+i+"' value='"+datalist[i].FEE+"'>"+"</input>"
					   +"<input type='hidden' id='dataFlow"+i+"' value='"+datalist[i].DATA_FLOW+"'>"+"</input>"
					   +"<input type='hidden' id='productName"+i+"' value='"+datalist[i].PRODUCT_NAME+"'>"+"</input>"
					   +"</ul>";
			}
			if(datalist.length<=0){
				html+="<ul class='row'><li style='text-align:center;'>未查询到数据<li></ul>"  ;
			}
			
			datalistdiv.html(html);
		
		}
		
		//取radio那一列的值
		function radioSelect(){
		 	  var val=$('input:radio[name="radiocheck"]:checked').val();
		 	  
		 	  $("#_p_product_id").val($("#proudctId"+val).val());
		 	  $("#_product_name").val($("#productName"+val).val());
		 	  $("#_fee").val($("#fee"+val).val());	 	  
		 	  $("#_p_data_flow").val($("#dataFlow"+val).val());
		}
		
		function save_wholesalelog(){
			
			$("#show_error").hide();
			
			var url='${pageContext.request.contextPath}/wholesalelog/save.do';
			
			var _cust_id=$("#_cust_id").val();//合作方ID	
			var user_id = $("#_user_id").val();
			var acct_id = $("#_acct_id").val();
			var serial_number = $("#serial_number").val();
			var _cust_name = $("#_cust_name").val();
			var _remark = $("#_remark").val();			
			var phone = $("#_phone").val();
				
			var _p_product_id=$("#_p_product_id").val();//订购产品
			var _product_name=$("#_product_name").val();//订购产品名	
			var _fee=$("#_fee").val();//价格(单位:元)			
			var _p_data_flow=$("#_p_data_flow").val();//产品流量(单位:M);
			var availableBalance = $("#availableBalanceInput").val();
			
		
			
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
				availableBalance:availableBalance,
				p_data_flow:_p_data_flow,
				remark:_remark,
				bugfix:_bugfix,
				phone: phone
			};
			var callback=function(result){
				unblockUI();
				if(result.msg){					
					magic.alert('流量包购买成功!', '消息提示',{
		               		'label': '返回',
							'callback': function(){
		                     	window.location.reload();
		 					}
		             	});
					
				}else{
					if(result.respDesc == '0'){
						alert("购买异常,请重新订购!");
					}
					else if(result.respDesc == '1'){
						alert("订购产品价格大于可用余额,请重新订购!");
					}else{
						alert(result.respDesc);	
					}									
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
					alert(error);
				}
			});
		}
		function showmsg(s){
			$("#show_error").show();
			$("#show_error_text").html(s);
		}
		
		//查询合作方信息
		function getPartnerDes(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/wholesalelog/getPartnerDes.do';

			var data={
						
			};
			var callback=function(result){
				if(result.msg){				
					showPartnerDes(result.partnerDes,result.residualFlows);
					//showDataList(result.productList);
					showProdList(result.productList);			
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/wholesalelog/list.do">我的订单</a>&nbsp;&gt;&nbsp;购买流量包</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								
								<ul class="title"><li>用户信息</li></ul>
								<ul class="row">
									<li class=" w100 tr">电话号码</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_phone" value="${phone}" disabled="disabled"/></li>
									<li class="w100 tr" >可用余额:</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="availableBalance" disabled="disabled"/></li>	
											
								</ul>
								<ul class="row">
									<li class=" w100 tr">用户名称</li>
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
									<ul class="title"><li>可选产品明细</li></ul>							
									<ul class="row">
										<li class="w20"></li>
										<li class="w70">请选择</li>
										<li class="w250">产品名称</li>
										<li class="w150 tr">产品价格</li>
										<li class="w150 tr">产品单价</li>
										<li class="w150 tr">产品流量</li>
									</ul>
									<div id="datalist">
								
									</div>
									
									<input type="hidden" class="form-control input-sm" id="_residual_flow" disabled="disabled"/>
								<!--  </li>
									<li class=" w100 tr">地市编码:</li>
									
									<li class="w200">-->	
									<input type="hidden" class="form-control input-sm" id="_eparchy_code"/>
								<!-- </li></ul> -->
									<input type="hidden" class="form-control input-sm" id="_user_id"/>
									<input type="hidden" class="form-control input-sm" id="_acct_id"/>
									<input type="hidden" class="form-control input-sm" id="serial_number"/>
									<input type="hidden" class="form-control input-sm" id="_cust_id" disabled="disabled"/>
								<!-- radio box begin -->
									<input type="hidden" class="form-control input-sm" id="_p_product_id"/>
									<input type="hidden" class="form-control input-sm" id="_product_name"/>
									<input type="hidden" class="form-control input-sm" id="_fee"/>
									<input type="hidden" class="form-control input-sm" id="_p_data_flow"/>
									<input type="hidden" id="availableBalanceInput" value="${availableBalance}" disabled="disabled"/>					
								<!-- radio box end -->										
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
