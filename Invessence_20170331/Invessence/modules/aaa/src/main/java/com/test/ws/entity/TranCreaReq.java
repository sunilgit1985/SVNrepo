package com.test.ws.entity;

public class TranCreaReq {
	
	private Long MESSAGE_ID;
	private String MERCHANT_ID;
	private String MERCHANT_REFERENCE_NUMBER;
	private String VENDOR_ID;
	private String DELIVERY_BOY_ID;
	private Double AMOUNT;
	private String TID;
	private String TRANSACTION_CD;
	private String CHECKSUM;
	
	public Long getMESSAGE_ID() {
		return MESSAGE_ID;
	}
	public void setMESSAGE_ID(Long mESSAGE_ID) {
		MESSAGE_ID = mESSAGE_ID;
	}
		
	public String getMERCHANT_ID() {
		return MERCHANT_ID;
	}
	public void setMERCHANT_ID(String mERCHANT_ID) {
		MERCHANT_ID = mERCHANT_ID;
	}
	
	public String getMERCHANT_REFERENCE_NUMBER() {
		return MERCHANT_REFERENCE_NUMBER;
	}
	public void setMERCHANT_REFERENCE_NUMBER(String mERCHANT_REFERENCE_NUMBER) {
		MERCHANT_REFERENCE_NUMBER = mERCHANT_REFERENCE_NUMBER;
	}
	
	public String getVENDOR_ID() {
		return VENDOR_ID;
	}
	public void setVENDOR_ID(String vENDOR_ID) {
		VENDOR_ID = vENDOR_ID;
	}
		
	public String getDELIVERY_BOY_ID() {
		return DELIVERY_BOY_ID;
	}
	public void setDELIVERY_BOY_ID(String dELIVERY_BOY_ID) {
		DELIVERY_BOY_ID = dELIVERY_BOY_ID;
	}
		
	public Double getAMOUNT() {
		return AMOUNT;
	}
	public void setAMOUNT(Double aMOUNT) {
		AMOUNT = aMOUNT;
	}
	
	public String getTID() {
		return TID;
	}
	public void setTID(String tID) {
		TID = tID;
	}
		
	public String getTRANSACTION_CD() {
		return TRANSACTION_CD;
	}
	public void setTRANSACTION_CD(String tRANSACTION_CD) {
		TRANSACTION_CD = tRANSACTION_CD;
	}
		
	public String getCHECKSUM() {
		return CHECKSUM;
	}
	public void setCHECKSUM(String cHECKSUM) {
		CHECKSUM = cHECKSUM;
	}
	

}
