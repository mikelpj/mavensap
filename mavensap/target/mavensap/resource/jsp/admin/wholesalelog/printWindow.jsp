<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<%@page import="com.uflow.entity.Partner"%>
<%@page import="com.uflow.web.core.ActionBase" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>发票打印窗口</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="/jsp/common/commonResInclude.jsp"/>
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/magic.control.Dialog.css" rel="stylesheet"/>		
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/magic.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/LodopFuncs.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				
				var respCode = $("#respCode").val();
				var respDesc = $("#respDesc").val();
				if(respCode != '0000'){
					alert("查询发票资源失败,失败原因:"+respDesc+",请关闭窗口重新选择!");
					$("#changebtn").attr("disabled",true);
					$("#checkbtn").attr("disabled",true);
				}
			});
			function settaxvalue(){
				var seltaxid = $("#seltaxid").html();
				var selbookid = $("#selbookid").html();
				var selnoteId = $("#selnoteId").html();
				var seltaxstate = $("#seltaxstate").html();	
			
				$("#taxid").val(seltaxid);
				$("#bookid").val(selbookid);
				$("#noteId").val(selnoteId);
				
			}
			function changetax(){
				
				var taxid = $("#taxid").val();
				var bookid = $("#bookid").val();
				var noteId = $("#noteId").val();
				$("#seltaxid").html(taxid);
				$("#selbookid").html(bookid);
				$("#selnoteId").html(noteId);
				$("#printbtn").attr("disabled",true);
				$("#preveiwbtn").attr("disabled",true);
				
			} 
			//校验接口需传到后台
			function checktax(){
				var url='${pageContext.request.contextPath}/admin/wholesalelog_checktax.do';
				var radioBatchId = $("#radioBatchId").val(); 
				var seltaxid = $("#seltaxid").html();
				var selbookid = $("#selbookid").html();
				var selnoteId = $("#selnoteId").html();
				var seltaxstate = $("#seltaxstate").html();	
				
				
				var data={
				radioBatchId:radioBatchId,
				seltaxid:seltaxid,
				selbookid:selbookid,
				selnoteId:selnoteId,
				seltaxstate:seltaxstate				
				};
				
				
				var callback=function(result){
					unblockUI();
				if(result.msg){					
					alert("校验通过,可以打印!");
					$("#loginStaffId").val(result.loginStaffId);
					$("#printTime").val(result.printTime);
					$("#printTime1").val(result.printTime1);	
					$("#printbtn").removeAttr("disabled");
					$("#preveiwbtn").removeAttr("disabled");
					
				}else{
					alert("校验失败,失败原因:"+result.respDesc);
				}
				};
				ajaxQuery(url,'post','json',data,callback);
				blockUI();
				
			};
				

			function printtax(){
				var url='${pageContext.request.contextPath}/admin/wholesalelog_printtax.do';
			 	var seltaxid = $("#seltaxid").html();
				var selbookid = $("#selbookid").html();
				var selnoteId = $("#selnoteId").html();
				var seltaxstate = $("#seltaxstate").html();
				var radioBatchId = $("#radioBatchId").val(); 
				var data={
				seltaxid:seltaxid,
				selbookid:selbookid,
				selnoteId:selnoteId,
				seltaxstate:seltaxstate,
				radioBatchId:radioBatchId			
				};
				var callback=function(result){
				unblockUI();
				if(result.msg){		
					alert("请点击确定进行打印!");			
					CreateDataBill();					
					var printResult = LODOP.PRINT();
					
					if(printResult == false){
						alert("连打印机超时,请检查您的打印机连接是否正常");
						printtaxrollback();
					}		
				}else{
					 alert("打印失败,失败原因:"+result.respDesc);
					 printtaxrollback();
					 self.location.href = "/admin/wholesalelog_print.do";					 
				}
				};
				ajaxQuery(url,'post','json',data,callback);
				blockUI();				
			}
			
			function printtaxrollback(){
				var url='${pageContext.request.contextPath}/admin/wholesalelog_taxrollback.do';
			 	var seltaxid = $("#seltaxid").html();
				var selbookid = $("#selbookid").html();
				var selnoteId = $("#selnoteId").html();
				var seltaxstate = $("#seltaxstate").html();
				var radioBatchId = $("#radioBatchId").val(); 
				var data={
				seltaxid:seltaxid,
				selbookid:selbookid,
				selnoteId:selnoteId,
				seltaxstate:seltaxstate,
				radioBatchId:radioBatchId			
				};
				var callback=function(result){			
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
			//预览
			function preview(){
				CreateDataBill();
				LODOP.PREVIEW();
			}
		
			function CreateDataBill() {
					var seltaxid = $("#seltaxid").html();//税务登记号
					var selbookid = $("#selbookid").html();//发票代码
					var selnoteId = $("#selnoteId").html();//发票号码
					var custname = $("#custName").val();
					var fee = $("#fee").val();
					var radioBatchId = $("#radioBatchId").val();
					var updateStaff = $("#updateStaff").val();
					var serialNumber = $("#serialNumber").val();
					var custname = $("#custName").val();
					var acctId = $("#acctId").val();
					var loginStaffId = $("#loginStaffId").val();
					var printTime = $("#printTime").val();
					var printTime1 = $("#printTime1").val();
					
					LODOP=getLodop();  
					LODOP.PRINT_INIT("账务发票收据打印");
					LODOP.SET_PRINT_PAGESIZE(1,1890,960,"");
					LODOP.SET_PRINT_STYLE("FontColor","#0000FF");
					LODOP.ADD_PRINT_TEXT(72,40,80,13,printTime);
					LODOP.ADD_PRINT_TEXT(72,250,100,13,"邮电通信业");
					LODOP.ADD_PRINT_TEXT(98,40,500,13,"客户名称:"+custname);
					//LODOP.ADD_PRINT_TEXT(115,40,500,13,"业务号码:"+serialNumber);
					LODOP.ADD_PRINT_TEXT(132,40,500,13,"合 同 号:"+acctId);
					LODOP.ADD_PRINT_TEXT(149,40,500,13,"打印流水:"+radioBatchId);
					LODOP.ADD_PRINT_TEXT(175,40,500,13,"通信服务费");
					LODOP.ADD_PRINT_TEXT(175,190,500,13,fee);
			
					LODOP.ADD_PRINT_TEXT(132,400,500,13,"机打票号:"+selbookid+""+selnoteId);
					//LODOP.ADD_PRINT_TEXT(149,400,500,13,"防 伪 码:"+selnoteId);
		
					LODOP.ADD_PRINT_TEXT(215,40,500,13,"小写合计:￥ "+fee);
					LODOP.ADD_PRINT_TEXT(232,40,500,13,"大写合计:"+DX(fee));
		
					LODOP.ADD_PRINT_TEXT(300,40,500,13,"打印日期:"+printTime1);
					LODOP.ADD_PRINT_TEXT(300,300,500,13,"操作员:"+loginStaffId);
		
					LODOP.SET_PRINT_STYLEA(1,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(2,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(3,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(4,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(5,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(6,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(7,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(8,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(9,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(10,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(11,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(12,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(13,"FontSize",10);
					LODOP.SET_PRINT_STYLEA(14,"FontSize",10);
		
					LODOP.SET_PRINT_STYLEA(1,"Bold",1);
					LODOP.SET_PRINT_STYLEA(2,"Bold",1);
					LODOP.SET_PRINT_STYLEA(3,"Bold",1);
					LODOP.SET_PRINT_STYLEA(4,"Bold",1);
					LODOP.SET_PRINT_STYLEA(5,"Bold",1);
					LODOP.SET_PRINT_STYLEA(6,"Bold",1);
					LODOP.SET_PRINT_STYLEA(7,"Bold",1);
					LODOP.SET_PRINT_STYLEA(8,"Bold",1);
					LODOP.SET_PRINT_STYLEA(9,"Bold",1);
					LODOP.SET_PRINT_STYLEA(10,"Bold",1);
					LODOP.SET_PRINT_STYLEA(11,"Bold",1);
					LODOP.SET_PRINT_STYLEA(12,"Bold",1);
					LODOP.SET_PRINT_STYLEA(13,"Bold",1);
					LODOP.SET_PRINT_STYLEA(14,"Bold",1); 
		}
		</script>
		
		
		<style type="text/css">
		</style>
	</head>

<body class="bodybg">
		<jsp:include page="/jsp/common/menu_header.jsp"></jsp:include>
		
         <div id="contain">
         	<div class="box">
						<div class="heading">
    						<h1>打印发票</h1>
  						</div>
  						<div class="content">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
								<ul class="row">
									
									<li class=" w100 tr">税务登记号</li>
									<li class="w150"><input type="text" class="form-control input-sm" id="taxid" value="${taxId}" disabled="disabled"/></li>
									<li class=" w100 tr">发票代码</li>
									<li class="w100"><input type="text" id="bookid" class="form-control input-sm" value="${bookId}"/></li>
									<li class=" w100 tr">发票号码</li>
									<li class="w100"><input type="text" id="noteId" class="form-control input-sm" value="${noteId}"/></li>
								</ul>
								<ul class="row">
									<li class="w30 tr"></li>									
									<li class="w100 tr"><button onclick="changetax('1');" type="submit" class="btn btn-warning btn-sm btn-block" id="changebtn">修改</button></li>
									<li class="w100 tr"><button onclick="checktax('1');" type="submit" class="btn btn-warning btn-sm btn-block" id="checkbtn">校验</button></li>
									<li class="w100 tr"><button onclick="printtax('1');" type="submit" class="btn btn-warning btn-sm btn-block" id="printbtn" disabled="disabled">确认</button></li>
									<li class="w100 tr"><button onclick="preview('1');" type="submit" class="btn btn-warning btn-sm btn-block" id="preveiwbtn" disabled="disabled" >预览</button></li>										
								</ul>	
																	
								<ul class="row">
									<li class="w30"></li>
									<li class="w100 tr">税务登记号</li>
									<li class="w100 tr">发票代码</li>
									<li class="w100 tr">发票号码</li>
									<li class="w100 tr">状态</li>									
								</ul>
								<ul class="row" id="seltax" onclick="settaxvalue();">
									<li class="w30"></li>
									<li class="w100 tr" id="seltaxid">${taxId}</li>
									<li class="w100 tr" id="selbookid">${bookId}</li>
									<li class="w100 tr" id="selnoteId">${noteId}</li>
									<li class="w100 tr" id="seltaxstate">可用</li>									
								</ul>																	
									<input type="hidden" class="form-control input-sm" id="custName" value="${custName}"/>
									<input type="hidden" class="form-control input-sm" id="acctId" value="${acctId}"/>							
									<input type="hidden" class="form-control input-sm" id="fee" value="${fee}"/>				
									<input type="hidden" class="form-control input-sm" id="radioBatchId" value="${radioBatchId}"/>
									<input type="hidden" class="form-control input-sm" id="updateStaff"  value="${updateStaff}"/>
									<input type="hidden" class="form-control input-sm" id="serialNumber" value="${serialNumber}"/>
									<input type="hidden" class="form-control input-sm" id="loginStaffId" />	
									<input type="hidden" class="form-control input-sm" id="printTime"/>
									<input type="hidden" class="form-control input-sm" id="printTime1"/>
									<input type="hidden" id="respCode" value="${respCode}" />
									<input type="hidden" id="respDesc" value="${respDesc}" />		
																	
								<div style="clear:both;"></div>
							</div>
						</div>
            	</div>
         	
         </div>
         
		<!-- 页脚部分-->
		<!-- 页脚部分结束-->
	</body>
</html>
