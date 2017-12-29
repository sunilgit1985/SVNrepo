package com.invessence.custody.dao;

import java.sql.*;
import java.util.*;

import com.invessence.custody.data.AORequestAudit;
import com.invessence.custody.uob.data.*;
import com.invessence.ws.bean.DBResponse;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.object.StoredProcedure;

/**
 * Created by abhangp on 10/26/2017.
 */
public class CustodySP extends StoredProcedure
{
   public CustodySP(JdbcTemplate datasource, String SPROC_NAME, Integer mode)
   {
      super(datasource, SPROC_NAME);
      switch (mode)
      {
         case 0: //File Processor Audit
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            break;
         case 1:
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_clientAccountID", Types.VARCHAR));
            declareParameter(new SqlParameter("p_repId", Types.VARCHAR));
            declareParameter(new SqlParameter("p_caseNumber", Types.VARCHAR));
            declareParameter(new SqlParameter("p_advisorId", Types.VARCHAR));
            declareParameter(new SqlParameter("p_acctTypeId", Types.VARCHAR));
            declareParameter(new SqlParameter("p_logonId", Types.VARCHAR));
            break;
         case 2:
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_acctOwnerId", Types.NUMERIC));
            declareParameter(new SqlParameter("p_title", Types.VARCHAR));
            declareParameter(new SqlParameter("p_fullName", Types.VARCHAR));
            declareParameter(new SqlParameter("p_gender", Types.VARCHAR));
            declareParameter(new SqlParameter("p_dob", Types.VARCHAR));
            declareParameter(new SqlParameter("p_countryOfBirth", Types.VARCHAR));
            declareParameter(new SqlParameter("p_emailAddress", Types.VARCHAR));
            declareParameter(new SqlParameter("p_ownership", Types.VARCHAR));
            declareParameter(new SqlParameter("p_logonId", Types.VARCHAR));
            break;
         case 3:
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_acctOwnerId", Types.NUMERIC));
            declareParameter(new SqlParameter("p_name", Types.VARCHAR));
            declareParameter(new SqlParameter("p_value", Types.VARCHAR));
            declareParameter(new SqlParameter("p_table", Types.VARCHAR));
            break;
         case 4:
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_acctOwnerId", Types.NUMERIC));
            declareParameter(new SqlParameter("p_emplId", Types.NUMERIC));
            declareParameter(new SqlParameter("p_emplTypeId", Types.VARCHAR));
            declareParameter(new SqlParameter("p_sourceOfIncome", Types.VARCHAR));
            declareParameter(new SqlParameter("p_employerName", Types.VARCHAR));
            declareParameter(new SqlParameter("p_occupation", Types.VARCHAR));
            declareParameter(new SqlParameter("p_typeOfBusiness", Types.VARCHAR));
            declareParameter(new SqlParameter("p_employerStreetAddress1", Types.VARCHAR));
            declareParameter(new SqlParameter("p_employerStreetAddress2", Types.VARCHAR));
            declareParameter(new SqlParameter("p_employerStreetAddress3", Types.VARCHAR));
            declareParameter(new SqlParameter("p_employerStreetAddress4", Types.VARCHAR));
            declareParameter(new SqlParameter("p_employerCity", Types.VARCHAR));
            declareParameter(new SqlParameter("p_employerState", Types.VARCHAR));
            declareParameter(new SqlParameter("p_employerZipCode", Types.VARCHAR));
            declareParameter(new SqlParameter("p_employerZipCountry", Types.VARCHAR));
            declareParameter(new SqlParameter("p_fromDate", Types.VARCHAR));
            declareParameter(new SqlParameter("p_toDate", Types.VARCHAR));
            declareParameter(new SqlParameter("p_logonId", Types.VARCHAR));
            break;
         case 5:
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_acctOwnerId", Types.NUMERIC));
            declareParameter(new SqlParameter("p_physicalAddressStreet1", Types.VARCHAR));
            declareParameter(new SqlParameter("p_physicalAddressStreet2", Types.VARCHAR));
            declareParameter(new SqlParameter("p_physicalAddressStreet3", Types.VARCHAR));
            declareParameter(new SqlParameter("p_physicalAddressStreet4", Types.VARCHAR));
            declareParameter(new SqlParameter("p_physicalAddressCity", Types.VARCHAR));
            declareParameter(new SqlParameter("p_physicalAddressState", Types.VARCHAR));
            declareParameter(new SqlParameter("p_physicalAddressZipCode", Types.VARCHAR));
            declareParameter(new SqlParameter("p_physicalAddressCountry", Types.VARCHAR));
            declareParameter(new SqlParameter("p_mailingAddressStreet1", Types.VARCHAR));
            declareParameter(new SqlParameter("p_mailingAddressStreet2", Types.VARCHAR));
            declareParameter(new SqlParameter("p_mailingAddressStreet3", Types.VARCHAR));
            declareParameter(new SqlParameter("p_mailingAddressStreet4", Types.VARCHAR));
            declareParameter(new SqlParameter("p_mailingAddressCity", Types.VARCHAR));
            declareParameter(new SqlParameter("p_mailingAddressState", Types.VARCHAR));
            declareParameter(new SqlParameter("p_mailingAddressZipCode", Types.VARCHAR));
            declareParameter(new SqlParameter("p_mailingAddressCountry", Types.VARCHAR));
            declareParameter(new SqlParameter("p_logonId", Types.VARCHAR));
            break;
         case 6:
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_acctOwnerId", Types.NUMERIC));
            declareParameter(new SqlParameter("p_category", Types.VARCHAR));
            declareParameter(new SqlParameter("p_id", Types.NUMERIC));
            declareParameter(new SqlParameter("p_name", Types.VARCHAR));
            declareParameter(new SqlParameter("p_value", Types.VARCHAR));
            break;
         case 7:
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_acctOwnerId", Types.NUMERIC));
            declareParameter(new SqlParameter("p_category", Types.VARCHAR));
            break;
         case 8:
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_name", Types.VARCHAR));
            declareParameter(new SqlParameter("p_value", Types.VARCHAR));
            declareParameter(new SqlParameter("p_table", Types.VARCHAR));
            break;
         case 9:
            declareParameter(new SqlParameter("p_advisor", Types.VARCHAR));
            break;
         case 10:
            declareParameter(new SqlParameter("p_product", Types.VARCHAR));
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_reqType", Types.VARCHAR));
            break;
         case 11:
            declareParameter(new SqlParameter("p_reqId", Types.NUMERIC));
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_product", Types.VARCHAR));
            declareParameter(new SqlParameter("p_action", Types.VARCHAR));
            declareParameter(new SqlParameter("p_requestFor", Types.VARCHAR));
            declareParameter(new SqlParameter("p_fileName", Types.VARCHAR));
            declareParameter(new SqlParameter("p_filePath", Types.VARCHAR));
            declareParameter(new SqlParameter("p_reqType", Types.VARCHAR));
            declareParameter(new SqlParameter("p_logonId", Types.VARCHAR));
            declareParameter(new SqlParameter("p_seqno", Types.NUMERIC));
            break;
         case 12:
            declareParameter(new SqlParameter("p_product", Types.VARCHAR));
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_action", Types.VARCHAR));
            break;
         case 13:
            declareParameter(new SqlParameter("p_product", Types.VARCHAR));
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_advisorid", Types.NUMERIC));
            declareParameter(new SqlParameter("p_reqType", Types.VARCHAR));
            break;
         case 14:
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_acctOwnerId", Types.NUMERIC));
            declareParameter(new SqlParameter("p_bankName", Types.VARCHAR));
            declareParameter(new SqlParameter("p_bankAccountNo", Types.VARCHAR));
            declareParameter(new SqlParameter("p_bankAddressStreet1", Types.VARCHAR));
            declareParameter(new SqlParameter("p_bankAddressStreet2", Types.VARCHAR));
            declareParameter(new SqlParameter("p_bankAddressStreet3", Types.VARCHAR));
            declareParameter(new SqlParameter("p_bankAddressStreet4", Types.VARCHAR));
            declareParameter(new SqlParameter("p_bankAddressCity", Types.VARCHAR));
            declareParameter(new SqlParameter("p_bankAddressState", Types.VARCHAR));
            declareParameter(new SqlParameter("p_bankAddressZipCode", Types.VARCHAR));
            declareParameter(new SqlParameter("p_bankAddressCountry", Types.VARCHAR));
            declareParameter(new SqlParameter("p_swiftBic", Types.VARCHAR));
            declareParameter(new SqlParameter("p_correspondentBank", Types.VARCHAR));
            declareParameter(new SqlParameter("p_correspondentBankSwiftBic", Types.VARCHAR));
            declareParameter(new SqlParameter("p_logonId", Types.VARCHAR));
            break;
        case 20:
            declareParameter(new SqlParameter("p_acctnum", Types.NUMERIC));
            declareParameter(new SqlParameter("p_eventnum", Types.NUMERIC));
            break;
         case 21:
            declareParameter(new SqlParameter("p_id", Types.BIGINT));
            declareParameter(new SqlParameter("p_product", Types.VARCHAR));
            declareParameter(new SqlParameter("p_mode", Types.VARCHAR));
            declareParameter(new SqlParameter("p_requestIds", Types.VARCHAR));
            declareParameter(new SqlParameter("p_acctNum", Types.VARCHAR));
            declareParameter(new SqlParameter("p_eventNum", Types.VARCHAR));
            declareParameter(new SqlParameter("p_reqAckwNum",Types.VARCHAR));
            declareParameter(new SqlParameter("p_status",Types.VARCHAR));
            declareParameter(new SqlParameter("p_aoRequest", Types.VARCHAR));
            declareParameter(new SqlParameter("p_aoResponce", Types.VARCHAR));
            declareParameter(new SqlParameter("p_reqTime", Types.TIMESTAMP));
            declareParameter(new SqlParameter("p_resTime", Types.TIMESTAMP));
            declareParameter(new SqlParameter("p_remarks", Types.VARCHAR));
            declareParameter(new SqlParameter("p_opt", Types.VARCHAR) );  //declaring sql in parameter to pass input
            declareParameter( new SqlOutParameter("op_msgCode", Types.INTEGER ) );
            declareParameter( new SqlOutParameter("op_msg", Types.VARCHAR ) );
            break;
         default:  // All other (no arg)
            break;
      }
   }

