package com.test.ws.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="transaction")
public class Transaction {

	private Long REQUEST_ID;
	private Date REQUEST_DATE;
	private String MERCHANT_ID;
	private Long TRANSACTION_CD;
	private Date TRANSACTION_DATE;
	private Date PAYMENT_DATE;
	private Long MERCHANT_REFERENCE_NO;
	private String SOURCE_CODE;
	private String CHANNEL_TYPE;
	private String VENDOR_ID;
	private String ORIGINAL_REQUEST_MESSAGE;
	private String DELIVERY_BOY_ID;
	private Double AMOUNT;
	private String REQ_PROCESSED_FLAG;
	private Date REQ_PROCESSED_DATE;
	private String REQ_PROC_REMARKS;
	private String PAYSO_RESP_CODE;
	private String PAYSO_RESP_REMARKS;
	private String AUTHZ_TYPE;
	private String AUTHORIZATION_REQUIRED;
	private String AUTHORIZATION_RECEIVED;
	private String AUTHZ_COMPLETE_FLAG;
	private String RULE_ID;
	private String CANCEL_FLAG;
	private Date CANCEL_DATE;
	private String CANCEL_BY;
	private String BANK_RESP_CODE;
	private String BANK_RESP_REMARKS;
	private String BANK_REF_NUMER;
	private String RRN;
	private String BANK_REQUEST_XML;
	private String BANK_RESPONSE_XML;
	private String RECEIPT_NO;
	private Date RECEIPT_GENERATION_DATE;
	private String TXN_RPT_VALIDATED_FLAG;
	private String TXN_RPT_GENERATION_FLAG;
	private String TXN_RPT_GENERATION_DATE;
	private String TXN_RPT_FILE_NAME;
	private String ALERT_PROCESSED_FLAG;
	private String ALERT_PROC_REMARKS;
	private String REVERSAL_TOBE_PASSED_FLAG;
	private String REVERSAL_PASSED_FLAG;
	private String REVERSAL_REQUEST_XML;
	private String REVERSAL_RESPONSE_XML;
	private Date REVERSAL_PROC_DATE;
	private String REVERSAL_PROC_REMARKS;
	private String CREATED_BY;
	private Date CREATED_DATE;
	private String MODIFIED_BY;
	private Date MODIFIED_DATE;
	private String RECEIPT_HTML;
	private Date ALERT_PROCESSED_DATE;
	private String REVERSE_ALERT_PROCESS_FLAG;
	private Date REVERSE_ALERT_PROCESS_DATE;
	private String AUTHZ_PENDING_ALERT_FLAG;
	private Date AUTHZ_PENDING_ALERT_DATE;
	private String RECON_GENERATION_FLAG;
	private Date RECON_GENERATION_DATE;
	private String RECON_FILE_NAME;
	private String REVERSAL_TOBE_PASSED_BY;
	private Date REVERSAL_TOBE_PASSED_DATE;
	
	public Transaction(String MESSAGE_ID,
			String MERCHANT_ID,
			Long MERCHANT_REFERENCE_NUMBER,
			String VENDOR_ID,
			String DELIVERY_BOY_ID,
			Double AMOUNT,
			String TID,
			String TRANSACTION_CD,
			String CHECKSUM
			) {
		//this.MESSAGE_ID=MESSAGE_ID;
		this.MERCHANT_ID=MERCHANT_ID ;
		this.MERCHANT_REFERENCE_NO=MERCHANT_REFERENCE_NUMBER;
		this.VENDOR_ID=VENDOR_ID ;
		this.DELIVERY_BOY_ID=DELIVERY_BOY_ID ;
		this.AMOUNT=AMOUNT;
//		this.TID=TID ;
//		this.TRANSACTION_CD=TRANSACTION_CD;
//		this.CHECKSUM=CHECKSUM;
		this.REQUEST_DATE=new Date();
	} 
	
