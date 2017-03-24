package com.test.ws.dao;

import com.test.ws.entity.Transaction;

public interface PayTranDAO {
	
	public Transaction insertTransaction(Transaction transaction);
	
	public Transaction updateTransaction(Transaction transaction);	
	
}
