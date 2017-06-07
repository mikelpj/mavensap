<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>河南联通-流量后向计费平台</title>
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
	    <script src="${pageContext.request.contextPath}/js/front/wholesalereport/wholesalereport_list.js"></script>
	    <!-- background:#FF9C00;color:#FFFFFF;  font-weight:bold;  color:#FF9C00;-->
	   <style type="text/css">
         ul#ls:hover{background:#CDBFB5;font-weight:bold;color:#FF9C00;filter : alpha(opacity=20);}
        </style>
	</head>
	
<body class="bodybg">
		<!-- 页头开始-->
		<jsp:include page="/jsp/common/menu_header.jsp"></jsp:include>
		<!-- 页头结束-->
         <div id="contain">
         	<div class="box">
						<div class="heading">
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/wholesalereport/list.do">统计查询</a>&nbsp;&gt;&nbsp;流量赠送汇总表</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
						    <ul class="title"><li>查询条件</li></ul>
								<ul class="row">
									<li class="w100 tr">归属地市：</li>
									<li class="w200">
									<select id="eparchy_code" class="form-control input-sm">
									   <option value="0" selected="selected">全部</option>
									   <option value="0371">郑州</option>
									   <option value="0379">洛阳</option>
									   <option value="0378">开封</option>
									   <option value="0391">焦作</option>
									   <option value="0373">新乡</option>
									   <option value="0374">许昌</option>
									   <option value="0395">漯河</option>
									   <option value="0372">安阳</option>
									   <option value="0370">商丘</option>
									   <option value="0375">平顶山</option>
									   <option value="0394">周口</option>
									   <option value="0396">驻马店</option>
									   <option value="0398">三门峡</option>
									   <option value="0393">濮阳</option>
									   <option value="0392">鹤壁</option>
									   <option value="0399">济源</option>
									   <option value="0376">信阳</option>
									   <option value="0377">南阳</option>
									</select>
									</li>
									<li class="w100 tr">订购产品：</li>
									<li class="w200"><select class="form-control input-sm" id="product_id"><option value=0>--请选择产品--</option></select></li>
								</ul>
								<ul class="row">
									
								    <li class="w100 tr">开始时间：</li>
									<li class="w200"><input type="text" id="startDate" class="form-control input-sm"/></li>
									<li class="w100 tr">结束时间：</li>
									<li class="w200"><input type="text" id="endDate" class="form-control input-sm"/></li>
								
								    <li class="w100 tr"><button onclick="query(1);" type="submit" class="btn btn-warning btn-sm btn-block">查询</button></li>
								</ul>
								
								<ul class="title"><li>查询结果</li></ul>
								<ul class="row">
								    <li class="w20"></li>
									<li class="w100">归属地市</li>
									<li class="w300">订购产品</li>
									<li class="w120">总流量(M)</li>		
									<li class="w120">用户数</li>
								</ul>
								<!--loop start-->
								<div id="datalist">
								<c:if test="${not empty datalist}">
								<c:forEach items="${datalist}" var="d">
								<ul class="row">
								    <li class="w20"></li>
									<li class="w100">${d.eparchyName}</li>
									<li class="w300">${d.productName}</li>
									<li class="w120">${d.flow}</li>					
									<li class="w120">${d.users}</li>
								</ul>
								</c:forEach>
								</c:if>
								<c:if test="${empty datalist}">
								<ul class="row"><li class="w10"></li><li style="text-align:center;color:#FF9C00;">点击查询，开始加载数据。。。<li></ul>
								</c:if>
							 </div>
							    <!--loop end-->
							    <table style="text-align:center;margin:0px auto">
							      <tr><td> <div id="pager"></div></td></tr>
							    </table>
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
