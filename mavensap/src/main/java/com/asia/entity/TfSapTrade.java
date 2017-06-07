package com.asia.entity;

import java.math.BigDecimal;
import java.util.Date;

public class TfSapTrade {
    private Long sapTradeId;

    private Long sapSubscribeId;

    private Long cbssTradeId;

    private Long cbssSubscribeId;

    private String tradeEparchyCode;

    private String tradeCityCode;

    private String tradeDepartId;

    private String tradeStaffId;

    private Short acceptMonth;

    private Date acceptDate;

    private String netTypeCode;

    private Long custId;

    private String custName;

    private String serialNumber;

    private Long totalFee;

    private Short tradeTypeCode;

    private String subscribeState;

    private String nextDealTag;

    private String cancelEparchyCode;

    private String cancelCityCode;

    private String cancelDepartId;

    private String cancelStaffId;

    private String cancelTag;

    private Date cancelDate;

    private Integer productId;

    private String productName;

    private Integer productId2;

    private String productName2;

    private Integer serviceId;

    private String serviceName;

    private Integer discntCode;

    private String discntName;

    private String isNeedAssign;

    private String simCardNo;

    private String imsi;

    private String imei;

    private String state;

    private String remark;

    private Date rsrvTime1;

    private Date rsrvTime2;

    private String rsrvValue1;

    private String rsrvValue2;

    private String rsrvValue3;

    private String rsrvValue4;

    private BigDecimal rsrvNum1;

    private BigDecimal rsrvNum2;

    private String psptId;

    private String paperlessConductState;

    private String tradeSource;

    public Long getSapTradeId() {
        return sapTradeId;
    }

    public void setSapTradeId(Long sapTradeId) {
        this.sapTradeId = sapTradeId;
    }

    public Long getSapSubscribeId() {
        return sapSubscribeId;
    }

    public void setSapSubscribeId(Long sapSubscribeId) {
        this.sapSubscribeId = sapSubscribeId;
    }

    public Long getCbssTradeId() {
        return cbssTradeId;
    }

    public void setCbssTradeId(Long cbssTradeId) {
        this.cbssTradeId = cbssTradeId;
    }

    public Long getCbssSubscribeId() {
        return cbssSubscribeId;
    }

    public void setCbssSubscribeId(Long cbssSubscribeId) {
        this.cbssSubscribeId = cbssSubscribeId;
    }

    public String getTradeEparchyCode() {
        return tradeEparchyCode;
    }

    public void setTradeEparchyCode(String tradeEparchyCode) {
        this.tradeEparchyCode = tradeEparchyCode == null ? null : tradeEparchyCode.trim();
    }

    public String getTradeCityCode() {
        return tradeCityCode;
    }

    public void setTradeCityCode(String tradeCityCode) {
        this.tradeCityCode = tradeCityCode == null ? null : tradeCityCode.trim();
    }

    public String getTradeDepartId() {
        return tradeDepartId;
    }

    public void setTradeDepartId(String tradeDepartId) {
        this.tradeDepartId = tradeDepartId == null ? null : tradeDepartId.trim();
    }

    public String getTradeStaffId() {
        return tradeStaffId;
    }

    public void setTradeStaffId(String tradeStaffId) {
        this.tradeStaffId = tradeStaffId == null ? null : tradeStaffId.trim();
    }

    public Short getAcceptMonth() {
        return acceptMonth;
    }

    public void setAcceptMonth(Short acceptMonth) {
        this.acceptMonth = acceptMonth;
    }

    public Date getAcceptDate() {
        return acceptDate;
    }

    public void setAcceptDate(Date acceptDate) {
        this.acceptDate = acceptDate;
    }

    public String getNetTypeCode() {
        return netTypeCode;
    }

    public void setNetTypeCode(String netTypeCode) {
        this.netTypeCode = netTypeCode == null ? null : netTypeCode.trim();
    }

    public Long getCustId() {
        return custId;
    }

    public void setCustId(Long custId) {
        this.custId = custId;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName == null ? null : custName.trim();
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber == null ? null : serialNumber.trim();
    }

    public Long getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(Long totalFee) {
        this.totalFee = totalFee;
    }

    public Short getTradeTypeCode() {
        return tradeTypeCode;
    }

    public void setTradeTypeCode(Short tradeTypeCode) {
        this.tradeTypeCode = tradeTypeCode;
    }

    public String getSubscribeState() {
        return subscribeState;
    }

    public void setSubscribeState(String subscribeState) {
        this.subscribeState = subscribeState == null ? null : subscribeState.trim();
    }

    public String getNextDealTag() {
        return nextDealTag;
    }

    public void setNextDealTag(String nextDealTag) {
        this.nextDealTag = nextDealTag == null ? null : nextDealTag.trim();
    }

    public String getCancelEparchyCode() {
        return cancelEparchyCode;
    }

    public void setCancelEparchyCode(String cancelEparchyCode) {
        this.cancelEparchyCode = cancelEparchyCode == null ? null : cancelEparchyCode.trim();
    }

