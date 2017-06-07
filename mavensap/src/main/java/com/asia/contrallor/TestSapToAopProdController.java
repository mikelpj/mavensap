package com.asia.contrallor;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asia.service.TradeService;
import com.asia.util.EparchyCodeLocalUtil;
import com.asia.util.HttpCall;
import com.asia.util.HttpConf;
import com.asia.util.HttpUtils;

@Controller
public class TestSapToAopProdController {
	
	@Autowired
	private TradeService tradeService;
	
	private static final Logger logger = Logger.getLogger(TestSapToAopProdController.class);
	

	@RequestMapping("/newUserOpen")
	public void newUserOpen(HttpServletRequest request,HttpServletResponse response){
		String sapInterFaceUrl = HttpConf.getInterfaceUrl("sapInterFaceUrl")+"/loginsap/newEssUserOpenAction.do?pic1=1111";
		//String url = "http://127.0.0.1:8080/hnsap/loginsap/newEssUserOpenAction.do?pic1=1111";
		//String url = "http://133.160.98.46:8108/hnsap/loginsap/newEssUserOpenAction.do?pic1=1111";//准生产测试环境
		String opeSysType ="1";//1 ESS 2CBSS
		String serialNumber="18638242694";
		String[] firstMonBillModeArray = {"01","02","03"};//首月资费模式  01：标准资费（免首月月租）  02：全月套餐  03：套餐减半		
		/***
		 * 写一个接口去查亚丽妹在库里配置的产品信息，封装成jsonArray的入参，放到参数表里，进行解压
		 * 比如一个主产品，下面需要传两个附加产品，循环去调用 
		 */
			String beginDate = tradeService.getSysdate();
			/**先查测试用例，根据用例返回产品配置*/
			List<Map<String,Object>> caseList = tradeService.selectCaseList();
			for(int j=0;j<caseList.size();j++){
				Map<String,Object> caseMap = caseList.get(j);
				String caseId = (String)caseMap.get("CASE_ID");
				String eparchyCode = (String)caseMap.get("EPARCHY_CODE");
				String flag = (String)caseMap.get("FLAG");
				
				//封装好产品信息
				JSONObject userProdJson = autoPutProdJsonArray(caseId,"0");
				//封装好员工信息
				JSONObject staffInfoJson = autoPutStaffInfo(eparchyCode);
				//调用接口
				for(int i=0;i<firstMonBillModeArray.length;i++){				
					JSONObject ret = newUserOpenCase(serialNumber,userProdJson,staffInfoJson,firstMonBillModeArray[i],sapInterFaceUrl,opeSysType);
					String httpcode = (String)ret.get("httpcode");
			        String msgFlag = (String)ret.get("msgFlag");
			        JSONObject requestContent = (JSONObject)ret.get("requestContent");		        
			        //调用结果分析 0是调接口成功 1、2是不成功
			        if("1".equals(msgFlag)||"2".equals(msgFlag)){
			        	String errMsg = (String)ret.get("errmsg");
			        	tradeService.saveTestResult(userProdJson, staffInfoJson, requestContent.toString(), errMsg, "1",caseId,httpcode,firstMonBillModeArray[i]);
			        }else{
			        	JSONObject result = (JSONObject)ret.get("resultJson");
			        	tradeService.saveTestResult(userProdJson, staffInfoJson, requestContent.toString(), result.toString(), "0",caseId,httpcode,firstMonBillModeArray[i]);
			        	
			        	//调订单回滚接口
			        	String cbssSubscribeId = (String)result.get("provOrderId");
			        	String sapSubscribeId = (String)result.get("ordersId");
			        	try{
				        	this.cancelSubTrade(staffInfoJson, cbssSubscribeId, sapSubscribeId, opeSysType);
			        	}catch(Exception e){
			        		e.printStackTrace();
			        	}
			        }			        
					if("1".equals(flag)){
						break;
					}
				}
				String endDate = tradeService.getSysdate();
				//记录调一次用例用多久
				tradeService.insertCsCaseResult(caseId, beginDate, endDate);
				//更新case表
				tradeService.updateCase(caseId);
			}
		
			
			JSONObject newjsonObject = new JSONObject();
			newjsonObject.put("result", "OK");
			try{
				HttpUtils.jsonOutPrint(newjsonObject, request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
			
	}
	/**
	 * 产品自动封装
	 * @param caseId
	 * @return
	 */
	public  JSONObject autoPutProdJsonArray(String caseId,String productSource){
		
		JSONArray productJsonArray = new JSONArray();
		JSONArray activityJsonArray = new JSONArray();
		JSONObject userJson = new JSONObject();
		
		List<Map<String,Object>> prodList = tradeService.selectProdList(caseId, productSource);
		for(int i=0;i<prodList.size();i++){
			Map prodMap = prodList.get(i);
			String productId = (String)prodMap.get("PRODUCT_ID");
			String productMode = (String)prodMap.get("PRODUCT_MODE");
			JSONObject productJson = new JSONObject();
					
			//50是活动
			if("50".equals(productMode)){				
				productJson.put("actPlanId", productId);
				JSONArray elementJsonArray = this.autoPutPkeElement(productId);
				if(elementJsonArray.size()>0){
					productJson.put("packageElement", elementJsonArray);
				}
				activityJsonArray.add(productJson);
			}else{
				productJson.put("productId", productId);
				String pMode="";
				if("00".equals(productMode)){
					pMode ="1";//1主产品 2附加产品
				}
				if("01".equals(productMode)){
					pMode ="2";
				}
				productJson.put("productMode", pMode);
				JSONArray elementJsonArray = this.autoPutPkeElement(productId);
				if(elementJsonArray.size()>0){
					productJson.put("packageElement", elementJsonArray);
				}
				productJsonArray.add(productJson);
			}
		}
		if(activityJsonArray.size()>0){
			userJson.put("activityInfo", activityJsonArray);//封装活动信息
		}
		if(productJsonArray.size()>0){
			userJson.put("product", productJsonArray);//封装产品信息
		}
		return userJson;		
	}	
	/**
	 * 元素信息自动封包
	 * @param productId
	 * @return
	 */
	public JSONArray autoPutPkeElement(String productId){
		List<Map<String,Object>> elementList = tradeService.selectElementList(productId);
		
		JSONArray elementJsonArray = new JSONArray();
		
		for(int i=0;i<elementList.size();i++){
			Map elementMap = elementList.get(i);
			String packageId =  (String)elementMap.get("PACKAGE_ID");
			String elementId =  (String)elementMap.get("ELEMENT_ID");
			String elementType =  (String)elementMap.get("ELEMENT_TYPE");
			JSONObject elementJson = new JSONObject();
			elementJson.put("packageId", packageId);
			elementJson.put("elementId",elementId );
			elementJson.put("elementType", elementType);	
			elementJsonArray.add(elementJson);
		}	
		return elementJsonArray;
	}
	/**
	 * 员工信息封装
	 * @return
	 */
	public JSONObject autoPutStaffInfo(String eparchyCode){
		Map<String,Object> staffMap = tradeService.selectStaffInfo(eparchyCode);

		String staffId = (String)staffMap.get("STAFF_ID");
		String cityCode = (String)staffMap.get("CITY_CODE");
		String departId = (String)staffMap.get("DEPART_ID");
		String departKindCode = (String)staffMap.get("DEPART_KIND_CODE");
		
		JSONObject inJson = new JSONObject();
	
		inJson.put("operatorId", staffId);
		inJson.put("province", "76");
		inJson.put("city", EparchyCodeLocalUtil.getCityByEparchyCode(eparchyCode));
		inJson.put("district", cityCode);
		inJson.put("channelId", departId);
		inJson.put("channelType", departKindCode);
		
		return inJson;
	}
	
	public JSONObject newUserOpenCase(String serialNumber,JSONObject prodJson,JSONObject staffJson,String firstMonBillMode,String url
			,String opeSysType){
		
		JSONObject userOpenJson = new JSONObject();
		
		/**
		userOpenJson.put("operatorId", "ha-wangli11");
		userOpenJson.put("province", "76");
		userOpenJson.put("city", "760");
		userOpenJson.put("district", "766480");
		userOpenJson.put("channelId", "76b1x9d");
		userOpenJson.put("channelType", "1010300");
		*/
		userOpenJson = staffJson;
		
		userOpenJson.put("opeSysType",opeSysType);//办理业务系统 1 ESS 2 CBSS
		userOpenJson.put("deductionTag", "1");
		userOpenJson.put("delayTag", "0");
		
		/**号码资料节点 numId 父节点msg*/
		JSONObject numIdJson = new JSONObject();			
		numIdJson.put("serialNumber", serialNumber);//号码    18638016641
		numIdJson.put("proKey", "1");//资源预占关键字
		
		
		//靓号信息节点niceInfo 父节点numId
		
		JSONObject niceInfoJsonInput = new JSONObject();
		niceInfoJsonInput.put("advancePay", "690");//预存话费金额 必填
		niceInfoJsonInput.put("classId", "6");//号码等级：1,2,3,4,5,6 是1到6级靓号 9是普通号码 号码查询接口有返回,前台传过来
		//numIdJson.put("niceInfo", niceInfoJsonInput);			
		
		userOpenJson.put("numId", numIdJson);
				
		//卡资料信息节点simCardNo  父节点msg 测试支不支持成卡
		/**
		JSONObject simCardNoJsonInput = new JSONObject();
		simCardNoJsonInput.put("simId", "8986011460760029682");	
		//simCardNoJsonInput.put("cardType", "4");//白卡数据类型
		userOpenJson.put("simCardNo", simCardNoJsonInput);
		*/
		
		JSONObject customerInfoJsonInput = new JSONObject();
		customerInfoJsonInput.put("authTag", "0");
		customerInfoJsonInput.put("realNameType", "0");
		customerInfoJsonInput.put("custType", "0");//新老客户标识 0新增客户 1老客户
		customerInfoJsonInput.put("custId", "");//上面的custType为0的话，这为空 110106231144
		/**新客户信息节点newCustomerInfo  父节点customerInfo*/
		JSONObject newCustomerInfoJsonInput =new JSONObject();
			
		newCustomerInfoJsonInput.put("certType","02");
		newCustomerInfoJsonInput.put("certNum", "412824198506217717");
		newCustomerInfoJsonInput.put("certAdress", "郑州市金水区东明路2号院1号楼20号");
		newCustomerInfoJsonInput.put("customerName", "李平");
		//newCustomerInfoJsonInput.put("certExpireDate", "20190122");
		newCustomerInfoJsonInput.put("certExpireDate", "2050");
		newCustomerInfoJsonInput.put("contactPerson", "朱雪霖");
		//newCustomerInfoJsonInput.put("contactPhone", "13607664736");
		newCustomerInfoJsonInput.put("contactPhone", "18638020707");
		newCustomerInfoJsonInput.put("contactAddress", "河南省项城市范集乡朱庄村");
		newCustomerInfoJsonInput.put("custType", "01");//客户类型 01 个人客户 02集团客户
			/**客户备注节点customerRemark 父节点newCustomerInfo*/
			JSONObject customerRemarkJsonInput = new JSONObject();
			customerRemarkJsonInput.put("customerRemarkId","");
			customerRemarkJsonInput.put("customerRemarkValue","");			
		newCustomerInfoJsonInput.put("customerRemark", customerRemarkJsonInput);						
		customerInfoJsonInput.put("newCustomerInfo", newCustomerInfoJsonInput);			
		userOpenJson.put("customerInfo",customerInfoJsonInput);
		
		/**账户信息节点 acctInfo 父节点msg*/
		JSONObject acctInfoJsonInput = new JSONObject();	
		acctInfoJsonInput.put("createOrExtendsAcct","1");//1继承老账户
		acctInfoJsonInput.put("accountPayType", "10");		
		acctInfoJsonInput.put("accId", "7979992");//加合账号码
		userOpenJson.put("acctInfo", acctInfoJsonInput);
		
		/**用户信息节点userInfo 父节点msg*/
		JSONObject userInfoJsonInput= new JSONObject();
		userInfoJsonInput.put("userType","1");//用户类型 1新用户2老用户
		userInfoJsonInput.put("bipType","1");//业务类型： 1：号卡类业务  2：合约类业务  3：上网卡  4：上网本  5：其它配件类  6：自备机合约类业务 目前是用1,2,6三种
		userInfoJsonInput.put("is3G","1");//0-2G 1-3G 2-4G 若没值就传1 
		userInfoJsonInput.put("serType","1");//受理类型  1：后付费   2：预付费  3：准预付费 填2
		userInfoJsonInput.put("packageTag","0");//套包销售标记  0：非套包销售  1：套包销售 默认填0
		userInfoJsonInput.put("firstMonBillMode", firstMonBillMode);//首月资费模式  01：标准资费（免首月月租）  02：全月套餐  03：套餐减半
		userInfoJsonInput.put("checkType", "2");//认证类型：01：本地认证02：公安认证03：二代证读卡器
		
		/**产品节点product 父节点userInfo*/
		/** 注掉,用下面两行封装好的
		JSONArray productJsonArrayInput = new JSONArray();
		JSONObject productJsonInput = new JSONObject();
		productJsonInput.put("productId",productId);//亚丽妹给的产品ID     88150200 --生产  99124755 --测试   88150200 
		productJsonInput.put("productMode","1");
		productJsonArrayInput.add(productJsonInput);
		userInfoJsonInput.put("product", productJsonArrayInput);						
		JSONObject activityInfoJsonInput = new JSONObject();
		activityInfoJsonInput.put("actPlanId", "10445477");//合约套餐编码  String(8)	
		JSONObject actParaJsonInput = new JSONObject();
		actParaJsonInput.put("actParaId","");
		actParaJsonInput.put("actParaValue","");
		activityInfoJsonInput.put("actPara", actParaJsonInput);							
		userInfoJsonInput.put("activityInfo", activityInfoJsonInput);
		*/
		userInfoJsonInput.put("product", (JSONArray)prodJson.get("product"));
		userInfoJsonInput.put("activityInfo", (JSONArray)prodJson.get("activityInfo"));

		
		//加入集团收入归集群
		/**
		userInfoJsonInput.put("groupFlag","1");
		userInfoJsonInput.put("groupId", "7676076648002015338");
		userInfoJsonInput.put("cBssGroupId","760GSV009845" );
		userInfoJsonInput.put("appType","" );
		userInfoJsonInput.put("subAppType","" );
		userInfoJsonInput.put("guarantorType","" );
		userInfoJsonInput.put("guCertType","" );
		userInfoJsonInput.put("guCertNum","" );
		*/
		
		userOpenJson.put("recomPersonId","ha-wangli11");//发展员工
		userOpenJson.put("recomPersonName", "王丽");//发展人名称
		
		/**支付信息payInfo 父节点userInfo*/
		JSONObject payInfoJsonInput = new JSONObject();
		payInfoJsonInput.put("payType","10");
		userInfoJsonInput.put("payInfo", payInfoJsonInput);
		
		userOpenJson.put("userInfo", userInfoJsonInput);//msg->下面子节点是userInfo-->下面子节点是product,activityInfo,payInfo-->下面子节点是packageElement

		/**resourcesInfo 父节点msg 先不填
		JSONObject resourcesInfoJsonInput = new JSONObject();
		//套包对应产品活动信息productActivityInfo 父节点resourcesInfo
		JSONObject productActivityInfoJsonInput = new JSONObject();
		productActivityInfoJsonInput.put("productId","111111");	
		resourcesInfoJsonInput.put("productActivityInfo", productActivityInfoJsonInput);
		
		resourcesInfoJsonInput.put("salePrice", "");
		resourcesInfoJsonInput.put("cost", "");
		resourcesInfoJsonInput.put("cardPrice", "");
		resourcesInfoJsonInput.put("reservaPrice","" );		
		resourcesInfoJsonInput.put("resourcesBrandCode", "");
		resourcesInfoJsonInput.put("orgDeviceBrandCode", "");
		resourcesInfoJsonInput.put("resourcesBrandName", "");
		resourcesInfoJsonInput.put("resourcesModelCode", "");
		resourcesInfoJsonInput.put("resourcesModelName", "");
		resourcesInfoJsonInput.put("resourcesSrcCode", "");
		resourcesInfoJsonInput.put("resourcesSrcName", "");
		resourcesInfoJsonInput.put("resourcesSupplyCorp","" );
		resourcesInfoJsonInput.put("resourcesServiceCorp", "");
		resourcesInfoJsonInput.put("resourcesColor", "");
		resourcesInfoJsonInput.put("machineTypeCode","" );
		resourcesInfoJsonInput.put("machineTypeName", "");
		resourcesInfoJsonInput.put("distributionTag", "");
		resourcesInfoJsonInput.put("resRele", "");
		resourcesInfoJsonInput.put("terminalType", "");
		resourcesInfoJsonInput.put("terminalTSubType", "");
		resourcesInfoJsonInput.put("serviceNumber", "");		
		userOpenJson.put("resourcesInfo", resourcesInfoJsonInput);
		
*/	
        String[] param = {"1234567891",// apptx不超过30位的唯一请求流水号可以包含数字字母,
            new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),// timestamp
            "ai.cuc.ll.method.loginFilter",// method
            "ai.cuc.ll.appkey.sap",// appkey上线前需要确认
            userOpenJson.toString()// msg,json格式报文体
        };

        // 第一个参数：需要加密的参数，第二个参数：加密方式，第三个参数：密钥（上线需要和修改）
        HttpCall httpcall = new HttpCall();
        Map ret = httpcall.execute(url, param, "88888888");
        

        System.out.println("rescode=" + ret.get("resultJson"));
       
        JSONObject retJson = JSONObject.fromObject(ret);
        retJson.put("requestContent", userOpenJson);
        return retJson;
		
		
		
		//System.out.println("resultinfo=" + ret.get("resultJson"));
	}
	 
	//订单回退
	 public void cancelSubTrade(JSONObject staffJson,String cbssSubscribeId,String sapSubscribeId,String opeSysType)throws Exception{
		 
		 
		 try{
			 
			 String operatorId = (String)staffJson.get("operatorId");
			 String province = (String)staffJson.get("province");
			 String city = (String)staffJson.get("city");
			 String district = (String)staffJson.get("district");
			 String channelId = (String)staffJson.get("channelId");
			 String channelType = (String)staffJson.get("channelType");
  	
			 JSONObject cancelSubJson = new JSONObject();
			 cancelSubJson.put("operatorId",operatorId);
			 cancelSubJson.put("province", province);
			 cancelSubJson.put("city",city);
			 cancelSubJson.put("district", district);
			 cancelSubJson.put("channelId",channelId);
			 cancelSubJson.put("channelType",channelType);
			 cancelSubJson.put("provOrderId", cbssSubscribeId);//ESS订单交易流水
			 cancelSubJson.put("ordersId", sapSubscribeId);//预受理系统订单ID
				 
			 String sapInterFaceUrl = HttpConf.getInterfaceUrl("sapInterFaceUrl")+"/otherServ/cancelSub.do";
	
			 String[] param = {"1234567891",// apptx不超过30位的唯一请求流水号可以包含数字字母,
			             new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),// timestamp
			             "ai.cuc.ll.method.loginFilter",// method
			             "ai.cuc.ll.appkey.sap",// appkey上线前需要确认
			             cancelSubJson.toString()// msg,json格式报文体
			         };
	
			       // 第一个参数：需要加密的参数，第二个参数：加密方式，第三个参数：密钥（上线需要和修改）
			 HttpCall httpcall = new HttpCall();
			 Map ret = httpcall.execute(sapInterFaceUrl, param, "88888888");
			 String provOrderId = "";
			 String essOrderId="";
			       if(!ret.get("msgFlag").equals("")&&ret.get("msgFlag").equals("0")){			    	   			    	  
			    	   JSONObject resultJson = (JSONObject)ret.get("resultJson");
			    	   provOrderId = (String)resultJson.get("provOrderId");	
			    	   essOrderId = (String)resultJson.get("essOrderId");	
			       }		       
			       if(!ret.get("msgFlag").equals("")&&ret.get("msgFlag").equals("1")){
			    	   JSONObject resultJson = (JSONObject)ret.get("resultJson");			    	   
			    	   String code = (String)resultJson.get("code");		    	   
			    	   String errMsg = (String)ret.get("errmsg");			    	
			       }
			       if(!ret.get("msgFlag").equals("")&&ret.get("msgFlag").equals("2")){
			    	   String errMsg = (String)ret.get("errmsg");			    	 
			       }
		    	}catch(Exception e){
		    		e.printStackTrace();
		    	}
	 }

	

}
