<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<%@page import="com.uflow.entity.Partner"%>
<%@page import="com.uflow.web.core.ActionBase" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>发票打印</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="/jsp/common/commonResInclude.jsp"/>
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/magic.control.Dialog.css" rel="stylesheet"/>		
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/magic.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer/layer.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		
		$(document).ready(function(){
			
			showPager();	
		});
		
		//根据条件查询
		function query(cond){	
			if(cond == '1'){
				$("#pageNumber").val("1");
			}	
			var url='${pageContext.request.contextPath}/admin/wholesalelog_query.do';
			//var _city_code=$("#city_code").val();//归属地市
			//var _cust_id=$("#cust_id").val();//合作方ID
			var _startDate=$("#startDate").val();//开始时间
			var _endDate=$("#endDate").val();//结束时间
			var _p_product_id=$("#_p_product_id").val();
			var pageNumber=$("#pageNumber").val();
			var cust_name = $("#cust_name").val();
			var phone = $("#_phone").val();
			var printTag = $("#printTag").val();
			
			if(_startDate.length!=0){
				if(!isDate(_startDate)){alert('时间格式不正确,请选择正确的开始时间');return;};
			}
			if(_endDate.length!=0){
				if(!isDate(_endDate)){alert('时间格式不正确,请选择正确的结束时间');return;};	
			}
			if(phone.length!=0){
				if(!isMobile(phone)){alert('请输入正确的联通手机号码');return;};
			}
			
			
			$("#_cust_name").val("");
			$("#_update_staff").val("");
			$("#_printFee").val("");
			
			var data={
				//cust_id:_cust_id,
				//city_code:_city_code,
				product_id:_p_product_id,
				startDate:_startDate,
				endDate:_endDate,
				phone:phone,
				cust_name:cust_name,
				printTag:printTag,
				page:pageNumber
				
			};
			
			var callback=function(result){
				unblockUI();
				if(result.msg){					
					if(result.pager){
						$("#pageNumber").val(result.pager.pageIndex);
						$("#pageCount").val(result.pager.pageCount);
						showPager();
					}
					
					showDataList(result.dataList);		
               		
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
			blockUI();
		}
		
		//查询列表
		function showDataList(datalist){
		
			var html='';
			var radioHtml='';
			var isPrint='';
			var datalistdiv = $("#datalist");
			for(var i=0;i<datalist.length;i++){
			
				if(datalist[i].IS_PRINTED == 1){
					radioHtml ="<li class='w20'></li><li class='w70'><input type='radio' name='radiocheck' disabled='disabled' value='"+i+"' onclick='radioSelect()'/></li>";
					isPrint = "<li class='w120'>已打</li>";
				}else{
					radioHtml ="<li class='w20'></li><li class='w70'><input type='radio' name='radiocheck' value='"+i+"' onclick='radioSelect()'/></li>";
					isPrint = "<li class='w120'>未打</li>";
				}				
				html+="<ul class='row'>"
					   +radioHtml
					   +"<li class='w100' id='radioCustName"+i+"'>"+datalist[i].CUST_NAME+"</li>"
					   +"<li class='w150' id='radioProductName"+i+"'>"+datalist[i].PRODUCT_NAME+"</li>"					   
					   +"<li class='w100' id='radioDataFlow"+i+"'>"+datalist[i].p_DATA_FLOW+"</li>"
					   +"<li class='w100' id='radioFee"+i+"'>"+datalist[i].FEE+"</li>"
					   +"<li class='w150'>"+datalist[i].RSRV_VALUE1+"</li>"
					   +isPrint
					   +"<input type='hidden' id='serialNumber"+i+"' value='"+datalist[i].SERIAL_NUMBER+"'>"+"</input>"
					   +"<input type='hidden' id='updateStaff"+i+"' value='"+datalist[i].UPDATE_STAFF+"'>"+"</input>"
					   +"<input type='hidden' id='radioBatchId"+i+"' value='"+datalist[i].BATCH_ID+"'>"+"</input>"
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
		 	  
		 	  $("#_cust_name").val($("#radioCustName"+val).html());
		 	  $("#_fee").val($("#radioFee"+val).html());
		 	  $("#radioBatchId").val($("#radioBatchId"+val).val());	 	  
		 	  $("#_update_staff").val($("#updateStaff"+val).val());
		 	  $("#serialNumber").val($("#serialNumber"+val).val());
		 	  $("#_printFee").val($("#radioFee"+val).html());
		 	  
		 	  //alert($("#radioProductName"+val).html());
		 	  //alert($("#radioFee"+val).html());
		}
		function showPrintWindow(){
					 
			 var custName = $("#_cust_name").val();
			 var fee = $("#_fee").val();
			 var radioBatchId = $("#radioBatchId").val();
			 var updateStaff = $("#_update_staff").val();			 
			 var serialNumber = $("#serialNumber").val();
			 
			 if(radioBatchId == ''){
			 	alert("请选择一条记录");
			 	return false;
			 }
			 var param="?custName="+custName+"&fee="+fee+"&radioBatchId="+radioBatchId+"&updateStaff="+updateStaff+"&serialNumber="+serialNumber;
			 var url="${pageContext.request.contextPath}/admin/wholesalelog_printWindow.do"+param;
	
			 url=encodeURI(encodeURI(url)); 
			 self.location.href = url;
			 //window.open(url,'newwindow','dependent=yes,status=no,toolbar=no,location=no,scrollbars=0,statusbar=0,menubar=0,resizable=1,width=900,height=300,top=100,left=200,resizable=no');		
			 //$("#fupdateStaff").val(updateStaff);
			// $("#fcustName").val(custName);
			 //$("#submitform").attr("action", url);
			// $("#submitform").submit();
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
	

		//分页查询
		function showPager(){
			var pageNumber = $("#pageNumber").val();
			var pageCount = $("#pageCount").val();
			$("#pager").pager({
					pagenumber : pageNumber,
					pagecount : pageCount,
					buttonClickCallback : function(pnumber) {
					$("#pageNumber").val(pnumber);
					query();
				}
			});
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/admin/wholesalelog_print.do">发票打印</a>&nbsp;&gt;&nbsp;发票打印</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>查找条件</li></ul>
								<ul class="row">
									<li class=" w100 tr">电话号码</li>
									<li class="w120"><input type="text" class="form-control input-sm" id="_phone"/></li>
									<li class=" w100 tr">开始时间</li>
									<li class="w120"><input type="text" id="startDate" class="form-control input-sm"/></li>
									<li class=" w100 tr">结束时间</li>
									<li class="w120" ><input type="text" id="endDate" class="form-control input-sm"/></li>
									<li class=" w100 tr">打印状态</li>
									<li class="w120" ><select id="printTag" class="form-control input-sm"><option value="">请选择</option></option><option value="0">未打</option><option value="1">已打</option></select></li>									
									<li class="w100 tr"><button onclick="query('1');" type="submit" class="btn btn-warning btn-sm btn-block">查询</button></li>									
								</ul>
								<ul class="title"><li>发票打印</li></ul>
								<ul class="row">
									<li class=" w100 tr">客户名称</li>									
									<li class="w120"><input type="text" class="form-control input-sm" id="_cust_name" value=""/></li>
									<li class=" w100 tr">受理工号</li>									
									<li class="w120"><input type="text" class="form-control input-sm" id="_update_staff" value="" disabled="disabled"/></li>
									<li class=" w100 tr">打印金额</li>									
									<li class="w120"><input type="text" class="form-control input-sm" id="_printFee" value="" disabled="disabled"/></li>
									<!-- 
									<li class=" w100 tr">联系电话</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_link_phone" value="" disabled="disabled"/></li>
									-->
								</ul>
								<!-- 
								<ul class="row">
									<li class=" w100 tr">联系人</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_post_person" value="" disabled="disabled"/></li>
									<li class=" w100 tr">剩余流量</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_residual_flows" value="" disabled="disabled"/></li>
								</ul>
								-->
								<ul class="title"><li>批发记录</li></ul>							
								<ul class="row">
									<li class="w20"></li>
									<li class="w70">请选择</li>
									<li class="w100">客户名称</li>
									<li class="w150">订购产品</li>
									<li class="w100">产品流量</li>
									<li class="w100">交费金额</li>									
									<li class="w150">订购时间</li>
									<li class="w120">打印状态</li>
									<!--  <li>操作</li> -->
								</ul>
								<!--loop start-->
								<div id="datalist">
								
								</div>
								<!--loop end-->
								<div id="pager">
								</div>
																														
								<ul class="last row">
									<li class="w100"><button onclick="showPrintWindow();" type="submit" class="btn btn-warning btn-sm btn-block">打印</button></li>
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								
								<div style="clear:both;">
									<input type="hidden" id="pageNumber" value="${pager.pageIndex}"/>
									<input type="hidden" id="pageCount" value="${pager.pageCount}"/>
								</div>
								<div id="proudctCooseDiv"></div>
								<div style="clear:both;"></div>
							</div>
						</div>
            	</div>
         	<!-- 
         	<div class="con_side">
         		 根据用户权限生成TODO 
         		<div class="box">
					${leftmenu}
            	</div>
            	 根据用户权限生成OVER
         	</div>
         	 -->
         </div>
		<!-- 页脚部分-->
		<div id="footer">
			2014© China Unicom 中国联通.版权所有 
		</div>
		<!-- 页脚部分结束-->
		<form method="post" id="submitform" >
			<input type="hidden" class="form-control input-sm" id="_fee" name="fee"/>
			<input type="hidden" class="form-control input-sm" id="radioBatchId" name="radioBatchId"/>	
			<!-- <input type="hidden" class="form-control input-sm" id="serialNumber" name="serialNumber"/> -->
			<!-- <input type="hidden" class="form-control input-sm" id="fcustName" name="custName"/>-->
			<!-- <input type="hidden" class="form-control input-sm" id="fupdateStaff" name="updateStaff"/>	-->	
		</form>
	</body>
</html>
