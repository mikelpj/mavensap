<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>流量赠送查询</title>
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
		<script type="text/javascript">
		$(document).ready(function(){
			if($("#state").val()=="2"){
				$("#state").attr('checked','checked');
			}
			$('#s_update_time').datetimepicker({
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
			$('#e_update_time').datetimepicker({
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
			$('#start_date').datetimepicker({
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
			showPager();
		});
		//分页 
		function showPager(){
			var pageNumber = $("#pageNumber").val();
			var pageCount = $("#pageCount").val();
			$("#pager").pager({
					pagenumber : pageNumber,
					pagecount : pageCount,
					buttonClickCallback : function(pnumber) {
					$("#pageNumber").val(pnumber);
					query_log();
				}
			});
		}
		function query_log(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/givinglog/query.do';
			if($("#state").attr('checked')){
				$("#state").val('2');
				
			}else{
				$("#state").val('3');
				
			}
			var _state=$("#state").val();
			var _cust_name=$("#cust_name").val();//用户ID
			var _serial_number=$("#serial_number").val();//受赠号码
			var _eparchy_code=$("#eparchy_code").val();//合作方ID
			var s_update_time=$("#s_update_time").val();//开始时间
			var e_update_time=$("#e_update_time").val();//开始时间
			var _start_date=$("#start_date").val();//开始时间
			$("#_cust_name").val(_cust_name);
			$("#_serial_number").val(_serial_number);
			$("#_eparchy_code").val(_eparchy_code);
			$("#_start_date").val(_start_date);
			$("#_s_update_time").val(s_update_time);
			$("#_e_update_time").val(e_update_time);
			$("#_state").val(_state);
			
			document.queryform.submit();
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/givinglog/list.do">流量赠送</a>&nbsp;&gt;&nbsp;流量赠送查询</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
							<form name="queryform" method="post" action="${pageContext.request.contextPath}/givinglog/query.do">
								<input type="hidden" name="cust_name" id="_cust_name"/>
								<input type="hidden" name="serial_number" id="_serial_number"/>
								<input type="hidden" name="eparchy_code" id="_eparchy_code"/>
								<input type="hidden" name="start_date" id="_start_date"/>
								<input type="hidden" name="s_update_time" id="_s_update_time"/>
								<input type="hidden" name="e_update_time" id="_e_update_time"/>
								<input type="hidden" name="state" id="_state"/>
								<input type="hidden" id="pageNumber" name="page" value="${pager.pageIndex}"/>
								<input type="hidden" id="pageCount" value="${pager.pageCount}"/>
								<ul class="title"><li>查询条件</li></ul>
								<ul class="row">
									<li class="w100 tr">号码归属地市</li>
									<li class="w200">
									<select class="form-control input-sm" id="eparchy_code">
									<option value="">--请选择--</option>
									<option value="0371">郑州</option>
									<option value="0379">洛阳</option>
									<option value="0378">开封</option>
									<option value="0391">焦作</option>
									<option value="0377">南阳</option>
									<option value="0376">信阳</option>
									<option value="0370">商丘</option>
									<option value="0399">济源</option>
									<option value="0373">新乡</option>
									<option value="0374">许昌</option>
									<option value="0392">鹤壁</option>
									<option value="0393">濮阳</option>
									<option value="0396">驻马店</option>
									<option value="0398">三门峡</option>
									<option value="0395">漯河</option>
									<option value="0375">平顶山</option>
									<option value="0372">安阳</option>
									<option value="0394">周口</option>
									</select></li>
									<li class=" w100 tr">手机号码</li>
									<li class="w200"><input type="text" id="serial_number" class="form-control input-sm" value="${serial_number}"/></li>
									<li class="w200 tl"><input type="checkbox" id="state" value="${state}" />失败记录</li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">赠送日期段</li>
									<li class="w200"><input type="text" id="s_update_time" class="form-control input-sm" value="${s_update_time}"/></li>
									<li class=" w100 tr">到</li>
									<li class="w200"><input type="text" id="e_update_time" class="form-control input-sm" value="${e_update_time}"/></li>
									<!-- <li class="w100 tr">生效月份</li>
									<li class="w200"><input type="text"   id="start_date" value="${start_date}" class="form-control input-sm"/></li> -->
									<li class="w100 tl"><button onclick="query_log();" type="submit" class="btn btn-warning btn-sm btn-block">查询</button></li>
								</ul>
								
								<ul class="title"><li>查询结果</li></ul>
								<ul class="row" >
									<li class="w20">&nbsp;</li>
									<li class="w110">受赠号码</li>
									<li class="w110">归属地市</li>
									<li class="w170">赠送时间</li>
									<li class="w110">赠送流量(M)</li>
									<li class="w110">开始时间</li>
									<li class="w110">结束时间</li>
									<li class="w110">赠送状态</li>
									<li class="w170">赠送备注</li>
								</ul>
								<!--loop start-->
								<c:if test="${not empty datalist}">
								<div id="datalist">
								<c:forEach var="d" items="${datalist}">
								<ul class="row">
									<!--   <li class="w20"><input type="checkbox" value="1"/></li>-->
									<li class="w20">&nbsp;</li>
									<li class="w110">${d.SERIAL_NUMBER}</li>
									<li class="w110"><c:if test="${d.EPARCHY_CODE=='0371'}">郑州</c:if>
									<c:if test="${d.EPARCHY_CODE=='0379'}">洛阳</c:if>
									<c:if test="${d.EPARCHY_CODE=='0378'}">开封</c:if>
									<c:if test="${d.EPARCHY_CODE=='0373'}">新乡</c:if>
									<c:if test="${d.EPARCHY_CODE=='0391'}">焦作</c:if>
									<c:if test="${d.EPARCHY_CODE=='0377'}">南阳</c:if>
									<c:if test="${d.EPARCHY_CODE=='0376'}">信阳</c:if>
									<c:if test="${d.EPARCHY_CODE=='0370'}">商丘</c:if>
									<c:if test="${d.EPARCHY_CODE=='0399'}">济源</c:if>
									<c:if test="${d.EPARCHY_CODE=='0374'}">许昌</c:if>
									<c:if test="${d.EPARCHY_CODE=='0392'}">鹤壁</c:if>
									<c:if test="${d.EPARCHY_CODE=='0393'}">濮阳</c:if>
									<c:if test="${d.EPARCHY_CODE=='0396'}">驻马店</c:if>
									<c:if test="${d.EPARCHY_CODE=='0398'}">三门峡</c:if>
									<c:if test="${d.EPARCHY_CODE=='0395'}">漯河</c:if>
									<c:if test="${d.EPARCHY_CODE=='0375'}">平顶山</c:if>
									<c:if test="${d.EPARCHY_CODE=='0372'}">安阳</c:if>
									<c:if test="${d.EPARCHY_CODE=='0394'}">周口</c:if>
									</li>
									<li class="w170"><c:if test="${not empty d.UPDATE_TIME}">
									<fmt:formatDate type="both" value="${d.UPDATE_TIME}" />
									</c:if>
									</li>
									<li class="w110">${d.UDATA_FLOW}</li>
									<li class="w110"><c:if test="${not empty d.START_TIME}">
									<fmt:formatDate value="${d.START_TIME}" pattern="yyyy-MM-dd"/>
									</c:if></li>
									<li class="w110"><c:if test="${not empty d.END_TIME}">
									<fmt:formatDate value="${d.END_TIME}" pattern="yyyy-MM-dd"/>
									</c:if></li>
									
									<li class="w110"><c:if test="${d.STATE=='0'}">处理中</c:if>
									<c:if test="${d.STATE=='1'}">处理中</c:if>
									<c:if test="${d.STATE=='9'}">赠送成功</c:if>
									<c:if test="${d.STATE=='2'}">赠送失败</c:if>
									<c:if test="${d.STATE=='4'}">处理中</c:if>
									</li>
									<li class="w170">${d.FAIL_REASON}</li>
								</ul>
								</c:forEach>
								</div>
								</c:if>
								<c:if test="${empty datalist}">
								<ul class="row"><li style="text-align:center;">未查询到数据<li></ul>
								</c:if>
								<!--loop end-->
								<div id="pager"></div>
								<div style="clear:both;">
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
