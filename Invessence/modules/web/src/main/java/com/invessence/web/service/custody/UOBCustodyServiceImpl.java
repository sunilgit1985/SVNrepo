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
               objMap.put(convert.getStrData(rs.get("displayName")), convert.getStrData(rs.get("rep")));
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
   public List<CustodyFileDetails> fetchFileUpdList(String Product, Long acctNum)
   {
      List<CustodyFileDetails> objCstdFileLst=null;
      try
      {
         objCstdFileLst=new ArrayList<CustodyFileDetails>();
         SQLData convert = new SQLData();
         jdbcTemplate = new JdbcTemplate(dataSource);
         CustodySP sp = new CustodySP(jdbcTemplate, "sel_custody_file_master_list", 10);
         Map outMap = sp.fetchFileUpdList( Product,  acctNum);
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
               objCustodyFileDetails.setFileType(convert.getStrData(rs.get("fileType")));
               objCustodyFileDetails.setFileExtensions(convert.getStrData(rs.get("fileExtensions")));
               objCstdFileLst.add(objCustodyFileDetails);
               i++;
            }
         }
      }
      catch (Exception ex)
      {
         System.out.println("UOBCustodyServiceImpl.fetchSalesRepList Exception " + ex);
         ex.printStackTrace();
      }
      return objCstdFileLst;
   }
}
