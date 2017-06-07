<%@ page contentType="text/html; charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>消息页面</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			setTimeout(function(){window.location.href='${pageContext.request.contextPath}/givinglog/add.do';},7000);
		});
		function goback(){window.location.href='${pageContext.request.contextPath}/givinglog/add.do';}
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/givinglog/list.do">流量赠送</a>&nbsp;&gt;&nbsp;消息提示</h1>
  						</div>
						<div class="content" style="height: 300px;">
							<div class="page_notice">
								<div class="t_1"></div>
								<div class="t_2">
								</div>
								<div class="t_m2">
									<span class="red">${msg}</span>
								</div>
								<div class="t_2"></div>
								<div class="t_1"></div>
							</div>
							<ul class="row tl">
								<li class="w100" style="margin-left: 10px; margin-top: 10px;">
									<button onclick="goback();" type="button" class="btn btn-warning btn-sm btn-block">返回</button>
								</li>
							</ul>
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