	public Transaction(String MESSAGE_ID,
	String MERCHANT_ID,
	Long MERCHANT_REFERENCE_NUMBER,
	Long PAYSO_TXN_ID,
	String REQUEST_TYPE,
	String AUTH_REMARKS,
	String DATE_TIME,
	String REQUESTED_BY,
	String CHECKSUM){
		//this.MESSAGE_ID=MESSAGE_ID;
		this.MERCHANT_ID=MERCHANT_ID;
		this.MERCHANT_REFERENCE_NO=MERCHANT_REFERENCE_NUMBER;
		this.REQUEST_ID=PAYSO_TXN_ID;
		this.REQ_PROCESSED_DATE=new Date();
	/*	this.REQUEST_TYPE=REQUEST_TYPE;
		this.AUTH_REMARKS=AUTH_REMARKS;
		this.DATE_TIME=DATE_TIME ;
		this.REQUESTED_BY=REQUESTED_BY;
		this.CHECKSUM=CHECKSUM;*/
	} 
	
	@Id @GeneratedValue
	@Column(name = "REQUEST_ID", length=20)
	public Long getREQUEST_ID() {
		return REQUEST_ID;
	}
	public void setREQUEST_ID(Long rEQUEST_ID) {
		REQUEST_ID = rEQUEST_ID;
	}
	
	@Column(name = "REQUEST_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getREQUEST_DATE() {
		return REQUEST_DATE;
	}
	public void setREQUEST_DATE(Date rEQUEST_DATE) {
		REQUEST_DATE = rEQUEST_DATE;
	}
	
	@Column(name = "MERCHANT_ID", length=10)
	public String getMERCHANT_ID() {
		return MERCHANT_ID;
	}
	public void setMERCHANT_ID(String mERCHANT_ID) {
		MERCHANT_ID = mERCHANT_ID;
	}
	
	@Column(name = "TRANSACTION_CD", length=5)
	public Long getTRANSACTION_CD() {
		return TRANSACTION_CD;
	}
	public void setTRANSACTION_CD(Long tRANSACTION_CD) {
		TRANSACTION_CD = tRANSACTION_CD;
	}
	
	@Column(name = "TRANSACTION_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getTRANSACTION_DATE() {
		return TRANSACTION_DATE;
	}
	public void setTRANSACTION_DATE(Date tRANSACTION_DATE) {
		TRANSACTION_DATE = tRANSACTION_DATE;
	}
	
	@Column(name = "PAYMENT_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getPAYMENT_DATE() {
		return PAYMENT_DATE;
	}
	public void setPAYMENT_DATE(Date pAYMENT_DATE) {
		PAYMENT_DATE = pAYMENT_DATE;
	}
	
	@Column(name = "MERCHANT_REFERENCE_NO", length=20)
	public Long getMERCHANT_REFERENCE_NO() {
		return MERCHANT_REFERENCE_NO;
	}
	public void setMERCHANT_REFERENCE_NO(Long mERCHANT_REFERENCE_NO) {
		MERCHANT_REFERENCE_NO = mERCHANT_REFERENCE_NO;
	}
	
	@Column(name = "SOURCE_CODE", length=10)
	public String getSOURCE_CODE() {
		return SOURCE_CODE;
	}
	public void setSOURCE_CODE(String sOURCE_CODE) {
		SOURCE_CODE = sOURCE_CODE;
	}
	
	@Column(name = "CHANNEL_TYPE", length=10)
	public String getCHANNEL_TYPE() {
		return CHANNEL_TYPE;
	}
	public void setCHANNEL_TYPE(String cHANNEL_TYPE) {
		CHANNEL_TYPE = cHANNEL_TYPE;
	}
	
	@Column(name = "VENDOR_ID", length=10)
	public String getVENDOR_ID() {
		return VENDOR_ID;
	}
	public void setVENDOR_ID(String vENDOR_ID) {
		VENDOR_ID = vENDOR_ID;
	}
	
	@Column(name = "ORIGINAL_REQUEST_MESSAGE", length=200)
	public String getORIGINAL_REQUEST_MESSAGE() {
		return ORIGINAL_REQUEST_MESSAGE;
	}
	public void setORIGINAL_REQUEST_MESSAGE(String oRIGINAL_REQUEST_MESSAGE) {
		ORIGINAL_REQUEST_MESSAGE = oRIGINAL_REQUEST_MESSAGE;
	}
	
	@Column(name = "DELIVERY_BOY_ID", length=10)
	public String getDELIVERY_BOY_ID() {
		return DELIVERY_BOY_ID;
	}
	public void setDELIVERY_BOY_ID(String dELIVERY_BOY_ID) {
		DELIVERY_BOY_ID = dELIVERY_BOY_ID;
	}
	