    public String getCancelCityCode() {
        return cancelCityCode;
    }

    public void setCancelCityCode(String cancelCityCode) {
        this.cancelCityCode = cancelCityCode == null ? null : cancelCityCode.trim();
    }

    public String getCancelDepartId() {
        return cancelDepartId;
    }

    public void setCancelDepartId(String cancelDepartId) {
        this.cancelDepartId = cancelDepartId == null ? null : cancelDepartId.trim();
    }

    public String getCancelStaffId() {
        return cancelStaffId;
    }

    public void setCancelStaffId(String cancelStaffId) {
        this.cancelStaffId = cancelStaffId == null ? null : cancelStaffId.trim();
    }

    public String getCancelTag() {
        return cancelTag;
    }

    public void setCancelTag(String cancelTag) {
        this.cancelTag = cancelTag == null ? null : cancelTag.trim();
    }

    public Date getCancelDate() {
        return cancelDate;
    }

    public void setCancelDate(Date cancelDate) {
        this.cancelDate = cancelDate;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName == null ? null : productName.trim();
    }

    public Integer getProductId2() {
        return productId2;
    }

    public void setProductId2(Integer productId2) {
        this.productId2 = productId2;
    }

    public String getProductName2() {
        return productName2;
    }

    public void setProductName2(String productName2) {
        this.productName2 = productName2 == null ? null : productName2.trim();
    }

    public Integer getServiceId() {
        return serviceId;
    }

    public void setServiceId(Integer serviceId) {
        this.serviceId = serviceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName == null ? null : serviceName.trim();
    }

    public Integer getDiscntCode() {
        return discntCode;
    }

    public void setDiscntCode(Integer discntCode) {
        this.discntCode = discntCode;
    }

    public String getDiscntName() {
        return discntName;
    }

    public void setDiscntName(String discntName) {
        this.discntName = discntName == null ? null : discntName.trim();
    }

    public String getIsNeedAssign() {
        return isNeedAssign;
    }

    public void setIsNeedAssign(String isNeedAssign) {
        this.isNeedAssign = isNeedAssign == null ? null : isNeedAssign.trim();
    }

    public String getSimCardNo() {
        return simCardNo;
    }

    public void setSimCardNo(String simCardNo) {
        this.simCardNo = simCardNo == null ? null : simCardNo.trim();
    }

    public String getImsi() {
        return imsi;
    }

    public void setImsi(String imsi) {
        this.imsi = imsi == null ? null : imsi.trim();
    }

    public String getImei() {
        return imei;
    }

    public void setImei(String imei) {
        this.imei = imei == null ? null : imei.trim();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Date getRsrvTime1() {
        return rsrvTime1;
    }

    public void setRsrvTime1(Date rsrvTime1) {
        this.rsrvTime1 = rsrvTime1;
    }

    public Date getRsrvTime2() {
        return rsrvTime2;
    }

    public void setRsrvTime2(Date rsrvTime2) {
        this.rsrvTime2 = rsrvTime2;
    }

    public String getRsrvValue1() {
        return rsrvValue1;
    }

    public void setRsrvValue1(String rsrvValue1) {
        this.rsrvValue1 = rsrvValue1 == null ? null : rsrvValue1.trim();
    }

    public String getRsrvValue2() {
        return rsrvValue2;
    }

    public void setRsrvValue2(String rsrvValue2) {
        this.rsrvValue2 = rsrvValue2 == null ? null : rsrvValue2.trim();
    }

    public String getRsrvValue3() {
        return rsrvValue3;
    }

    public void setRsrvValue3(String rsrvValue3) {
        this.rsrvValue3 = rsrvValue3 == null ? null : rsrvValue3.trim();
    }

    public String getRsrvValue4() {
        return rsrvValue4;
    }

    public void setRsrvValue4(String rsrvValue4) {
        this.rsrvValue4 = rsrvValue4 == null ? null : rsrvValue4.trim();
    }

    public BigDecimal getRsrvNum1() {
        return rsrvNum1;
    }

    public void setRsrvNum1(BigDecimal rsrvNum1) {
        this.rsrvNum1 = rsrvNum1;
    }

    public BigDecimal getRsrvNum2() {
        return rsrvNum2;
    }

    public void setRsrvNum2(BigDecimal rsrvNum2) {
        this.rsrvNum2 = rsrvNum2;
    }

    public String getPsptId() {
        return psptId;
    }

    public void setPsptId(String psptId) {
        this.psptId = psptId == null ? null : psptId.trim();
    }

    public String getPaperlessConductState() {
        return paperlessConductState;
    }

    public void setPaperlessConductState(String paperlessConductState) {
        this.paperlessConductState = paperlessConductState == null ? null : paperlessConductState.trim();
    }

    public String getTradeSource() {
        return tradeSource;
    }

    public void setTradeSource(String tradeSource) {
        this.tradeSource = tradeSource == null ? null : tradeSource.trim();
    }
}