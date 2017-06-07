package com.asia.test;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.asia.util.HttpCall;


public class TestNewUserOpen {
	public static void main(String str[]) throws Exception {

		// String url = "http://localhost:8080/uflow/api.do";
		// 测试环境
		//String url = "http://133.160.98.26:8098/hnsap/loginsap/newUserOpenAction.do";
		String url ="http://localhost:8080/hnsap/loginsap/newUserOpenAction.do";//登录
		
		
		/******************** 1.1 接收前台参数,解析入参,并封装入参给SAP接口调用 **************************************/
		//twoThreeToFourOpenAction();
		//viceUserOpen();
		 //newUserOpen();
		//newUserOpenZsc();
		newEssUserOpen();
		//queryPhoneMessage();
		//newCustGroupUserOpen();//集团开户 纯集客，客户ID也是集客的测试
		//newPersonCustGroupUserOpen();//集团开户 客户ID是公众客户 ，目的是加收入归集群
		//newEssCustGroupUserOpen();//集团ESS开户
		//getTaskPhoto();
		//openTakePhotoAskToApp();
		//jPushTest();
	}
	
	
	/**
	 * 准生产环境测试 压单
	 */
	public  static void newUserOpenZsc(){
		/**测试压单子订单号：7602017020923598 
		 * CBSS订单号：7617020957204079 
		 * 压单的是在写卡提交后，把tf_b_trade表里的next_deal_tag改为H，ti_b_iom里不放数据
		 * 正常不压单订单在正式提交之后会在ti_b_iom表里放一条数据，写完卡之后把主订单表的next_deal_tag改为9
		 * 
		 * 准生产压单测试成功号码：17538717934
		 * 
		*/
		//String url = "http://133.160.98.26:8098/hnsap/loginsap/newUserOpenAction.do?pic1=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";
		//String url = "http://127.0.0.1:8080/hnsap/loginsap/newUserOpenAction.do?pic1='1111'";
		// String url = "http://127.0.0.1:8080/hnsap/loginsap/newUserOpenAction.do?pic1=/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAB+AGYDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDv6KKKACiiue1PxTDZStHGqyFeuSRQBt3V3DaQtLPIqKvqa5m+8aQxMVt0z6ZrjdY8QzX11KwY7H6AnpWM0pJoKSO+g8dOrYnjUj/Z4rZsvF2n3Eio7lS3TI4FeThvepY5ApBBwRQFj3CKWOZN8Th1PcU+vLtI8TXdgcLIGRh0YZxXoul6lDqdos0Lf7y9waBWLlFFFAgooooAKKKKAMLxXq39m6cVQMZJeARxgeua8tu7qS6fkde1d18SLkJa2tuAd7MWz7CuT0bTzdN5rj5R0pSaSNIpNFGLTppTwhq2NDmxkqa6+1tUQDAq/wCUpXBrLnNOU4BtHcdAary6bLH/AAk16A9queKgktUweKOdhyo8/VWQ8riul8J6vJY38cYbMUrBXX+VSX+mRSZ2jBrn2je0u9u4qQeGHUValclqx7XRVTSrj7VpltPjG+MGrdWYhRRRQAUUUUAcD8SkLXdj6bG/mKj0SHbZjNa3j21WW3s5tuWWTaT7H/69UY4zHbhFOKymzaBehkQEDcv51bxkcEH6VmR2dsY9zNl/XNWLcGA7UkLA+pzioSNWWih9KrTlUB3Mo+pqaWV9vXGaoS29tKczuCT6mnZCRC7K3Qg1zesxf6RurfkgSKT9y2FHaqGrwhog/TmmtBSR2vhGYzeHbTK42Ls/Ktms/Qbc2ui2kRTYwjG4e9aFbHMwooooAKKKKAOZ8RTSzO9s8YEYKlT1J5zmqgjMke0cE961fEEPzxygdeCapWw5GawludEXoZ0ukLLGyyZyTncDzVy3tliUbRtAwABWiY9w9qglIVwuRQO42flVFZ11psdxICyng54OM+1X7n5AGyPzqWDEsYZaSGY4sWjckfKvoOlR3kQkAXAI3A4IrcnGEIIrLkA3UwTN7QbqaYyxytuVACvFbNZGgQlYpJjn5jgfhWvW0djCfxBRRRTICiiigCvfQfabV48ZbHy/WucTMb7W4IOCK6uud1eIxXpY/dfkVnNdTSD6EiSnbjNUb2LzeA5XIwcU9ZMJmqc11NvwiD6k1mbxjcWa1OARK7beOTV+0IjiAzzWS1xdDqi4Hv1qza3JccjBFA5RsXLuSqcED3M6xoCST+VOnkya1/DsGIpJyPvHA/CqSuzJ+6rmrBCsEKxoMACpKKK2MAooooAKKKKACsvxBGv2ISn7yMMfjWhPcRW0RkmdUQdya5S78QDVpJbWCErDGfmdj9704/CplsXBO5Ak5xgGpNu/k1QcNC+QOKmS9Xy8N1rnOhXJimRjORSZ8sYAxUIuUznNMnutxwtMrUfJNlq7WyhWC0ijToFBrg0Ut8zVrWXi0Q3Atb2LCDgSLyT+FaQdjKom1odbRTYpEmjWSNgyMMgjvTq1OcKKKKACoLu8gs4jJPIFHb1P0qv/AGiS7sISsCKSZH4/IVxmpahJf3LSuxI6KOwFaRhcdiTWNUk1OYnJEQ4RP6/WnaZZiGIFRgvy3uaywSGzXRaZIk0ABPzDrU1oW2NosV7dX61Ul08E8CtYrg0pGa5LFpmEdPI7mnpY45xWx5fNDpgUD5jLMOBjFZd/br5ys3Va35QsaFmOBWBdzGWZj2HStqUW3czkzotB11IYltrs4QcI/p7GuoUhlBU5B715gjN0rrfDl8x094nlQPG3y7z2NdM4dUZNHR0VXguS8YMq7W/2fmB+hFFYknndzqFxeXUlzPKyA8BM8AVCJY8Z8xcfWpjGrYB6UohUcDgVoqluh6n1KPcrPOipkZPuBmr2nXIRFkQ8nrmo/JUqV7VEbNJVKk4xUym5aFww0YvudLDdpMOD83erAJFcVA0tpKBHKxA7Gun025e5iDP1rFwe5y1IpSsjQ3Gml1LqhYAscDmmuxCk1z15cSS3ByxG08EUoxTJUObRHS6hb2cFm63U0ayEZUMRn8K4cGUNjO4Z9KuG2DsZpHZ3bqzcmnJEqqcVqny7HVDCr7RXyw69KduJA21IBkUoUCrVRjlhIGlY69e2NuIUCOg6bwTj8jRVJOlFLm8jP6pHuf/Z";
		 String url = "http://133.160.98.46:8108/hnsap/loginsap/newUserOpenAction.do?pic1=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";

		JSONObject userOpenJson = new JSONObject();
			
		userOpenJson.put("operatorId", "ha-suzhen5");
		userOpenJson.put("province", "76");
		userOpenJson.put("city", "760");
		userOpenJson.put("district", "766480");
		userOpenJson.put("channelId", "76a1652");
		userOpenJson.put("channelType", "1030100");
		
//		String pic = "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";
//		
//		pic = pic.replaceAll("=", "\\\\u003d");
		userOpenJson.put("pic1", "1");
//		userOpenJson.put("pic2", pic);
//		userOpenJson.put("pic3", pic);
		
		userOpenJson.put("opeSysType", "2");//办理业务系统
		userOpenJson.put("deductionTag", "1");
		userOpenJson.put("delayTag", "1");//是否压单标识 0 不压单 1 压单
		
		/**号码资料节点 numId 父节点msg*/
		JSONObject numIdJson = new JSONObject();			
		numIdJson.put("serialNumber", "18530914894");//号码
		numIdJson.put("proKey", "1");//资源预占关键字
		
		
		/**靓号信息节点niceInfo 父节点numId
		
		JSONObject niceInfoJsonInput = new JSONObject();
		niceInfoJsonInput.put("advancePay", "80000");//预存话费金额 必填
		niceInfoJsonInput.put("classId", "8");//号码等级：1,2,3,4,5,6 是1到6级靓号 9是普通号码 号码查询接口有返回,前台传过来
		numIdJson.put("niceInfo", niceInfoJsonInput);		
		*/
		
		userOpenJson.put("numId", numIdJson);
				
		//卡资料信息节点simCardNo  父节点msg 测试支不支持成卡
		/**
		JSONObject simCardNoJsonInput = new JSONObject();
		simCardNoJsonInput.put("simId", "8986021550828154210");	
		//simCardNoJsonInput.put("cardType", "4");//白卡数据类型
		userOpenJson.put("simCardNo", simCardNoJsonInput);
		*/
		
		JSONObject customerInfoJsonInput = new JSONObject();
		customerInfoJsonInput.put("authTag", "0");
		customerInfoJsonInput.put("realNameType", "0");
		customerInfoJsonInput.put("custType", "1");//新老客户标识 0新增客户 1老客户
		customerInfoJsonInput.put("custId", "7617012443390551");//上面的custType为0的话，这为空
		/**新客户信息节点newCustomerInfo  父节点customerInfo*/
		JSONObject newCustomerInfoJsonInput =new JSONObject();
			
		newCustomerInfoJsonInput.put("certType","12");
		newCustomerInfoJsonInput.put("certNum", "410781199009303635");
		newCustomerInfoJsonInput.put("certAdress", "河南省卫辉市后河镇关帝庙村新范大街２９号");
		newCustomerInfoJsonInput.put("customerName", "赵志朋");
		//newCustomerInfoJsonInput.put("certExpireDate", "20250518");
		newCustomerInfoJsonInput.put("certExpireDate", null);
		newCustomerInfoJsonInput.put("contactPerson", "赵志朋");
		//newCustomerInfoJsonInput.put("contactPhone", "18530232104");
		newCustomerInfoJsonInput.put("contactPhone", null);
		newCustomerInfoJsonInput.put("contactAddress", "河南省卫辉市后河镇关帝庙村新范大街２９号");
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
		acctInfoJsonInput.put("createOrExtendsAcct","0");//是否继承老账户
		acctInfoJsonInput.put("accountPayType", "10");		
		userOpenJson.put("acctInfo", acctInfoJsonInput);
		
		/**用户信息节点userInfo 父节点msg*/
		JSONObject userInfoJsonInput= new JSONObject();
		userInfoJsonInput.put("userType","2");//用户类型 1新用户2老用户
		userInfoJsonInput.put("bipType","1");//业务类型： 1：号卡类业务  2：合约类业务  3：上网卡  4：上网本  5：其它配件类  6：自备机合约类业务 目前是用1,2,6三种
		userInfoJsonInput.put("is3G","2");//0-2G 1-3G 2-4G 若没值就传1 
		userInfoJsonInput.put("serType","1");//受理类型  1：后付费   2：预付费  3：准预付费 填2
		userInfoJsonInput.put("packageTag","0");//套包销售标记  0：非套包销售  1：套包销售 默认填0
		userInfoJsonInput.put("firstMonBillMode", "02");//首月资费模式  01：标准资费（免首月月租）  02：全月套餐  03：套餐减半
		userInfoJsonInput.put("checkType", "2");//认证类型：01：本地认证02：公安认证03：二代证读卡器
		
		/**产品节点product 父节点userInfo*/
		JSONArray productJsonArrayInput = new JSONArray();

		JSONObject productJsonInput = new JSONObject();
		productJsonInput.put("productId","89950166");//亚丽妹给的产品ID
		productJsonInput.put("productMode","1");
				
		JSONObject productJsonInput2 = new JSONObject();
		productJsonInput2.put("productId","89026083");//亚丽妹给的产品ID
		productJsonInput2.put("productMode","2");
		
		JSONArray packageElementJsonArray = new JSONArray();
		JSONObject packageElemetJson1 = new JSONObject();
		JSONObject packageElemetJson2 = new JSONObject();
		packageElemetJson1.put("elementId", "8102714");
		packageElemetJson1.put("packageId", "51716924");
		packageElemetJson1.put("elementType", "D");
		packageElemetJson2.put("elementId", "8102783");
		packageElemetJson2.put("packageId", "51716924");
		packageElemetJson2.put("elementType", "D");
		
		packageElementJsonArray.add(packageElemetJson1);
		packageElementJsonArray.add(packageElemetJson2);
		
		//productJsonInput.put("packageElement", packageElementJsonArray);
		
		productJsonArrayInput.add(productJsonInput);
		//productJsonArrayInput.add(productJsonInput2);
		
		userInfoJsonInput.put("product", productJsonArrayInput);				
		/**开户时活动信息activityInfo 父节点userInfo*/
		JSONObject activityInfoJsonInput = new JSONObject();
		activityInfoJsonInput.put("actPlanId", "89950118");//合约套餐编码  String(8)
		/**活动扩展字段actPara 父节点activityInfo*/
		JSONObject actParaJsonInput = new JSONObject();
		//actParaJsonInput.put("actParaId","");
		//actParaJsonInput.put("actParaValue","");
		//activityInfoJsonInput.put("actPara", actParaJsonInput);					
		
		userInfoJsonInput.put("activityInfo", activityInfoJsonInput);
		
		//加入集团收入归集群		
		userInfoJsonInput.put("groupFlag","1");
		//select a.*, rowid from ucr_crm3.tf_f_user a where a.remove_tag = '0' and a.eparchy_code = '0371' and a.net_type_code = 'WV' and a.brand_code = 'XNJT' and a.in_date > sysdate - 30;
		//这里填的是上面语名里的根据cust_id去查tf_f_cust_group里的group_id 
		userInfoJsonInput.put("groupId", "7676000000000307188");
		userInfoJsonInput.put("cBssGroupId","" );
		userInfoJsonInput.put("appType","" );
		userInfoJsonInput.put("subAppType","" );
		userInfoJsonInput.put("guarantorType","" );
		userInfoJsonInput.put("guCertType","" );
		userInfoJsonInput.put("guCertNum","" );
		
		
		userOpenJson.put("recomPersonId","zhangwj196");//发展员工
		userOpenJson.put("recomPersonName", "张文娟");//发展人名称
		
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
		//System.out.println("resultinfo=" + ret.get("resultJson"));
	}
	
