package com.invessence.web.dao.consumer;

import java.sql.Types;
import java.util.*;
import javax.sql.DataSource;

import org.springframework.jdbc.core.*;
import org.springframework.jdbc.object.StoredProcedure;

/**
 * Created by sagar on 1/31/2018.
 */

@SuppressWarnings({"unchecked", "DuplicateStringLiteralInspection"})
public class ConsumerAuditSP  extends StoredProcedure
{
   public ConsumerAuditSP(DataSource datasource, String sp_name, Integer mode)
   {
      super(datasource, sp_name);
      switch (mode) {
         case 1: // save_user_trade_profile_audit
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            break;
      }
      compile();
   }

   @SuppressWarnings({"unchecked", "rawtypes"})
   public void auditClientProfile(Long acctnum)
   {
      Map inputMap = new HashMap();

      inputMap.put("p_acctnum", acctnum);
      super.execute(inputMap);
   }
}
