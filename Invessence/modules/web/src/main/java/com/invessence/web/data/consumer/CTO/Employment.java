package com.invessence.web.data.consumer.CTO;

import java.util.Date;

public class Employment
{

	private Long acctnum;
    private String occupation;
	private String securityaffiliatedemployee;
	private String status;
	private String safirmrelationship;
	private Date dateofemployment;
	private String safirmname;
	private String employername;
	private String sapersonname;
	private String employeraddress;
	

    public Long getAcctnum() {
		return acctnum;
	}
	public void setAcctnum(Long acctnum) {
		this.acctnum = acctnum;
	}
    public String getOccupation() {
        return occupation;
    }
    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }
    public String getSecurityaffiliatedemployee() {
        return securityaffiliatedemployee;
    }
    public void setSecurityaffiliatedemployee(String securityaffiliatedemployee) {
        this.securityaffiliatedemployee = securityaffiliatedemployee;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getSafirmrelationship() {
        return safirmrelationship;
    }
    public void setSafirmrelationship(String safirmrelationship) {
        this.safirmrelationship = safirmrelationship;
    }
    public Date getDateofemployment() {
        return dateofemployment;
    }
    public void setDateofemployment(Date dateofemployment) {
        this.dateofemployment = dateofemployment;
    }
    public String getSafirmname() {
        return safirmname;
    }
    public void setSafirmname(String safirmname) {
        this.safirmname = safirmname;
    }
    public String getEmployername() {
        return employername;
    }
    public void setEmployername(String employername) {
        this.employername = employername;
    }
    public String getSapersonname() {
        return sapersonname;
    }
    public void setSapersonname(String sapersonname) {
        this.sapersonname = sapersonname;
    }
    public String getEmployeraddress() {
        return employeraddress;
    }
    public void setEmployeraddress(String employeraddress) {
        this.employeraddress = employeraddress;
    }
}