	//23转4测试
	public static void twoThreeToFourOpenAction(){
		 String url ="http://localhost:8080/hnsap/loginsap/twoThreeToFourOpenAction.do";//登录
			//String url ="http://133.160.98.26:8098/hnsap/loginsap/twoThreeToFourOpenAction.do";//登录
			/******************** 1.1 接收前台参数,解析入参,并封装入参给SAP接口调用 **************************************/
			JSONObject userOpenJson = new JSONObject();

			userOpenJson.put("operatorId", "miaoyu11");
			userOpenJson.put("province", "76");
			userOpenJson.put("city", "760");
			userOpenJson.put("district", "766480");
			userOpenJson.put("channelId", "76a3160");
			userOpenJson.put("channelType", "1010300");
			
			userOpenJson.put("opeSysType", "1");// 办理业务系统
			userOpenJson.put("deductionTag", "1");
			userOpenJson.put("delayTag", "0");

			/** 号码资料节点 numId 父节点msg */
			JSONArray numIdJsonArray = new JSONArray();
			JSONObject numIdJson = new JSONObject();
			numIdJson.put("serialNumber", "18539561440");// 号码
			numIdJson.put("proKey", "1");// 资源预占关键字
			numIdJsonArray.add(numIdJson);
			/**
			 * 靓号信息节点niceInfo 父节点numId
			 * 
			 * JSONObject niceInfoJsonInput = new JSONObject();
			 * niceInfoJsonInput.put("advancePay", "100");//预存话费金额 必填
			 * niceInfoJsonInput.put("classId", "9");//号码等级：1,2,3,4,5,6 是1到6级靓号
			 * 9是普通号码 号码查询接口有返回,前台传过来 numIdJson.put("niceInfo", niceInfoJsonInput);
			 */

			userOpenJson.put("numId", numIdJsonArray);

			/**
			 * 卡资料信息节点simCardNo 父节点msg JSONObject simCardNoJsonInput = new
			 * JSONObject(); simCardNoJsonInput.put("simId", "89860");
			 * userOpenJson.put("simCardNo", simCardNoJsonInput);
			 */
			JSONArray customerInfoJsonInputArray = new JSONArray();
			JSONObject customerInfoJsonInput = new JSONObject();
			customerInfoJsonInput.put("authTag", "0");
			customerInfoJsonInput.put("realNameType", "0");
			customerInfoJsonInput.put("custType", "1");// 新老客户标识 0新增客户 1老客户
			customerInfoJsonInput.put("custId", "113008715327");
			
			/** 新客户信息节点newCustomerInfo 父节点customerInfo */
			JSONArray newCustomerInfoJsonInputArray = new JSONArray();
			JSONObject newCustomerInfoJsonInput = new JSONObject();

			newCustomerInfoJsonInput.put("certType", "02");
			newCustomerInfoJsonInput.put("certNum", "412824198506217717");
			newCustomerInfoJsonInput.put("certAdress", "测试");
			newCustomerInfoJsonInput.put("customerName", "李平");
			newCustomerInfoJsonInput.put("certExpireDate", "20151112");
			newCustomerInfoJsonInput.put("contactPerson", "13697726927");
			newCustomerInfoJsonInput.put("contactPhone", "13697726927");
			newCustomerInfoJsonInput.put("contactAddress", "测试");
			newCustomerInfoJsonInput.put("custType", "01");// 客户类型 01 个人客户 02集团客户
			/** 客户备注节点customerRemark 父节点newCustomerInfo */
			JSONArray customerRemarkJsonInputArray = new JSONArray();
			JSONObject customerRemarkJsonInput = new JSONObject();
			customerRemarkJsonInput.put("customerRemarkId", "");
			customerRemarkJsonInput.put("customerRemarkValue", "");
			customerRemarkJsonInputArray.add(customerRemarkJsonInput);
			newCustomerInfoJsonInput.put("customerRemark", customerRemarkJsonInputArray);
			newCustomerInfoJsonInputArray.add(newCustomerInfoJsonInput);		
			customerInfoJsonInput.put("newCustomerInfo", newCustomerInfoJsonInputArray);			
			customerInfoJsonInputArray.add(customerInfoJsonInput);
			userOpenJson.put("customerInfo", customerInfoJsonInputArray);

			/** 账户信息节点 acctInfo 父节点msg */
			JSONArray acctInfoJsonInputArray = new JSONArray();
			JSONObject acctInfoJsonInput = new JSONObject();
			acctInfoJsonInput.put("createOrExtendsAcct", "0");
			acctInfoJsonInput.put("accountPayType", "10");
			acctInfoJsonInputArray.add(acctInfoJsonInput);
			//userOpenJson.put("acctInfo", acctInfoJsonInputArray);

			/** 用户信息节点userInfo 父节点msg */
			JSONArray userInfoJsonInputArray = new JSONArray();
			JSONObject userInfoJsonInput = new JSONObject();
			userInfoJsonInput.put("userType", "2");// 用户类型 1新用户2老用户
			userInfoJsonInput.put("bipType", "1");// 业务类型： 1：号卡类业务 2：合约类业务 3：上网卡
													// 4：上网本 5：其它配件类 6：自备机合约类业务
													// 目前是用1,2,6三种
			userInfoJsonInput.put("is3G", "1");// 0-2G 1-3G 2-4G 若没值就传1
			userInfoJsonInput.put("serType", "1");// 受理类型 1：后付费 2：预付费 3：准预付费 填2
			userInfoJsonInput.put("packageTag", "0");// 套包销售标记 0：非套包销售 1：套包销售 默认填0
			userInfoJsonInput.put("firstMonBillMode", "01");// 首月资费模式 01：标准资费（免首月月租）
															// 02：全月套餐 03：套餐减半
			userInfoJsonInput.put("checkType", "2");// 认证类型：01：本地认证02：公安认证03：二代证读卡器

			/** 产品节点product 父节点userInfo */
			JSONArray productJsonInputArray = new JSONArray();
			JSONObject productJsonInput = new JSONObject();
			productJsonInput.put("productId", "89016260");// 亚丽妹给的产品ID
			productJsonInput.put("productMode", "1");
			productJsonInputArray.add(productJsonInput);
			userInfoJsonInput.put("product", productJsonInputArray);
			/** 开户时活动信息activityInfo 父节点userInfo */
			JSONArray activityInfoJsonInputArray = new JSONArray();
			JSONObject activityInfoJsonInput = new JSONObject();
			//activityInfoJsonInput.put("actPlanId", "89000100");// 合约套餐编码 String(8)
			activityInfoJsonInput.put("actPlanId", "89000100");
			//activityInfoJsonInput.put("resourcesCode", "76MI3173515003");// 76MI3173515003
			//activityInfoJsonInput.put("resourcesFee", "149900");
			//activityInfoJsonInput.put("resourcesType", "03");
			activityInfoJsonInputArray.add(activityInfoJsonInput);
			userInfoJsonInput.put("activityInfo", activityInfoJsonInputArray);

			userOpenJson.put("recomPersonId", "miaoyu11");// 发展员工
			userOpenJson.put("recomPersonName", "miaoyu");// 发展人名称

			/** 支付信息payInfo 父节点userInfo */
			JSONObject payInfoJsonInput = new JSONObject();
			payInfoJsonInput.put("payType", "10");
			userInfoJsonInput.put("payInfo", payInfoJsonInput);
			
			userInfoJsonInputArray.add(userInfoJsonInput);
			userOpenJson.put("userInfo", userInfoJsonInputArray);// msg->下面子节点是userInfo-->下面子节点是product,activityInfo,payInfo-->下面子节点是packageElement

			String[] param = { "1234567891",// apptx不超过30位的唯一请求流水号可以包含数字字母,
					new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),// timestamp
					"ai.cuc.ll.method.loginFilter",// method
					"ai.cuc.ll.appkey.sap",// appkey上线前需要确认
					userOpenJson.toString() // msg,json格式报文体
			};

