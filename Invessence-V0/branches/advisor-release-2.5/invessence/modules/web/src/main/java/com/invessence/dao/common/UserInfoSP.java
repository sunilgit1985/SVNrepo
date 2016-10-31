package com.invessence.dao.common;


import com.invessence.constant.Const;
import com.invessence.data.*;


import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.object.StoredProcedure;

import java.sql.Types;
import java.util.*;

import org.springframework.jdbc.core.SqlParameter;

public class UserInfoSP extends StoredProcedure
{

   public UserInfoSP(DataSource datasource, String sp_name, Integer mode)
   {

      //super(datasource, "sp_login_add_mod");
      super(datasource, sp_name);
      switch (mode) {
         case 0:
            declareParameter(new SqlParameter("p_addmod", Types.VARCHAR));
            declareParameter(new SqlOutParameter(Const.LOGONID_PARAM, Types.BIGINT));
            declareParameter(new SqlParameter("p_userid", Types.VARCHAR));
            declareParameter(new SqlParameter("p_email", Types.VARCHAR));
            declareParameter(new SqlParameter("p_pwd", Types.VARCHAR));
            declareParameter(new SqlParameter("p_logonstatus", Types.VARCHAR));
            declareParameter(new SqlParameter("p_lastname", Types.VARCHAR));
            declareParameter(new SqlParameter("p_firstname", Types.VARCHAR));
            declareParameter(new SqlParameter("p_state", Types.VARCHAR));
            declareParameter(new SqlParameter("p_emailalt", Types.VARCHAR));
            declareParameter(new SqlParameter("p_leadsource", Types.VARCHAR));
            declareParameter(new SqlParameter("p_question1", Types.VARCHAR));
            declareParameter(new SqlParameter("p_answer1", Types.VARCHAR));
            declareParameter(new SqlParameter("p_question2", Types.VARCHAR));
            declareParameter(new SqlParameter("p_answer2", Types.VARCHAR));
            declareParameter(new SqlParameter("p_question3", Types.VARCHAR));
            declareParameter(new SqlParameter("p_answer3", Types.VARCHAR));
            declareParameter(new SqlParameter("p_ip", Types.VARCHAR));
            declareParameter(new SqlParameter("p_macaddress", Types.VARCHAR));
            declareParameter(new SqlParameter("p_resetID", Types.VARCHAR));
            declareParameter(new SqlParameter("p_cookieID", Types.VARCHAR));
            declareParameter(new SqlParameter("p_emailmsgtype", Types.VARCHAR));
            break;
         case 1:
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            break;
         case 2:
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_userid", Types.VARCHAR));
            declareParameter(new SqlParameter("p_email", Types.VARCHAR));
            declareParameter(new SqlParameter("p_pwd", Types.VARCHAR));
            break;
         case 3:
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_question1", Types.VARCHAR));
            declareParameter(new SqlParameter("p_answer1", Types.VARCHAR));
            declareParameter(new SqlParameter("p_question2", Types.VARCHAR));
            declareParameter(new SqlParameter("p_answer2", Types.VARCHAR));
            declareParameter(new SqlParameter("p_question3", Types.VARCHAR));
            declareParameter(new SqlParameter("p_answer3", Types.VARCHAR));
            break;
         case 4:
            break;
         default:
      }


     compile();
   }


   public Map addUser(String action, UserData data)
   {


      Map inputMap = new HashMap();


      inputMap.put("p_addmod", action);
      inputMap.put("p_logonid", data.getLogonID());
      inputMap.put("p_userid", data.getUserID());
      inputMap.put("p_email", data.getEmailID());
      inputMap.put("p_pwd", data.getPassword());
      if (action.equals("A"))
      {
         inputMap.put("p_logonstatus", "T");
      }
      else
      {
         inputMap.put("p_logonstatus", data.getLogonstatus());
      }

      inputMap.put("p_lastname", data.getLastName());
      inputMap.put("p_firstname", data.getFirstName());


      inputMap.put("p_state", data.getStateCode());

      inputMap.put("p_emailalt", data.getEmailalt());

      inputMap.put("p_leadsource", data.getLeadsource());
      inputMap.put("p_question1", data.getQ1());
      inputMap.put("p_answer1", data.getAns1());
      inputMap.put("p_question2", data.getQ2());
      inputMap.put("p_answer2", data.getAns2());
      inputMap.put("p_question3", data.getQ3());
      inputMap.put("p_answer3", data.getAns3());
      inputMap.put("p_ip", data.getIp());
      inputMap.put("p_macaddress", data.getIp());
      inputMap.put("p_resetID", data.getResetID());
      inputMap.put("p_cookieID", data.getCookieID());
      inputMap.put("p_emailmsgtype", data.getEmailmsgtype());

      return super.execute(inputMap);
   }

   public Map selectUserProfile(Long logonid)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", logonid);
      return super.execute(inputMap);
   }

   public Map updateUserProfile(UserData data)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", data.getLogonID());
      inputMap.put("p_userid", data.getUserID());
      inputMap.put("p_email", data.getEmailID());
      inputMap.put("p_pwd", data.getPassword());
      return super.execute(inputMap);
   }

   public Map updateSecurityQuestions(UserData data)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", data.getLogonID());
      inputMap.put("p_question1", data.getQ1());
      inputMap.put("p_answer1", data.getAns1());
      inputMap.put("p_question2", data.getQ2());
      inputMap.put("p_answer2", data.getAns2());
      inputMap.put("p_question3", data.getQ3());
      return super.execute(inputMap);
   }

}

