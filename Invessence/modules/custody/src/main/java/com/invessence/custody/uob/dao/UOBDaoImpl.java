package com.invessence.custody.uob.dao;

import java.lang.reflect.Field;
import java.util.*;

import com.invessence.converter.SQLData;
import com.invessence.custody.dao.CustodySP;
import com.invessence.custody.uob.UOBDataMaster;
import com.invessence.custody.uob.data.*;
import com.invessence.custody.util.SQLDataCustody;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

/**
 * Created by abhangp on 10/26/2017.
 */
@Repository("uobDaoImpl")
public class UOBDaoImpl implements UOBDao
{

   private static final Logger logger = Logger.getLogger(UOBDaoImpl.class);

   @Autowired
   JdbcTemplate webServiceJdbcTemplate;

   SQLDataCustody sqlData = new SQLDataCustody();

   @Override
   public void save()
   {

   }

   @Override
      public Object fetch(Long acctNum)
      {
         UOBDataMaster uobDataMaster=new UOBDataMaster();
         try
         {
            CustodySP serviceSP = new CustodySP(webServiceJdbcTemplate, "spao_uob_fetch_data", 0);
            try
            {
               Map outMap = serviceSP.fetchData(acctNum);
               if (outMap != null)
               {
                  ArrayList<LinkedHashMap<String, Object>> rows = (ArrayList<LinkedHashMap<String, Object>>) outMap.get("#result-set-1");

                  if(rows.size()>0)
                  {
                     sqlData.getObjectFormCOLUMN(rows,uobDataMaster.getAccountDetails());
                  }
                  uobDataMaster.setAccountDetails(uobDataMaster.getAccountDetails());

                  rows =null;
                  rows = (ArrayList<LinkedHashMap<String, Object>>) outMap.get("#result-set-2");
                  if(rows.size()>0)
                  {
                     sqlData.getObjectFormROW(rows,uobDataMaster.getAccountDetails().getAccountMiscDetails());
                  }

                  rows=null;
                  rows = (ArrayList<LinkedHashMap<String, Object>>) outMap.get("#result-set-3");
                  if(rows.size()>0)
                  {
                     Iterator<LinkedHashMap<String, Object>> itr = rows.iterator();

                     while (itr.hasNext())
                     {
                        StringBuilder fileRow = new StringBuilder();
                        LinkedHashMap<String, Object> map = itr.next();
                        OwnerDetails ownerDetails = new OwnerDetails();
                        sqlData.getObjectFormCOLUMN(map, ownerDetails);
                        if(ownerDetails.getOwnership().equals("Individual"))
                        {
                           getOwnerDetails( ownerDetails, outMap);
                           uobDataMaster.setIndividualOwnersDetails(ownerDetails);
                        }else if(ownerDetails.getOwnership().equals("Joint"))
                        {
                           getOwnerDetails( ownerDetails, outMap);
                           uobDataMaster.setJointOwnersDetails(ownerDetails);
                        }
                     }
                  }
//                  rows=null;
//                  rows = (ArrayList<LinkedHashMap<String, Object>>) outMap.get("#result-set-3");
//                  if(rows.size()>0)
//                  {
//                     OwnerContactDetails ownerContactDetails=new OwnerContactDetails();
//                     getObjectFormROW(rows,ownerContactDetails,"acctOwnerId",ownerDetails.getAcctOwnerId());
//                     System.out.println(ownerContactDetails);
//                  }
//                  System.out.println("rows = " + rows);
                  return uobDataMaster;
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
         return uobDataMaster;
      }

   private void getOwnerDetails(OwnerDetails ownerDetails, Map map){

      ArrayList<LinkedHashMap<String, Object>> rows =null;
      rows = (ArrayList<LinkedHashMap<String, Object>>) map.get("#result-set-4");
      if(rows.size()>0)
      {
         sqlData.getObjectFormROW(rows,ownerDetails.getOwnerContactDetails(),"acctOwnerId",ownerDetails.getAcctOwnerId());
      }

      rows =null;
      rows = (ArrayList<LinkedHashMap<String, Object>>) map.get("#result-set-5");
      if(rows.size()>0)
      {
         sqlData.getObjectFormROW(rows,ownerDetails.getOwnersFinancialDetails(),"acctOwnerId",ownerDetails.getAcctOwnerId());
      }

      rows =null;
      rows = (ArrayList<LinkedHashMap<String, Object>>) map.get("#result-set-6");
      if(rows.size()>0)
      {
         sqlData.getObjectFormROW(rows,ownerDetails.getOwnerRegularityDetails(),"acctOwnerId",ownerDetails.getAcctOwnerId());
      }

      rows =null;
      rows = (ArrayList<LinkedHashMap<String, Object>>) map.get("#result-set-7");
      if(rows.size()>0)
      {
         sqlData.getObjectFormROW(rows,ownerDetails.getOwnerMiscDetails(),"acctOwnerId",ownerDetails.getAcctOwnerId());
      }

      rows =null;
      rows = (ArrayList<LinkedHashMap<String, Object>>) map.get("#result-set-8");
      if(rows.size()>0)
      {
         sqlData.getObjectFormROW(rows,ownerDetails.getOwnerIdentificationDetails(),"acctOwnerId",ownerDetails.getAcctOwnerId());
      }

      rows =null;
      rows = (ArrayList<LinkedHashMap<String, Object>>) map.get("#result-set-9");
      if(rows.size()>0)
      {
         sqlData.getObjectFormROW(rows,ownerDetails.getOwnerCitizenshipDetails(),"acctOwnerId",ownerDetails.getAcctOwnerId());
      }

      rows =null;
      rows = (ArrayList<LinkedHashMap<String, Object>>) map.get("#result-set-10");
      if(rows.size()>0)
      {
         sqlData.getObjectFormCOLUMN(rows,ownerDetails.getOwnerEmploymentDetails(),"acctOwnerId",ownerDetails.getAcctOwnerId());
      }

      rows =null;
      rows = (ArrayList<LinkedHashMap<String, Object>>) map.get("#result-set-11");
      if(rows.size()>0)
      {
         sqlData.getObjectFormROW(rows,ownerDetails.getOwnerTaxationDetails(),"Taxation","acctOwnerId",ownerDetails.getAcctOwnerId());
      }

      rows =null;
      rows = (ArrayList<LinkedHashMap<String, Object>>) map.get("#result-set-12");
      if(rows.size()>0)
      {
         sqlData.getObjectFormCOLUMN(rows,ownerDetails.getOwnerBankDetails(),"acctOwnerId",ownerDetails.getAcctOwnerId());

      }

   }

}
