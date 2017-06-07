<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>列表</title>
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
			
		});
		function query_jobconfig(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/jobconfig/query.do';
			var page=$("#pageNumber").val();
			var startDate=$("#startDate").val();
			var endDate=$("#endDate").val();
			
			var data={
				startDate:startDate,
				endDate:endDate,
				page:page
			};
			var callback=function(result){
				if(result.msg){
					if(result.pager){
						$("#pageNumber").val(result.pager.pageIndex);
						$("#pageCount").val(100);
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
				html+='<ul class="row"><li class="w100">';
					html+='<li class="w100">'+datalist[i].PSPT_ID+'</li>';
					html+='<li class="w100">'+datalist[i].PSPT_ID+'</li>';
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
					query_jobconfig();
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
         	<div class="con_main">
         		<div class="con_main_wrap" style="height:800px;">
         			<div class="box">
						<div class="heading">
    						<h1>列表</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>查询结果:</li></ul>
								<ul class="row">
									<li class="w20">&nbsp;</li>
									<li class="w100">定时任务名</li>
									<li class="w150">最近成功时间</li>
									<li class="w100">成功次数</li>
									<li class="w150">上次失败时间</li>
									<li class="w100">失败次数</li>
									<li>操作</li>
								</ul>
								<!--loop start-->
								<c:if test="${not empty datalist}">
								<c:forEach var="d" items="${datalist}">
								<ul class="row">
									<li class="w20"></li>
									<li class="w100">${d.JOB_NAME}</li>
									<li class="w150">${d.JOB_LASTSUCCTIME}</li>
									<li class="w100">${d.JOB_SUCC}次</li>
									<li class="w150">${d.JOB_LASTFAILTIME}</li>
									<li class="w100">${d.JOB_FAIL}次</li>
									<li>
										<a class="btn btn-default btn-xs" href="${pageContext.request.contextPath}/admin/jobconfig_edit.do?job_id=${d.JOB_ID}">查看</a>
									</li>
								</ul>
								</c:forEach>
								</c:if>
								<div id="pager">
								</div>
								<c:if test="${empty datalist}">
								<ul class="row"><li style="text-align:center;">未查询到数据<li></ul>
								</c:if>
								<!--loop end-->
								<ul class="last row">
									<li class="w100"><button onclick="apply_partner();" type="submit" class="btn btn-warning btn-sm btn-block">批量操作1</button></li>
									<li class="w100"><button onclick="apply_partner();" type="submit" class="btn btn-warning btn-sm btn-block">批量操作2</button></li>
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
         	</div>
         	<div class="con_side">
         		<!-- 根据用户权限生成TODO -->
         		<div class="box">
					${leftmenu}
            	</div>
            	<!-- 根据用户权限生成OVER -->
         	</div>
         </div>
		<!-- 页脚部分-->
		<div id="footer">
			2014&copy; China Unicom
		</div>
		<!-- 页脚部分结束-->
	</body>
</html>
