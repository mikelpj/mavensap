<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>工号列表</title>
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
			showPager();
		});
		function query_staff(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/staff_query.do';

			var staff_id=$("#staff_id").val();
			var page=$("#pageNumber").val();
			
			var data={
				staff_id:staff_id,
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
		function add_staff(){
			window.location.href='${pageContext.request.contextPath}/admin/staff_add.do';
		}
		function showDataList(datalist){
			var html='';
			for(var i=0;i<datalist.length;i++){
				html+='<ul class="row"><li class="w20"></li>';
					html+='<li class="w200">'+datalist[i].STAFF_ID+'</li>';
					html+='<li class="w100">'+datalist[i].STAFF_NAME+'</li>';
					html+='<li class="w120">'+datalist[i].SERIAL_NUMBER+'</li>';
					html+='<li class="w100">'+(datalist[i].SEX==0?'男':'女')+'</li>';
					html+='<li class="w100">'+datalist[i].PARTNER_ID+'</li>';
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
					query_staff();
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;权限管理&nbsp;&gt;&nbsp;工号管理</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>查询工号</li></ul>
								<ul class="row">
									<li class="w20"></li>
									<li class="w100">工号名称</li>
									<li class="w200"><input type="text" id="staff_id" class="form-control input-sm"/></li>
									<li class=" w100 tr"><button onclick="query_staff();" type="submit" class="btn btn-default btn-sm btn-block">查询</button></li>
								</ul>
								<ul class="title"><li>查询结果</li></ul>
								<ul class="row">
									<li class="w20">&nbsp;</li>
									<li class="w200">工号</li>
									<li class="w100">姓名</li>
									<li class="w120">手机号码</li>
									<li class="w100">性别</li>
									<li class="w100">归属部门</li>
									<li class="w100">工号级别</li>
								</ul>
								<!--loop start-->
								<div id="datalist">
								<c:if test="${not empty datalist}">
								<c:forEach var="d" items="${datalist}">
								<ul class="row">
									<li class="w20"></li>
									<li class="w200">${d.STAFF_ID}</li>
									<li class="w100">${d.STAFF_NAME}</li>
									<li class="w120">${d.SERIAL_NUMBER}</li>
									<li class="w100"><c:if test="${d.SEX=='0'}">男</c:if><c:if test="${d.SEX=='1'}">女</c:if></li>
									<li class="w100">${d.DEPART_ID}</li>
									<li class="w100"><c:if test="${d.ROLE_ID=='3'}">省级工号</c:if><c:if test="${d.ROLE_ID=='4'}">地市(${d.RSRV_VALUE1})</c:if></li>
									<li class="w100"><a class="btn btn-default btn-xs" href="${pageContext.request.contextPath}/admin/staff_edit.do?id=${d.STAFF_ID}">编辑</a></li>
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
									<li class="w100"><button onclick="add_staff();" type="button" class="btn btn-warning btn-sm btn-block">添加后台工号</button></li>
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div style="clear:both;">
									<input type="hidden" id="pageNumber" value="${pager.pageIndex}"/>
									<input type="hidden" id="pageCount" value="${pager.pageCount}"/>
								</div>
							</div>
						</div>
            	</div>
         	<!--
         	<div class="con_side">
         		<div class="box">
					${leftmenu}
            	</div>
         	</div>
         	 -->
         </div>
		<!-- 页脚部分-->
		<div id="footer">
			2014&copy; China Unicom 中国联通.版权所有
		</div>
		<!-- 页脚部分结束-->
	</body>
</html>
