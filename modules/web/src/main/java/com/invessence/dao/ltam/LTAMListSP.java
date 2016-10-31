package com.invessence.dao.ltam;


import java.sql.Types;
import java.util.*;
import javax.sql.DataSource;

import com.invessence.data.ltam.LTAMCustomerData;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.StoredProcedure;


public class LTAMListSP extends StoredProcedure
{

   public LTAMListSP(DataSource datasource, String sp_name, Integer mode)
   {
      super(datasource, sp_name);
      switch (mode) {
         case 0:   // SP: sel_ClientProfileData2
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            break;
         case 1:   // SP: sel_newClient
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            break;
         case 2:   // SP: sel_newClient
            break;
         case 3:   // SP: sel_newClient
            break;
         default:
      }
      compile();
   }

   @SuppressWarnings({"unchecked", "rawtypes"})
   public Map loadClientProfileData(Long logonid, Long acctnum)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", logonid);
      inputMap.put("p_acctnum", acctnum);
      return super.execute(inputMap);
   }

   public Map loadClientProfileData(LTAMCustomerData data)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", data.getLogonid());
      inputMap.put("p_acctnum", data.getAcctnum());
      return super.execute(inputMap);
   }

}
