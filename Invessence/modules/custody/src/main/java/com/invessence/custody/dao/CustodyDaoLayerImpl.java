package com.invessence.custody.dao;

import java.sql.SQLException;
import java.util.*;

import com.docusign.esign.model.EnvelopeSummary;
import com.invessence.converter.SQLData;
import com.invessence.custody.data.AORequest;
import com.invessence.custody.uob.UOBDataMaster;
import com.invessence.custody.uob.data.OwnerDetails;
import com.invessence.ws.bean.DBResponse;
import com.invessence.ws.provider.td.bean.*;
import com.invessence.ws.provider.td.dao.SPDCRequestAuditrial;
import com.invessence.ws.util.WSConstants;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.ParameterizedBeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

/**
 * Created by abhangp on 8/17/2016.
 */
@Repository
public class CustodyDaoLayerImpl implements CustodyDaoLayer
{
   private static final Logger logger = Logger.getLogger(CustodyDaoLayerImpl.class);

   @Autowired
   JdbcTemplate webServiceJdbcTemplate;
   SQLData sqlData = new SQLData();

   private final String getDCRequests="select * from vwdc_requests where eventNum =? and acctnum=? and status='I'";
   private final String getAcctDetails="select * from vwdc_acct_details where acctnum=? ";
   private final String getBenefiaciaryDetails="select * from vwdc_benefiaciary_details where acctnum=? ";
   private final String getDupDocReqPartyDetails="select * from vwdc_employment_details where acctnum=? and 1=2";


   private final String getAcctOwnerDetails="select * from vwdc_acct_owners_details where acctnum=? ";
   private final String getEmploymentDetails="select * from vwdc_employment_details where acctnum=? and acctOwnerId=?";
   private final String getVisaDetails="select * from vwdc_visa_details where acctnum=? and 1=2";
   private final String updateEnvelopDetails="update dc_requests set envelopeId=? where eventNum=?";
   private final String insertReqAudit = "insert into dc_request_audit(eventNum, envelopeDetails, status, remarks, reqTime, resTime) value (?,?,?,?,?,?)";

   // Move Money
   private final String getMove_money_details="select * from vwdc_move_money_details where reqId =? and acctnum=? ";
   private final String getMMAchBankDetails="select * from vwdc_mm_ach_bank_details where moveMoneyPayMethodID =? ";
   private final String getMMFedwireAcctDetails="select * from vwdc_mm_internal_transfer_details where moveMoneyPayMethodID =? ";
   private final String getMMInternalTransferDetails="select * from vwdc_mm_fedwire_acct_details where moveMoneyPayMethodID =? ";

   private final String getAcctTransferDetails="select * from vwdc_acct_transfer_details where reqId=? and acctnum=?";
   private final String getTDTransferDetails="select * from vwdc_td_transfer_details where reqId=? and acctnum=?";

   private final String getElecFundTransferDetails="select * from vwdc_elecfund_transfer_details where reqId=? and acctnum=?";

   private final String getAcctChngAddrDetails ="select * from vwdc_td_chng_addrs_details where accountNumber=?";




   @Override
   public List<AORequest> getAORequests(Long acctNum, Integer eventNum) throws SQLException
   {
      List<AORequest> aoRequests=new LinkedList<>();
      try
      {
         CustodySP serviceSP = new CustodySP(webServiceJdbcTemplate, "spao_requests", 20);
         try
         {
            Map outMap = serviceSP.getAORequests(acctNum, eventNum);
            if (outMap != null)
            {
               ArrayList<LinkedHashMap<String, Object>> rows = (ArrayList<LinkedHashMap<String, Object>>) outMap.get("#result-set-1");

               if(rows.size()>0)
               {
                  Iterator<LinkedHashMap<String, Object>> itr = rows.iterator();

                  while (itr.hasNext())
                  {
                     StringBuilder fileRow = new StringBuilder();
                     LinkedHashMap<String, Object> map = itr.next();
                     AORequest aoRequest = new AORequest();
                     sqlData.getObjectFormCOLUMN(map, aoRequest);
                     aoRequests.add(aoRequest);
                  }
               }
//               return aoRequests;
            }
         }
         catch (Exception ex)
         {
            ex.printStackTrace();
         }
      }
      catch (Exception e)
      {
         logger.error("Issue while storing web request in DB :" + e.getMessage());
      }
      return aoRequests;
   }
}
