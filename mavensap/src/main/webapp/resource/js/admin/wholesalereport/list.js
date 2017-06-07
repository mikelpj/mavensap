$(document).ready(function(){
			$('#startDate').datetimepicker({
			language:'zh-CN',
			weekStart: 1,
			todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0,
    		format: 'yyyy-mm-dd'
		});
		$('#endDate').datetimepicker({
			language:'zh-CN',
			weekStart: 1,
			todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0,
    		format: 'yyyy-mm-dd'
		});
		loadProductList();		
		showPager();
		});
		 //格式化日期,
      function formatDate(date,format){
        var paddNum = function(num){
          num += "";
          return num.replace(/^(\d)$/,"0$1");
        }
        //指定格式字符
        var cfg = {
           yyyy : date.getFullYear() //年 : 4位
          ,yy : date.getFullYear().toString().substring(2)//年 : 2位
          ,M  : date.getMonth() + 1  //月 : 如果1位的时候不补0
          ,MM : paddNum(date.getMonth() + 1) //月 : 如果1位的时候补0
          ,d  : date.getDate()   //日 : 如果1位的时候不补0
          ,dd : paddNum(date.getDate())//日 : 如果1位的时候补0
          ,hh : date.getHours()  //时
          ,mm : date.getMinutes() //分
          ,ss : date.getSeconds() //秒
        }
        format || (format = "yyyy-MM-dd hh:mm:ss");
        return format.replace(/([a-z])(\1)*/ig,function(m){return cfg[m];});
      } 
      //定义地区编码-名称对应关系
      function getAreaName(areaNo) {
        var areaName="全部";
         if(areaNo='0371'){
            areaName="郑州";
         }else if(areaNo='0379'){
           areaName="洛阳";
         }else if(areaNo='0378'){
           areaName="开封";
         }else if(areaNo='0391'){
           areaName="焦作";
         }else if(areaNo='0373'){
           areaName="新乡";
         }else if(areaNo='0374'){
           areaName="许昌";
         }else if(areaNo='0395'){
           areaName="漯河";
         }else if(areaNo='0370'){
           areaName="商丘";
         }else if(areaNo='0375'){
           areaName="平顶山";
         }else if(areaNo='0394'){
           areaName="周口";
         }else if(areaNo='0396'){
           areaName="驻马店";
         }else if(areaNo='0398'){
           areaName="三门峡";
         }else if(areaNo='0393'){
           areaName="濮阳";
         }else if(areaNo='0392'){
           areaName="鹤壁";
         }else if(areaNo='0399'){
           areaName="济源";
         }else if(areaNo='0376'){
           areaName="信阳";
         }else if(areaNo='0377'){
           areaName="南阳";
         }
      }
		function showmsg(s){
			$("#show_error").show();
			$("#show_error_text").html(s);
		}
		
		function dateVaild(){
		 var start_date=$('#startDate').val();
		 var end_date=$('#endDate').val();
		 var sys_date= formatDate((new Date()),"yyyy-MM-dd");
		 if(start_date!="" && start_date>sys_date){
		   alert("开始时间不能大于当前时间【"+sys_date+"】,请重新选择日期！");
		   $("#startDate").focus();
		   return;
		 }
		 if(end_date!="" && start_date>end_date){
		    alert("开始时间不能大于结束时间,请重新选择日期！");
		    $("#startDate").focus();
		    return;
		 }
		}
		//根据条件查询
		function query(cond){	
		    dateVaild();
	    	$("#show_error").hide();
			if(cond == '1'){
				$("#pageNumber").val("1");
			}	
			var url=context_path+'/admin/wholesalereport_query.do';
			var startDate=$("#startDate").val();//开始时间
			var endDate=$("#endDate").val();//结束时间
			var product_id=$("#product_id").val();
			var staff_type = $("#staff_type").val();
			var pageNumber=$("#pageNumber").val();
			var data={
				product_id:product_id,
				startDate:startDate,
				endDate:endDate,
				staff_type:staff_type,
				page:pageNumber
			};
			var callback=function(result){
				//unblockUI();
				if(result.msg){					
					if(result.pager){
						$("#pageNumber").val(result.pager.pageIndex);
						$("#pageCount").val(result.pager.pageCount);
						showPager();
					}
					showDataList(result.dataList);		
				}else{
					showmsg(result.errmsg);
				}
			};
			ajaxQuery(url,'post','json',data,callback);
			//blockUI();
		}
		//查询列表
		function showDataList(datalist){
			var html='';
			var datalistdiv = $("#datalist");
			for(var i=0;i<datalist.length;i++){
				html+="<ul class='row'><li class='w20'>"+(i+1)+".</li><li class='w120'>"+datalist[i].staffType+"</li>"
					   +"<li class='w300'>"+datalist[i].productName+"</li>"					   
					   +"<li class='w120'>"+datalist[i].fee+"</li>"
					   +"<li class='w120'>"+datalist[i].flow+"</li>"
					   +"</ul>";
			}
			if(datalist.length<=0){
				html+="<ul class='row'><li class='w10'></li><li style='text-align:center;color:red;'>未查询到数据！<li></ul>"  ;
			}
			datalistdiv.html(html);
		}
		//分页查询
		function showPager(){
			var pageNumber = $("#pageNumber").val();
			var pageCount = $("#pageCount").val();
			$("#pager").pager({
					pagenumber : pageNumber,
					pagecount : pageCount,
					buttonClickCallback : function(pnumber) {
					$("#pageNumber").val(pnumber);
					query();
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
		//查询产品信息
		function loadProductList(){	
			var url=context_path+'/admin/product_queryProduct.do';			
			var data={state:'P'};			
			var callback=function(result){
				if(result.msg){
					showProductList(result.productList);
				}else{
					showmsg(result.errmsg);
				}
			};	
			ajaxQuery(url,'post','json',data,callback);	
		}
		function showProductList(datalist){
			var html="<option value=0>--请选择产品--</option>";
			var inputHtml="";
			var productId = $("#product_id");
			for(var i=0;i<datalist.length;i++){			
				html+="<option value="+datalist[i].PRODUCT_ID+">"+datalist[i].PRODUCT_NAME+"</option>";				
			}					
			productId.html(html);	
		}