   public DBResponse audit(AORequestAudit aoRequest){
      Map inputs = new HashMap();
      inputs.put("p_id", aoRequest.getId());
      inputs.put("p_product", aoRequest.getProduct());
      inputs.put("p_mode", aoRequest.getMode());
      inputs.put("p_requestIds", aoRequest.getRequestIds());
      inputs.put("p_acctNum", aoRequest.getAcctnum());
      inputs.put("p_eventNum", aoRequest.getEventNum());
      inputs.put("p_reqAckwNum", aoRequest.getEnvelopId());
      inputs.put("p_status", aoRequest.getStatus());
      inputs.put("p_aoRequest", aoRequest.getDcRequest());
      inputs.put("p_aoResponce", aoRequest.getDcResponce());
      inputs.put("p_reqTime", aoRequest.getReqTime()==null?null: new Timestamp(aoRequest.getReqTime().getTime()));
      inputs.put("p_resTime", aoRequest.getResTime()==null?null: new Timestamp(aoRequest.getResTime().getTime()));
      inputs.put("p_remarks", aoRequest.getRemarks());
      inputs.put("p_opt", aoRequest.getOpt());

      Map<String,Object> results = super.execute(inputs);
      DBResponse dbRes= new DBResponse((int)results.get("op_msgCode"),results.get("op_msg").toString());
      return dbRes; //reading output of stored procedure using out parameters
   }

