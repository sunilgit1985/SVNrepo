package com.invmodel.risk.dao;

import java.sql.Types;
import java.util.*;
import javax.sql.DataSource;

import com.invmodel.risk.data.*;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.StoredProcedure;

/**
 * Created by prashant on 11/10/2017.
 */
public class RiskSP extends StoredProcedure
{

   public RiskSP(DataSource datasource, String storedProcName, int process)
   {
      super(datasource, storedProcName);
      switch (process)
      {
         case 1:
            declareParameter(new SqlParameter("p_advisor", Types.VARCHAR));
            break;
         case 2:
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            break;
         case 3:
            break;
         case 4:
            break;
         case 5:
            break;
         case 10:
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            break;
         case 11:
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            declareParameter(new SqlParameter("p_key", Types.VARCHAR));
            declareParameter(new SqlParameter("p_sortorder", Types.INTEGER));
            declareParameter(new SqlParameter("p_ans", Types.VARCHAR));
            declareParameter(new SqlParameter("p_answerType", Types.VARCHAR));
            declareParameter(new SqlParameter("p_riskScore", Types.DOUBLE));
            break;
         case 12:
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            declareParameter(new SqlParameter("p_year", Types.INTEGER));
            declareParameter(new SqlParameter("p_calcFormula", Types.VARCHAR));
            declareParameter(new SqlParameter("p_allCashFlag", Types.BOOLEAN));
            declareParameter(new SqlParameter("p_score", Types.DOUBLE));
            declareParameter(new SqlParameter("p_standardScore", Types.DOUBLE));
            declareParameter(new SqlParameter("p_assetScore", Types.DOUBLE));
            declareParameter(new SqlParameter("p_portfolioScore", Types.DOUBLE));
            declareParameter(new SqlParameter("p_adjustment", Types.DOUBLE));
            break;
         case 13:
            declareParameter(new SqlParameter("p_acctnum", Types.BIGINT));
            declareParameter(new SqlParameter("p_investmentgoal", Types.VARCHAR));
            declareParameter(new SqlParameter("p_age", Types.TINYINT));
            declareParameter(new SqlParameter("p_retireage", Types.TINYINT));
            declareParameter(new SqlParameter("p_retired", Types.TINYINT));
            declareParameter(new SqlParameter("p_horizon", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans1", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans2", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans3", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans4", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans5", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans6", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans7", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans8", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans9", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans10", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans11", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans12", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans13", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans14", Types.TINYINT));
            declareParameter(new SqlParameter("p_ans15", Types.TINYINT));
            declareParameter(new SqlParameter("p_formula", Types.VARCHAR));
            declareParameter(new SqlParameter("p_r1", Types.TINYINT));
            declareParameter(new SqlParameter("p_r2", Types.TINYINT));
            declareParameter(new SqlParameter("p_r3", Types.TINYINT));
            declareParameter(new SqlParameter("p_r4", Types.TINYINT));
            declareParameter(new SqlParameter("p_r5", Types.TINYINT));
            declareParameter(new SqlParameter("p_r6", Types.TINYINT));
            declareParameter(new SqlParameter("p_r7", Types.TINYINT));
            declareParameter(new SqlParameter("p_r8", Types.TINYINT));
            declareParameter(new SqlParameter("p_r9", Types.TINYINT));
            declareParameter(new SqlParameter("p_r10", Types.TINYINT));
            declareParameter(new SqlParameter("p_r11", Types.TINYINT));
            declareParameter(new SqlParameter("p_r12", Types.TINYINT));
            declareParameter(new SqlParameter("p_r13", Types.TINYINT));
            declareParameter(new SqlParameter("p_r14", Types.TINYINT));
            declareParameter(new SqlParameter("p_r15", Types.TINYINT));
            declareParameter(new SqlParameter("p_totalRisk", Types.DOUBLE));
            declareParameter(new SqlParameter("p_riskByQuestion", Types.DOUBLE));
            declareParameter(new SqlParameter("p_riskOverride", Types.DOUBLE));
         default: // All others with no args.
      }
      compile();
   }

