package com.test.ws.rest;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.test.ws.entity.Transaction;
import com.test.ws.resp.TranCreaResp;
import com.test.ws.resp.TranProcResp;
import com.test.ws.transaction.TransactionBo;

@Component
@Path("/payment")
public class PaymentService {

	@Autowired
	TransactionBo transactionBo;

	@POST
	@Path("/createTrans")
	@Produces(MediaType.APPLICATION_XML)
	public Response createTransaction(@FormParam("MESSAGE_ID")String MESSAGE_ID,                 
			@FormParam("MERCHANT_ID") String MERCHANT_ID,                
			@FormParam("MERCHANT_REFERENCE_NUMBER") String MERCHANT_REFERENCE_NUMBER,  
			@FormParam("VENDOR_ID") String VENDOR_ID,                  
			@FormParam("DELIVERY_BOY_ID") String DELIVERY_BOY_ID,            
			@FormParam("AMOUNT") String AMOUNT,                     
			@FormParam("TID") String TID,                        
			@FormParam("TRANSACTION_CD") String TRANSACTION_CD,
			@FormParam("CHECKSUM") String CHECKSUM) {
		
		System.out.println("PaymentService.createTransaction()");
		System.out.println("MESSAGE_ID: " + MESSAGE_ID);                 
		System.out.println("MERCHANT_ID: " + MERCHANT_ID);                
		System.out.println("MERCHANT_REFERENCE_NUMBER: " + MERCHANT_REFERENCE_NUMBER);  
		System.out.println("VENDOR_ID: " + VENDOR_ID);                  
		System.out.println("DELIVERY_BOY_ID: " + DELIVERY_BOY_ID);            
		System.out.println("AMOUNT: " + AMOUNT);                     
		System.out.println("TID: " + TID);                        
		System.out.println("TRANSACTION_CD: " + TRANSACTION_CD);
		System.out.println("CHECKSUM: " + CHECKSUM);
		
		
		Transaction tran=new Transaction(MESSAGE_ID, MERCHANT_ID, 
				Long.valueOf(MERCHANT_REFERENCE_NUMBER), 
				VENDOR_ID, 
				DELIVERY_BOY_ID, 
				Double.valueOf(AMOUNT), 
				TID, TRANSACTION_CD, 
				CHECKSUM);
		TranCreaResp result = transactionBo.createTran(tran);

		return Response.status(200).entity(result).build();

	}
	
	
	@POST
	@Path("/processTrans")
	@Produces(MediaType.APPLICATION_XML)
	public Response processTransaction(@FormParam("MESSAGE_ID") String MESSAGE_ID,                 
			@FormParam("MERCHANT_ID") String MERCHANT_ID,                
			@FormParam("MERCHANT_REFERENCE_NUMBER") String MERCHANT_REFERENCE_NUMBER,  
			@FormParam("PAYSO_TXN_ID") String PAYSO_TXN_ID,               
			@FormParam("REQUEST_TYPE") String REQUEST_TYPE,               
			@FormParam("AUTH_REMARKS") String AUTH_REMARKS,               
			@FormParam("DATE_TIME") String DATE_TIME,                  
			@FormParam("REQUESTED_BY") String REQUESTED_BY,               
			@FormParam("CHECKSUM") String CHECKSUM) {

		System.out.println("PaymentService.processTransaction()");
		System.out.println("MESSAGE ID: " + MESSAGE_ID);                 
		System.out.println("MERCHANT ID: " + MERCHANT_ID);                
		System.out.println("MERCHANT REFERENCE NUMBER: " + MERCHANT_REFERENCE_NUMBER);  
		System.out.println("PAYSO_TXN_ID: " + PAYSO_TXN_ID);               
		System.out.println("REQUEST_TYPE: " + REQUEST_TYPE);               
		System.out.println("AUTH_REMARKS: " + AUTH_REMARKS);               
		System.out.println("DATE_TIME: " + DATE_TIME);                  
		System.out.println("REQUESTED_BY: " + REQUESTED_BY);               
		System.out.println("CHECKSUM:" + CHECKSUM); 
		
		Transaction tran=new Transaction(MESSAGE_ID, MERCHANT_ID, Long.valueOf(MERCHANT_REFERENCE_NUMBER), Long.valueOf(PAYSO_TXN_ID), REQUEST_TYPE, AUTH_REMARKS, DATE_TIME, REQUESTED_BY, CHECKSUM);
		
		
		TranProcResp result = transactionBo.processTran(tran);

		return Response.status(200).entity(result).build();

	}

	@GET
	@Path("/save")
	public Response save(){
		
		String result = transactionBo.save();
		return Response.status(200).entity(result).build();
	}
}