<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>企业用户查询</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.pager.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			showPager();
		});
		function query_partnertemp(p){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/admin/partnertemp_query.do';
			var _cust_name=$("#_cust_name").val();//合作方名称
			var _usertype=$("#_usertype").val();//类型
			var _phone=$("#_phone").val();//
			var page=$("#pageNumber").val();
			if(p){page=1;}
			var data={
				cust_name:_cust_name,
				usertype:_usertype,
				phone:_phone,
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
		function showDataList(datalist){
			var html='';
			for(var i=0;i<datalist.length;i++){
				html+='<ul class="row"><li class="w20">&nbsp;</li>';
					html+='<li class="w250"><a href="${pageContext.request.contextPath}/admin/partnertemp_edit.do?id='+datalist[i].PARTNER_ID+'">'+datalist[i].CUST_NAME+'</a></li>';
					html+='<li class="w100">'+(datalist[i].RSRV_VALUE2=='P'?'个人用户':'企业用户')+'</li>';
					html+='<li class="w100"><input type="text" class="form-control input-sm" value="'+datalist[i].POST_PERSON+'"/></li>';
					html+='<li class="w120">'+datalist[i].PHONE+'</li>';
					html+='<li class="w100">'+getStateStr(datalist[i].STATE)+'</li>';
					html+='<li class="w170">'+datalist[i].SERIAL_NUMBER+'</li>';
					html+='<li>'+getStateLink(datalist[i].STATE,datalist[i].PARTNER_ID,datalist[i].RSRV_VALUE2)+'</li>';
				html+='</ul>';
			}
			$("#datalist").html(html);
		}
		function getStateStr(s){
			s=parseInt(s);
			if(s>=9)return '同步失败';
			var states='未审核,审核成功,审核失败,处理中,审核成功,审核成功'.split(',');
			return states[s];
		}
		function getStateLink(s,id,type){
			if(s=='0'){
				return '&nbsp;<a class="btn btn-default btn-xs" href="${pageContext.request.contextPath}/admin/partnertemp_edit.do?id='+id+'">审核</a>';
			}
			if(type=='P'||type=='U')return '';
			s=parseInt(s);
			if(s==1||s==3||s==4||s==5){
				return '&nbsp;<a class="btn btn-default btn-xs" href="${pageContext.request.contextPath}/admin/product_partner.do?partner_id='+id+'">设置</a>';
			}
			return '';
		}
		function showPager(){
			var pageNumber = $("#pageNumber").val();
			var pageCount = $("#pageCount").val();
			$("#pager").pager({
					pagenumber : pageNumber,
					pagecount : pageCount,
					buttonClickCallback : function(pnumber) {
					$("#pageNumber").val(pnumber);
					query_partnertemp();
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
		function set_status(s,v){
			$("#current_status").html(v);
			$("#search_status").html(s);
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
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/admin/partnertemp_list.do">合作商管理</a>&nbsp;&gt;&nbsp;合作商查询</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="title"><li>查询</li></ul>
								<ul class="row">
									<li class="w20">&nbsp;</li>
									<li class="w90 tr">公司名称</li>
									<li class="w200"><input type="text" id="_cust_name" class="form-control input-sm"/></li>
									<li class="w90 tr">用户类型</li>
									<li class="w150 tr">
										<select id="_usertype" class="form-control input-sm">
											<option value="">所有类型</option>
											<option value="C">企业用户</option>
											<option value="P">个人用户</option>
										</select>
									</li>
									<li class="w90 tr">联系人手机</li>
									<li class="w150 tr">
										<input type="text" id="_phone" class="form-control input-sm"/>
									</li>
									<li class="w100">
										<input type="hidden" id="_status" class="form-control input-sm"/>
										<button onclick="query_partnertemp('1');" type="button" class="btn btn-default btn-sm btn-block">查询</button>
									</li>
								</ul>
								<ul class="title"><li>查询结果</li></ul>
								<ul class="row">
									<li class="w20">&nbsp;</li>
									<li class="w250">公司名称</li>
									<li class="w100">用户类型</li>
									<li class="w100">联系人</li>
									<li class="w120">联系电话</li>
									<li class="w100">状态</li>
									<li class="w170 tc">充值号码</li>
									<li>操作</li>
								</ul>
								<!--loop start-->
								<div id="datalist">
								<c:if test="${not empty datalist}">
								<c:forEach var="d" items="${datalist}">
								<ul class="row">
									<li class="w20">&nbsp;</li>
									<li class="w250"><a href="${pageContext.request.contextPath}/admin/partnertemp_edit.do?id=${d.PARTNER_ID}">${d.CUST_NAME}</a></li>
									<li class="w100">
										<c:if test="${d.RSRV_VALUE2=='P'}">个人用户</c:if>
										<c:if test="${d.RSRV_VALUE2=='C'}">企业用户</c:if>
									</li>
									<li class="w100"><input type="text" class="form-control input-sm" value="${d.POST_PERSON}"/></li>
									<li class="w120">${d.PHONE}</li>
									<li class="w100">
										<c:if test="${d.STATE=='0'}">未审核</c:if>
										<c:if test="${d.STATE=='1'}">审核成功</c:if>
										<c:if test="${d.STATE=='2'}">审核失败</c:if>
										<c:if test="${d.STATE=='4'}">审核成功</c:if>
										<c:if test="${d.STATE=='5'}">审核成功</c:if>
										<c:if test="${d.STATE=='9'}">同步失败</c:if>
									</li>
									<li class="w170">
										${d.SERIAL_NUMBER}
									</li>
									<li><c:if test="${d.STATE=='0'}">
											<a class="btn btn-default btn-xs" href="${pageContext.request.contextPath}/admin/partnertemp_edit.do?id=${d.PARTNER_ID}">审核</a>
										</c:if>
										<c:if test="${d.RSRV_VALUE2=='C' and (d.STATE=='1' || d.STATE=='4' || d.STATE=='5')}">
											<a class="btn btn-default btn-xs" href="${pageContext.request.contextPath}/admin/product_partner.do?partner_id=${d.PARTNER_ID}">设置</a>
										</c:if>
									</li>
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
		<!-- 页脚部分-->
		<div id="footer">
			2014&copy; China Unicom 中国联通.版权所有
		</div>
		<!-- 页脚部分结束-->
	</body>
</html>
