package com.asia.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.asia.entity.TfSapTrade;

public interface TfSapTradeDao {
   public int insert(TfSapTrade record);

   public int insertSelective(TfSapTrade record);
    
   public List<Map<String, Object>>  getTfSapTradeById(
		   @Param(value="sapTradeId") String idsapTradeId,
		   @Param(value="sapSubscribeId") String sapSubscribeId
		   );
   public int insertTradeItem(
		   @Param(value="SAP_TRADE_ID") String sapTradeId,
		   @Param(value="ACCEPT_MONTH") String acceptMonth,
		   @Param(value="ATTR_CODE") String attrCode,
		   @Param(value="ATTR_VALUE") String attrValue
		   );
}