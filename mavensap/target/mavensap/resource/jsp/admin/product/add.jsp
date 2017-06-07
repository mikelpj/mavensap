<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>添加产品参数</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/magic.control.Dialog.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/magic.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			
		});
		function save_product(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/product_save.do';
			var _product_name=$("#_product_name").val();//产品名称
			var _use_object=$("#_use_object").val();//产品类型
			var _fee=$("#_fee").val();//单位分
			var _data_flow=$("#_data_flow").val();//单位M
			var _unit_price=$("#_unit_price").val();//单位分每兆
			var _valid_tag=$("#_valid_tag").val();//生失效标志
			var _product_type=$("#product_type").val();
			if(_product_name.length<1){showmsg('产品名称不能为空');return;};
			if(_use_object.length<1){showmsg('产品类型不能为空');return;};
			if(_fee.length<1){showmsg('产品价格不能为空');return;};
			if(_data_flow.length<1){showmsg('总流量不能为空');return;};
			if(_unit_price.length<1){showmsg('单价不能为空');return;};
			
			if(!isNum(_fee)){showmsg('产品价格请填入整数！');return;};
			if(!isNum(_data_flow)){showmsg('总流量请填入整数！');return;};
			if(!isNum(_unit_price)){showmsg('单价请填入整数(单位为分)！');return;};
			var _bugfix='';
			try{
				if(parseInt(_data_flow)*parseInt(_unit_price)!=_fee){
					magic.alert('总价X总注量与价格不一致', '消息提示',{
	               		'label': '关闭'
	             	});
					return;
				}
			}catch(e){
			}

			var data={
				product_name:_product_name,
				use_object:_use_object,
				fee:_fee,
				data_flow:_data_flow,
				unit_price:_unit_price,
				valid_tag:_valid_tag,
				product_type:_product_type,
				bugfix:_bugfix
			};
			var callback=function(result){
				if(result.msg){
					magic.alert('产品添加成功', '消息提示',{
	               		'label': '返回',
						'callback': function(){
	                     	
	 					}
	             	});
				}else{
					showmsg(result.errmsg);
				}
			};
			magic.confirm('确认添加该产品吗？', '提示', {
                'label': '确定',
                'callback': function(){
					ajaxQuery(url,'post','json',data,callback);
                }
            }, {
                'label': '取消',
                'callback': function(){
                    return;
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
		function calc_price(){
			var unit_price=$("#_unit_price").val();
			var flow=$("#_data_flow").val();
			try{
				$("#_fee").val(parseFloat(unit_price)*parseFloat(flow));
			}catch(e){
			}
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/admin/product_list.do">流量产品管理</a>&nbsp;&gt;&nbsp;添加流量产品</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>产品信息</li></ul>
								<ul class="row">
									<li class=" w100 tr">产品名称</li>
									<li class="w250"><input type="text" class="form-control input-sm" id="_product_name" placeholder="产品名称"/></li>

									<li class=" w100 tr">产品类型</li>
									<li class="w200">
									<select id="_use_object" class="form-control input-sm" disabled="disabled">
										<option value="U">赠送</option>
										<option value="P" selected="selected">批发</option>
									</select></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">单价</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_unit_price" onkeyup="calc_price();" onblur="calc_price();" placeholder="单位:分/M"/></li>
									<li class="w50">(分/	M)</li>

									<li class=" w100 tr">总流量</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_data_flow" onkeyup="calc_price();" onblur="calc_price();" splaceholder="总流量(单位:M)"/></li>
									<li class="w50">(M)</li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">产品价格</li>
									<li class="w200"><input type="text" class="form-control input-sm" id="_fee" placeholder="价格:分" /></li>
									<li class="w50">(分)</li>
									
									<li class=" w100 tr">生效标志</li>
									<li class="w200"><select class="form-control input-sm" id="_valid_tag"><option value="0">暂不生效</option><option value="1" selected="selected">生效</option></select></li>
								</ul>
								<ul class="row">
									<li class=" w100 tr">批发类型</li>
									<li class="w200"><select class="form-control input-sm" id="product_type"><option value="2">个人用户批发</option><option value="1" selected="selected">企业用户批发</option></select></li>
								</ul>
								<ul class="last row">
									<li class="w100"><button onclick="save_product();" type="submit" class="btn btn-warning btn-sm btn-block">保存</button></li>
									<li class="w100"><button onclick="javascript:history.go('-1');" type="submit" class="btn btn-warning btn-sm btn-block">返回</button></li>
								</ul>
								<div style="clear:both;"></div>
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
