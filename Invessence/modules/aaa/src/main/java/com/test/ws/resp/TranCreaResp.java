package com.test.ws.resp;

import java.util.Date;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class TranCreaResp {

	private Long MESSAGE_ID;
	private String MERCHANT_ID;
	private String MERCHANT_REFERENCE_NUMBER;
	private String RESP_CODE;
	private String RESP_DESCRIPTION;
	private String PAYSO_TXN_ID;
	private Date DATE_TIME;
	private String CHECKSUM;
	
	public TranCreaResp() {
		// TODO Auto-generated constructor stub
	}
	
	public TranCreaResp(Long mESSAGE_ID, String mERCHANT_ID, String mERCHANT_REFERENCE_NUMBER, String rESP_CODE,
			String rESP_DESCRIPTION, String pAYSO_TXN_ID, Date dATE_TIME, String cHECKSUM) {
		MESSAGE_ID = mESSAGE_ID;
		MERCHANT_ID = mERCHANT_ID;
		MERCHANT_REFERENCE_NUMBER = mERCHANT_REFERENCE_NUMBER;
		RESP_CODE = rESP_CODE;
		RESP_DESCRIPTION = rESP_DESCRIPTION;
		PAYSO_TXN_ID = pAYSO_TXN_ID;
		DATE_TIME = dATE_TIME;
		CHECKSUM = cHECKSUM;
	}
	
	@XmlElement
	public Long getMESSAGE_ID() {
		return MESSAGE_ID;
	}
	public void setMESSAGE_ID(Long mESSAGE_ID) {
		MESSAGE_ID = mESSAGE_ID;
	}
	
	@XmlElement
	public String getMERCHANT_ID() {
		return MERCHANT_ID;
	}
	public void setMERCHANT_ID(String mERCHANT_ID) {
		MERCHANT_ID = mERCHANT_ID;
	}
	
	@XmlElement
	public String getMERCHANT_REFERENCE_NUMBER() {
		return MERCHANT_REFERENCE_NUMBER;
	}
	public void setMERCHANT_REFERENCE_NUMBER(String mERCHANT_REFERENCE_NUMBER) {
		MERCHANT_REFERENCE_NUMBER = mERCHANT_REFERENCE_NUMBER;
	}
	
	@XmlElement
	public String getRESP_CODE() {
		return RESP_CODE;
	}
	public void setRESP_CODE(String rESP_CODE) {
		RESP_CODE = rESP_CODE;
	}
	
	@XmlElement
	public String getRESP_DESCRIPTION() {
		return RESP_DESCRIPTION;
	}
	public void setRESP_DESCRIPTION(String rESP_DESCRIPTION) {
		RESP_DESCRIPTION = rESP_DESCRIPTION;
	}
	
	@XmlElement
	public String getPAYSO_TXN_ID() {
		return PAYSO_TXN_ID;
	}
	public void setPAYSO_TXN_ID(String pAYSO_TXN_ID) {
		PAYSO_TXN_ID = pAYSO_TXN_ID;
	}
	
	@XmlElement
	public Date getDATE_TIME() {
		return DATE_TIME;
	}
	public void setDATE_TIME(Date dATE_TIME) {
		DATE_TIME = dATE_TIME;
	}
	
	@XmlElement
	public String getCHECKSUM() {
		return CHECKSUM;
	}
	public void setCHECKSUM(String cHECKSUM) {
		CHECKSUM = cHECKSUM;
	}
	
	@Override
	public String toString() {
		return "TranCreaResp [MESSAGE_ID=" + MESSAGE_ID + ", MERCHANT_ID=" + MERCHANT_ID
				+ ", MERCHANT_REFERENCE_NUMBER=" + MERCHANT_REFERENCE_NUMBER + ", RESP_CODE=" + RESP_CODE
				+ ", RESP_DESCRIPTION=" + RESP_DESCRIPTION + ", PAYSO_TXN_ID=" + PAYSO_TXN_ID + ", DATE_TIME="
				+ DATE_TIME + ", CHECKSUM=" + CHECKSUM + "]";
	}
	
	
	
	

}
