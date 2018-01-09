package com.invessence.web.dao.admin;

import java.sql.Types;
import java.util.*;
import javax.sql.DataSource;

import org.springframework.jdbc.core.*;
import org.springframework.jdbc.object.StoredProcedure;
/**
 * Created by sagar on 6/15/2017.
 */
public class AdminEmulationSp extends  StoredProcedure
{

   public AdminEmulationSp(JdbcTemplate datasource, String sp_name, Integer mode,Long logonid)
   {
      super(datasource, sp_name);
      switch (mode) {
         case 0: //
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            break;
         case 1: //
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            declareParameter(new SqlParameter("p_amount", Types.DOUBLE));
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            break;
         default:  // All other (no arg)
            break;
      }
      compile();
   }

   public Map processAccountRequest(Long acctnum,Long logonid)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_acctnum", acctnum);
      inputMap.put("p_logonid", logonid);
      return super.execute(inputMap);
   }

   public Map processAccountAmountRequest(Long acctnum,Double amount,Long logonid)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_acctnum", acctnum);
      inputMap.put("p_amount", amount);
      inputMap.put("p_logonid", logonid);
      return super.execute(inputMap);
   }
}