			// 第一个参数：需要加密的参数，第二个参数：加密方式，第三个参数：密钥（上线需要和修改）
			HttpCall httpcall = new HttpCall();
			Map ret = httpcall.execute(url, param, "88888888");

			System.out.println("rescode=" + ret.get("resultJson"));
			//System.out.println("resultinfo=" + ret.get("resultJson"));
	}
	//主附卡测试
	public static void viceUserOpen(){
		String url ="http://localhost:8080/hnsap/loginsap/viceUserOpenAction.do";//登录
		//String url = "http://133.160.98.26:8098/hnsap/loginsap/viceUserOpenAction.do";  
		/******************** 1.1 接收前台参数,解析入参,并封装入参给SAP接口调用 **************************************/
		JSONObject userOpenJson = new JSONObject();

		userOpenJson.put("operatorId", "miaoyu11");
		userOpenJson.put("province", "76");
		userOpenJson.put("city", "760");
		userOpenJson.put("district", "766480");
		userOpenJson.put("channelId", "76a3160");
		userOpenJson.put("channelType", "1010300");
		userOpenJson.put("eModeCode", "");
		userOpenJson.put("mainNumberTag", "0");	
		userOpenJson.put("firstMonBillMode", "01");
		/** 新客户信息节点newCustomerInfo 父节点customerInfo */
		JSONObject custInfoJson = new JSONObject();
		custInfoJson.put("custId", "31046804");
		custInfoJson.put("certType", "02");
		custInfoJson.put("certNum", "410105198503050131");
		custInfoJson.put("certAdress", "测试");
		custInfoJson.put("customerName", "赵晨");
		custInfoJson.put("sex", "0");
		custInfoJson.put("certExpireDate", "20151112");
		custInfoJson.put("contactPerson", "13697726927");
		custInfoJson.put("contactPhone", "13697726927");
		custInfoJson.put("contactAddress", "测试");
		custInfoJson.put("checkType", "01");// 01：本地认证 02：公安认证 03：二代证读卡器
		
		userOpenJson.put("custInfo", custInfoJson);
		
		userOpenJson.put("serialNumber", "17555670193");
		userOpenJson.put("mainNumber", "");//副卡开户时对应的主卡号码 
		userOpenJson.put("bipType", "1");
		userOpenJson.put("serType", "1");
		
		/**靓号信息节点niceInfo 父节点numId*/		  
		JSONObject niceInfoJsonInput = new JSONObject();
		niceInfoJsonInput.put("classId", "9");//号码等级：1,2,3,4,5,6 是1到6级靓号
		niceInfoJsonInput.put("advancePay", "100");//预存话费金额 必填
		userOpenJson.put("niceNumberInfo", niceInfoJsonInput);

		/** 产品节点product 父节点userInfo */
		JSONArray productJsonInputArray = new JSONArray();
		JSONObject productJsonInput = new JSONObject();
		productJsonInput.put("productId", "89016260");// 亚丽妹给的产品ID
		productJsonInput.put("productMode", "1");
		
		//附加产品
		JSONObject productFjJsonInput = new JSONObject();
		productFjJsonInput.put("productId", "89128069");//亚丽妹给的产品ID
		productFjJsonInput.put("productMode", "2");
		
		JSONArray packageElementJsonArray=new JSONArray();
		JSONObject packageElementJson = new JSONObject();
		packageElementJson.put("packageId", "51218896");
		packageElementJson.put("elementId", "20119785");
		packageElementJson.put("elementType", "D");
		
		JSONObject packageElementJson1 = new JSONObject();
		packageElementJson1.put("packageId", "51184969");
		packageElementJson1.put("elementId", "5994300");
		packageElementJson1.put("elementType", "D");
		
		JSONObject packageElementJson2 = new JSONObject();
		packageElementJson2.put("packageId", "51184969");
		packageElementJson2.put("elementId", "5994301");
		packageElementJson2.put("elementType", "D");
		
		
		packageElementJsonArray.add(packageElementJson);
		packageElementJsonArray.add(packageElementJson1);
		productFjJsonInput.put("packageElement", packageElementJsonArray);
		
		productJsonInputArray.add(productJsonInput);
		productJsonInputArray.add(productFjJsonInput);
		userOpenJson.put("productInfo", productJsonInputArray);
		/** 开户时活动信息activityInfo 父节点userInfo */
		JSONObject activityInfoJsonInput = new JSONObject();
		//89000100--存费送费的合约 89012393--购机合约
		//activityInfoJsonInput.put("actPlanId", "89000100");// 合约套餐编码 String(8)
		activityInfoJsonInput.put("actPlanId", "89012393");
		activityInfoJsonInput.put("resourcesCode", "76MI3173515004");// 76MI3173515003
		activityInfoJsonInput.put("resourcesFee", "149900");
		activityInfoJsonInput.put("resourcesType", "03");
		userOpenJson.put("activityInfo", activityInfoJsonInput);
		
		/** 账户信息节点 acctInfo 父节点msg */
		JSONObject acctInfoJsonInput = new JSONObject();
		acctInfoJsonInput.put("createOrExtendsAcct", "0");
		acctInfoJsonInput.put("accountPayType", "10");
		userOpenJson.put("acctInfo", acctInfoJsonInput);
		
		/**发展人信息*/
		JSONObject recomInfoJsonInput = new JSONObject();
		recomInfoJsonInput.put("recomPersonId", "miaoyu11");// 发展员工
		recomInfoJsonInput.put("recomPersonName", "miaoyu");// 发展人名称
		userOpenJson.put("recomInfo", recomInfoJsonInput);
	
		userOpenJson.put("phoneSpeedLevel", "1");//速率
		userOpenJson.put("delayTag", "0");//
		
	
		String[] param = { "1234567891",// apptx不超过30位的唯一请求流水号可以包含数字字母,
				new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),// timestamp
				"ai.cuc.ll.method.loginFilter",// method
				"ai.cuc.ll.appkey.sap",// appkey上线前需要确认
				userOpenJson.toString() // msg,json格式报文体
		};

		// 第一个参数：需要加密的参数，第二个参数：加密方式，第三个参数：密钥（上线需要和修改）
		HttpCall httpcall = new HttpCall();
		Map ret = httpcall.execute(url, param, "88888888");

		System.out.println("rescode=" + ret.get("resultJson"));
		//System.out.println("resultinfo=" + ret.get("resultJson"));
	}
	public  static void newUserOpen(){
		/**测试压单子订单号：7602017020923598 
		 * CBSS订单号：7617020957204079 
		 * 压单的是在写卡提交后，把tf_b_trade表里的next_deal_tag改为H，ti_b_iom里不放数据
		 * 正常不压单订单在正式提交之后会在ti_b_iom表里放一条数据，写完卡之后把主订单表的next_deal_tag改为9
		 * 
		*/
		//String url = "http://133.160.98.26:8098/hnsap/loginsap/newUserOpenAction.do?pic1=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";
		//String url = "http://127.0.0.1:8080/hnsap/loginsap/newUserOpenAction.do?pic1='1111'";
		 String url = "http://127.0.0.1:8080/hnsap/loginsap/newUserOpenAction.do?pic1=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";
		//String url = "http://133.160.98.46:8108/hnsap/loginsap/newUserOpenAction.do?pic1=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";

		JSONObject userOpenJson = new JSONObject();
			
		userOpenJson.put("operatorId", "miaoyu11");
		userOpenJson.put("province", "76");
		userOpenJson.put("city", "760");
		userOpenJson.put("district", "766480");
		userOpenJson.put("channelId", "76a3160");
		userOpenJson.put("channelType", "1010300");
		
//		String pic = "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";
//		
//		pic = pic.replaceAll("=", "\\\\u003d");
//		userOpenJson.put("pic1", "1");
//		userOpenJson.put("pic2", pic);
//		userOpenJson.put("pic3", pic);
		
		userOpenJson.put("opeSysType", "2");//办理业务系统
		userOpenJson.put("deductionTag", "1");
		userOpenJson.put("delayTag", "0");
		
		/**号码资料节点 numId 父节点msg*/
		JSONObject numIdJson = new JSONObject();			
		numIdJson.put("serialNumber", "18503818445");//号码
		numIdJson.put("proKey", "1");//资源预占关键字
		
		
		/**靓号信息节点niceInfo 父节点numId*/
		
		JSONObject niceInfoJsonInput = new JSONObject();
		niceInfoJsonInput.put("advancePay", "228000");//预存话费金额 必填
		niceInfoJsonInput.put("classId", "6");//号码等级：1,2,3,4,5,6 是1到6级靓号 9是普通号码 号码查询接口有返回,前台传过来
		niceInfoJsonInput.put("lowCostPro", "76000");
		numIdJson.put("niceInfo", niceInfoJsonInput);	
		/***/
		
		userOpenJson.put("numId", numIdJson);
				
		//卡资料信息节点simCardNo  父节点msg 测试支不支持成卡
		/**
		JSONObject simCardNoJsonInput = new JSONObject();
		simCardNoJsonInput.put("simId", "8986021550828154210");	
		//simCardNoJsonInput.put("cardType", "4");//白卡数据类型
		userOpenJson.put("simCardNo", simCardNoJsonInput);
		*/
		
		JSONObject customerInfoJsonInput = new JSONObject();
		customerInfoJsonInput.put("authTag", "0");
		customerInfoJsonInput.put("realNameType", "0");
		customerInfoJsonInput.put("custType", "1");//新老客户标识 0新增客户 1老客户
		customerInfoJsonInput.put("custId", "2116122114433617");//上面的custType为0的话，这为空
		/**新客户信息节点newCustomerInfo  父节点customerInfo*/
		JSONObject newCustomerInfoJsonInput =new JSONObject();
			
		newCustomerInfoJsonInput.put("certType","12");
		newCustomerInfoJsonInput.put("certNum", "410781199009303635");
		newCustomerInfoJsonInput.put("certAdress", "河南省卫辉市后河镇关帝庙村新范大街２９号");
		newCustomerInfoJsonInput.put("customerName", "赵志朋");
		//newCustomerInfoJsonInput.put("certExpireDate", "20250518");
		newCustomerInfoJsonInput.put("certExpireDate", null);
		newCustomerInfoJsonInput.put("contactPerson", "赵志朋");
		//newCustomerInfoJsonInput.put("contactPhone", "18530232104");
		newCustomerInfoJsonInput.put("contactPhone", null);
		newCustomerInfoJsonInput.put("contactAddress", "河南省卫辉市后河镇关帝庙村新范大街２９号");
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
		acctInfoJsonInput.put("createOrExtendsAcct","0");//是否继承老账户
		acctInfoJsonInput.put("accountPayType", "10");		
		userOpenJson.put("acctInfo", acctInfoJsonInput);
		
		/**用户信息节点userInfo 父节点msg*/
		JSONObject userInfoJsonInput= new JSONObject();
		userInfoJsonInput.put("userType","2");//用户类型 1新用户2老用户
		userInfoJsonInput.put("bipType","1");//业务类型： 1：号卡类业务  2：合约类业务  3：上网卡  4：上网本  5：其它配件类  6：自备机合约类业务 目前是用1,2,6三种
		userInfoJsonInput.put("is3G","2");//0-2G 1-3G 2-4G 若没值就传1 
		userInfoJsonInput.put("serType","1");//受理类型  1：后付费   2：预付费  3：准预付费 填2
		userInfoJsonInput.put("packageTag","0");//套包销售标记  0：非套包销售  1：套包销售 默认填0
		userInfoJsonInput.put("firstMonBillMode", "02");//首月资费模式  01：标准资费（免首月月租）  02：全月套餐  03：套餐减半
		userInfoJsonInput.put("checkType", "2");//认证类型：01：本地认证02：公安认证03：二代证读卡器
		
		/**产品节点product 父节点userInfo*/
		JSONArray productJsonArrayInput = new JSONArray();

		JSONObject productJsonInput = new JSONObject();
		productJsonInput.put("productId","89950166");//亚丽妹给的产品ID
		productJsonInput.put("productMode","1");
		productJsonArrayInput.add(productJsonInput);
		userInfoJsonInput.put("product", productJsonArrayInput);				
		/**开户时活动信息activityInfo 父节点userInfo*/
		JSONObject activityInfoJsonInput = new JSONObject();
		activityInfoJsonInput.put("actPlanId", "89000100");//合约套餐编码  String(8)
		/**活动扩展字段actPara 父节点activityInfo*/
		JSONObject actParaJsonInput = new JSONObject();
		//actParaJsonInput.put("actParaId","");
		//actParaJsonInput.put("actParaValue","");
		//activityInfoJsonInput.put("actPara", actParaJsonInput);					
		
		//userInfoJsonInput.put("activityInfo", activityInfoJsonInput);
		
		//加入集团收入归集群		
		userInfoJsonInput.put("groupFlag","0");
		//select a.*, rowid from ucr_crm3.tf_f_user a where a.remove_tag = '0' and a.eparchy_code = '0371' and a.net_type_code = 'WV' and a.brand_code = 'XNJT' and a.in_date > sysdate - 30;
		//这里填的是上面语名里的根据cust_id去查tf_f_cust_group里的group_id 
		//userInfoJsonInput.put("groupId", "7676076648003010504");
		userInfoJsonInput.put("cBssGroupId","" );
		userInfoJsonInput.put("appType","" );
		userInfoJsonInput.put("subAppType","" );
		userInfoJsonInput.put("guarantorType","" );
		userInfoJsonInput.put("guCertType","" );
		userInfoJsonInput.put("guCertNum","" );
		
		
		userOpenJson.put("recomPersonId","7600844696");//发展员工
		userOpenJson.put("recomPersonName", "高胜利");//发展人名称
		
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
		//System.out.println("resultinfo=" + ret.get("resultJson"));
	}
	
	public  static void newEssUserOpen(){
		String url = "http://133.160.98.26:8098/hnsap/loginsap/newEssUserOpenAction.do?pic1=1111";
		//String url = "http://127.0.0.1:8080/hnsap/loginsap/newEssUserOpenAction.do?pic1=1111";
		//String url = "http://133.160.98.46:8108/hnsap/loginsap/newEssUserOpenAction.do?pic1=1111";//准生产测试环境
		JSONObject userOpenJson = new JSONObject();
			
		userOpenJson.put("operatorId", "miaoyu11");
		userOpenJson.put("province", "76");
		userOpenJson.put("city", "760");
		userOpenJson.put("district", "766480");
		userOpenJson.put("channelId", "76a3160");
		userOpenJson.put("channelType", "1010300");
		
		
		userOpenJson.put("opeSysType", "1");//办理业务系统 1 ESS 2 CBSS
		userOpenJson.put("deductionTag", "1");
		userOpenJson.put("delayTag", "0");
		
		/**号码资料节点 numId 父节点msg*/
		JSONObject numIdJson = new JSONObject();			
		numIdJson.put("serialNumber", "18638242694");//号码    18638016641
		numIdJson.put("proKey", "1");//资源预占关键字
		
		
		//靓号信息节点niceInfo 父节点numId
		
		JSONObject niceInfoJsonInput = new JSONObject();
		niceInfoJsonInput.put("advancePay", "690");//预存话费金额 必填
		niceInfoJsonInput.put("classId", "6");//号码等级：1,2,3,4,5,6 是1到6级靓号 9是普通号码 号码查询接口有返回,前台传过来
		numIdJson.put("niceInfo", niceInfoJsonInput);		
		
		
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
		userInfoJsonInput.put("firstMonBillMode", "01");//首月资费模式  01：标准资费（免首月月租）  02：全月套餐  03：套餐减半
		userInfoJsonInput.put("checkType", "2");//认证类型：01：本地认证02：公安认证03：二代证读卡器
		
		/**产品节点product 父节点userInfo*/
		JSONArray productJsonArrayInput = new JSONArray();

		JSONObject productJsonInput = new JSONObject();
		productJsonInput.put("productId","88150200");//亚丽妹给的产品ID     88150200 --生产  99124755 --测试   88150200 
		productJsonInput.put("productMode","1");
		productJsonArrayInput.add(productJsonInput);
		userInfoJsonInput.put("product", productJsonArrayInput);				
		/**开户时活动信息activityInfo 父节点userInfo*/
		JSONObject activityInfoJsonInput = new JSONObject();
		activityInfoJsonInput.put("actPlanId", "10445477");//合约套餐编码  String(8)
		/**活动扩展字段actPara 父节点activityInfo*/
		JSONObject actParaJsonInput = new JSONObject();
		//actParaJsonInput.put("actParaId","");
		//actParaJsonInput.put("actParaValue","");
		//activityInfoJsonInput.put("actPara", actParaJsonInput);					
		
		//userInfoJsonInput.put("activityInfo", activityInfoJsonInput);
		
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
		
		userOpenJson.put("recomPersonId","miaoyu11");//发展员工
		userOpenJson.put("recomPersonName", "miaoyu");//发展人名称
		
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
		
		userOpenJson.put("xinYiCardFlag", "1");
		userOpenJson.put("mainSerialNumber", "13083719876");
		userOpenJson.put("mainUserId", "8830002");
		userOpenJson.put("mainAcctId", "7979992");
		userOpenJson.put("mainCustId", "7964817");
		userOpenJson.put("mainRoleCode", "1");
		userOpenJson.put("viceRoleCode", "2");
		userOpenJson.put("isChengKa", "0");
		userOpenJson.put("isExisComp", "0");
		
		JSONObject mixObject = new JSONObject();
		mixObject.put("xnSerialNumber", "");
		mixObject.put("xnUserId", "");
		mixObject.put("xnRoleCode", "0");
		
		JSONObject xnProductInfo = new JSONObject();		
		xnProductInfo.put("productId", "50001044");
		xnProductInfo.put("productMode", "0");		
		xnProductInfo.put("xnSerialNumber", "");
		mixObject.put("xnProductInfo",xnProductInfo);
		
		userOpenJson.put("mixTemplate", mixObject);
		userOpenJson.put("relationTypeCode", "10");
	
		
		
		
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
		//System.out.println("resultinfo=" + ret.get("resultJson"));
	}
	public static void openTakePhotoAskToApp(){
		//String url = "http://133.160.98.26:8098/hnsap/loginsap/openTakePhotoAskToApp.do";
		String url = "http://127.0.0.1:8080/hnsap/loginsap/takePhotoAskAction.do";
		//String url = "http://133.160.98.26:8108/hnsap/loginsap/openTakePhotoAskToApp.do";//准生产测试环境
		JSONObject userOpenJson = new JSONObject();
		
		userOpenJson.put("operatorId", "miaoyu11");
		userOpenJson.put("province", "76");
		userOpenJson.put("city", "760");
		userOpenJson.put("district", "766480");
		userOpenJson.put("channelId", "76a3160");
		userOpenJson.put("channelType", "1010300");
		userOpenJson.put("serialNumber", "18638020707");
		userOpenJson.put("certType", "02");
		userOpenJson.put("certNum", "412824198506217717");
		userOpenJson.put("certName", "李平");
		
		 String[] param = {"1234567891",// apptx不超过30位的唯一请求流水号可以包含数字字母,
		            new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),// timestamp
		            "ai.cuc.ll.method.loginFilter",// method
		            "ai.cuc.ll.appkey.sap",// appkey上线前需要确认
		            userOpenJson.toString()// msg,json格式报文体
		        };

		        // 第一个参数：需要加密的参数，第二个参数：加密方式，第三个参数：密钥（上线需要和修改）
		        HttpCall httpcall = new HttpCall();
		        Map ret = httpcall.execute(url, param, "88888888");
		        
		    	System.out.println("rescode=" + ret.get("tfSapPhoneMessage"));
		
	}
	public static void queryPhoneMessage(){
		
		//String url = "http://133.160.98.26:8098/hnsap/loginsap/queryPhoneMessage.do";
		//String url = "http://127.0.0.1:8080/hnsap/loginsap/queryPhoneMessage.do";
		String url = "http://localhost:8080/hnsap/loginsap/queryPhoneMessage.do";
		//String url = "http://133.160.98.26:8108/hnsap/loginsap/queryPhoneMessage.do";//准生产测试环境
		JSONObject userOpenJson = new JSONObject();
			
		userOpenJson.put("operatorId", "miaoyu11");
		userOpenJson.put("province", "76");
		userOpenJson.put("city", "760");
		userOpenJson.put("district", "766480");
		userOpenJson.put("channelId", "76a3160");
		userOpenJson.put("channelType", "1010300");
		//userOpenJson.put("serialNumber", "18638020707");
		userOpenJson.put("currentPage", "3");
		userOpenJson.put("pageSize", "3");
		
		  String[] param = {"1234567891",// apptx不超过30位的唯一请求流水号可以包含数字字母,
		            new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),// timestamp
		            "ai.cuc.ll.method.loginFilter",// method
		            "ai.cuc.ll.appkey.sap",// appkey上线前需要确认
		            userOpenJson.toString()// msg,json格式报文体
		        };

		        // 第一个参数：需要加密的参数，第二个参数：加密方式，第三个参数：密钥（上线需要和修改）
		        HttpCall httpcall = new HttpCall();
		        Map ret = httpcall.execute(url, param, "88888888");
		        
		    	System.out.println("rescode=" + ret.get("tfSapPhoneMessage"));
	}
	
	public static void getTaskPhoto(){
		String url = "http://133.160.98.26:8098/hnsap/loginsap/getTaskPhoto.do";
		//String url = "http://127.0.0.1:8080/hnsap/loginsap/getTaskPhoto.do";
		//String url = "http://133.160.98.26:8108/hnsap/loginsap/getTaskPhoto.do";//准生产测试环境
		JSONObject userOpenJson = new JSONObject();
			
		userOpenJson.put("transIdo", "3");
		userOpenJson.put("city", "760");
			
		String[] param = {"1234567891",// apptx不超过30位的唯一请求流水号可以包含数字字母,
		            new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),// timestamp
		            "ai.cuc.ll.method.loginFilter",// method
		            "ai.cuc.ll.appkey.sap",// appkey上线前需要确认
		            userOpenJson.toString()// msg,json格式报文体
		        };

		        // 第一个参数：需要加密的参数，第二个参数：加密方式，第三个参数：密钥（上线需要和修改）
		        HttpCall httpcall = new HttpCall();
		        Map ret = httpcall.execute(url, param, "88888888");
		        
		    	System.out.println("rescode=" + ret.get("tfSapPhoneMessage"));
	}
	
	/**
	 * 集团客户开户 cBSS
	 */
	public  static void newCustGroupUserOpen(){
		String url = "http://133.160.98.26:8098/hnsap/loginsap/newGroupUserOpenAction.do?pic1='1111'";
		//String url = "http://127.0.0.1:8080/hnsap/loginsap/newGroupUserOpenAction.do";
		JSONObject userOpenJson = new JSONObject();
			
		userOpenJson.put("operatorId", "miaoyu11");
		userOpenJson.put("province", "76");
		userOpenJson.put("city", "760");
		userOpenJson.put("district", "766480");
		userOpenJson.put("channelId", "76a3160");
		userOpenJson.put("channelType", "1010300");
		
//		String pic = "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";
//		
//		pic = pic.replaceAll("=", "\\\\u003d");
//		userOpenJson.put("pic1", pic);
//		userOpenJson.put("pic2", pic);
//		userOpenJson.put("pic3", pic);
		
		userOpenJson.put("opeSysType", "2");//办理业务系统
		userOpenJson.put("deductionTag", "1");
		userOpenJson.put("delayTag", "0");
		
		/**号码资料节点 numId 父节点msg*/
		JSONObject numIdJson = new JSONObject();			
		numIdJson.put("serialNumber", "18569975244");//号码
		numIdJson.put("proKey", "1");//资源预占关键字
		
		
		/**靓号信息节点niceInfo 父节点numId
		
		JSONObject niceInfoJsonInput = new JSONObject();
		niceInfoJsonInput.put("advancePay", "80000");//预存话费金额 必填
		niceInfoJsonInput.put("classId", "8");//号码等级：1,2,3,4,5,6 是1到6级靓号 9是普通号码 号码查询接口有返回,前台传过来
		numIdJson.put("niceInfo", niceInfoJsonInput);		
		*/
		
		userOpenJson.put("numId", numIdJson);
				
		//卡资料信息节点simCardNo  父节点msg 测试支不支持成卡
		/**
		JSONObject simCardNoJsonInput = new JSONObject();
		simCardNoJsonInput.put("simId", "8986021550828154210");	
		//simCardNoJsonInput.put("cardType", "4");//白卡数据类型
		userOpenJson.put("simCardNo", simCardNoJsonInput);
		*/
		
		JSONObject customerInfoJsonInput = new JSONObject();
		customerInfoJsonInput.put("authTag", "0");
		customerInfoJsonInput.put("realNameType", "0");
		//custType='0'的做成功一笔，预受理流水号是：7602016121721538
		//测试一笔custType="1"老客户的，custId看在集团那生效不“7616110911961322” 预受理流水号：7602016121721539
		//这个是有收入归集群的集客
		customerInfoJsonInput.put("custType", "1");//新老客户标识 0新增客户 1老客户
		customerInfoJsonInput.put("custId", "7616120511973193");//上面的custType为0的话，这为空
		
		//没有收入归集群的集客
		//customerInfoJsonInput.put("custType", "1");//新老客户标识 0新增客户 1老客户
		//customerInfoJsonInput.put("custId", "99393190701");//上面的custType为0的话，这为空
		
		
		/**新客户信息节点newCustomerInfo 经测试，这个地方为必填 父节点customerInfo*/
		JSONObject newCustomerInfoJsonInput =new JSONObject();
			
		newCustomerInfoJsonInput.put("certType","07");
		newCustomerInfoJsonInput.put("certNum", "EWRREGF4R45G4G45G4RG4R");
		newCustomerInfoJsonInput.put("certAdress", "111");
		newCustomerInfoJsonInput.put("customerName", "河南收入归集12月5号");
		newCustomerInfoJsonInput.put("certExpireDate", "20250518");
		newCustomerInfoJsonInput.put("contactPerson", "");
		newCustomerInfoJsonInput.put("contactPhone", "");
		newCustomerInfoJsonInput.put("contactAddress", "");
		newCustomerInfoJsonInput.put("custType", "02");//客户类型 01 个人客户 02集团客户
			/**客户备注节点customerRemark 父节点newCustomerInfo*/
			JSONObject customerRemarkJsonInput = new JSONObject();
			customerRemarkJsonInput.put("customerRemarkId","");
			customerRemarkJsonInput.put("customerRemarkValue","");			
		newCustomerInfoJsonInput.put("customerRemark", customerRemarkJsonInput);
		customerInfoJsonInput.put("newCustomerInfo", newCustomerInfoJsonInput);			
		
		userOpenJson.put("customerInfo",customerInfoJsonInput);
		
		/**账户信息节点 acctInfo 父节点msg*/
		/**说明一下： 这个合账号码，若是选的别的收入归集群，也是可以把别的收入归集群下面的账号当成主账号*/
		JSONObject acctInfoJsonInput = new JSONObject();	
		acctInfoJsonInput.put("createOrExtendsAcct","1");//填1，测试下能继承老账户不能
		acctInfoJsonInput.put("accountPayType", "10");
		acctInfoJsonInput.put("debutySn", "");
		//测试 能随便查账户不能
		acctInfoJsonInput.put("accId", "7616061319440397");

		userOpenJson.put("acctInfo", acctInfoJsonInput);
		
		/**用户信息节点userInfo 父节点msg*/
		JSONObject userInfoJsonInput= new JSONObject();
		userInfoJsonInput.put("userType","1");//用户类型 1新用户2老用户
		userInfoJsonInput.put("bipType","1");//业务类型： 1：号卡类业务  2：合约类业务  3：上网卡  4：上网本  5：其它配件类  6：自备机合约类业务 目前是用1,2,6三种
		userInfoJsonInput.put("is3G","2");//0-2G 1-3G 2-4G 若没值就传1 
		userInfoJsonInput.put("serType","1");//受理类型  1：后付费   2：预付费  3：准预付费 填2
		userInfoJsonInput.put("packageTag","0");//套包销售标记  0：非套包销售  1：套包销售 默认填0
		userInfoJsonInput.put("firstMonBillMode", "02");//首月资费模式  01：标准资费（免首月月租）  02：全月套餐  03：套餐减半
		userInfoJsonInput.put("checkType", "2");//认证类型：01：本地认证02：公安认证03：二代证读卡器
		
		/**产品节点product 父节点userInfo*/
		JSONArray productJsonArrayInput = new JSONArray();

		JSONObject productJsonInput = new JSONObject();
		productJsonInput.put("productId","89950166");//亚丽妹给的产品ID
		productJsonInput.put("productMode","1");
		productJsonArrayInput.add(productJsonInput);
		
		JSONObject productJsonInput2 = new JSONObject();
		productJsonInput2.put("productId", "89016237");
		productJsonInput2.put("productMode", "2");
		JSONArray packageElementJsonArray = new JSONArray();
		JSONObject packageElementJsonObject = new JSONObject();
		packageElementJsonObject.put("packageId", "51016979");
		packageElementJsonObject.put("elementId", "5992130");
		packageElementJsonObject.put("elementType", "D");
		packageElementJsonArray.add(packageElementJsonObject);
		productJsonInput2.put("packageElement", packageElementJsonArray);
		
		productJsonArrayInput.add(productJsonInput2);
		
		
		userInfoJsonInput.put("product", productJsonArrayInput);				
		/**开户时活动信息activityInfo 父节点userInfo*/
		JSONObject activityInfoJsonInput = new JSONObject();
		activityInfoJsonInput.put("actPlanId", "89000100");//合约套餐编码  String(8)
		/**活动扩展字段actPara 父节点activityInfo*/
		JSONObject actParaJsonInput = new JSONObject();
		//actParaJsonInput.put("actParaId","");
		//actParaJsonInput.put("actParaValue","");
		//activityInfoJsonInput.put("actPara", actParaJsonInput);					
		
		//userInfoJsonInput.put("activityInfo", activityInfoJsonInput);
		
		//加入集团收入归集群 groupFlag必须填1，不写1，relation_uu表里不会生成数据
		userInfoJsonInput.put("groupFlag","1");
		//select a.*, rowid from ucr_crm3.tf_f_user a where a.remove_tag = '0' and a.eparchy_code = '0371' and a.net_type_code = 'WV' and a.brand_code = 'XNJT' and a.in_date > sysdate - 30;
		//这里填的是上面语名里的根据cust_id去查tf_f_cust_group里的group_id 7676076648003010504肯定能过 查了下，测试环境就这个能过
		//tf_f_cust_groupmember
		userInfoJsonInput.put("groupId", "7676000000000307006");//这里传收入归集的群号
		userInfoJsonInput.put("cBssGroupId","" );//这里传收入归集号码
		userInfoJsonInput.put("appType","" );
		userInfoJsonInput.put("subAppType","" );
		userInfoJsonInput.put("guarantorType","" );
		userInfoJsonInput.put("guCertType","" );
		userInfoJsonInput.put("guCertNum","" );
		
		
		userOpenJson.put("recomPersonId","7600844696");//发展员工
		userOpenJson.put("recomPersonName", "高胜利");//发展人名称
		
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
		JSONObject useCustInfoJsonInput = new JSONObject();

		useCustInfoJsonInput.put("useCustName", "孙爱玲");//责任人姓名
		useCustInfoJsonInput.put("useCustPsptType", "02");//证件类型
		useCustInfoJsonInput.put("useCustPsptCode", "412829199206253245");//证件号码
		useCustInfoJsonInput.put("useCustPsptAddress", "郑州市金水区明路");//证件地址
		useCustInfoJsonInput.put("itmPrdGroupType", "");
		useCustInfoJsonInput.put("itmPrdRespobsible", "");
		userOpenJson.put("useCustInfo", useCustInfoJsonInput);				
		
		
		
		
		
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
		//System.out.println("resultinfo=" + ret.get("resultJson"));
	}
	/**
	 * 集团客户开户
	 */
	public  static void newPersonCustGroupUserOpen(){
		String url = "http://133.160.98.26:8098/hnsap/loginsap/newGroupUserOpenAction.do";
		//String url = "http://127.0.0.1:8080/hnsap/loginsap/newGroupUserOpenAction.do";
		JSONObject userOpenJson = new JSONObject();
			
		userOpenJson.put("operatorId", "miaoyu11");
		userOpenJson.put("province", "76");
		userOpenJson.put("city", "760");
		userOpenJson.put("district", "766480");
		userOpenJson.put("channelId", "76a3160");
		userOpenJson.put("channelType", "1010300");
		
//		String pic = "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";
//		
//		pic = pic.replaceAll("=", "\\\\u003d");
//		userOpenJson.put("pic1", pic);
//		userOpenJson.put("pic2", pic);
//		userOpenJson.put("pic3", pic);
		
		userOpenJson.put("opeSysType", "2");//办理业务系统
		userOpenJson.put("deductionTag", "1");
		userOpenJson.put("delayTag", "0");
		
		/**号码资料节点 numId 父节点msg*/
		JSONObject numIdJson = new JSONObject();			
		numIdJson.put("serialNumber", "18638242642");//号码
		numIdJson.put("proKey", "1");//资源预占关键字
		
		
		/**靓号信息节点niceInfo 父节点numId
		
		JSONObject niceInfoJsonInput = new JSONObject();
		niceInfoJsonInput.put("advancePay", "80000");//预存话费金额 必填
		niceInfoJsonInput.put("classId", "8");//号码等级：1,2,3,4,5,6 是1到6级靓号 9是普通号码 号码查询接口有返回,前台传过来
		numIdJson.put("niceInfo", niceInfoJsonInput);		
		*/
		
		userOpenJson.put("numId", numIdJson);
				
		//卡资料信息节点simCardNo  父节点msg 测试支不支持成卡
		/**
		JSONObject simCardNoJsonInput = new JSONObject();
		simCardNoJsonInput.put("simId", "8986021550828154210");	
		//simCardNoJsonInput.put("cardType", "4");//白卡数据类型
		userOpenJson.put("simCardNo", simCardNoJsonInput);
		*/
		
		JSONObject customerInfoJsonInput = new JSONObject();
		customerInfoJsonInput.put("authTag", "0");
		customerInfoJsonInput.put("realNameType", "0");
		
		//放一个公众客户custId=7614041421760402
		customerInfoJsonInput.put("custType", "1");//新老客户标识 0新增客户 1老客户
		customerInfoJsonInput.put("custId", "6930000");//上面的custType为0的话，这为空
		/**新客户信息节点newCustomerInfo 经测试，这个地方为必填 父节点customerInfo*/
		JSONObject newCustomerInfoJsonInput =new JSONObject();
			
		newCustomerInfoJsonInput.put("certType","02");
		newCustomerInfoJsonInput.put("certNum", "410124193509190019");
		newCustomerInfoJsonInput.put("certAdress", "");
		newCustomerInfoJsonInput.put("customerName", "张三");
		newCustomerInfoJsonInput.put("certExpireDate", "20250518");
		newCustomerInfoJsonInput.put("contactPerson", "");
		newCustomerInfoJsonInput.put("contactPhone", "");
		newCustomerInfoJsonInput.put("contactAddress", "");
		newCustomerInfoJsonInput.put("custType", "02");//客户类型 01 个人客户 02集团客户
			/**客户备注节点customerRemark 父节点newCustomerInfo*/
			JSONObject customerRemarkJsonInput = new JSONObject();
			customerRemarkJsonInput.put("customerRemarkId","");
			customerRemarkJsonInput.put("customerRemarkValue","");			
		newCustomerInfoJsonInput.put("customerRemark", customerRemarkJsonInput);						
		customerInfoJsonInput.put("newCustomerInfo", newCustomerInfoJsonInput);			
		userOpenJson.put("customerInfo",customerInfoJsonInput);
		
		/**账户信息节点 acctInfo 父节点msg*/
		JSONObject acctInfoJsonInput = new JSONObject();	
		acctInfoJsonInput.put("createOrExtendsAcct","0");
		acctInfoJsonInput.put("accountPayType", "10");		
		userOpenJson.put("acctInfo", acctInfoJsonInput);
		
		/**用户信息节点userInfo 父节点msg*/
		JSONObject userInfoJsonInput= new JSONObject();
		userInfoJsonInput.put("userType","1");//用户类型 1新用户2老用户
		userInfoJsonInput.put("bipType","1");//业务类型： 1：号卡类业务  2：合约类业务  3：上网卡  4：上网本  5：其它配件类  6：自备机合约类业务 目前是用1,2,6三种
		userInfoJsonInput.put("is3G","2");//0-2G 1-3G 2-4G 若没值就传1 
		userInfoJsonInput.put("serType","1");//受理类型  1：后付费   2：预付费  3：准预付费 填2
		userInfoJsonInput.put("packageTag","0");//套包销售标记  0：非套包销售  1：套包销售 默认填0
		userInfoJsonInput.put("firstMonBillMode", "02");//首月资费模式  01：标准资费（免首月月租）  02：全月套餐  03：套餐减半
		userInfoJsonInput.put("checkType", "2");//认证类型：01：本地认证02：公安认证03：二代证读卡器
		
		/**产品节点product 父节点userInfo*/
		JSONArray productJsonArrayInput = new JSONArray();

		JSONObject productJsonInput = new JSONObject();
		productJsonInput.put("productId","89950166");//亚丽妹给的产品ID
		productJsonInput.put("productMode","1");
		productJsonArrayInput.add(productJsonInput);
		
		JSONObject productJsonInput2 = new JSONObject();
		productJsonInput2.put("productId", "89016237");
		productJsonInput2.put("productMode", "2");
		JSONArray packageElementJsonArray = new JSONArray();
		JSONObject packageElementJsonObject = new JSONObject();
		packageElementJsonObject.put("packageId", "51016979");
		packageElementJsonObject.put("elementId", "5992130");
		packageElementJsonObject.put("elementType", "D");
		packageElementJsonArray.add(packageElementJsonObject);
		productJsonInput2.put("packageElement", packageElementJsonArray);
		
		productJsonArrayInput.add(productJsonInput2);
		
		
		userInfoJsonInput.put("product", productJsonArrayInput);				
		/**开户时活动信息activityInfo 父节点userInfo*/
		JSONObject activityInfoJsonInput = new JSONObject();
		activityInfoJsonInput.put("actPlanId", "89000100");//合约套餐编码  String(8)
		/**活动扩展字段actPara 父节点activityInfo*/
		JSONObject actParaJsonInput = new JSONObject();
		//actParaJsonInput.put("actParaId","");
		//actParaJsonInput.put("actParaValue","");
		//activityInfoJsonInput.put("actPara", actParaJsonInput);					
		
		//userInfoJsonInput.put("activityInfo", activityInfoJsonInput);
		
		//加入集团收入归集群 groupFlag必须填1，不写1，relation_uu表里不会生成数据
		userInfoJsonInput.put("groupFlag","1");
		//select a.*, rowid from ucr_crm3.tf_f_user a where a.remove_tag = '0' and a.eparchy_code = '0371' and a.net_type_code = 'WV' and a.brand_code = 'XNJT' and a.in_date > sysdate - 30;
		//这里填的是上面语名里的根据cust_id去查tf_f_cust_group里的group_id 7676076648003010504肯定能过 查了下，测试环境就这个能过
		//tf_f_cust_groupmember
		userInfoJsonInput.put("groupId", "7676076648003010504");
		userInfoJsonInput.put("cBssGroupId","" );
		userInfoJsonInput.put("appType","" );
		userInfoJsonInput.put("subAppType","" );
		userInfoJsonInput.put("guarantorType","" );
		userInfoJsonInput.put("guCertType","" );
		userInfoJsonInput.put("guCertNum","" );
		
		
		userOpenJson.put("recomPersonId","7600844696");//发展员工
		userOpenJson.put("recomPersonName", "高胜利");//发展人名称
		
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
		JSONObject useCustInfoJsonInput = new JSONObject();

		useCustInfoJsonInput.put("useCustName", "张三");//责任人姓名
		useCustInfoJsonInput.put("useCustPsptType", "02");//证件类型
		useCustInfoJsonInput.put("useCustPsptCode", "7614041021750418");//证件号码
		useCustInfoJsonInput.put("useCustPsptAddress", "郑州市金水区明路");//证件地址
		useCustInfoJsonInput.put("itmPrdGroupType", "");
		useCustInfoJsonInput.put("itmPrdRespobsible", "");
		userOpenJson.put("useCustInfo", useCustInfoJsonInput);				
		
		
		
		
		
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
		//System.out.println("resultinfo=" + ret.get("resultJson"));
	}
	public static void jPushTest(){
		try{
			
		String msgTitle="沃受理工单拍照提醒";
		String msgContent="18638020707需拍照,请处理,有效时间3分钟.";
		JSONObject inDataMap = new JSONObject();
		inDataMap.put("liusuihao", "1231412");
		inDataMap.put("transIdo", "123231");
		inDataMap.put("msgTitle", msgTitle);
		inDataMap.put("msgContent", msgContent);
		inDataMap.put("staffId", "miaoyu11");
		inDataMap.put("serialNumber", "18638021111");
		inDataMap.put("custName", "张三");
		inDataMap.put("certnum", "412824198506217717");
		
		/**调服务器推送*/
		//String url = HttpConf.getInterfaceUrl("androidJpushUrl");
		//String url = "http://127.0.0.1:8099/henan/sap/androidJpush.do";
		String url = "http://133.160.92.59:8099/henan/sap/androidJpush.do";
        String[] param = {"1234567891",// apptx不超过30位的唯一请求流水号可以包含数字字母,
            new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),// timestamp
            "ai.cuc.ll.method.androidJpush",// method
            "ai.cuc.ll.appkey.sap",// appkey上线前需要确认
            inDataMap.toString()// msg,json格式报文体
        };
        HttpCall httpcall = new HttpCall();
        // 第一个参数：需要加密的参数，第二个参数：加密方式，第三个参数：密钥（上线需要和修改）
        Map ret = httpcall.execute(url, param, "88888888");
        
        String phoneMsgFlag = (String)ret.get("msgFlag");
		if(phoneMsgFlag.equals("2222")){
			String errCode = (String)ret.get("errCode");
			//要是10，再调一次推送 不管成功失败，都插消息列表
			if("10".equals(errCode)){
				Map secondRet = httpcall.execute(url, param, "88888888");
				 if(secondRet.get("state").equals("0")){
					 String secondPhoneMsgFlag = (String)secondRet.get("msgFlag");
						if(secondPhoneMsgFlag.equals("2222")){
							String secondErrCode = (String)secondRet.get("errCode");
							if("1011".equals(secondErrCode)){
								System.out.println("请及时登录沃受理APP，进行拍照处理!");
								
							}
						}				
						//tradeService.savePhoneMessage(tfSapPhoneMessage);
				 }
				
			}else{
				//要是1011,让前台给营业员一提示，让登录工号，再点推送
				if("1011".equals(errCode)){
					System.out.println("请及时登录沃受理APP，进行拍照处理!");
					
				}
				
			}				
		}else{				
			System.out.println("phoneMsgFlag:"+phoneMsgFlag);
		}
        
	}catch(Exception e){
		e.printStackTrace();
	}
	}
	
	/**
	 * 集团客户开户 ess
	 */
	public  static void newEssCustGroupUserOpen(){
		String url = "http://133.160.98.26:8098/hnsap/loginsap/newGroupUserOpenAction.do?pic1=1111";
		//String url = "http://127.0.0.1:8080/hnsap/loginsap/newGroupUserOpenAction.do";
		JSONObject userOpenJson = new JSONObject();
			
		userOpenJson.put("operatorId", "miaoyu11");
		userOpenJson.put("province", "76");
		userOpenJson.put("city", "760");
		userOpenJson.put("district", "766480");
		userOpenJson.put("channelId", "76a3160");
		userOpenJson.put("channelType", "1010300");
		
//		String pic = "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";
//		
//		pic = pic.replaceAll("=", "\\\\u003d");
//		userOpenJson.put("pic1", pic);
//		userOpenJson.put("pic2", pic);
//		userOpenJson.put("pic3", pic);
		
		userOpenJson.put("opeSysType", "1");//办理业务系统 1 ESS
		userOpenJson.put("deductionTag", "1");
		userOpenJson.put("delayTag", "0");
		
		/**号码资料节点 numId 父节点msg*/
		JSONObject numIdJson = new JSONObject();			
		numIdJson.put("serialNumber", "18538582204");//号码
		numIdJson.put("proKey", "1");//资源预占关键字
		
		
		/**靓号信息节点niceInfo 父节点numId
		
		JSONObject niceInfoJsonInput = new JSONObject();
		niceInfoJsonInput.put("advancePay", "80000");//预存话费金额 必填
		niceInfoJsonInput.put("classId", "8");//号码等级：1,2,3,4,5,6 是1到6级靓号 9是普通号码 号码查询接口有返回,前台传过来
		numIdJson.put("niceInfo", niceInfoJsonInput);		
		*/
		
		userOpenJson.put("numId", numIdJson);
				
		//卡资料信息节点simCardNo  父节点msg 测试支不支持成卡
		/**
		JSONObject simCardNoJsonInput = new JSONObject();
		simCardNoJsonInput.put("simId", "8986021550828154210");	
		//simCardNoJsonInput.put("cardType", "4");//白卡数据类型
		userOpenJson.put("simCardNo", simCardNoJsonInput);
		*/
		
		JSONObject customerInfoJsonInput = new JSONObject();
		customerInfoJsonInput.put("authTag", "0");
		customerInfoJsonInput.put("realNameType", "0");
		//custType='0'的做成功一笔，预受理流水号是：7602016121721538
		//测试一笔custType="1"老客户的，custId看在集团那生效不“7616110911961322” 预受理流水号：7602016121721539
		customerInfoJsonInput.put("custType", "1");//新老客户标识 0新增客户 1老客户
		customerInfoJsonInput.put("custId", "113010409675");//上面的custType为0的话，这为空
		/**新客户信息节点newCustomerInfo 经测试，这个地方为必填 父节点customerInfo*/
		JSONObject newCustomerInfoJsonInput =new JSONObject();
			
		newCustomerInfoJsonInput.put("certType","07");
		newCustomerInfoJsonInput.put("certNum", "410000300000179");
		newCustomerInfoJsonInput.put("certAdress", "");
		newCustomerInfoJsonInput.put("customerName", "中国农业银行股份有限公司河南省分行");
		newCustomerInfoJsonInput.put("certExpireDate", "20250518");
		newCustomerInfoJsonInput.put("contactPerson", "");
		newCustomerInfoJsonInput.put("contactPhone", "");
		newCustomerInfoJsonInput.put("contactAddress", "");
		newCustomerInfoJsonInput.put("custType", "02");//客户类型 01 个人客户 02集团客户
			/**客户备注节点customerRemark 父节点newCustomerInfo*/
			JSONObject customerRemarkJsonInput = new JSONObject();
			customerRemarkJsonInput.put("customerRemarkId","");
			customerRemarkJsonInput.put("customerRemarkValue","");			
		newCustomerInfoJsonInput.put("customerRemark", customerRemarkJsonInput);						
		customerInfoJsonInput.put("newCustomerInfo", newCustomerInfoJsonInput);			
		userOpenJson.put("customerInfo",customerInfoJsonInput);
		
		/**账户信息节点 acctInfo 父节点msg*/
		JSONObject acctInfoJsonInput = new JSONObject();	
		acctInfoJsonInput.put("createOrExtendsAcct","1");//填1，测试下能继承老账户不能
		acctInfoJsonInput.put("accountPayType", "10");
		acctInfoJsonInput.put("debutySn", "");//填号码
		acctInfoJsonInput.put("accId", "7113041509493021");
		
		userOpenJson.put("acctInfo", acctInfoJsonInput);
		
		/**用户信息节点userInfo 父节点msg*/
		JSONObject userInfoJsonInput= new JSONObject();
		userInfoJsonInput.put("userType","1");//用户类型 1新用户2老用户
		userInfoJsonInput.put("bipType","1");//业务类型： 1：号卡类业务  2：合约类业务  3：上网卡  4：上网本  5：其它配件类  6：自备机合约类业务 目前是用1,2,6三种
		userInfoJsonInput.put("is3G","1");//0-2G 1-3G 2-4G 若没值就传1 
		userInfoJsonInput.put("serType","1");//受理类型  1：后付费   2：预付费  3：准预付费 填2
		userInfoJsonInput.put("packageTag","0");//套包销售标记  0：非套包销售  1：套包销售 默认填0
		userInfoJsonInput.put("firstMonBillMode", "02");//首月资费模式  01：标准资费（免首月月租）  02：全月套餐  03：套餐减半
		userInfoJsonInput.put("checkType", "2");//认证类型：01：本地认证02：公安认证03：二代证读卡器
		
		/**产品节点product 父节点userInfo*/
		JSONArray productJsonArrayInput = new JSONArray();

		JSONObject productJsonInput = new JSONObject();
		productJsonInput.put("productId","88150200");//亚丽妹给的产品ID
		productJsonInput.put("productMode","1");
		productJsonArrayInput.add(productJsonInput);
		

		userInfoJsonInput.put("product", productJsonArrayInput);				
		/**开户时活动信息activityInfo 父节点userInfo*/
		JSONObject activityInfoJsonInput = new JSONObject();
		activityInfoJsonInput.put("actPlanId", "89000100");//合约套餐编码  String(8)
		/**活动扩展字段actPara 父节点activityInfo*/
		JSONObject actParaJsonInput = new JSONObject();
		//actParaJsonInput.put("actParaId","");
		//actParaJsonInput.put("actParaValue","");
		//activityInfoJsonInput.put("actPara", actParaJsonInput);					
		
		//userInfoJsonInput.put("activityInfo", activityInfoJsonInput);
		
		//加入集团收入归集群 groupFlag必须填1，不写1，relation_uu表里不会生成数据
		userInfoJsonInput.put("groupFlag","1");
		//select a.*, rowid from ucr_crm3.tf_f_user a where a.remove_tag = '0' and a.eparchy_code = '0371' and a.net_type_code = 'WV' and a.brand_code = 'XNJT' and a.in_date > sysdate - 30;
		//这里填的是上面语名里的根据cust_id去查tf_f_cust_group里的group_id 7676076648003010504肯定能过 查了下，测试环境就这个能过
		//tf_f_cust_groupmember
		userInfoJsonInput.put("groupId", "7676000000000306829");
		userInfoJsonInput.put("cBssGroupId","" );
		userInfoJsonInput.put("appType","" );
		userInfoJsonInput.put("subAppType","" );
		userInfoJsonInput.put("guarantorType","" );
		userInfoJsonInput.put("guCertType","" );
		userInfoJsonInput.put("guCertNum","" );
		
		
		userOpenJson.put("recomPersonId","7600844696");//发展员工
		userOpenJson.put("recomPersonName", "高胜利");//发展人名称
		
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
		JSONObject useCustInfoJsonInput = new JSONObject();

		useCustInfoJsonInput.put("useCustName", "张三");//责任人姓名
		useCustInfoJsonInput.put("useCustPsptType", "02");//证件类型
		useCustInfoJsonInput.put("useCustPsptCode", "7614041021750418");//证件号码
		useCustInfoJsonInput.put("useCustPsptAddress", "郑州市金水区明路");//证件地址
		useCustInfoJsonInput.put("itmPrdGroupType", "");
		useCustInfoJsonInput.put("itmPrdRespobsible", "");
		userOpenJson.put("useCustInfo", useCustInfoJsonInput);				
		
		
		
		
		
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
		//System.out.println("resultinfo=" + ret.get("resultJson"));
	}
}
