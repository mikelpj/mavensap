<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>查看批发记录详情</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			
		});
		</script>
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
    						<h1>添加批发记录</h1>
  						</div>
  						<div class="content">
							<div class="table">
								<ul class="title"><li>示例</li></ul>
								<ul class="row gry">
									<li class=" w100 tr">证件类型</li>
									<li class="w200"><select class="form-control input-sm"><option value="1">身份证</option></select></li>
									<li class=" w100 tr">证件号码</li>
									<li class="w200"><input type="text" class="form-control input-sm"/></li>
								</ul>
								<ul class="title"><li>部分字段</li></ul>
								<ul class="row">
									<li class=" w100 tr">合作方ID</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_cust_id" value="${data.cust_id}"/></li>
								
									<li class=" w100 tr">订购产品</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_p_product_id" value="${data.p_product_id}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">价格(单位:元)</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_fee" value="${data.fee}"/></li>
								
									<li class=" w100 tr">产品流量(单位:M)</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_p_data_flow" value="${data.p_data_flow}"/></li>
								</ul>
								
								<ul class="row">
									<li class=" w100 tr">剩余流量(单位:M)</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_residual_flow" value="${data.residual_flow}"/></li>
								
									<li class=" w100 tr">地市编码</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_eparchy_code" value="${data.eparchy_code}"/></li>
								</ul>
								
								<ul class="last row">
									<li class="w100"><button onclick="save_wholesalelog();" type="submit" class="btn btn-warning btn-sm btn-block">保存</button></li>
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div style="clear:both;"></div>
							</div>
						</div>
            	</div>
         		</div>
         	</div>
         	<div class="con_side">
         		<!-- 根据用户权限生成TODO -->
         		<div class="box">
					<div class="heading">
    					<h1>批发记录管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/wholesalelog/list.do">批发记录列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/wholesalelog/add.do">添加批发记录</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>产品管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/product/list.do">产品列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/product/add.do">添加产品</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>合作方管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/parter/list.do">合作方列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/parter/add.do">添加合作方</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>赠送记录管理</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/givinglog/list.do">赠送记录列表</a>
						</li>
						<li class="submenu">
							 <a href="${pageContext.request.contextPath}/givinglog/add.do">添加赠送记录</a>
						</li>
					</ul>
					<div class="heading">
    					<h1>根据权限生成菜单TODO</h1>
  					</div>
					<ul class="menu">
						<li class="submenu">
							  子菜单
						</li>
					</ul>
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
