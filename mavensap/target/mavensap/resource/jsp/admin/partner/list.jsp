<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>合作方列表</title>
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
			
		});
		function query_partner(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/partner/query.do';
			var _cust_id=$("#cust_id").val();//BSS客户ID
			var _cust_id=$("#cust_id").val();//BSS客户ID
			var _acct_id=$("#acct_id").val();//主账户ID
			var _acct_id=$("#acct_id").val();//主账户ID
			var _serial_number=$("#serial_number").val();//主号码
			var _serial_number=$("#serial_number").val();//主号码
			var _user_id=$("#user_id").val();//主用户
			var _user_id=$("#user_id").val();//主用户
			var _cust_name=$("#cust_name").val();//合作方名称
			var _cust_name=$("#cust_name").val();//合作方名称
			var _pspt_type_code=$("#pspt_type_code").val();//证件类型
			var _pspt_type_code=$("#pspt_type_code").val();//证件类型
			var page=$("#pageNumber").val();
			var startDate=$("#startDate").val();
			var endDate=$("#endDate").val();
			
			var data={
				cust_id:_cust_id,
				cust_id:_cust_id,
				acct_id:_acct_id,
				acct_id:_acct_id,
				serial_number:_serial_number,
				serial_number:_serial_number,
				user_id:_user_id,
				user_id:_user_id,
				cust_name:_cust_name,
				cust_name:_cust_name,
				pspt_type_code:_pspt_type_code,
				pspt_type_code:_pspt_type_code,
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
					html+='<li class="w100">'+datalist[i].CUST_ID+'</li>';
					html+='<li class="w100">'+datalist[i].CUST_ID+'</li>';
					html+='<li class="w100">'+datalist[i].ACCT_ID+'</li>';
					html+='<li class="w100">'+datalist[i].ACCT_ID+'</li>';
					html+='<li class="w100">'+datalist[i].SERIAL_NUMBER+'</li>';
					html+='<li class="w100">'+datalist[i].SERIAL_NUMBER+'</li>';
					html+='<li class="w100">'+datalist[i].USER_ID+'</li>';
					html+='<li class="w100">'+datalist[i].USER_ID+'</li>';
					html+='<li class="w100">'+datalist[i].CUST_NAME+'</li>';
					html+='<li class="w100">'+datalist[i].CUST_NAME+'</li>';
					html+='<li class="w100">'+datalist[i].PSPT_TYPE_CODE+'</li>';
					html+='<li class="w100">'+datalist[i].PSPT_TYPE_CODE+'</li>';
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
					query_partner();
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
    						<h1>合作方列表</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>查询合作方</li></ul>
								<ul class="row">
									<li class="w100">参数一</li>
									<li class="w200"><input type="text" id="username" class="form-control input-sm"/></li>
									<li class=" w100 tr">参数一</li>
									<li class="w200"><input type="text" class="form-control input-sm"/></li>
								</ul>
								<ul class="title"><li>查询结果</li></ul>
								<ul class="row">
									<li class="w20">&nbsp;</li>
									<li class="w100">BSS客户ID</li>
									<li class="w100">BSS客户ID</li>
									<li class="w100">主账户ID</li>
									<li class="w100">主账户ID</li>
									<li class="w100">主号码</li>
									<li class="w100">主号码</li>
									<li class="w100">主用户</li>
									<li class="w100">主用户</li>
									<li class="w100">合作方名称</li>
									<li class="w100">合作方名称</li>
									<li class="w100">证件类型</li>
									<li class="w100">证件类型</li>
									<li>操作</li>
								</ul>
								<!--loop start-->
								<c:if test="${not empty datalist}">
								<c:forEach var="d" items="${datalist}">
								<ul class="row">
									<li class="w20"><input type="checkbox" value="1"/></li>
									<li class="w100">${d.CUST_ID}</li>
									<li class="w100">${d.CUST_ID}</li>
									<li class="w100">${d.ACCT_ID}</li>
									<li class="w100">${d.ACCT_ID}</li>
									<li class="w100">${d.SERIAL_NUMBER}</li>
									<li class="w100">${d.SERIAL_NUMBER}</li>
									<li class="w100">${d.USER_ID}</li>
									<li class="w100">${d.USER_ID}</li>
									<li class="w100">${d.CUST_NAME}</li>
									<li class="w100">${d.CUST_NAME}</li>
									<li class="w100">${d.PSPT_TYPE_CODE}</li>
									<li class="w100">${d.PSPT_TYPE_CODE}</li>
									<li>
										<a class="btn btn-default btn-xs" >查看</a>
										<a class="btn btn-default btn-xs" >修改</a>
										<a class="btn btn-default btn-xs" >删除</a>
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
			2014&copy; China Unicom 中国联通.版权所有
		</div>
		<!-- 页脚部分结束-->
	</body>
</html>
