package com.test.ws.resp;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class CommResp {


	private String RESP_CODE;
	private String RESP_DESCRIPTION;
	
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
	
	@Override
	public String toString() {
		return "CommResp [RESP_CODE=" + RESP_CODE + ", RESP_DESCRIPTION=" + RESP_DESCRIPTION + "]";
	}
	
	
	
	
}
