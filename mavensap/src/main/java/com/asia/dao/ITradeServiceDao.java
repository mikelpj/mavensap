package com.asia.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface ITradeServiceDao {
	/**
	 * 这个是测试用的
	 * @param sapTradeId
	 * @param acceptMonth
	 * @param attrCode
	 * @param attrValue
	 * @return
	 */
	  public int insertTradeItem(
			   @Param(value="SAP_TRADE_ID") String sapTradeId,
			   @Param(value="ACCEPT_MONTH") String acceptMonth,
			   @Param(value="ATTR_CODE") String attrCode,
			   @Param(value="ATTR_VALUE") String attrValue
			   );
	  /**
	   * 调用存储过程
	   * @param inDataMap
	   * @return
	   */
	  public void callCopyTrade(Map<String,Object> inDataMap);
	  
	  /**
	   * 调 用结果入库
	   * @param inDataMap
	   * @return
	   */
	  public Integer insertCsSapProdResult(Map<String,Object> inDataMap);
	  
	  
	  /**取测试用例列表*/
	  public List<Map<String,Object>> selectCaseList();

	  /**取后台查询的产品信息*/
	  public List<Map<String,Object>> selectProdList(
			  @Param(value="CASE_ID") String CASE_ID,	  
			  @Param(value="PRODUCT_SOURCE") String productSource
			  );	 
	  /** 取产品下的元素信息*/
	  public List<Map<String,Object>> selectElementList(
			  @Param(value="PRODUCT_ID") String productId			
			  );
	  /**取地市下工号信息*/
	  public Map<String,Object> selectStaffInfo(
			  @Param(value="EPARCHY_CODE") String EPARCHY_CODE		
			  );
	  
	  public List<Map<String,Object>> selectTradeWxList( @Param(value="TRADE_ID") String tradeId);
	  /**
	   * 插入产品表
	   * @param tradeId
	   * @param prodList
	   * @param FIRSTMONBILLMODE
	   * @return
	   */
	  public Integer insertCsSapProd(
			@Param(value="TRADE_ID")  String tradeId,
			@Param(value="prodList")  List<Map<String,String>> prodList,		
			@Param(value="FIRSTMONBILLMODE")  String FIRSTMONBILLMODE		  
			 );
	  /**
	   * 插入元素信息表
	   * @param tradeId
	   * @param elementList
	   * @return
	   */
	  public Integer insertCsSapElement(
			  @Param(value="TRADE_ID") String tradeId,
			  @Param(value="elementList") List<Map<String,String>> elementList
			  );
	  
	  /**
	   * 测试case入库
	   * @param caseId
	   * @param startDate
	   * @param endDate
	   * @return
	   */
	  public Integer insertCsCaseResult(
			  @Param(value="CASE_ID") String caseId,
			  @Param(value="START_DATE") String startDate,
			  @Param(value="END_DATE") String endDate
			  );
	  
	  /**
	   * 更新case表
	   * @param caseId
	   * @return
	   */
	  public Integer updateCase(
			  @Param(value="caseId") String caseId
			  );
	  
	  
	  /**
	   * 取序列
	   * @param seqName
	   * @return
	   */
	  public String getSequence(
			  @Param(value="seqName") String seqName);

	  /**取数据库时间*/
	  public String getSysdate();
	  
	  
}
