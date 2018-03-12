package com.invessence.web.dao.consumer;

import java.io.Serializable;

import javax.faces.bean.*;
import javax.sql.DataSource;

import com.invessence.converter.SQLData;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 * Created by sagar on 1/31/2018.
 */

@ManagedBean(name = "consumerAuditDataDAO")
@SessionScoped
public class ConsumerAuditDataDAO  extends JdbcDaoSupport implements Serializable
{
   SQLData convert = new SQLData();

   public void auditClientProfile(Long acctnum)
   {
      try
      {
         DataSource ds = getDataSource();
         ConsumerAuditSP sp = new ConsumerAuditSP(ds, "audit.sp_client_profile_audit", 1);
         sp.auditClientProfile(acctnum);
      }catch (Exception ex){
         ex.printStackTrace();
      }
   }
}
