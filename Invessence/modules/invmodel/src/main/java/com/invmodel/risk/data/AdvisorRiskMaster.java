package com.invmodel.risk.data;

import java.util.*;

import com.invmodel.risk.dao.RiskDAO;

/**
 * Created by prashant on 11/9/2017.
 */
public class AdvisorRiskMaster
{
   private String advisor;
   private Map<String, AdvisorRiskMasterData> masterdata;
   private Map<Integer, AdvisorRiskMapping> mappingdata;

   private RiskDAO riskfetchDAO = new RiskDAO();

   public AdvisorRiskMaster()
   {
      masterdata = new HashMap<String, AdvisorRiskMasterData>();
      mappingdata = new HashMap<Integer, AdvisorRiskMapping>();
   }

   public AdvisorRiskMaster(String advisor)
   {
      this.advisor = advisor;
      masterdata = new HashMap<String, AdvisorRiskMasterData>();
      mappingdata = new HashMap<Integer, AdvisorRiskMapping>();
      initAdvisorMaster(advisor);
   }

   public void initAdvisorMaster(String advisor) {
      this.advisor = advisor;
      mappingdata.clear();
      mappingdata.clear();
      riskfetchDAO.fetchAdvisorRiskMaster(this);
   }


   public String getAdvisor()
   {
      return advisor;
   }

   public void setAdvisor(String advisor)
   {
      this.advisor = advisor;
   }

   public void removeAdvisorMasterData(String key)
   {
      if (key != null)
      {
         if (this.masterdata.containsKey(key))
         {
            this.masterdata.remove(key);
         }
      }
   }

   public void addAdvisorMasterData(String key, AdvisorRiskMasterData masterdata)
   {
      if (masterdata == null)
      {
         removeAdvisorMasterData(key);
      }
      if (key != null)
      {
         this.masterdata.put(key, masterdata);
      }
   }

   public Map<String, AdvisorRiskMasterData> getAdvisorMasterdata()
   {
      return masterdata;
   }

   public void removeAdvisorMapping(Integer riskNum)
   {
      if (riskNum != null)
      {
         if (this.mappingdata.containsKey(riskNum))
         {
            this.mappingdata.remove(riskNum);
         }
      }
   }

   public void addAdvisorMapping(Integer riskNum, AdvisorRiskMapping mappingdata)
   {
      if (mappingdata != null)
      {
         removeAdvisorMapping(riskNum);
      }
      if (riskNum != null)
      {
         this.mappingdata.put(riskNum, mappingdata);
      }
   }

   public Map<Integer, AdvisorRiskMapping> getAdvisorMappings()
   {
      return mappingdata;
   }


}