	@Column(name = "AMOUNT", length=19, precision=2)
	public Double getAMOUNT() {
		return AMOUNT;
	}
	public void setAMOUNT(Double aMOUNT) {
		AMOUNT = aMOUNT;
	}
	
	@Column(name = "REQ_PROCESSED_FLAG", length=1)
	public String getREQ_PROCESSED_FLAG() {
		return REQ_PROCESSED_FLAG;
	}
	public void setREQ_PROCESSED_FLAG(String rEQ_PROCESSED_FLAG) {
		REQ_PROCESSED_FLAG = rEQ_PROCESSED_FLAG;
	}
	
	@Column(name = "REQ_PROCESSED_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getREQ_PROCESSED_DATE() {
		return REQ_PROCESSED_DATE;
	}
	public void setREQ_PROCESSED_DATE(Date rEQ_PROCESSED_DATE) {
		REQ_PROCESSED_DATE = rEQ_PROCESSED_DATE;
	}
	
	@Column(name = "REQ_PROC_REMARKS", length=100)
	public String getREQ_PROC_REMARKS() {
		return REQ_PROC_REMARKS;
	}
	public void setREQ_PROC_REMARKS(String rEQ_PROC_REMARKS) {
		REQ_PROC_REMARKS = rEQ_PROC_REMARKS;
	}
	
	@Column(name = "PAYSO_RESP_CODE", length=20)
	public String getPAYSO_RESP_CODE() {
		return PAYSO_RESP_CODE;
	}
	public void setPAYSO_RESP_CODE(String pAYSO_RESP_CODE) {
		PAYSO_RESP_CODE = pAYSO_RESP_CODE;
	}
	
	@Column(name = "PAYSO_RESP_REMARKS", length=100)
	public String getPAYSO_RESP_REMARKS() {
		return PAYSO_RESP_REMARKS;
	}
	public void setPAYSO_RESP_REMARKS(String pAYSO_RESP_REMARKS) {
		PAYSO_RESP_REMARKS = pAYSO_RESP_REMARKS;
	}
	
	@Column(name = "AUTHZ_TYPE", length=10)
	public String getAUTHZ_TYPE() {
		return AUTHZ_TYPE;
	}
	public void setAUTHZ_TYPE(String aUTHZ_TYPE) {
		AUTHZ_TYPE = aUTHZ_TYPE;
	}
	
	@Column(name = "AUTHORIZATION_REQUIRED", length=1)
	public String getAUTHORIZATION_REQUIRED() {
		return AUTHORIZATION_REQUIRED;
	}
	public void setAUTHORIZATION_REQUIRED(String aUTHORIZATION_REQUIRED) {
		AUTHORIZATION_REQUIRED = aUTHORIZATION_REQUIRED;
	}
	
	@Column(name = "AUTHORIZATION_RECEIVED", length=1)
	public String getAUTHORIZATION_RECEIVED() {
		return AUTHORIZATION_RECEIVED;
	}
	public void setAUTHORIZATION_RECEIVED(String aUTHORIZATION_RECEIVED) {
		AUTHORIZATION_RECEIVED = aUTHORIZATION_RECEIVED;
	}
	
	@Column(name = "AUTHZ_COMPLETE_FLAG", length=1)
	public String getAUTHZ_COMPLETE_FLAG() {
		return AUTHZ_COMPLETE_FLAG;
	}
	public void setAUTHZ_COMPLETE_FLAG(String aUTHZ_COMPLETE_FLAG) {
		AUTHZ_COMPLETE_FLAG = aUTHZ_COMPLETE_FLAG;
	}
	
	@Column(name = "RULE_ID", length=10)
	public String getRULE_ID() {
		return RULE_ID;
	}
	public void setRULE_ID(String rULE_ID) {
		RULE_ID = rULE_ID;
	}
	
	@Column(name = "CANCEL_FLAG", length=1)
	public String getCANCEL_FLAG() {
		return CANCEL_FLAG;
	}
	public void setCANCEL_FLAG(String cANCEL_FLAG) {
		CANCEL_FLAG = cANCEL_FLAG;
	}
	
	@Column(name = "CANCEL_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getCANCEL_DATE() {
		return CANCEL_DATE;
	}
	public void setCANCEL_DATE(Date cANCEL_DATE) {
		CANCEL_DATE = cANCEL_DATE;
	}
	
