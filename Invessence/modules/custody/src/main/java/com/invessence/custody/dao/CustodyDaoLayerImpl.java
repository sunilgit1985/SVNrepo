package com.invessence.custody.dao;

import java.sql.SQLException;
import java.util.*;

import com.invessence.converter.SQLData;
import com.invessence.custody.data.*;
import com.invessence.custody.uob.data.*;
import com.invessence.ws.bean.DBResponse;
import com.invessence.ws.provider.td.dao.SPDCRequestAuditrial;
import com.invessence.ws.util.WSConstants;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
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
   public List<CustodyFileRequest> fetchUploadedFiles(String Product, Long acctNum, String action)
   {
      List<CustodyFileRequest> objCstdFileLst=null;
      try
      {
         objCstdFileLst=new ArrayList<CustodyFileRequest>();
         SQLData convert = new SQLData();
         CustodySP sp = new CustodySP(webServiceJdbcTemplate, "sel_custody_file_rqst_dtls", 12);
         Map outMap = sp.fetchUploadedFiles(  Product,  acctNum, action);
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            int i = 0;
            for (Map<String, Object> map : rows)
            {
               CustodyFileRequest custodyFileRequest=new CustodyFileRequest();
               Map rs = (Map) rows.get(i);
               custodyFileRequest.setReqId(convert.getLongData(rs.get("reqId")));
               custodyFileRequest.setProduct(convert.getStrData(rs.get("product")));
               custodyFileRequest.setAcctnum(convert.getLongData(rs.get("acctnum")));
               custodyFileRequest.setAction(convert.getStrData(rs.get("action")));
               custodyFileRequest.setRequestFor(convert.getStrData(rs.get("requestFor")));
               custodyFileRequest.setSeqno(convert.getIntData(rs.get("seqno")));
               custodyFileRequest.setFileName(convert.getStrData(rs.get("fileName")));
               custodyFileRequest.setFilePath(convert.getStrData(rs.get("filePath")));
               custodyFileRequest.setReqType(convert.getStrData(rs.get("reqType")));
               objCstdFileLst.add(custodyFileRequest);
               i++;
            }
         }
      }
      catch (Exception ex)
      {
         System.out.println("UOBCustodyServiceImpl.fetchUploadedFiles Exception " + ex);
         ex.printStackTrace();
      }
      return objCstdFileLst;
   }


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

   @Override
   public boolean callDCAuditSP(AORequestAudit aoRequest)
   {
      try
      {
         logger.info("CustodyDaoLayerImpl.callDCAuditSP");
         logger.debug("aoRequest = " + aoRequest);

         CustodySP requestAuditrialSP = new CustodySP(webServiceJdbcTemplate, "ao_request_auditrial", 21);
         aoRequest.setResTime(new Date());
         aoRequest.setOpt(WSConstants.dbInsertOpt);
         logger.debug("dcRequest.setOpt = " + aoRequest.getOpt());
         DBResponse dbResponse = requestAuditrialSP.audit(aoRequest);
         logger.debug("dbResponse = [" + dbResponse.toString() + "]");
      }catch (Exception e){
         logger.error("Issue while storing web request in DB :"+e.getMessage());

      }
      return true;
   }
}
