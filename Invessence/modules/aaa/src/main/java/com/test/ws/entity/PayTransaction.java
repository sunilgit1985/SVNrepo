package com.test.ws.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pay_transaction")
public class PayTransaction {
	
	private Long ID;
	private Long MESSAGE_ID;
	private String MERCHANT_ID;
	private String MERCHANT_REFERENCE_NUMBER;
	private String VENDOR_ID;
	private String DELIVERY_BOY_ID;
	private Double AMOUNT;
	private String TID;
	private String TRANSACTION_CD;
	private String CHECKSUM;
	
	@Id @GeneratedValue
	public Long getID() {
		return ID;
	}
	public void setID(Long iD) {
		ID = iD;
	}
	
	@Column(name = "MESSAGE_ID",  nullable = false, length=10)		
	public Long getMESSAGE_ID() {
		return MESSAGE_ID;
	}
	public void setMESSAGE_ID(Long mESSAGE_ID) {
		MESSAGE_ID = mESSAGE_ID;
	}
	
	@Column(name = "MERCHANT_ID",  nullable = false, length=10)	
	public String getMERCHANT_ID() {
		return MERCHANT_ID;
	}
	public void setMERCHANT_ID(String mERCHANT_ID) {
		MERCHANT_ID = mERCHANT_ID;
	}
	
	@Column(name = "MERCHANT_REFERENCE_NUMBER",  nullable = false, length=20)	
	public String getMERCHANT_REFERENCE_NUMBER() {
		return MERCHANT_REFERENCE_NUMBER;
	}
	public void setMERCHANT_REFERENCE_NUMBER(String mERCHANT_REFERENCE_NUMBER) {
		MERCHANT_REFERENCE_NUMBER = mERCHANT_REFERENCE_NUMBER;
	}
	
	@Column(name = "VENDOR_ID",  nullable = false, length=10)	
	public String getVENDOR_ID() {
		return VENDOR_ID;
	}
	public void setVENDOR_ID(String vENDOR_ID) {
		VENDOR_ID = vENDOR_ID;
	}
	
	@Column(name = "DELIVERY_BOY_ID",  nullable = false, length=10)	
	public String getDELIVERY_BOY_ID() {
		return DELIVERY_BOY_ID;
	}
	public void setDELIVERY_BOY_ID(String dELIVERY_BOY_ID) {
		DELIVERY_BOY_ID = dELIVERY_BOY_ID;
	}
	
	@Column(name = "AMOUNT",  nullable = false, length=19, precision=2)	
	public Double getAMOUNT() {
		return AMOUNT;
	}
	public void setAMOUNT(Double aMOUNT) {
		AMOUNT = aMOUNT;
	}
	
	@Column(name = "TID",  nullable = false, length=20)	
	public String getTID() {
		return TID;
	}
	public void setTID(String tID) {
		TID = tID;
	}
	
	@Column(name = "TRANSACTION_CD",  nullable = false, length=10)	
	public String getTRANSACTION_CD() {
		return TRANSACTION_CD;
	}
	public void setTRANSACTION_CD(String tRANSACTION_CD) {
		TRANSACTION_CD = tRANSACTION_CD;
	}
	
	@Column(name = "CHECKSUM",  nullable = false, length=50)	
	public String getCHECKSUM() {
		return CHECKSUM;
	}
	public void setCHECKSUM(String cHECKSUM) {
		CHECKSUM = cHECKSUM;
	}
	

}
