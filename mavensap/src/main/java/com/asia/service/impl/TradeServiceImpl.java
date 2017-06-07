package com.asia.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.asia.dao.ITradeServiceDao;
import com.asia.dao.TfSapTradeDao;
import com.asia.service.TradeService;
import com.asia.util.DataSourceContextHolder;
import com.asia.util.DataSourceRoute;

@Service("tradeService")
public class TradeServiceImpl implements TradeService{
	
	@Autowired
	private TfSapTradeDao tfSapTradeDao;
	
	@Autowired
	private ITradeServiceDao tradeServicedao;
	
	public List<Map<String, Object>> getTfSapTrade(String sapTradeId,String sapSubscribeId) {
		DataSourceContextHolder.setDbType(DataSourceRoute.dbType("760"));
		return tfSapTradeDao.getTfSapTradeById(sapTradeId,sapSubscribeId);
	}

	@Override
	public int insertTradeItem(String sapTradeId, String acceptMonth,
			String attrCode, String attrValue) {
		// TODO Auto-generated method stub
		return tfSapTradeDao.insertTradeItem(sapTradeId, acceptMonth, attrCode, attrValue);
	}

	//存储过程数据入库
	@Override
	public void callCopyTrade(Map<String, Object> inDataMap) {
		// TODO Auto-generated method stub
		tradeServicedao.callCopyTrade(inDataMap);		
	}
	//插入结果集
	@Override
	public Integer insertCsSapProdResult(Map<String, Object> inDataMap) {
		// TODO Auto-generated method stub
		
		String tradeId = tradeServicedao.getSequence("")+"";
		inDataMap.put("SAP_TRADE_ID", tradeId);
		Integer result = tradeServicedao.insertCsSapProdResult(inDataMap);
		return result;
	}
	//取测试用例
	@Override
	public List<Map<String, Object>> selectCaseList() {		
		return tradeServicedao.selectCaseList();
	}
	
	public Integer updateCase(String caseId){
		return tradeServicedao.updateCase(caseId);
	}
	
	//取产品信息
	@Override
	public List<Map<String, Object>> selectProdList(String caseId,String prodSource) {
			// TODO Auto-generated method stub
		List<Map<String, Object>> returnList = tradeServicedao.selectProdList(caseId,prodSource);
		return returnList;
	}
	//取元素信息
	@Override
	public List<Map<String, Object>> selectElementList(String productId) {
		// TODO Auto-generated method stub
		return tradeServicedao.selectElementList(productId);
	}
	
	//取地市下工号信息 
	@Override
	public Map<String, Object> selectStaffInfo(String EparchyCode) {
		return tradeServicedao.selectStaffInfo(EparchyCode);
	}
	//调用结果入库
	@Transactional
	public void saveTestResult(JSONObject userProdJson,JSONObject staffInfoJson,
			String requestContent,String responseConetnt,String resultFlag,String caseId,String httpcode,
			String firstMonBillMode){
		
		String tradeId= new SimpleDateFormat("yyyyMMdd").format(new Date())+tradeServicedao.getSequence("SEQ_AOP_TEST_ID");
		
		String operatorId = (String)staffInfoJson.get("operatorId");
		String province = (String)staffInfoJson.get("province");
		String city = (String)staffInfoJson.get("city");
		String district = (String)staffInfoJson.get("district");
		String channelId = (String)staffInfoJson.get("channelId");
		String channelType = (String)staffInfoJson.get("channelType");
		
		JSONArray productJsonArray = (JSONArray)userProdJson.get("product");
		
		JSONArray activityInfoJsonArray = (JSONArray)userProdJson.get("activityInfo");
		
		//取产品信息
		List<Map<String,String>> prodList = new ArrayList<Map<String,String>>();
		//封装元素信息
		List<Map<String,String>> elementList = new ArrayList<Map<String,String>>();
		
		
		this.autoPutProdAndPkgElement(prodList, elementList, productJsonArray);
		this.autoPutActivtyAndPkgElement(prodList, elementList, activityInfoJsonArray);
		
		//入产品、元素 
		if(prodList.size()>0){
			tradeServicedao.insertCsSapProd(tradeId, prodList, firstMonBillMode);
		}
		if(elementList.size()>0){
			tradeServicedao.insertCsSapElement(tradeId, elementList);
		}		
		
		Map<String,Object> inResultMap = new HashMap<String,Object>();
		inResultMap.put("TRADE_ID",tradeId);
		inResultMap.put("CASE_ID",caseId);
		inResultMap.put("REQUEST_CONTENT", requestContent);
		inResultMap.put("RESPONSE_CONTENT", responseConetnt);
		inResultMap.put("REMARK","产品自动化测试");
		inResultMap.put("STAFF_ID", operatorId);
		inResultMap.put("DEPART_ID", channelId);
		inResultMap.put("EPARCHY_CODE",city);
		inResultMap.put("CITY_CODE",district);
		inResultMap.put("MSG","");
		inResultMap.put("HTTP_CODE",httpcode);
		inResultMap.put("MSG_SOURCE", "");
		inResultMap.put("HTTP_METHOD", "");
		inResultMap.put("RESULT_FLAG", resultFlag);
		
		tradeServicedao.insertCsSapProdResult(inResultMap);
		
	}
	/**取数据库时间*/
	public String getSysdate(){
		return tradeServicedao.getSysdate();
	}
	