	@Column(name = "CANCEL_BY", length=20)
	public String getCANCEL_BY() {
		return CANCEL_BY;
	}
	public void setCANCEL_BY(String cANCEL_BY) {
		CANCEL_BY = cANCEL_BY;
	}
	
	@Column(name = "BANK_RESP_CODE", length=10)
	public String getBANK_RESP_CODE() {
		return BANK_RESP_CODE;
	}
	public void setBANK_RESP_CODE(String bANK_RESP_CODE) {
		BANK_RESP_CODE = bANK_RESP_CODE;
	}
	
	@Column(name = "BANK_RESP_REMARKS", length=50)
	public String getBANK_RESP_REMARKS() {
		return BANK_RESP_REMARKS;
	}
	public void setBANK_RESP_REMARKS(String bANK_RESP_REMARKS) {
		BANK_RESP_REMARKS = bANK_RESP_REMARKS;
	}
	
	@Column(name = "BANK_REF_NUMER", length=20)
	public String getBANK_REF_NUMER() {
		return BANK_REF_NUMER;
	}
	public void setBANK_REF_NUMER(String bANK_REF_NUMER) {
		BANK_REF_NUMER = bANK_REF_NUMER;
	}
	
	@Column(name = "RRN", length=20)
	public String getRRN() {
		return RRN;
	}
	public void setRRN(String rRN) {
		RRN = rRN;
	}
	
	@Column(name = "BANK_REQUEST_XML", length=200)
	public String getBANK_REQUEST_XML() {
		return BANK_REQUEST_XML;
	}
	public void setBANK_REQUEST_XML(String bANK_REQUEST_XML) {
		BANK_REQUEST_XML = bANK_REQUEST_XML;
	}
	
	@Column(name = "BANK_RESPONSE_XML", length=200)
	public String getBANK_RESPONSE_XML() {
		return BANK_RESPONSE_XML;
	}
	public void setBANK_RESPONSE_XML(String bANK_RESPONSE_XML) {
		BANK_RESPONSE_XML = bANK_RESPONSE_XML;
	}
	
	@Column(name = "RECEIPT_NO", length=20)
	public String getRECEIPT_NO() {
		return RECEIPT_NO;
	}
	public void setRECEIPT_NO(String rECEIPT_NO) {
		RECEIPT_NO = rECEIPT_NO;
	}
	
	@Column(name = "RECEIPT_GENERATION_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getRECEIPT_GENERATION_DATE() {
		return RECEIPT_GENERATION_DATE;
	}
	public void setRECEIPT_GENERATION_DATE(Date rECEIPT_GENERATION_DATE) {
		RECEIPT_GENERATION_DATE = rECEIPT_GENERATION_DATE;
	}
	
	@Column(name = "TXN_RPT_VALIDATED_FLAG", length=1)
	public String getTXN_RPT_VALIDATED_FLAG() {
		return TXN_RPT_VALIDATED_FLAG;
	}
	public void setTXN_RPT_VALIDATED_FLAG(String tXN_RPT_VALIDATED_FLAG) {
		TXN_RPT_VALIDATED_FLAG = tXN_RPT_VALIDATED_FLAG;
	}
	
	@Column(name = "TXN_RPT_GENERATION_FLAG", length=1)
	public String getTXN_RPT_GENERATION_FLAG() {
		return TXN_RPT_GENERATION_FLAG;
	}
	public void setTXN_RPT_GENERATION_FLAG(String tXN_RPT_GENERATION_FLAG) {
		TXN_RPT_GENERATION_FLAG = tXN_RPT_GENERATION_FLAG;
	}
	
	@Column(name = "TXN_RPT_GENERATION_DATE", length=1)
	public String getTXN_RPT_GENERATION_DATE() {
		return TXN_RPT_GENERATION_DATE;
	}
	public void setTXN_RPT_GENERATION_DATE(String tXN_RPT_GENERATION_DATE) {
		TXN_RPT_GENERATION_DATE = tXN_RPT_GENERATION_DATE;
	}
	
	@Column(name = "TXN_RPT_FILE_NAME", length=20)
	public String getTXN_RPT_FILE_NAME() {
		return TXN_RPT_FILE_NAME;
	}
	public void setTXN_RPT_FILE_NAME(String tXN_RPT_FILE_NAME) {
		TXN_RPT_FILE_NAME = tXN_RPT_FILE_NAME;
	}
	
