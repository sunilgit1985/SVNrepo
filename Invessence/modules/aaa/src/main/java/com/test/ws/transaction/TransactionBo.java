package com.test.ws.transaction;

import com.test.ws.entity.Transaction;
import com.test.ws.resp.TranCreaResp;
import com.test.ws.resp.TranProcResp;

public interface TransactionBo{
 
	String save();
	public TranCreaResp createTran(Transaction transaction);
	public TranProcResp processTran(Transaction transaction);
 
}