   public Map fetchData(Long acctNum)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", acctNum);
      return execute(inputMap);
   }

   public Map getAORequests(Long acctNum, int eventNum)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_eventnum", eventNum);
      return execute(inputMap);
   }

   public Map saveAcctDetails(AccountDetails accountDetails, String p_logonId)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", accountDetails.getAcctnum());
      inputMap.put("p_clientAccountID", accountDetails.getClientAccountID());
      inputMap.put("p_repId", accountDetails.getRepId());
      inputMap.put("p_caseNumber", accountDetails.getCaseNumber());
      inputMap.put("p_advisorId", accountDetails.getAdvisorId());
      inputMap.put("p_acctTypeId", accountDetails.getAcctTypeId());
      inputMap.put("p_logonId", p_logonId);
      return execute(inputMap);
   }

   public Map saveAcctHolderDetails(Long acctNum, int acctOwnerId, String p_logonId, OwnerDetails ownerDetails)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_acctOwnerId", acctOwnerId);
      inputMap.put("p_title", ownerDetails.getTitle());
      inputMap.put("p_fullName", ownerDetails.getFullName());
      inputMap.put("p_gender", ownerDetails.getGender());
      inputMap.put("p_dob", ownerDetails.getDob());
      inputMap.put("p_countryOfBirth", ownerDetails.getCountryOfBirth());
      inputMap.put("p_emailAddress", ownerDetails.getEmailAddress());
      inputMap.put("p_ownership", ownerDetails.getOwnership());
      inputMap.put("p_logonId", p_logonId);
      return execute(inputMap);
   }

   public Map saveAcctAdditionalDetails(Long acctNum, int acctOwnerId, String name, String value, String table)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_acctOwnerId", acctOwnerId);
      inputMap.put("p_name", name);
      inputMap.put("p_value", value);
      inputMap.put("p_table", table);
      return execute(inputMap);
   }

   public Map saveAcctMiscDetails(Long acctNum, String name, String value, String table)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_name", name);
      inputMap.put("p_value", value);
      inputMap.put("p_table", table);
      return execute(inputMap);
   }


   public Map saveAcctEmpDetails(Long acctNum, int acctOwnerId, String p_logonId, OwnerDetails ownerDetails)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_acctOwnerId", acctOwnerId);
      inputMap.put("p_emplId", ownerDetails.getOwnerEmploymentDetails().getEmplId());
      inputMap.put("p_emplTypeId", ownerDetails.getOwnerEmploymentDetails().getEmplTypeId());
      inputMap.put("p_sourceOfIncome", ownerDetails.getOwnerEmploymentDetails().getSourceOfIncome());
      inputMap.put("p_employerName", ownerDetails.getOwnerEmploymentDetails().getEmployerName());
      inputMap.put("p_occupation", ownerDetails.getOwnerEmploymentDetails().getOccupation());
      inputMap.put("p_typeOfBusiness", ownerDetails.getOwnerEmploymentDetails().getTypeOfBusiness());
      inputMap.put("p_employerStreetAddress1", ownerDetails.getOwnerEmploymentDetails().getEmployerStreetAddress1());
      inputMap.put("p_employerStreetAddress2", ownerDetails.getOwnerEmploymentDetails().getEmployerStreetAddress2());
      inputMap.put("p_employerStreetAddress3", ownerDetails.getOwnerEmploymentDetails().getEmployerStreetAddress3());
      inputMap.put("p_employerStreetAddress4", ownerDetails.getOwnerEmploymentDetails().getEmployerStreetAddress4());
      inputMap.put("p_employerCity", ownerDetails.getOwnerEmploymentDetails().getEmployerCity());
      inputMap.put("p_employerState", ownerDetails.getOwnerEmploymentDetails().getEmployerState());
      inputMap.put("p_employerZipCode", ownerDetails.getOwnerEmploymentDetails().getEmployerZipCode());
      inputMap.put("p_employerZipCountry", ownerDetails.getOwnerEmploymentDetails().getEmployerZipCountry());
      inputMap.put("p_fromDate", ownerDetails.getOwnerEmploymentDetails().getFromDate());
      inputMap.put("p_toDate", ownerDetails.getOwnerEmploymentDetails().getToDate());
      inputMap.put("p_logonId", p_logonId);
      return execute(inputMap);
   }



   public Map saveAccountHolderBankDtls(Long acctNum, int acctOwnerId, String p_logonId, OwnerDetails ownerDetails)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_acctOwnerId", acctOwnerId);
      inputMap.put("p_bankName", ownerDetails.getOwnerBankDetails().getBankName());
      inputMap.put("p_bankAccountNo", ownerDetails.getOwnerBankDetails().getBankAccountNo());
      inputMap.put("p_bankAddressStreet1", ownerDetails.getOwnerBankDetails().getBankAddressStreet1());
      inputMap.put("p_bankAddressStreet2", ownerDetails.getOwnerBankDetails().getBankAddressStreet2());
      inputMap.put("p_bankAddressStreet3", ownerDetails.getOwnerBankDetails().getBankAddressStreet3());
      inputMap.put("p_bankAddressStreet4", ownerDetails.getOwnerBankDetails().getBankAddressStreet4());
      inputMap.put("p_bankAddressCity", ownerDetails.getOwnerBankDetails().getBankAddressCity());
      inputMap.put("p_bankAddressState", ownerDetails.getOwnerBankDetails().getBankAddressState());
      inputMap.put("p_bankAddressZipCode", ownerDetails.getOwnerBankDetails().getBankAddressZipCode());
      inputMap.put("p_bankAddressCountry",ownerDetails.getOwnerBankDetails().getBankAddressCountry());
      inputMap.put("p_swiftBic", ownerDetails.getOwnerBankDetails().getSwiftBic());
      inputMap.put("p_correspondentBank", ownerDetails.getOwnerBankDetails().getCorrespondentBank());
      inputMap.put("p_correspondentBankSwiftBic", ownerDetails.getOwnerBankDetails().getCorrespondentBankSwiftBic());
      inputMap.put("p_logonId", p_logonId);
      return execute(inputMap);
   }

   public Map saveSetMiscDtls(Long acctNum, int acctOwnerId, int id, String category, String name, String value)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_acctOwnerId", acctOwnerId);
      inputMap.put("p_category", category);
      inputMap.put("p_id", id);
      inputMap.put("p_name", name);
      inputMap.put("p_value", value);
      return execute(inputMap);
   }

   public Map deleteSetMiscDtls(Long acctNum, int acctOwnerId, String category)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_acctOwnerId", acctOwnerId);
      inputMap.put("p_category", category);
      return execute(inputMap);
   }

   public Map saveAcctAddrDetails(Long acctNum, int acctOwnerId, String p_logonId, OwnerDetails ownerDetails)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_acctOwnerId", acctOwnerId);

      inputMap.put("p_physicalAddressStreet1", ownerDetails.getPhysicalAddressStreet1());
      inputMap.put("p_physicalAddressStreet2", ownerDetails.getPhysicalAddressStreet2());
      inputMap.put("p_physicalAddressStreet3", ownerDetails.getPhysicalAddressStreet3());
      inputMap.put("p_physicalAddressStreet4", ownerDetails.getPhysicalAddressStreet4());
      inputMap.put("p_physicalAddressCity", ownerDetails.getPhysicalAddressCity());
      inputMap.put("p_physicalAddressState", ownerDetails.getPhysicalAddressState());
      inputMap.put("p_physicalAddressZipCode", ownerDetails.getPhysicalAddressZipCode());
      inputMap.put("p_physicalAddressCountry", ownerDetails.getPhysicalAddressCountry());
      inputMap.put("p_mailingAddressStreet1", ownerDetails.getMailingAddressStreet1());
      inputMap.put("p_mailingAddressStreet2", ownerDetails.getMailingAddressStreet2());
      inputMap.put("p_mailingAddressStreet3", ownerDetails.getMailingAddressStreet3());
      inputMap.put("p_mailingAddressStreet4", ownerDetails.getMailingAddressStreet4());
      inputMap.put("p_mailingAddressCity", ownerDetails.getMailingAddressCity());
      inputMap.put("p_mailingAddressState", ownerDetails.getMailingAddressState());
      inputMap.put("p_mailingAddressZipCode", ownerDetails.getMailingAddressZipCode());
      inputMap.put("p_mailingAddressCountry", ownerDetails.getMailingAddressCountry());
      inputMap.put("p_logonId", p_logonId);
      return execute(inputMap);
   }

   public Map fetchSalesRepList(String advisor)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_advisor", advisor);
      return execute(inputMap);
   }

   public Map fetchFileUpdMasterList(String Product, Long acctNum,String reqType)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_product", Product);
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_reqType", reqType);
      return execute(inputMap);
   }

   public Map saveCustodyFiles(String Product, Long acctNum, String logonId, CustodyFileRequest custodyFileRequest)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_reqId", custodyFileRequest.getReqId());
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_product", Product);
      inputMap.put("p_action", custodyFileRequest.getAction());
      inputMap.put("p_requestFor", custodyFileRequest.getRequestFor());
      inputMap.put("p_fileName", custodyFileRequest.getFileName());
      inputMap.put("p_filePath", custodyFileRequest.getFilePath());
      inputMap.put("p_reqType", custodyFileRequest.getReqType());
      inputMap.put("p_logonId", logonId);
      inputMap.put("p_seqno", custodyFileRequest.getSeqno());
      return execute(inputMap);
   }


   public Map fetchUploadedFiles(String Product, Long acctNum, String action)
   {
      Map inputMap = new LinkedHashMap();
      inputMap.put("p_product", Product);
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_action", action);
      return execute(inputMap);
   }

   public Map saveCustodyDocReq(String product, Long acctNum, Long advisorId, String reqType)
   {

      Map inputMap = new LinkedHashMap();
      inputMap.put("p_product", product);
      inputMap.put("p_acctnum", acctNum);
      inputMap.put("p_advisorid", advisorId);
      inputMap.put("p_reqType", reqType);
      return execute(inputMap);
   }

   public Map nonParamProcCall()
   {

      return super.execute();
   }
}