	@Column(name = "ALERT_PROCESSED_FLAG", length=1)
	public String getALERT_PROCESSED_FLAG() {
		return ALERT_PROCESSED_FLAG;
	}
	public void setALERT_PROCESSED_FLAG(String aLERT_PROCESSED_FLAG) {
		ALERT_PROCESSED_FLAG = aLERT_PROCESSED_FLAG;
	}
	
	@Column(name = "ALERT_PROC_REMARKS", length=50)
	public String getALERT_PROC_REMARKS() {
		return ALERT_PROC_REMARKS;
	}
	public void setALERT_PROC_REMARKS(String aLERT_PROC_REMARKS) {
		ALERT_PROC_REMARKS = aLERT_PROC_REMARKS;
	}
	
	@Column(name = "REVERSAL_TOBE_PASSED_FLAG", length=1)
	public String getREVERSAL_TOBE_PASSED_FLAG() {
		return REVERSAL_TOBE_PASSED_FLAG;
	}
	public void setREVERSAL_TOBE_PASSED_FLAG(String rEVERSAL_TOBE_PASSED_FLAG) {
		REVERSAL_TOBE_PASSED_FLAG = rEVERSAL_TOBE_PASSED_FLAG;
	}
	
	@Column(name = "REVERSAL_PASSED_FLAG", length=1)
	public String getREVERSAL_PASSED_FLAG() {
		return REVERSAL_PASSED_FLAG;
	}
	public void setREVERSAL_PASSED_FLAG(String rEVERSAL_PASSED_FLAG) {
		REVERSAL_PASSED_FLAG = rEVERSAL_PASSED_FLAG;
	}
	
	@Column(name = "REVERSAL_REQUEST_XML", length=200)
	public String getREVERSAL_REQUEST_XML() {
		return REVERSAL_REQUEST_XML;
	}
	public void setREVERSAL_REQUEST_XML(String rEVERSAL_REQUEST_XML) {
		REVERSAL_REQUEST_XML = rEVERSAL_REQUEST_XML;
	}
	
	@Column(name = "REVERSAL_RESPONSE_XML", length=200)
	public String getREVERSAL_RESPONSE_XML() {
		return REVERSAL_RESPONSE_XML;
	}
	public void setREVERSAL_RESPONSE_XML(String rEVERSAL_RESPONSE_XML) {
		REVERSAL_RESPONSE_XML = rEVERSAL_RESPONSE_XML;
	}
	
	@Column(name = "REVERSAL_PROC_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getREVERSAL_PROC_DATE() {
		return REVERSAL_PROC_DATE;
	}
	public void setREVERSAL_PROC_DATE(Date rEVERSAL_PROC_DATE) {
		REVERSAL_PROC_DATE = rEVERSAL_PROC_DATE;
	}
	
	@Column(name = "REVERSAL_PROC_REMARKS", length=50)
	public String getREVERSAL_PROC_REMARKS() {
		return REVERSAL_PROC_REMARKS;
	}
	public void setREVERSAL_PROC_REMARKS(String rEVERSAL_PROC_REMARKS) {
		REVERSAL_PROC_REMARKS = rEVERSAL_PROC_REMARKS;
	}
	
	@Column(name = "CREATED_BY", length=20)
	public String getCREATED_BY() {
		return CREATED_BY;
	}
	public void setCREATED_BY(String cREATED_BY) {
		CREATED_BY = cREATED_BY;
	}
	
	@Column(name = "CREATED_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getCREATED_DATE() {
		return CREATED_DATE;
	}
	public void setCREATED_DATE(Date cREATED_DATE) {
		CREATED_DATE = cREATED_DATE;
	}
	
	@Column(name = "MODIFIED_BY", length=20)
	public String getMODIFIED_BY() {
		return MODIFIED_BY;
	}
	public void setMODIFIED_BY(String mODIFIED_BY) {
		MODIFIED_BY = mODIFIED_BY;
	}
	
	@Column(name = "MODIFIED_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getMODIFIED_DATE() {
		return MODIFIED_DATE;
	}
	public void setMODIFIED_DATE(Date mODIFIED_DATE) {
		MODIFIED_DATE = mODIFIED_DATE;
	}

	@Column(name = "RECEIPT_HTML", length=500)
	public String getRECEIPT_HTML() {
		return RECEIPT_HTML;
	}
	public void setRECEIPT_HTML(String rECEIPT_HTML) {
		RECEIPT_HTML = rECEIPT_HTML;
	}
	
