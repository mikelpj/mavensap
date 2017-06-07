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
		<script src="${pageContext.request.contextPath}/js/accounting.js"></script>	
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

		<script type="text/javascript">
		$(document).ready(function(){
		 showPager();
		});
		function showmsg(){
			$("#show_error").show();
			$("#show_error_text").html(s);
		}
		//根据条件查询
		function query(cond){
		
			$("#show_error").hide();
			
			if(cond == '1'){
				$("#pageNumber").val("1");
			}	

			var url='${pageContext.request.contextPath}/wholesalelog/qryRecvfee.do';

			var _startDate=$("#startDate").val();//开始时间
			var _endDate=$("#endDate").val();//结束时间
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
					showmsg(result.respDesc);
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
					   +"<li class='w250'>"+datalist[i].payName+"</li>"					   
					   +"<li class='w200'>"+accounting.formatNumber(parseFloat(parseFloat(datalist[i].recvFee).toFixed(2)/100.00),2,'')+"元</li>"					   
					   +"<li class='w300'>"+datalist[i].outerTradeId+"</li>"
					  // +"<li class='w120'>"+datalist[i].actionName+"</li>"
					   +"<li class='w200'>"+datalist[i].recvTime+"</li>"
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/wholesalelog/list.do">我的订单</a>&nbsp;&gt;&nbsp;充值记录查询</h1>
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
									<li class="w100 tr"><button onclick="query('1');" type="submit" class="btn btn-warning btn-sm btn-block">查询</button></li>
								</ul>
								<ul class="title"><li>查询结果</li></ul>
								<ul class="row">
									<li class="w30"></li>
									<li class="w250">客户名称</li>									
									<li class="w200">充值金额</li>
									<li class="w300">交易流水号</li>									
									<!-- <li class="w120">剩余流量</li> -->
									<li class="w200">充值时间</li>
									<!--  <li>操作</li> -->
								</ul>
								<!--loop start-->
								<div id="datalist">
									
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
