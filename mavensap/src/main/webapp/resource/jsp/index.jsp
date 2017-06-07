<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
    	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>河南联通流量后向计费平台</title>
		<link href="${pageContext.request.contextPath}/resource/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/resource/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/bootstrap.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#username").focus();
			});
		</script>
		<style type="text/css">
		</style>
	</head>
	<body class="bodybg">
		<!-- 页头开始-->
		<jsp:include page="/resource/jsp/common/menu_header.jsp"></jsp:include>
		<!-- 页头结束-->
         <div id="contain">
         		<div class="box">
						<div class="heading">
    						<h1>当前位置 : <a href="${pageContext.request.contextPath}/welcome.do">首页</a></h1>
  						</div>
  						<div class="content">
							<div class="user_service" style="margin-bottom:10px;">
           	   					<dl class="clear overflow-hidden">
                					<dt onclick="myInfo();" class="fl  sign_nselfService_uase"></dt>
                   					 <dd class="fl padding-left-5 line-height-180">
                    				<div id="userinfo"><span style="height:30px;" class="display-block wrap"> 
                    				&nbsp;${staff.STAFF_NAME}，您好！</span><div style="margin-top:4px; position:absolute;">
                    				<c:if test="${staff.STAFF_TYPE=='P'}">个人用户</c:if>
                    				<c:if test="${staff.STAFF_TYPE=='C'}">企业用户</c:if>
                    				<c:if test="${staff.STAFF_TYPE=='U'}">管理员</c:if>
                    				| <c:if test="${not empty partner}">充值号码:${partner.SERIAL_NUMBER}</c:if><c:if test="${empty partner}"><a href="${pageContext.request.contextPath}/logout.do">退出系统</a></c:if></div></div>
                   				</dd>
              				</dl>
							</div>
							<c:if test="${staff.STAFF_TYPE=='U' and staff.ROLE_ID=='3'}">
							<div class="table">
								<ul class="title"><li>常用业务办理</li></ul>
								<div class="icon_garden">
								<ul class="icon_ul">
								<li class="icons">
									<a href="${pageContext.request.contextPath}/admin/wholesalelog_add.do"><div style="width:29px; height:29px;background:url(${pageContext.request.contextPath}/img/nav.png) no-repeat 0px -145px; float:left;"></div></a>
									<div class="li_text"><h3><a class="blue" href="${pageContext.request.contextPath}/admin/wholesalelog_add.do">流量批发受理</a></h3><p>合作方办理流量购买业务</p></div>
								</li>
								<li class="icons">
									<a href="${pageContext.request.contextPath}/admin/wholesalelog_list.do"><div style=" width:29px; height:29px;background:url(${pageContext.request.contextPath}/img/nav.png) no-repeat -87px -29px; float:left;"></div></a>
									<div class="li_text"><h3><a class="blue" href="${pageContext.request.contextPath}/admin/wholesalelog_list.do">流量批发查询</a></h3><p>查询流量批发历史记录</p></div>
								</li>
								<li class="icons">
									<a href="${pageContext.request.contextPath}/admin/partnertemp_audit.do"><div style=" width:29px; height:29px;background:url(${pageContext.request.contextPath}/img/nav.png) no-repeat 0px -261px; float:left;"></div></a>
									<div class="li_text"><h3><a class="blue" href="${pageContext.request.contextPath}/admin/partnertemp_audit.do">合作商审核</a></h3><p>处理合作商审核业务</p></div>
								</li>
								</ul>
								<div class="clear"></div>
								</div>
							</div>
							</c:if>
							<c:if test="${staff.STAFF_TYPE=='U' and staff.ROLE_ID=='1'}">
							<div class="table">
								<ul class="title"><li>常用业务办理</li></ul>
								<div class="icon_garden">
								<ul class="icon_ul">
								<li class="icons">
									<a href="${pageContext.request.contextPath}/admin/product_list.do"><div style="width:29px; height:29px;background:url(${pageContext.request.contextPath}/img/nav.png) no-repeat 0px -145px; float:left;"></div></a>
									<div class="li_text"><h3><a class="blue" href="${pageContext.request.contextPath}/admin/product_list.do">流量产品管理</a></h3><p>流量产品管理</p></div>
								</li>
								<li class="icons">
									<a href="${pageContext.request.contextPath}/admin/role_list.do"><div style=" width:29px; height:29px;background:url(${pageContext.request.contextPath}/img/nav.png) no-repeat -87px -29px; float:left;"></div></a>
									<div class="li_text"><h3><a class="blue" href="${pageContext.request.contextPath}/admin/role_list.do">角色权限</a></h3><p>角色权限管理</p></div>
								</li>
								<li class="icons">
									<a href="${pageContext.request.contextPath}/admin/staff_add.do"><div style=" width:29px; height:29px;background:url(${pageContext.request.contextPath}/img/nav.png) no-repeat 0px -261px; float:left;"></div></a>
									<div class="li_text"><h3><a class="blue" href="${pageContext.request.contextPath}/admin/staff_add.do">后台工号添加</a></h3><p>联通后台工号添加</p></div>
								</li>
								</ul>
								<div class="clear"></div>
								</div>
							</div>
							</c:if>
							<c:if test="${staff.STAFF_TYPE=='C'||staff.STAFF_TYPE=='P'}">
							<div class="table">
								<ul class="title"><li>常用业务办理</li></ul>
								<div class="icon_garden">
								<ul class="icon_ul">
								<li class="icons">
									<a href="${pageContext.request.contextPath}/givinglog/add.do"><div style=" width:29px; height:29px;background:url(${pageContext.request.contextPath}/img/nav.png) no-repeat 0px 0px; float:left;"></div></a>
									<div class="li_text"><h3><a class="blue" href="${pageContext.request.contextPath}/givinglog/add.do">流量赠送</a></h3><p>给用户派发流量产品</p></div>
								</li>
								<li class="icons">
									<a href="${pageContext.request.contextPath}/wholesalelog/list.do"><div style=" width:29px; height:29px;background:url(${pageContext.request.contextPath}/img/nav.png) no-repeat -29px 0px; float:left;"></div></a>
									<div class="li_text"><h3><a class="blue" href="${pageContext.request.contextPath}/wholesalelog/list.do">我的订单</a></h3><p>查询流量批发历史记录</p></div>
								</li>
								<li class="icons">
									<a href="${pageContext.request.contextPath}/wholesalereport/list.do"><div style=" width:29px; height:29px;background:url(${pageContext.request.contextPath}/img/nav.png) no-repeat -29px -87px; float:left;"></div></a>
									<div class="li_text"><h3><a class="blue" href="${pageContext.request.contextPath}/wholesalereport/list.do">统计查询</a></h3><p>流量赠送汇总报表</p></div>
								</li>
								</ul>
								<div class="clear"></div>
								</div>
							</div>
							</c:if>
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
