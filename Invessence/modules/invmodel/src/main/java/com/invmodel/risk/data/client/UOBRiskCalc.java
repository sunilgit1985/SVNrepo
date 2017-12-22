package com.invmodel.risk.data.client;

import com.invmodel.risk.data.*;

/**
 * Created by prashant on 12/4/2017.
 */
public class UOBRiskCalc extends RiskCalc
{
   public UOBRiskCalc()
   {
      super();
   }

   public UOBRiskCalc(UserRiskProfile userRiskProfile)
   {
      super(userRiskProfile);
      if (userRiskProfile != null)
      {
         ageTimeFormula(userRiskProfile.getAge(), userRiskProfile.getHorizon());
         calculate(1);  // Calculate First year
      }

   }

   public UOBRiskCalc(UserRiskProfile userRiskProfile, Long acctnum)
   {
      super(userRiskProfile, acctnum);
   }

   private Double calcRiskPercentile(Double duration)
   {
      if (duration == null || duration < 2.0)
      {
         return 0.0;
      }

      Double maxScore = userRiskProfile.getMaxScore();
      Double riskPercentile = (duration - 2.0) / 28 * maxScore;
      riskPercentile = Math.min(riskPercentile, maxScore);
      return (riskPercentile < 0.0 ? 0.0 : riskPercentile);
   }

   private Integer getUOBDuration(Integer age, Integer horizon)
   {
      if (age == null || age < 2)
      {
         return 1;
      }

      Double defaultWithdrawl = 95.0;
      Integer calcDuration = 0;
      Integer withdrawlperiod = 0;
      RiskConst.GOALS goal = userRiskProfile.getGoal();

      Double presentValue;
      if (goal == RiskConst.GOALS.RETIREMENT)
      {
         Integer retirementage = userRiskProfile.getDefaultDoubleValue(RiskConst.RETIREMENTAGE, 65.0).intValue();
         withdrawlperiod = userRiskProfile.getDefaultDoubleValue(RiskConst.WITHDRAWLAGE, defaultWithdrawl).intValue();
         age = (age <= 0) ? 30 : age;
         withdrawlperiod = (withdrawlperiod <= 0) ? 0 : withdrawlperiod;
         calcDuration = (retirementage - age <= 0) ? 0 : (retirementage - age);
         calcDuration += (withdrawlperiod - age);
         return calcDuration;
      }
      if (goal == RiskConst.GOALS.RETIRED)
      {
         calcDuration = userRiskProfile.getDefaultDoubleValue(RiskConst.WITHDRAWLAGE, defaultWithdrawl).intValue();
         return calcDuration;
      }
      if (goal == RiskConst.GOALS.EDUCATION)
      {
         withdrawlperiod = userRiskProfile.getDefaultDoubleValue(RiskConst.WITHDRAWLAGE, 1.0).intValue();
         horizon = (horizon <= 0) ? 17 : horizon;
         withdrawlperiod = (withdrawlperiod <= 0) ? 1 : withdrawlperiod;
         calcDuration = horizon + withdrawlperiod;
         return calcDuration;
      }
      if (goal == RiskConst.GOALS.BUILDWEALTH)
      {
         horizon = (horizon <= 0) ? 17 : horizon;
         calcDuration = horizon;
         return calcDuration;
      }
      if (goal == RiskConst.GOALS.LEGACY)
      {
         horizon = (horizon <= 0) ? 17 : horizon;
         calcDuration = horizon - age;
         return (calcDuration <= 0) ? 100 : calcDuration;
      }
      return 30;
   }


   @Override
   public Double ageTimeFormula(Integer age, Integer horizon)
   {
      Double value = userRiskProfile.getMaxScore();
      Integer duration;
      try
      {
         //duration = getUOBDuration(age, horizon);
         duration = horizon;
         Double interestRate = userRiskProfile.getDefaultDoubleValue(RiskConst.WITHDRAWLRATE, 0.04);
         Double investment = userRiskProfile.getTotalInvestment(duration);
         Double presentvalue = presentValue(investment,interestRate,duration);
         return value;
      }
      catch (Exception ex)
      {
         value = 100.0;
      }
      return value;
   }
}
