<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>产品参数列表</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.pager.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css"/>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
	    <script src="${pageContext.request.contextPath}/js/accounting.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			showPager();
		});
		function query_product(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/product_query.do';
			var _product_name=$("#_product_name").val();//产品名称
			var _use_object=$("#_use_object").val();//产品类型
			var _valid_tag=$("#_valid_tag").val();
			var page=$("#pageNumber").val();
			var data={
				product_name:_product_name,
				use_object:_use_object,
				valid_tag:_valid_tag,
				page:page
			};
			var callback=function(result){
				if(result.msg){
					if(result.pager){
						$("#pageNumber").val(result.pager.pageIndex);
						$("#pageCount").val(result.pager.pageCount);
						showPager();
					}
					if(result.data){
						showDataList(result.data);
					}
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
		}
		function showDataList(datalist){
			var html='';
			for(var i=0;i<datalist.length;i++){
				html+='<ul class="row"><li class="w20"></li>';
					html+='<li class="w200"><input type="text" readonly="readonly" class="form-control input-sm" value="'+datalist[i].PRODUCT_NAME+'"/></li>';
					html+='<li class="w100">'+(datalist[i].USE_OBJECT=='P'?'批发':'赠送')+'</li>';
					html+='<li class="w100 tr">'+accounting.formatNumber(parseFloat(parseFloat(datalist[i].FEE).toFixed(2)/100.00),2,'')+'</li>';
					html+='<li class="w100 tr">'+accounting.formatNumber(datalist[i].DATA_FLOW)+'</li>';
					html+='<li class="w100 tc">'+datalist[i].UNIT_PRICE+'</li>';
					html+='<li class="w100">'+(datalist[i].VALID_TAG=='0'?'未生效':'生效')+'</li>';
					html+='<li><a class="btn btn-default btn-xs" href="${pageContext.request.contextPath}/admin/product_edit.do?id='+datalist[i].PRODUCT_ID+'">查看</a></li>';
				html+='</ul>';
			}
			$("#datalist").html(html);
		}
		function showPager(){
			var pageNumber = $("#pageNumber").val();
			var pageCount = $("#pageCount").val();
			$("#pager").pager({
					pagenumber : pageNumber,
					pagecount : pageCount,
					buttonClickCallback : function(pnumber) {
					$("#pageNumber").val(pnumber);
					query_product();
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/admin/product_list.do">流量产品管理</a>&nbsp;&gt;&nbsp;流量产品列表</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>查询产品参数</li></ul>
								<ul class="row">
									<li class="w100 tr">产品名称</li>
									<li class="w150"><input type="text" id="_product_name" class="form-control input-sm"/></li>
									<li class=" w80 tr">产品类型</li>
									<li class="w150"><select class="form-control input-sm" id="_use_object"><option value="" selected="selected">所有类型</option><option value="U">赠送</option>
										<option value="P">批发</option></select></li>
									<li class=" w80 tr">生效状态</li>
									<li class="w150"><select class="form-control input-sm" id="_valid_tag"><option value="" selected="selected">所有状态</option><option value="1">生效</option>
										<option value="0">未生效</option></select></li>
									<li class=" w100 tr"><button onclick="query_product();" type="button" class="btn btn-warning btn-sm btn-block">查询产品</button></li>
								</ul>
								<ul class="title"><li>查询结果</li></ul>
								<ul class="row">
									<li class="w20">&nbsp;</li>
									<li class="w200">产品名称</li>
									<li class="w100">产品类型</li>
									<li class="w100 tr">价格(元)</li>
									<li class="w100 tr">流量(M)</li>
									<li class="w100 tc">单价(分/M)</li>
									<li class="w100">生效状态</li>
									<li>操作</li>
								</ul>
								<div id="datalist">
								<!--loop start-->
								<c:if test="${not empty datalist}">
								<c:forEach var="d" items="${datalist}">
								<ul class="row">
									<li class="w20"></li>
									<li class="w200"><input type="text" readonly="readonly" class="form-control input-sm" value="${d.PRODUCT_NAME}"/></li>
									<li class="w100"><c:if test="${d.USE_OBJECT=='P'}">批发</c:if><c:if test="${d.USE_OBJECT=='U'}">赠送</c:if></li>
									<li class="w100 tr"><fmt:formatNumber value="${d.FEE/100}" type="number" pattern="#,##0.00"></fmt:formatNumber></li>
									<li class="w100 tr"><fmt:formatNumber value="${d.DATA_FLOW}" type="number"></fmt:formatNumber></li>
									<li class="w100 tc">${d.UNIT_PRICE}</li>
									<li class="w100"><c:if test="${d.VALID_TAG=='0'}">未生效</c:if><c:if test="${d.VALID_TAG=='1'}">生效</c:if></li>
									<li>
										<a class="btn btn-default btn-xs" href="${pageContext.request.contextPath}/admin/product_edit.do?id=${d.PRODUCT_ID}">查看</a>
									</li>
								</ul>
								</c:forEach>
								</c:if>
								</div>
								<div id="pager">
								</div>
								<c:if test="${empty datalist}">
								<ul class="row"><li style="text-align:center;">未查询到数据<li></ul>
								</c:if>
								<!--loop end-->
								<ul class="last row">
									<li class="w20"></li>
								</ul>
								<div style="clear:both;">
									<input type="hidden" id="pageNumber" value="${pager.pageIndex}"/>
									<input type="hidden" id="pageCount" value="${pager.pageCount}"/>
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
