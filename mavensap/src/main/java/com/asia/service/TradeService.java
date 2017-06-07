package com.asia.service;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.ibatis.annotations.Param;

public interface TradeService {
	
	public List<Map<String, Object>> getTfSapTrade(String sapTradeId,String sapSubscribeId);
	public int insertTradeItem(String sapTradeId,String acceptMonth,String attrCode,String attrValue);
	
	//调用存储过程
	public void callCopyTrade(Map<String,Object> inDataMap);
	
	//调 测试结果入库
	public Integer insertCsSapProdResult(Map<String,Object> inDataMap);
	
	//取测试用例表
	public List<Map<String,Object>> selectCaseList();
	
	public Integer updateCase(String caseId);
	
	//取后台查询的产品信息
    public List<Map<String,Object>> selectProdList(String caseId,String prodSource);
    
    public List<Map<String,Object>> selectTradeWxList(String tradeId,String eparchyCode);
    
    //取产品下的元素信息
	public List<Map<String,Object>> selectElementList(String productId);
	
	//取地市下工号信息
	public Map<String,Object> selectStaffInfo(String EparchyCode);
	
	//调用结果入库
	public void saveTestResult(JSONObject userProdJson,JSONObject staffInfoJson,
			String requestContent,String responseConetnt,String resultFlag,String caseId,String httpcode,String firstMonBillMode);

	/**取数据库时间*/
	public String getSysdate();
	
	/**
	 * 看一个case执行多久
	 * @param caseId
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public Integer insertCsCaseResult(String caseId,String startDate,String endDate);
}
