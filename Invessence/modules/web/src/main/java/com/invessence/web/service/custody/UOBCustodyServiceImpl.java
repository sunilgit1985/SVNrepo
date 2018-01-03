package com.invessence.web.service.custody;

import java.util.*;
import javax.sql.DataSource;

import com.invessence.converter.SQLData;
import com.invessence.custody.dao.CustodySP;
import com.invessence.custody.uob.UOBDataMaster;
import com.invessence.custody.uob.dao.UOBDao;
import com.invessence.custody.uob.data.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 * Created by abhangp on 11/10/2017.
 */
@Service("uobCustodyService")
public class UOBCustodyServiceImpl  implements CustodyService
{
   @Autowired
   UOBDao uobDao;

   @Autowired
   DataSource dataSource;

   private JdbcTemplate jdbcTemplate ;
   private static Long defaultAdvisorId;


   @Override
   public void saveAcctDetails(AccountDetails accountDetails,String p_logonId)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "save_custody_ao_acct_dtls", 1);
         Map outMap = sp.saveAcctDetails(accountDetails,p_logonId);
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveAcctDetails Exception "+ex);
         ex.printStackTrace();
      }

   }

   @Override
   public void saveAccountHolderDtls(Long acctNum, int acctOwnerId , String p_logonId, OwnerDetails ownerDetails)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "save_custody_ao_owner_acct_hldr_dtls", 2);
         Map outMap = sp.saveAcctHolderDetails(acctNum,acctOwnerId,p_logonId,ownerDetails);
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveAccountHolderDtls Exception "+ex);
         ex.printStackTrace();
      }
   }

   @Override
   public void saveSetMiscDtls(Long acctNum, int acctOwnerId,int id,String category,String name,String value)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "save_custody_ao_owner_acct_set_misc_dtls", 6);
         Map outMap = sp.saveSetMiscDtls(acctNum, acctOwnerId, id, category, name,value);
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveAccountHolderDtls Exception "+ex);
         ex.printStackTrace();
      }
   }

   @Override
   public void deleteSetMiscDtls(Long acctNum, int acctOwnerId ,String category)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "del_custody_ao_owner_acct_set_misc_dtls", 7);
         Map outMap = sp.deleteSetMiscDtls(acctNum,acctOwnerId,category);
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveAccountHolderDtls Exception "+ex);
         ex.printStackTrace();
      }
   }

   @Override
   public void saveAdditionalDtls(Long acctNum,int acctOwnerId,String name,String value,String table)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "save_ao_owner_additional_dtls",3);
         Map outMap = sp.saveAcctAdditionalDetails( acctNum, acctOwnerId, name, value, table);;
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveAdditionalDtls Exception "+ex);
         ex.printStackTrace();
      }
   }


   @Override
   public void saveEmploymentDtls(Long acctNum, int acctOwnerId , String p_logonId, OwnerDetails ownerDetails)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "save_custody_ao_owner_emp_dtls", 4);
         Map outMap = sp.saveAcctEmpDetails(acctNum,acctOwnerId,p_logonId,ownerDetails);
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveEmploymentDtls Exception "+ex);
         ex.printStackTrace();
      }
   }

   @Override
   public void saveAccountHolderBankDtls(Long acctNum, int acctOwnerId , String p_logonId, OwnerDetails ownerDetails)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "save_custody_ao_owner_acct_hldr_bnk_dtls", 14);
         Map outMap = sp.saveAccountHolderBankDtls(acctNum,acctOwnerId,p_logonId,ownerDetails);
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveAccountHolderDtls Exception "+ex);
         ex.printStackTrace();
      }
   }

   @Override
   public void saveAddressDtls(Long acctNum, int acctOwnerId , String p_logonId, OwnerDetails ownerDetails)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "save_custody_ao_owner_acct_addr_dtls", 5);
         Map outMap = sp.saveAcctAddrDetails(acctNum,acctOwnerId,p_logonId,ownerDetails);
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveAddressDtls Exception "+ex);
         ex.printStackTrace();
      }
   }


   @Override
   public UOBDataMaster fetch(Long acctNum ,boolean isJoint)
   {
      UOBDataMaster uobDataMaster=new UOBDataMaster();
      try
      {
         Object ftchObj = uobDao.fetch(acctNum);
         if (ftchObj != null)
         {
            uobDataMaster =(UOBDataMaster)ftchObj;
         }
//         if(uobDataMaster.getAccountDetails()==null){
//            uobDataMaster.setAccountDetails(new AccountDetails());
//            uobDataMaster.getAccountDetails().setAcctnum(acctNum);
//         }
//         if(uobDataMaster.getIndividualOwnersDetails()==null){
//            uobDataMaster.setIndividualOwnersDetails(new OwnerDetails());
//            uobDataMaster.getIndividualOwnersDetails().setOwnerCitizenshipDetails(new OwnerCitizenshipDetails());
//            uobDataMaster.getIndividualOwnersDetails().setOwnerIdentificationDetails(new OwnerIdentificationDetails());
//            uobDataMaster.getIndividualOwnersDetails().setOwnerContactDetails(new OwnerContactDetails());
//         }
//         if(uobDataMaster.getJointOwnersDetails()==null && isJoint){
//            uobDataMaster.setJointOwnersDetails(new OwnerDetails());
//         }
         System.out.println("uobDataMaster obje ~@~["+uobDataMaster.toString()+"]~@~");
      }catch (Exception e){
         System.out.println("UOBCustodyServiceImpl.fetch Exception occured "+e);
         e.printStackTrace();
      }
      return uobDataMaster;
   }

   @Override
   public void saveAcctAdditionalDtls(Long acctNum,String name,String value,String table)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "save_ao_acct_additional_dtls",8);
         Map outMap = sp.saveAcctMiscDetails( acctNum,name, value, table);
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveAdditionalDtls Exception "+ex);
         ex.printStackTrace();
      }
   }

   @Override
   public Map<String, String> fetchSalesRepList(String advisor)
   {
      Map<String, String> objMap = new HashMap<String, String>();
      try
      {
         SQLData convert = new SQLData();
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "sp_advisor_base_rep_lst", 9);
         Map outMap = sp.fetchSalesRepList(advisor);
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            int i = 0;
            for (Map<String, Object> map : rows)
            {
               Map rs = (Map) rows.get(i);
               objMap.put(convert.getStrData(rs.get("displayName")), convert.getStrData(rs.get("rep"))+"~"+convert.getLongData(rs.get("logonid")));
               if(convert.getStrData(rs.get("rep")).equalsIgnoreCase("CATCHALL")){
                  setDefaultAdvisorId(convert.getLongData(rs.get("logonid")));
               }
               i++;
            }
         }
      }
      catch (Exception ex)
      {
         System.out.println("UOBCustodyServiceImpl.fetchSalesRepList Exception " + ex);
         ex.printStackTrace();
      }
      return objMap;
   }

   @Override
   public List<CustodyFileDetails> fetchFileMasterList(String product, Long acctNum,String reqType,String reqFor)
   {
      List<CustodyFileDetails> objCstdFileLst=null;
      try
      {
         objCstdFileLst=new ArrayList<CustodyFileDetails>();
         SQLData convert = new SQLData();
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "sel_custody_file_master_list", 10);
         Map outMap = sp.fetchFileUpdMasterList( product,  acctNum,reqType,reqFor);
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            int i = 0;
            for (Map<String, Object> map : rows)
            {
               CustodyFileDetails objCustodyFileDetails=new CustodyFileDetails();
               Map rs = (Map) rows.get(i);
               objCustodyFileDetails.setSeqno(convert.getIntData(rs.get("seqno")));
               objCustodyFileDetails.setFileName(convert.getStrData(rs.get("fileName")));
               objCustodyFileDetails.setFileLabel(convert.getStrData(rs.get("fileLabel")));
               objCustodyFileDetails.setReqType(convert.getStrData(rs.get("reqType")));
               objCustodyFileDetails.setFileExtensions(convert.getStrData(rs.get("fileExtensions")));
               objCstdFileLst.add(objCustodyFileDetails);
               i++;
            }
         }
      }
      catch (Exception ex)
      {
         System.out.println("UOBCustodyServiceImpl.fetchFileMasterList Exception " + ex);
         ex.printStackTrace();
      }
      return objCstdFileLst;
   }

   @Override
   public List<CustodyFileRequest> fetchUploadedFiles(String Product, Long acctNum,String action)
   {
      List<CustodyFileRequest> objCstdFileLst=null;
      try
      {
         objCstdFileLst=new ArrayList<CustodyFileRequest>();
         SQLData convert = new SQLData();
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "sel_custody_file_rqst_dtls", 12);
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
   public void saveCustodyFiles(String Product,Long acctNum,String logonId,CustodyFileRequest custodyFileRequest)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "save_custody_file_rqst",11);
         Map outMap = sp.saveCustodyFiles(  Product, acctNum, logonId, custodyFileRequest);
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveCustodyFiles Exception "+ex);
         ex.printStackTrace();
      }
   }

   @Override
   public String saveCustodyDocReq(String product,Long acctNum,Long advisorId,String reqType)
   {
      String eventNo =null;
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "save_ao_document_request",13);
         Map outMap = sp.saveCustodyDocReq( product, acctNum,advisorId,reqType);

         if (outMap != null)
         {
            SQLData convert = new SQLData();
            Integer whichAcct;
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            if (rows == null)
               eventNo =null;
            int i = 0;
            for (Map<String, Object> map : rows)
            {
               Map rs = (Map) rows.get(i);
               eventNo=convert.getStrData(rs.get("EventNo"));
            }
         }
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveCustodyDocReq Exception "+ex);
         ex.printStackTrace();
      }
      return eventNo;
   }

   @Override
   public void mangeUserProfile(Long data, String flag, Long logonid)
   {
      try {
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "sp_user_profile_manage",15);
         Map outMap = sp.mangeUserProfile(  data, flag, logonid);
      }
      catch (Exception ex) {
         System.out.println("UOBCustodyServiceImpl.saveCustodyFiles Exception "+ex);
         ex.printStackTrace();
      }
   }

   @Override
   public Long getDefaultAdvisor()
   {
      return getDefaultAdvisorId();
   }





   public static Long getDefaultAdvisorId()
   {
      return defaultAdvisorId;
   }

   public static void setDefaultAdvisorId(Long defaultAdvisorId)
   {
      UOBCustodyServiceImpl.defaultAdvisorId = defaultAdvisorId;
   }
}



