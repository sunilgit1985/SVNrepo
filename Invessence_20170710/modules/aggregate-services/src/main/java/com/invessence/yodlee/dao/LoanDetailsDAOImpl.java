package com.invessence.yodlee.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.invessence.yodlee.model.BankDetail;
import com.invessence.yodlee.model.LoanDetail;
import com.invessence.yodlee.util.HibernateUtil;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class LoanDetailsDAOImpl implements LoanDetailsDAO {

	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	HibernateUtil hibernateutil;

	public LoanDetail insertLoanDetails(LoanDetail loanDetails) {
		try {
			sessionFactory.getCurrentSession().save(loanDetails);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return loanDetails;
	}

	public LoanDetail updateLoanDetails(LoanDetail loanDetails) {
		try {
			sessionFactory.getCurrentSession().update(loanDetails);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return loanDetails;
	}

	public LoanDetail deleteLoanDetails(LoanDetail loanDetails) {
		try {
			sessionFactory.getCurrentSession().delete(loanDetails);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return loanDetails;
	}

	public List<LoanDetail> getLoanDetailsList() {
		List<LoanDetail> list = null;
		try {
			list = sessionFactory.getCurrentSession().createQuery("from LoanDetail").list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public LoanDetail findByPK(Long Id) {
		List<LoanDetail> lst = null;
		try {
			lst = (List<LoanDetail>) sessionFactory.getCurrentSession()
					.createQuery("from LoanDetail sm where sm.SM_ID=:ID").setLong("ID", Id).list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lst == null ? null : lst.size() == 0 ? null : lst.get(0);
	}

	public List<LoanDetail> findByWhereCluase(String where, Object[] values) {
		List<LoanDetail> list = null;
		try {
			list = hibernateutil.executeSQLQuery(sessionFactory.getCurrentSession(), "ydl_loan_details", LoanDetail.class,
					where, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<LoanDetail> findByWhereCluase(String where) {
		List<LoanDetail> lst = null;
		try {
			lst = (List<LoanDetail>) sessionFactory.getCurrentSession().createQuery("from LoanDetail where " + where)
					.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lst;
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

}
