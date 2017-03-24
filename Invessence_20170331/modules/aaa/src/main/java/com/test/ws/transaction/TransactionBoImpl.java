package com.test.ws.transaction;

import com.test.ws.resp.TranCreaResp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.test.ws.dao.PayTranDAO;
import com.test.ws.entity.Transaction;
import com.test.ws.resp.TranProcResp;

@Service
@Transactional
public class TransactionBoImpl implements TransactionBo {

	@Autowired
	PayTranDAO payTranDAO;
	public String save() {

		return "Jersey + Spring example";

	}

	public TranCreaResp createTran(Transaction transaction) {
		// TODO Auto-generated method stub
		TranCreaResp creaResp=null;
	try{
		Transaction tranDetails = payTranDAO.insertTransaction(transaction);
	
		creaResp=new TranCreaResp(tranDetails.getREQUEST_ID(), 
				tranDetails.getMERCHANT_ID(), 
				tranDetails.getMERCHANT_REFERENCE_NO().toString(), 
				"0000", 
				"Success", 
				tranDetails.getREQUEST_ID().toString(), 
				tranDetails.getREQUEST_DATE(), 
				"CHECKSUM");
	}catch(Exception e){
		e.printStackTrace();
	}
	
		return creaResp;
	}

	public TranProcResp processTran(Transaction transaction) {
		// TODO Auto-generated method stub
		
		TranProcResp procResp=null;
		try{
			Transaction tranDetails = payTranDAO.updateTransaction(transaction);
		
			procResp=new TranProcResp(tranDetails.getREQUEST_ID(), 
					tranDetails.getMERCHANT_ID(), 
					tranDetails.getMERCHANT_REFERENCE_NO().toString(), 
					"0000", 
					"Success", 
					tranDetails.getREQUEST_ID().toString(), 
					tranDetails.getREQUEST_DATE(), 
					"CHECKSUM");
		}catch(Exception e){
			e.printStackTrace();
		}
				
		return procResp;
	}

	public PayTranDAO getPayTranDAO() {
		return payTranDAO;
	}

	public void setPayTranDAO(PayTranDAO payTranDAO) {
		this.payTranDAO = payTranDAO;
	}

	
}