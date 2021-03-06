package com.invmodel.risk.dao;

import java.io.Serializable;
import java.util.*;

import javax.sql.DataSource;

import com.invessence.converter.SQLData;
import com.invmodel.dao.DBConnectionProvider;
import com.invmodel.risk.data.*;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 * Created by prashant on 11/10/2017.
 */
public class RiskDAO extends JdbcDaoSupport implements Serializable
{

   DBConnectionProvider dbconnection = DBConnectionProvider.getInstance();
   SQLData convert = new SQLData();
   DataSource ds = dbconnection.getMySQLDataSource();

   public void fetchAdvisorRiskMaster(AdvisorRiskMaster advisorMaster)
   {
      // DataSource ds = getDataSource();

      if (ds == null)
         return;

      RiskSP sp = new RiskSP(ds, "sel_advisor_risk_master", 1);
      Map outMap = sp.fetchRiskMaster(advisorMaster.getAdvisor());
      try
      {
         // AdvisorRiskMaster advisorMaster = new AdvisorRiskMaster(advisor);
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            if (rows != null)
            {
               int i = 0;
               for (Map<String, Object> map : rows)
               {
                  Map rs = (Map) rows.get(i);

                  // Body of code ...
                  String dbadvisor = convert.getStrData(rs.get("advisor"));
                  String dbkey = convert.getStrData(rs.get("key"));

                  AdvisorRiskMasterData masterdata = new AdvisorRiskMasterData(convert.getIntData(rs.get("sortorder")),
                                                                               dbkey,
                                                                               convert.getStrData(rs.get("displayName")),
                                                                               convert.getStrData(rs.get("defaultValue")),
                                                                               convert.getStrData(rs.get("dataType")),
                                                                               convert.getStrData(rs.get("displayOnStart")),
                                                                               convert.getBooleanData(rs.get("displayAdvisor")),
                                                                               convert.getBooleanData(rs.get("saveforUser"))
                                                                              );
                  advisorMaster.addAdvisorMasterData(dbkey, masterdata);

                  i++;
               }

               // After masterdata is loaded, then load the mapping data as well.
               // NOTE: Advisor Master is already created, so we just need to add mapping data;
               fetchRiskMapping(advisorMaster);
            }

         }
      }
      catch (Exception ex) {

      }
   }

   private void fetchRiskMapping(AdvisorRiskMaster advisordata)
   {
      // DataSource ds = getDataSource();

      if (ds == null)
         return;

      if (advisordata == null)
         return;

      RiskSP sp = new RiskSP(ds, "sel_advisor_risk_mapping", 1);
      Map outMap = sp.fetchRiskMapping(advisordata.getAdvisor());
      try
      {
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            if (rows != null)
            {
               int i = 0;
               for (Map<String, Object> map : rows)
               {
                  Map rs = (Map) rows.get(i);

                  // Body of code ...
                  Integer riskQuestion;
                  AdvisorRiskMapping advisorRiskMapping = new AdvisorRiskMapping();
                  riskQuestion = convert.getIntData(rs.get("riskQuestion"));
                  advisorRiskMapping.setRiskQuestion(riskQuestion);
                  advisorRiskMapping.setNumOfWeights(convert.getIntData(rs.get("numOfWeights")));
                  advisorRiskMapping.setKnockoutQuestion(convert.getIntData(rs.get("knockoutQuestion")));
                  advisorRiskMapping.setDefaultWeight(convert.getDoubleData(rs.get("defaultWeight")));
                  Map<Integer, Double> weights = new HashMap<Integer,Double>();
                  for (Integer count = 1; count < 10; count++) {
                     String wghStr = "weight" + count.toString();
                     advisorRiskMapping.setWeights(count, convert.getDoubleData(rs.get(wghStr)));
                  }
                  i++;
                  advisordata.addAdvisorMapping(riskQuestion,advisorRiskMapping );
               }
            }

         }
      }
      catch (Exception ex) {

      }
   }

   public void fetchRiskData(UserRiskProfile riskprofile)
   {
      // DataSource ds = getDataSource();

      if (ds == null)
         return;

      if (riskprofile == null)
         return;

      RiskSP sp = new RiskSP(ds, "sel_user_risk_profile", 2);
      Map outMap = sp.fetchRiskData(riskprofile.getAcctnum());
      try
      {
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            if (rows != null)
            {
               int i = 0;
               for (Map<String, Object> map : rows)
               {
                  Map rs = (Map) rows.get(i);
                  UserRiskData data = new UserRiskData(
                              convert.getIntData(rs.get("sortorder")),
                              convert.getStrData(rs.get("key")),
                              convert.getStrData(rs.get("answer")),
                              convert.getStrData(rs.get("answerType")),
                              convert.getDoubleData(rs.get("riskScore")));
                  // Body of code ...

                  riskprofile.setRiskData(data);
                  i++;
               }
            }

         }
      }
      catch (Exception ex) {

      }
   }

   public void fetchRiskScores(UserRiskProfile riskdata)
   {
      // DataSource ds = getDataSource();

      if (ds == null)
         return;

      RiskSP sp = new RiskSP(ds, "sel_user_risk_score", 2);
      Map outMap = sp.fetchRiskScores(riskdata.getAcctnum());
      try
      {
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            if (rows != null)
            {
               int i = 0;
               for (Map<String, Object> map : rows)
               {
                  Map rs = (Map) rows.get(i);

                  // Body of code ...
                  riskdata.setRiskScores(
                     convert.getIntData(rs.get("year")),
                     convert.getStrData(rs.get("calcFormula")),
                     convert.getBooleanData(rs.get("allCashFlag")),
                     convert.getDoubleData(rs.get("score")),
                     convert.getDoubleData(rs.get("standardScore")),
                     convert.getDoubleData(rs.get("assetScore")),
                     convert.getDoubleData(rs.get("portfolioScore")),
                     convert.getDoubleData(rs.get("adjustment"))
                     );
                  i++;
               }
               fetchRiskData(riskdata);
            }
         }
      }
      catch (Exception ex) {

      }
   }

   public void deleteRiskProfile(UserRiskProfile data) {
      if (ds == null)
         return;

      RiskSP sp = new RiskSP(ds, "del_user_risk_profile", 10);
      sp.deleteRiskProfile(data.getAcctnum());

   }

   public void saveRiskData(UserRiskProfile data) {
      if (ds == null)
         return;

      deleteRiskProfile(data);

      RiskSP sp1 = new RiskSP(ds, "save_user_risk_profile", 11);
      sp1.saveRiskProfile(data);

      RiskSP sp2 = new RiskSP(ds, "save_user_risk_score", 12);
      sp2.saveRiskScore(data);

      RiskSP sp3 = new RiskSP(ds, "sav_user_risk_questions", 13);
      sp3.saveOrigRiskData(data);
   }

}