   @SuppressWarnings({"unchecked", "rawtypes"})
   public Map fetchRiskMaster(String advisor)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_advisor", advisor);
      return super.execute(inputMap);
   }

   @SuppressWarnings({"unchecked", "rawtypes"})
   public Map fetchRiskMapping(String advisor)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_advisor", advisor);
      return super.execute(inputMap);
   }

   @SuppressWarnings({"unchecked", "rawtypes"})
   public Map fetchRiskData(Long acctnum)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_acctnum", acctnum);
      return super.execute(inputMap);
   }

   @SuppressWarnings({"unchecked", "rawtypes"})
   public Map fetchRiskScores(Long acctnum)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_acctnum", acctnum);
      return super.execute(inputMap);
   }

   public void deleteRiskProfile(Long acctnum)
   {
      Map inputMap = new HashMap();
      inputMap.put("p_acctnum", acctnum);
      super.execute(inputMap);
   }

   public void saveRiskProfile(UserRiskProfile data)
   {
      Map inputMap = null;

      Map<String, UserRiskData> dataMap = data.getRiskData();
      if (dataMap != null)
      {
         for (UserRiskData udata : dataMap.values())
         {
            inputMap = new HashMap();
            inputMap.put("p_acctnum", data.getAcctnum());
            inputMap.put("p_key", udata.getKey());
            inputMap.put("p_sortorder", udata.getSortorder());
            inputMap.put("p_ans", udata.getAnswer());
            inputMap.put("p_answerType", udata.getAnswerType());
            inputMap.put("p_riskScore", udata.getRiskScore());
            super.execute(inputMap);
         }
      }
   }

   public void saveRiskScore(UserRiskProfile data)
   {
      Map inputMap = null;

      ArrayList<RiskScore> scores = data.getALLRiskScores();
      if (scores != null)
      {
         for (RiskScore thisscore : scores)
         {
            inputMap = new HashMap();
            inputMap.put("p_acctnum", data.getAcctnum());
            inputMap.put("p_year", thisscore.getYear());
            inputMap.put("p_calcFormula", thisscore.getCalcFormula());
            inputMap.put("p_allCashFlag", thisscore.getAllCashFlag());
            inputMap.put("p_score", thisscore.getScore());
            inputMap.put("p_standardScore", thisscore.getStandardScore());
            inputMap.put("p_assetScore", thisscore.getAssetScore());
            inputMap.put("p_portfolioScore", thisscore.getPortfolioScore());
            inputMap.put("p_adjustment", thisscore.getAdjustment());
            super.execute(inputMap);
         }
      }
   }

   public void saveOrigRiskData(UserRiskProfile data)
   {
      Map inputMap = null;

      Map<String, UserRiskData> dataMap = data.getRiskData();
      if (dataMap != null)
      {
         inputMap = new HashMap();

         // Initial all values, Although New will create empty object, SP needs all values.
         inputMap.put("p_acctnum", null);
         inputMap.put("p_investmentgoal", null);
         inputMap.put("p_age", 0);
         inputMap.put("p_retireage", 0);
         inputMap.put("p_retired", 0);
         inputMap.put("p_horizon", 0);
         inputMap.put("p_ans1", 0);
         inputMap.put("p_ans2", 0);
         inputMap.put("p_ans3", 0);
         inputMap.put("p_ans4", 0);
         inputMap.put("p_ans5", 0);
         inputMap.put("p_ans6", 0);
         inputMap.put("p_ans7", 0);
         inputMap.put("p_ans8", 0);
         inputMap.put("p_ans9", 0);
         inputMap.put("p_ans10", 0);
         inputMap.put("p_ans11", 0);
         inputMap.put("p_ans12", 0);
         inputMap.put("p_ans13", 0);
         inputMap.put("p_ans14", 0);
         inputMap.put("p_ans15", 0);
         inputMap.put("p_formula", 0);
         inputMap.put("p_r1", 0);
         inputMap.put("p_r2", 0);
         inputMap.put("p_r3", 0);
         inputMap.put("p_r4", 0);
         inputMap.put("p_r5", 0);
         inputMap.put("p_r6", 0);
         inputMap.put("p_r7", 0);
         inputMap.put("p_r8", 0);
         inputMap.put("p_r9", 0);
         inputMap.put("p_r10", 0);
         inputMap.put("p_r11", 0);
         inputMap.put("p_r12", 0);
         inputMap.put("p_r13", 0);
         inputMap.put("p_r14", 0);
         inputMap.put("p_r15", 0);
         inputMap.put("p_totalRisk", 0);
         inputMap.put("p_riskByQuestion", 0);
         inputMap.put("p_riskOverride", 0);

         // Now fill with the actual data.
         inputMap.put("p_acctnum", data.getAcctnum());
         inputMap.put("p_investmentgoal", data.getAnswer(RiskConst.GOAL));
         inputMap.put("p_age", data.getAnswerInt(RiskConst.AGE));
         inputMap.put("p_horizon", data.getAnswerInt(RiskConst.HORIZON));
         inputMap.put("p_retireage", data.getAnswerInt(RiskConst.RETIREMENTAGE));
         inputMap.put("p_formula", data.getAnswer(RiskConst.CALCFORMULA));
         inputMap.put("p_ans1", 0);
         inputMap.put("p_ans2", 0);
         UserRiskData qdata = dataMap.get(RiskConst.RISKQUESTIONS);
         if (qdata != null)
         {
            Integer origAns = 3;
            for (Integer i = 1; i <= qdata.getAnswerInt(); i++)
            {
               UserRiskData riskInfo = dataMap.get(RiskConst.RISKQUESTIONKEY + i.toString());
               if (riskInfo != null)
               {
                  inputMap.put("p_ans" + origAns.toString(), riskInfo.getAnswerInt());
                  Double score = riskInfo.getRiskScore();
                  inputMap.put("p_r" + origAns.toString(), (score == null) ? 0 : score.intValue());
                  origAns++;
               }
            }
         }
      }

      if (inputMap != null)
      {
         RiskScore thisscore = data.getRiskScoreObj(0);
         if (thisscore != null)
         {
            inputMap.put("p_totalRisk", thisscore.getScore().intValue());
            inputMap.put("p_riskByQuestion", thisscore.getStandardScore().intValue());
            inputMap.put("p_riskOverride", thisscore.getAssetScore().intValue());
         }
         super.execute(inputMap);
      }
   }
}