	/**
	 * 封装产品、产品元素信息
	 * @param prodList
	 * @param elementList
	 * @param productJsonArray
	 */
	private void autoPutProdAndPkgElement(List<Map<String,String>> prodList,List<Map<String,String>> elementList,
			JSONArray productJsonArray){
		if(productJsonArray==null ||"".equals(productJsonArray)){
			productJsonArray = new JSONArray();
		}
		
		for(int i=0;i<productJsonArray.size();i++){
			JSONObject productJson = (JSONObject)productJsonArray.get(i);
			String productId = (String)productJson.get("productId");
			String productMode = (String)productJson.get("productMode");
			String product_mode="00";
			if("1".equals(productMode)){
				product_mode = "00";
			}
			if("2".equals(productMode)){
				product_mode = "01";
			}
			
			Map<String,String> prodMap = new HashMap<String,String>();
			prodMap.put("PRODUCT_ID", productId);
			prodMap.put("PRODUCT_MODE",product_mode);
			prodList.add(prodMap);
						
			JSONArray packageElementJsonArray = (JSONArray)productJson.get("packageElement");
			if(packageElementJsonArray==null ||"".equals(packageElementJsonArray)){
				packageElementJsonArray = new JSONArray();
			}
			for(int j=0;j<packageElementJsonArray.size();j++){
				JSONObject packageElementJson = (JSONObject)packageElementJsonArray.get(j);
				String packageId = (String)packageElementJson.get("packageId");
				String elementId = (String)packageElementJson.get("elementId");
				String elementType = (String)packageElementJson.get("elementType");
				
				Map<String,String> elementMap = new HashMap<String,String>();
				elementMap.put("PACKAGE_ID",   packageId);
				elementMap.put("ELEMENT_ID",   elementId);
				elementMap.put("ELEMENT_TYPE", elementType);
				elementMap.put("PRODUCT_ID", productId);
				elementList.add(elementMap);
				
			}
		}	
	}
	
	/**
	 * 封装活动、活动下元素信息
	 * @param prodList
	 * @param elementList
	 * @param activityInfoJsonArray
	 */
	private void autoPutActivtyAndPkgElement(List<Map<String,String>> prodList,List<Map<String,String>> elementList,
			JSONArray activityInfoJsonArray){
		if(activityInfoJsonArray==null || "".equals(activityInfoJsonArray)){
			activityInfoJsonArray =  new JSONArray();
		}
		//取活动信息
				for(int i=0;i<activityInfoJsonArray.size();i++){
					JSONObject activityInfoJson = (JSONObject)activityInfoJsonArray.get(i);
					String productId = (String)activityInfoJson.get("actPlanId");		
					Map<String,String> prodMap = new HashMap<String,String>();
					prodMap.put("PRODUCT_ID", productId);
					prodMap.put("PRODUCT_MODE","50");
					prodList.add(prodMap);			
					JSONArray packageElementJsonArray = (JSONArray)activityInfoJson.get("packageElement");
					
					if(packageElementJsonArray==null ||"".equals(packageElementJsonArray)){
						packageElementJsonArray = new JSONArray();
					}
					
					for(int j=0;j<packageElementJsonArray.size();j++){
						JSONObject packageElementJson = (JSONObject)packageElementJsonArray.get(j);
						String packageId = (String)packageElementJson.get("packageId");
						String elementId = (String)packageElementJson.get("elementId");
						String elementType = (String)packageElementJson.get("elementType");
						
						Map<String,String> elementMap = new HashMap<String,String>();
						elementMap.put("PACKAGE_ID",   packageId);
						elementMap.put("ELEMENT_ID",   elementId);
						elementMap.put("ELEMENT_TYPE", elementType);
						elementMap.put("PRODUCT_ID", productId);
						elementList.add(elementMap);
					}
				}	
		}

		@Override
		public Integer insertCsCaseResult(String caseId, String startDate,
				String endDate) {
			return tradeServicedao.insertCsCaseResult(caseId, startDate, endDate);
		}
	
		 public List<Map<String,Object>> selectTradeWxList(String tradeId,String eparchyCode){
			 DataSourceContextHolder.setDbType(DataSourceRoute.dbType(eparchyCode));			 
			 return tradeServicedao.selectTradeWxList(tradeId);
		 }
		
	
	

}
