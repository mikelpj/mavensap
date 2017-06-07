<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>流量赠送</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet"/>
		<link href="${pageContext.request.contextPath}/css/magic.control.Dialog.css" rel="stylesheet"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.pager.js"></script>
		<link rel="stylesheet" type="text/css" href="http://tangram.baidu.com/magic/index.php?m=frontData&a=file&bucket=magic-586&object=/resources/default/magic.Tooltip/magic.Tooltip.css"/>
        <script type="text/javascript" src='http://tangram.baidu.com/magic/index.php?m=frontData&a=imports&f=magic.Tooltip'></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css"/>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/magic.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
		<script type="text/javascript">
		
		var left_flow=parseInt('${sy_flow}');
		var update_staff='${update_staff}';
		var cust_id='${cust_id}';
		$(document).ready(function(){
			//开始时间结束时间赋值 
			get_date();
			/**浮动提示框
			var tooltip = new magic.Tooltip({
                    target: baidu('#serial_number')[0],
                    content: '<div>多个手机号请用逗号隔开，最多支持输入10个手机号码</div>',
                    position: "right",
                    autoHide: false,
                    showEvent: 'focus',
                    hideEvent: 'blur'
                });
                tooltip.render();
                tooltip.on('show', function(){
                    log('focus event', '提示框显示');
                });
                tooltip.on('hide', function(){
                    log('blur event', '提示框隐藏');
                });
                baidu('#serial_number').on("focus", function(){
                    log('focus event', '获取焦点');
                });
                baidu('#serial_number').on("blur", function(){
                    log('blur event', '失去焦点');
                });
                 **/
			//初始值赋值
			var _start_date=$("#start_date").val();//开始时间 
			var _end_date=$("#end_date").val();//结束时间 
			$("#bat_start_date").val(_start_date);
			$("#bat_end_date").val(_end_date);
			queryForNum();
			loadProductList();
			$("#left_allflow").val(left_flow+"M");
			
			
		});
		
		//查询产品信息
		function loadProductList(){	
			var url='${pageContext.request.contextPath}/product/queryProduct.do';	
			var data={
				state:'U'
			};
			var callback=function(result){
				if(result.msg){
					showDataList(result.productList);
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
		}
		
		function showDataList(datalist){		
			var html="<option value='0'>--请选择产品--</option>";
			var inputHtml="";
			var productId = $("#u_product_id");
			for(var i=0;i<datalist.length;i++){
				html+="<option value="+datalist[i].PRODUCT_ID+" ref="+datalist[i].DATA_FLOW+" id=opt"+datalist[i].PRODUCT_ID+">"+datalist[i].PRODUCT_NAME+"</option>";
			}		
			productId.html(html);	
		}
		//开始时间结束时间赋值 
		function get_date(){
			var myDate = new Date();
		    var year = myDate.getFullYear();
		    var month = myDate.getMonth()+2;
		    if (month<10){
		        month = "0"+month;
		    }
		    var firstDay = year+"/"+month+"/01"+" 00:00:00";
			$("#start_date").val(firstDay);
			lastDate = new Date(year,month,0);
		    var lastDay = year+"/"+month+"/"+lastDate.getDate()+" 23:59:59";
		 	$("#end_date").val(lastDay);
		}
		
		//导入按钮 
		function load_givinglog(){
			$("#show_error").hide();
			var filename=$("#file").val();
			var isIE = /msie/i.test(navigator.userAgent) && !window.opera; 
			var loadfile = document.getElementById("file").files;  
			var filesize=0;
			if (!isIE) { 
		    	filesize=loadfile[0].size/1024;
		    }
			 
			//alert(filesize);
			if(filesize>5120){
				showmsg('文件太大！');return;
			}
			
			var url='${pageContext.request.contextPath}/givinglog/upload.do';
			//给action 赋值
			document.addform.action=url;
			var post_url=$(addform).attr('action');
			
			var length=filename.length;
			var fielend=filename.substring(length-4,length);

			if(filename==null || filename==""){
				showmsg('请选择文件！');return;
			}else if('.txt#.xls#xlsx'.indexOf(fielend)==-1){
				showmsg('只能上传后缀名为 .txt 或 .xls的文件！请参照模板文件！');return;
			}
			
			var number_count=0;
			//产品流量 
			var choose_product_id=$("#u_product_id").val();
			var u_date_flow=$("#opt"+choose_product_id).attr('ref');
			var _u_product_id=$("#u_product_id").val();//流量产品 
			if(_u_product_id=='0'){showmsg('请选择产品！');return;};
			if(_u_product_id.length<1){showmsg('请选择流量产品 ！');return;};
			$("#bat_data_flow").val(u_date_flow);
			$("#bat_left_flow").val(left_flow);
			$("#bat_product_id").val(_u_product_id);
			
			magic.confirm('确认赠送？', '提示', {
                        'label': '确定',
                        'callback': function(){
                            document.addform.submit();
                        }
                    }, {
                        'label': '取消',
                        'callback': function(){
                            return;
                        }
                });
			
		}
		//单个赠送提交按钮 
		function save_givinglog(){
			$("#show_error").hide();
			var url='${pageContext.request.contextPath}/givinglog/save.do';
			var _serial_number=$.trim($("#serial_number").val());//受赠号码
			_serial_number=_serial_number.replaceAll("，",',');
			var numbers=_serial_number.split(",");
			var number_count=0;
			//产品流量 
			var choose_product_id=$("#u_product_id").val();
			var u_date_flow=$("#opt"+choose_product_id).attr('ref');
			
			var _u_product_id=$("#u_product_id").val();//流量产品 
			var _start_date=$("#start_date").val();//开始时间 
			var _end_date=$("#end_date").val();//结束时间 
			if(_u_product_id=='0'){showmsg('请选择产品！');return;};
			if(_serial_number.length<1){showmsg('受赠号码不能为空');return;};
			if(_u_product_id.length<1){showmsg('请选择流量产品 ！');return;};
			$("#_serial_number").val(_serial_number);
			$("#_u_product_id").val(_u_product_id);
			$("#_start_date").val(_start_date);
			$("#_end_date").val(_end_date);
			$("#_update_staff").val(update_staff);
			$("#_cust_id").val(cust_id);
			$("#_left_flow").val(left_flow);
			$("#_data_flow").val(u_date_flow);
			
			//给action 赋值
			document.addform.action=url;
			var post_url=$(addform).attr('action');
			var serial_list="";
			
			for(var i=0;i<numbers.length;i++){
				var serial_number=$.trim(numbers[i]);
				if(serial_number==null || serial_number==""){
					continue;
				}
				if(isMobile(serial_number)){
					number_count++;
					serial_list=serial_list+serial_number+",";
				}else {showmsg('手机号码非法！');return;}
			}
			//重新设置号码list值 
			$("#_serial_number").val(serial_list);
			if(number_count>10){
				showmsg('赠送号码不能大于10个！');return;
			}
			//判重 
			if(!o2o2(serial_list)){
				showmsg('受赠号码有重复，请核对！');return;
			}
			if(number_count>parseInt($("#person").html())){
				showmsg('您的流量不足，请您及时购买流量充值专属产品，感谢您的使用！');
				return;
			}
			
			
			magic.confirm('确认赠送？', '提示', {
                        'label': '确定',
                        'callback': function(){
                         document.addform.submit();
                        }
                    }, {
                        'label': '取消',
                        'callback': function(){
                            return;
                        }
                });

			
		}
		//导入按钮 
		function load_givinglogtwo(){
			$("#show_error").hide();
			var filename=$("#file").val();
			var isIE = /msie/i.test(navigator.userAgent) && !window.opera; 
			var loadfile = document.getElementById("file").files;  
			var filesize = 0;
			if (!isIE) { 
		    	filesize=loadfile[0].size/1024;
		    }
			 
			//alert(filesize);
			if(filesize>5120){
				showmsg('文件太大！');return;
			}
			
			var url='${pageContext.request.contextPath}/givinglog/upload.do';
			//给action 赋值
			document.addform.action=url;
			var post_url=$(addform).attr('action');
			
			var length=filename.length;
			var fielend=filename.substring(length-4,length);

			if(filename==null || filename==""){
				showmsg('请选择文件！');return;
			}else if(fielend!=".xls" && fielend!=".txt"){
				showmsg('只能上传后缀名为 .txt ,.xlsx或 .xls的文件！请参照模板文件！');return;
			}
			
			var number_count=0;
			//产品流量 
			var choose_product_id=$("#u_product_id").val();
			var u_date_flow=$("#opt"+choose_product_id).attr('ref');
			var _u_product_id=$("#u_product_id").val();//流量产品 
			if(_u_product_id=='0'){showmsg('请选择产品！');return;};
			if(_u_product_id.length<1){showmsg('请选择流量产品 ！');return;};
			$("#bat_data_flow").val(u_date_flow);
			$("#bat_left_flow").val(left_flow);
			$("#bat_product_id").val(_u_product_id);
			document.addform.submit();
			
		}
		function btn_submit(){
			var _u_product_id=$("#u_product_id").val();//流量产品 
			if(_u_product_id=='0'){showmsg('请先选择产品！');return;};
			var serialnumber=$.trim($("#serial_number").val());//受赠号码
			var filename=$("#file").val();
			if(serialnumber.length>0 && filename.length==0){
				save_givinglog();
				///givinglog/save.do
			}else if(serialnumber.length>0 && filename!=null && filename!=""){
				
				magic.confirm('受赠号码和上传文件同时提交只上传文件！', '提示', {
                        'label': '确定',
                        'callback': function(){
                            load_givinglogtwo();
                        }
                    }, {
                        'label': '取消',
                        'callback': function(){
                            return;
                        }
                });
				
			}else{
				load_givinglog();
				///givinglog/upload.do
			}
		}
		function queryForNum(){
			var choose_product_id=$("#u_product_id").val();
			if(choose_product_id){
				var current_product_flow=$("#opt"+choose_product_id).attr('ref');
				var person=(parseInt(parseInt(left_flow)/parseInt(current_product_flow)));
				$("#person").html(person);
			}else{
				$("#person").html('...');
			}
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
			.demo-region {
                margin:20px auto;
                width: 600px;
                text-align: center;
            }
            
            .magic-tooltip .magic-tooltip-content{
                color: red;
            }
			
		
		</style>
	</head>
<body class="bodybg">
		<!-- 页头开始-->
		<jsp:include page="/jsp/common/menu_header.jsp"></jsp:include>
		<!-- 页头结束-->
         <div id="contain">
         	<div class="box">
						<div class="heading">
    						<h1><a href="${pageContext.request.contextPath}/welcome.do">首页</a>&nbsp;&gt;&nbsp;<a href="${pageContext.request.contextPath}/givinglog/list.do">流量赠送</a>&nbsp;&gt;&nbsp;流量赠送</h1>
  						</div>
  						<div class="content" style="height: 400px;">
  							<div style="margin-bottom:10px;" id="show_error" class="show_error">
    							<span style="color:red;margin-left:4px;" class="glyphicon glyphicon-exclamation-sign"></span>
    							<span id="show_error_text" class="sl-error-text">...</span>
							</div>
							<div class="table">
							<form name="addform" method="post" action="#" enctype="multipart/form-data">
								<input type="hidden" name="serial_number" id="_serial_number"/>
								<input type="hidden" name="u_product_id" id="_u_product_id"/>
								<input type="hidden" name="start_date" id="_start_date"/>
								<input type="hidden" name="end_date" id="_end_date"/>
								<input type="hidden" name="update_staff" id="_update_staff"/>
								<input type="hidden" name="cust_id" id="_cust_id"/>
								<input type="hidden" name="left_flow" id="_left_flow"/>
								<input type="hidden" name="data_flow" id="_data_flow"/>
								<!-- upload -->
								<input type="hidden" name="bat_start_date" id="bat_start_date"/>
								<input type="hidden" name="bat_end_date" id="bat_end_date"/>
								<input type="hidden" name="bat_data_flow" id="bat_data_flow"/>
								<input type="hidden" name="bat_left_flow" id="bat_left_flow"/>
								<input type="hidden" name="bat_product_id" id="bat_product_id"/>
								<ul class="row gry">
									<li class=" w100 tr">开始时间</li>
									<li class="w200"><input  disabled="disabled" type="text"   id="start_date" value="" class="form-control input-sm"/></li>
									<li class=" w100 tr">结束时间</li>
									<li class="w200"><input disabled="disabled" type="text"   id="end_date" value="" class="form-control input-sm"/></li>
									
								</ul>
								<ul class="row gry">
									<li class=" w100 tr">赠送产品</li>
									<li class="w200"><select id="u_product_id" onchange="queryForNum();" class="form-control input-sm"></select></li>
									<li class=" w100 tr">剩余流量</li>
									<li class="w200"><input disabled="disabled" type="text" class="form-control input-sm" id="left_allflow" id="left_allflow"/></li>
									<li type="hidden" class="w200 tr" style="text-align:center;">可以赠送给<span id="person"></span>个人</li>
								</ul>
								<ul class="row gry">
									<li class=" w100 tr">受赠号码</li>
									<li class="w500"><textarea  class="form-control input-sm" id="serial_number" placeholder="多个手机号码之间请用逗号隔开，最多支持输入10个号码"></textarea></li>
									<li type="hidden" class="w400 tr" style="text-align:center;color: red">多个手机号码之间请用逗号隔开，最多支持输入10个号码</li>
									<!-- <li class="w100"><button onclick="save_givinglog();" type="button" class="btn btn-warning btn-sm btn-block">赠送</button></li> -->
								</ul>
								
								<ul class="row gry">
									<li class=" w100 tr">选择文件</li>
									<li class="w200"><input type="file" name="file" size="10" id="file"/></li>
								<!-- <li class="w100"><button onclick="load_givinglog();" type="button" class="btn btn-warning btn-sm btn-block">导入</button></li> -->
								</ul>
								<ul class="row gry">
									<li class=" w40 tr"></li>
									<li><img src="${pageContext.request.contextPath}/img/answers.gif" alt="info" width="13" height="14"/>上传前请查看模板格式(最多支持导入10万个手机号码)：</span>
			                        <a href="${pageContext.request.contextPath}/file/batmode.txt" target="printframe">批量导入模板TXT</a>&nbsp;&nbsp;
			                        <a href="${pageContext.request.contextPath}/file/batmode.xls" target="printframe">批量导入模板XLS</a></li>
								</ul>
								
								<ul class="row gry">
									<li class="w100"></li>
									<li class="w100"><button onclick="btn_submit();" type="button" class="btn btn-warning btn-sm btn-block">提交</button></li>
								</ul>
								
								<div style="clear:both;"></div>
								</form>
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
