<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>设置购买关系</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/magic.control.Dialog.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.pager.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css"/>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/magic.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			$('.selected_pp').each(function(){
				var product_id=$(this).attr('ref');
				var use_tag=$(this).val();
				if(use_tag=='1'){
					$('#usetag_'+product_id+'_1').addClass('btn-primary').removeClass('btn-default');
					$('#usetag_'+product_id+'_0').addClass('btn-default').removeClass('btn-primary');
				}else{
					$('#usetag_'+product_id+'_0').addClass('btn-primary').removeClass('btn-default');
					$('#usetag_'+product_id+'_1').addClass('btn-default').removeClass('btn-primary');
				}
			});
		});
		var pagefrom='${from}';
		var update_mode=2;//0:all not 1 all ok 2
		function switch_usetag(uri_id,usetag){
			if(usetag=='1'){
				$('#usetag_'+uri_id+'_1').addClass('btn-primary').removeClass('btn-default');
				$('#usetag_'+uri_id+'_0').addClass('btn-default').removeClass('btn-primary');
			}else{
				$('#usetag_'+uri_id+'_0').addClass('btn-primary').removeClass('btn-default');
				$('#usetag_'+uri_id+'_1').addClass('btn-default').removeClass('btn-primary');
			}
			$('#usetag_'+uri_id).val(usetag);
			$('#pp'+uri_id).val(usetag);
			//save_roleuri(uri_id,usetag);
		}
		function save_roleuri(product_id,usetag){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/product_partnerproduct_edit.do';
			var partner_id=$("#partner_id").val();
			var data={
				product_id:product_id,
				partner_id:partner_id,
				use_tag:usetag
			};
			var callback=function(result){
				if(result.msg){
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
		}
		function select_all(use_tag){
			/**add**/
			if(use_tag=='0'){
				$('button.choosen').addClass('btn-default').removeClass('btn-primary');
				$('button.btnlimit').addClass('btn-primary').removeClass('btn-default');
				$('.selected_pp').each(function(){
					$(this).val('0');
				});
			}else{
				$('button.choosen').addClass('btn-primary').removeClass('btn-default');
				$('button.btnlimit').addClass('btn-default').removeClass('btn-primary');
				$('.selected_pp').each(function(){
					$(this).val('1');
				});
			}
			return;
			/**addend**/
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/product_partnerproduct_chooseAll.do';
			var partner_id=$("#partner_id").val();
			var data={
				partner_id:partner_id,
				use_tag:use_tag
			};
			var callback=function(result){
				if(result.msg){
					magic.alert('设置成功!', '消息提示',{
	               		'label': '确定',
						'callback': function(){
	                     	//window.location.href=pagefrom;
	 					}
	             	});
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
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
		function confirm_product(){
			var _choose_some=false;
			var id_status='';
			$('button.choosen').each(function(){
				if($(this).hasClass('btn-primary')){
					_choose_some=true;
					id_status+=($(this).attr('ref')+'#1,');
				}
			});
			if(!_choose_some){
				magic.alert('请为合作商添加可选产品!', '消息提示',{
               		'label': '确定'
             	});
             	return;
			}
			//window.location.href=pagefrom;

			$('.selected_pp').each(function(){
				var pid=$(this).attr('ref');
				var val=$(this).val();
				if(val=='0'){
					id_status+=(pid+'#'+val+',');
				}
			});
			var url='${pageContext.request.contextPath}/admin/product_partnerproduct_confirm.do';
			var partner_id=$("#partner_id").val();
			var data={
				partner_id:partner_id,
				id_status:id_status
			};
			var callback=function(result){
				if(result.msg){
					magic.alert('设置成功!', '消息提示',{
	               		'label': '确定',
						'callback': function(){
	                     	//window.location.href=pagefrom;
	 					}
	             	});
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/admin/partnertemp_list.do">合作商管理</a>&nbsp;&gt;&nbsp;合作商产品设置</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>合作方信息:</li></ul>
								<ul class="row">
									<li class="w20">&nbsp;</li>
									<li class="w100 tr">公司名称</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" value="${partner.CUST_NAME}"/></li>
									<li class="w100 tr">联系人</li>
									<li class="w200"><input type="text" disabled="disabled" class="form-control input-sm" value="${partner.POST_PERSON}"/></li>
								</ul>
								<ul class="title"><li>所有产品:</li></ul>
								<ul class="row">
									<li class="w20">&nbsp;</li>
									<li class="w200">产品名称</li>
									<li class="w100">价格(元)</li>
									<li class="w100">流量(M)</li>
									<li class="w100">单价(元/M)</li>
									<li class="w100">生效状态</li>
									<li>能否购买</li>
								</ul>
								<div id="datalist">
								<!--loop start-->
								<c:if test="${not empty productlist}">
								<c:forEach var="d" items="${productlist}">
								<ul class="row">
									<li class="w20"></li>
									<li class="w200"><input type="text" readonly="readonly" class="form-control input-sm" value="${d.PRODUCT_NAME}"/></li>
									<li class="w100">${d.FEE}</li>
									<li class="w100">${d.DATA_FLOW}</li>
									<li class="w100">${d.UNIT_PRICE}</li>
									<li class="w100"><c:if test="${d.VALID_TAG=='0'}">不生效</c:if><c:if test="${d.VALID_TAG=='1'}">生效</c:if></li>
									<li>
										<div class="btn-group">
											<button type="button" class="choosen btn btn-default btn-xs" ref='${d.PRODUCT_ID}' id="usetag_${d.PRODUCT_ID}_1" onclick="switch_usetag('${d.PRODUCT_ID}','1');">可购买</button>
											<button type="button" class="btn btnlimit btn-default btn-xs" id="usetag_${d.PRODUCT_ID}_0" onclick="switch_usetag('${d.PRODUCT_ID}','0');">限制</button>
										</div>
									</li>
								</ul>
								</c:forEach>
								</c:if>
								</div>
								<div id="pager">
								</div>
								<c:if test="${empty productlist}">
								<ul class="row"><li style="text-align:center;">未查询到数据</li></ul>
								</c:if>
								<!--loop end-->
								<ul class="last row">
									<li class="w20"></li>
									<li class="w100"><button onclick="select_all('1');" type="submit" class="btn btn-default btn-sm btn-block">全部选择</button></li>
									<li class="w100"><button onclick="select_all('0');" type="submit" class="btn btn-default btn-sm btn-block">全部取消</button></li>
									<li class="w130"><button onclick="confirm_product();" type="submit" class="btn btn-warning btn-sm btn-block">确认修改</button></li>
								</ul>
								<div style="clear:both;">
									<input type="hidden" id="partner_id" value="${partner_id}"/>
									<c:forEach var="pp" items="${pplist}"><input type="hidden" class="selected_pp" id="pp${pp.product_id}" ref="${pp.product_id}" value="${pp.use_tag}"/></c:forEach>
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
