<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>批发记录列表</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="/jsp/common/commonResInclude.jsp"/>
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/accounting.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){	
			
		 loadProductList();		
		 showPager();
		});
		function showmsg(){
			$("#show_error").show();
			$("#show_error_text").html(s);
		}
		//根据条件查询
		function query(cond){
			
			if(cond == '1'){
				$("#pageNumber").val("1");
			}	

			var url='${pageContext.request.contextPath}/wholesalelog/query.do';
			//var _city_code=$("#city_code").val();//归属地市
			//var _cust_id=$("#cust_id").val();//合作方ID
			var _startDate=$("#startDate").val();//开始时间
			var _endDate=$("#endDate").val();//结束时间
			var _p_product_id=$("#_p_product_id").val();
			var pageNumber=$("#pageNumber").val();
			
			if(_startDate.length!=0){
				if(!isDate(_startDate)){alert('时间格式不正确,请选择正确的开始时间');return;};
			}
			if(_endDate.length!=0){
				if(!isDate(_endDate)){alert('时间格式不正确,请选择正确的结束时间');return;};	
			}
			
			var data={
				//cust_id:_cust_id,
				//city_code:_city_code,
				product_id:_p_product_id,
				startDate:_startDate,
				endDate:_endDate,
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
			var datalistdiv = $("#datalist");
			for(var i=0;i<datalist.length;i++){
			
				html+="<ul class='row'><li class='w30'></li>"
					   +"<li class='w300'>"+datalist[i].PRODUCT_NAME+"</li>"					   
					   +"<li class='w100'>"+accounting.formatNumber(datalist[i].p_DATA_FLOW)+"M</li>"
					   +"<li class='w110'>"+accounting.formatNumber(parseFloat(parseFloat(datalist[i].FEE).toFixed(2)/100.00),2,'')+"元</li>"
					   +"<li class='w150'>"+accounting.formatNumber(parseFloat(parseFloat(datalist[i].UNIT_PRICE).toFixed(2)/100.00),2,'')+"元/M</li>"
					   +"<li class='w120'>"+accounting.formatNumber(datalist[i].RESIDUAL_FLOW)+"M</li>"
					   +"<li class='w150'>"+datalist[i].RSRV_VALUE1+"</li>"
					   +"</ul>";
			}
			if(datalist.length<=0){
				html+="<ul class='row'><li style='text-align:center;'>未查询到数据<li></ul>"  ;
			}
			
			datalistdiv.html(html);
		
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
		
		function ajaxQuery(url,type,dataType,data,callback){
			$.ajax({url : url,type : type,dataType : dataType,data : data,
				success : callback,
				failure : function(error) {
					showmsg(error);
				}
			});
		}
		//查询产品信息
		function loadProductList(){	
	
			var partnerId = $("#partnerId").val();
			var rsrvValue2 = $("#rsrvValue2").val();
			
			var url='${pageContext.request.contextPath}/product/queryProduct.do';			
			var data={
				partnerId:partnerId,
				rsrvValue2:rsrvValue2,
				state:'P'
			};			
			var callback=function(result){
				if(result.msg){
					showProductList(result.productList);
				}else{
					showmsg(result.errmsg);
				}
			};	
			ajaxQuery(url,'post','json',data,callback);	
		}
		function showProductList(datalist){
			var html="<option value=0>请选择产品</option>";
			var inputHtml="";
			var productId = $("#_p_product_id");
			
			for(var i=0;i<datalist.length;i++){			
				html+="<option value="+datalist[i].PRODUCT_ID+">"+datalist[i].PRODUCT_NAME+"</option>";				
			}					
			productId.html(html);	
		
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/wholesalelog/list.do">我的订单</a>&nbsp;&gt;&nbsp;购买记录查询</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>查询</li></ul>
								<!-- 
								<ul class="row">
									<li class="w100 tr">归属地市:</li>
									<li class="w100"><input type="text" id="city_code" class="form-control input-sm"/></li>
									<li class="w100 tr">合作方:</li>
									<li class="w100"><input type="text" id="cust_id" class="form-control input-sm"/></li>
								</ul>
								 -->
								<ul class="row">
									<li class="w100 tr">开始时间</li>
									<li class="w120"><input type="text" id="startDate" class="form-control input-sm"/></li>
									<li class="w100 tr">结束时间</li>
									<li class="w120"><input type="text" id="endDate" class="form-control input-sm"/></li>
									<li class="w100 tr">订购产品</li>
									<li class="w120"><select class="form-control input-sm" id="_p_product_id"></select></li>
									<li class="w100 tr"><button onclick="query('1');" type="submit" class="btn btn-warning btn-sm btn-block">查询</button></li>
								</ul>
								<ul class="title"><li>查询结果</li></ul>
								<ul class="row">
									<li class="w30"></li>
									<li class="w300">订购产品</li>									
									<li class="w100">产品流量</li>
									<li class="w110">价格</li>	
									<li class='w150'>产品单价</li>						
									<li class="w120">剩余流量</li>
									<li class="w150">订购时间</li>
									<!--  <li>操作</li> -->
								</ul>
								<!--loop start-->
								<div id="datalist">
								<c:if test="${not empty datalist}">
								<c:forEach items="${datalist}" var="d">
								<ul class="row">
									<!-- <li class="w20"><input type="checkbox" value="1"/></li> -->
									<li class="w30"></li>
									<li class="w300">${d.PRODUCT_NAME}</li>
									<li class="w100"><fmt:formatNumber value="${d.p_DATA_FLOW}" type="number"></fmt:formatNumber>M</li>					
									<li class="w110"><fmt:formatNumber value="${d.FEE/100}" type="number" pattern="#,##0.00"></fmt:formatNumber>元</li>									
									<li class='w150'><fmt:formatNumber value="${d.UNIT_PRICE/100}" type="number" pattern="#,##0.00"></fmt:formatNumber>元/M</li>	
									<li class="w120"><fmt:formatNumber value="${d.RESIDUAL_FLOW}" type="number"></fmt:formatNumber>M</li>
									<li class="w150">
									<fmt:formatDate value="${d.ORDER_TIME}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</li>
									
									<!--  
									<li>
										<a class="btn btn-default btn-xs" >查看</a>
										<a class="btn btn-default btn-xs" >修改</a>
										<a class="btn btn-default btn-xs" >删除</a>
									</li>
									-->
								</ul>
								</c:forEach>
								</c:if>
								<c:if test="${empty datalist}">
								<ul class="row"><li style="text-align:center;">未查询到数据<li></ul>
								</c:if>
								</div>
								
								<!--loop end-->
								<div id="pager">
								</div>
								<ul class="last row">
									<!--  <li class="w100"><button onclick="apply_partner();" type="submit" class="btn btn-warning btn-sm btn-block">批量操作1</button></li>-->
									<!-- <li class="w100"><button onclick="apply_partner();" type="submit" class="btn btn-warning btn-sm btn-block">批量操作2</button></li> -->
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div style="clear:both;">
									<input type="hidden" id="pageNumber" value="${pager.pageIndex}"/>
									<input type="hidden" id="pageCount" value="${pager.pageCount}"/>
								</div>
								
							</div>
						</div>
            	</div>        	
         </div>

		<input type="hidden" id="partnerId" value="${partnerId }"/>
		<input type="hidden" id="rsrvValue2" value="${rsrvValue2 }"/>
		<!-- 页脚部分-->
		<div id="footer">
			2014© China Unicom 中国联通.版权所有 
		</div>
		<!-- 页脚部分结束-->
	</body>
</html>
