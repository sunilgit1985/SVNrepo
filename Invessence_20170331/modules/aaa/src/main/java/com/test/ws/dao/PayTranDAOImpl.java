package com.test.ws.dao;

import com.test.ws.entity.Transaction;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PayTranDAOImpl implements PayTranDAO {

	@Autowired
    private SessionFactory sessionFactory;
	

	public Transaction insertTransaction(Transaction transaction) {
		try {
			sessionFactory.getCurrentSession().save(transaction);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return transaction;
	}

	public Transaction updateTransaction(Transaction transaction) {
		try {
			sessionFactory.getCurrentSession().merge(transaction);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return transaction;
	}

	
	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}


}
