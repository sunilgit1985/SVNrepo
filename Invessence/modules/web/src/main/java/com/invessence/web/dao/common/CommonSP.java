package com.invessence.web.dao.common;


import java.sql.Types;
import java.util.*;
import javax.sql.DataSource;

import com.invessence.web.data.common.NotificationData;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.StoredProcedure;


@SuppressWarnings({"unchecked", "DuplicateStringLiteralInspection"})
public class CommonSP extends StoredProcedure
{

   public CommonSP(DataSource datasource, String sp_name, Integer mode)
   {
      super(datasource, sp_name);
      switch (mode) {
         case 0:
            break;
         case 1: // SP: sp_validate_state
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_state", Types.VARCHAR));
            break;
         case 2: // SP: sel_notification
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_messagetype", Types.VARCHAR));
            declareParameter(new SqlParameter("p_archive", Types.VARCHAR));
            break;
         case 3: // SP: sp_advisor_notification
            declareParameter(new SqlParameter("p_messageid", Types.BIGINT));
            declareParameter(new SqlParameter("p_status", Types.VARCHAR));
            declareParameter(new SqlParameter("p_advisorlogonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_advisor", Types.VARCHAR));
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            declareParameter(new SqlParameter("p_noticetype", Types.VARCHAR));
            declareParameter(new SqlParameter("p_tagid", Types.VARCHAR));
            declareParameter(new SqlParameter("p_alertdatetime", Types.VARCHAR));
            declareParameter(new SqlParameter("p_message", Types.VARCHAR));
            break;
         case 4: // SP: sel_web_site_info
            declareParameter(new SqlParameter("p_url", Types.VARCHAR));
            break;
         case 5: // SP: sel_advisor_web_info
            declareParameter(new SqlParameter("p_advisor", Types.VARCHAR));
            break;
         case 6: // SP: sel_advisor_web_info
            declareParameter(new SqlParameter("p_url", Types.VARCHAR));
            declareParameter(new SqlParameter("p_access", Types.VARCHAR));
            break;
         case 7: // SP: sel_user_advisor_details
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            break;
         case 8: // SP: sel_user_advisor_details
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_access", Types.VARCHAR));
            break;
         case 9: // sel_notification_advisor or sel_notification_consumer
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_messagetype", Types.VARCHAR));
            declareParameter(new SqlParameter("p_archive", Types.VARCHAR));
            declareParameter(new SqlParameter("p_advisor", Types.VARCHAR));
            declareParameter(new SqlParameter("p_rep", Types.VARCHAR));
            break;
         case 10: // SP: sav_notification_consumer
            declareParameter(new SqlParameter("p_messageid", Types.BIGINT));
            declareParameter(new SqlParameter("p_status", Types.VARCHAR));
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_advisor", Types.VARCHAR));
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            declareParameter(new SqlParameter("p_noticetype", Types.VARCHAR));
            declareParameter(new SqlParameter("p_tagid", Types.VARCHAR));
            declareParameter(new SqlParameter("p_alertdatetime", Types.VARCHAR));
            declareParameter(new SqlParameter("p_message", Types.VARCHAR));
            declareParameter(new SqlParameter("p_flag", Types.VARCHAR));
            declareParameter(new SqlParameter("p_link", Types.VARCHAR));
            break;
         case 11: // SP: sel_webpages_menu_items
            declareParameter(new SqlParameter("p_advisor", Types.VARCHAR));
            break;
         case 12: // sel_notification_advisor or sel_notification_consumer
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            declareParameter(new SqlParameter("p_messagetype", Types.VARCHAR));
            declareParameter(new SqlParameter("p_archive", Types.VARCHAR));
            break;
         case 99: // SP: sel_notificationInfo
            declareParameter(new SqlParameter("p_logonid", Types.BIGINT));
            break;
         default:
      }
      compile();
   }

   public Map collectProfileData(Long logonid, Long acctnum)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", logonid);
      inputMap.put("p_acctnum", acctnum);
      return super.execute(inputMap);
   }

   public Map validateState(Long acctnum, String state)
   {
      String info = "";
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", acctnum);
      inputMap.put("p_state", state);
      return super.execute(inputMap);
   }

   public Map getNotification(Long acctnum, String messagetype, String status)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", acctnum);
      inputMap.put("p_messagetype", messagetype);
      inputMap.put("p_archive", status);
      return super.execute(inputMap);
   }

   public void saveNotice(NotificationData data)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_messageid", data.getMessageid());
      inputMap.put("p_status", data.getStatus());
      inputMap.put("p_advisorlogonid", data.getAdvisorlogonid());
      inputMap.put("p_advisor", data.getAdvisor());
      inputMap.put("p_acctnum", data.getAcctnum());
      inputMap.put("p_noticetype", data.getNoticetype());
      inputMap.put("p_tagid", data.getTagid());
      inputMap.put("p_alertdatetime", data.getBusinessdate());
      inputMap.put("p_message", data.getMessage());
      super.execute(inputMap);
   }

   public Map getNotificationInfo(Long acctnum)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", acctnum);
      return super.execute(inputMap);
   }

   public Map getWebSiteInfo(String url)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_url", url);
      return super.execute(inputMap);
   }

   public Map getAdvisorWebInfo(String advisor)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_advisor", advisor);
      return super.execute(inputMap);
   }
   public Map getWebMenuInfo(String url,String access)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_url", url);
      inputMap.put("p_access", access);
      return super.execute(inputMap);
   }

   public Map getUserRepInfo(long logonid)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", logonid);
      return super.execute(inputMap);
   }

   public Map getNotificationCnt(long logonid,String access)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", logonid);
      inputMap.put("p_access", access);
      return super.execute(inputMap);
   }

   public Map getNotificationDtls(Long logonid, String messageType, String status,String advisor,String rep)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", logonid);
      inputMap.put("p_messagetype", messageType);
      inputMap.put("p_archive", status);
      inputMap.put("p_advisor", advisor);
      inputMap.put("p_rep", rep);
      return super.execute(inputMap);
   }


   public Map getNotificationConsumerDtls(Long logonid, String messageType, String status)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_logonid", logonid);
      inputMap.put("p_messagetype", messageType);
      inputMap.put("p_archive", status);
      return super.execute(inputMap);
   }




   public void saveConsumerNotification(NotificationData data,long logonid)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_messageid", data.getMessageid());
      inputMap.put("p_status", data.getStatus());
      inputMap.put("p_logonid", logonid);
      inputMap.put("p_advisor", data.getAdvisor());
      inputMap.put("p_acctnum", data.getAcctnum());
      inputMap.put("p_noticetype", data.getNoticetype());
      inputMap.put("p_tagid", data.getTagid());
      inputMap.put("p_alertdatetime", data.getBusinessdate());
      inputMap.put("p_message", data.getMessage());
      inputMap.put("p_flag", "E");
      inputMap.put("p_link", data.getLink());

      super.execute(inputMap);
   }

   public Map loadWebPagesMenuItems(String advisor)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_advisor", advisor);
      return super.execute(inputMap);
   }

}