	@Column(name = "ALERT_PROCESSED_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getALERT_PROCESSED_DATE() {
		return ALERT_PROCESSED_DATE;
	}
	public void setALERT_PROCESSED_DATE(Date aLERT_PROCESSED_DATE) {
		ALERT_PROCESSED_DATE = aLERT_PROCESSED_DATE;
	}
	
	@Column(name = "REVERSE_ALERT_PROCESS_FLAG", length=1)
	public String getREVERSE_ALERT_PROCESS_FLAG() {
		return REVERSE_ALERT_PROCESS_FLAG;
	}
	public void setREVERSE_ALERT_PROCESS_FLAG(String rEVERSE_ALERT_PROCESS_FLAG) {
		REVERSE_ALERT_PROCESS_FLAG = rEVERSE_ALERT_PROCESS_FLAG;
	}
	

	@Column(name = "REVERSE_ALERT_PROCESS_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getREVERSE_ALERT_PROCESS_DATE() {
		return REVERSE_ALERT_PROCESS_DATE;
	}
	public void setREVERSE_ALERT_PROCESS_DATE(Date rEVERSE_ALERT_PROCESS_DATE) {
		REVERSE_ALERT_PROCESS_DATE = rEVERSE_ALERT_PROCESS_DATE;
	}
	
	@Column(name = "AUTHZ_PENDING_ALERT_FLAG", length=1)
	public String getAUTHZ_PENDING_ALERT_FLAG() {
		return AUTHZ_PENDING_ALERT_FLAG;
	}
	public void setAUTHZ_PENDING_ALERT_FLAG(String aUTHZ_PENDING_ALERT_FLAG) {
		AUTHZ_PENDING_ALERT_FLAG = aUTHZ_PENDING_ALERT_FLAG;
	}
	
	@Column(name = "AUTHZ_PENDING_ALERT_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getAUTHZ_PENDING_ALERT_DATE() {
		return AUTHZ_PENDING_ALERT_DATE;
	}
	public void setAUTHZ_PENDING_ALERT_DATE(Date aUTHZ_PENDING_ALERT_DATE) {
		AUTHZ_PENDING_ALERT_DATE = aUTHZ_PENDING_ALERT_DATE;
	}
	
	@Column(name = "RECON_GENERATION_FLAG", length=1)
	public String getRECON_GENERATION_FLAG() {
		return RECON_GENERATION_FLAG;
	}
	public void setRECON_GENERATION_FLAG(String rECON_GENERATION_FLAG) {
		RECON_GENERATION_FLAG = rECON_GENERATION_FLAG;
	}
	
	@Column(name = "RECON_GENERATION_DATE", length=10)
	@Temporal(TemporalType.DATE)
	public Date getRECON_GENERATION_DATE() {
		return RECON_GENERATION_DATE;
	}
	public void setRECON_GENERATION_DATE(Date rECON_GENERATION_DATE) {
		RECON_GENERATION_DATE = rECON_GENERATION_DATE;
	}
	
	@Column(name = "RECON_FILE_NAME", length=20)
	public String getRECON_FILE_NAME() {
		return RECON_FILE_NAME;
	}
	public void setRECON_FILE_NAME(String rECON_FILE_NAME) {
		RECON_FILE_NAME = rECON_FILE_NAME;
	}
	
	@Column(name = "REVERSAL_TOBE_PASSED_BY", length=20)
	public String getREVERSAL_TOBE_PASSED_BY() {
		return REVERSAL_TOBE_PASSED_BY;
	}
	public void setREVERSAL_TOBE_PASSED_BY(String rEVERSAL_TOBE_PASSED_BY) {
		REVERSAL_TOBE_PASSED_BY = rEVERSAL_TOBE_PASSED_BY;
	}
	
	@Column(name = "REVERSAL_TOBE_PASSED_DATE", length=10)
	@Temporal(TemporalType.DATE)	
	public Date getREVERSAL_TOBE_PASSED_DATE() {
		return REVERSAL_TOBE_PASSED_DATE;
	}
	public void setREVERSAL_TOBE_PASSED_DATE(Date rEVERSAL_TOBE_PASSED_DATE) {
		REVERSAL_TOBE_PASSED_DATE = rEVERSAL_TOBE_PASSED_DATE;
	}
	
	
	

}
