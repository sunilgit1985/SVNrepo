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
      Double maxScore = userRiskProfile.getMaxScore();
      Double value = maxScore;
      Integer duration;
      try
      {
         /* Formula
         Input values
         B5. Retirement Age: Age +_ Horizon (Default RETIREMENTAGE from property.
         B6. Current Age: Age
         B7. When do expect to start withdrawing funds for this goal? (years): Formula (B5 - B6)
         B8. Initial/Current investment amount ($): Initial Investment
         B9. Intended Contribution ($ p.a.): Initial Investment
         B10. Number of Years of additional contribution (years): Addition Contribution Years
         B11. When I start withdrawing funds for this goal,
            I intend to withdraw the amount over the following number of years: Inferred based on goals
         B12. Goal Duration: = =MAX(MIN(ROUND((B7-PV(0.04,B10,B9)/B8*B10/2)+B11/2,0),30),2)
         I. Risk Percentile: = MIN((B12-2)/28*100,100)
         */

         RiskConst.GOALS goal = RiskConst.GOALS.valueOf(userRiskProfile.getAnswer(RiskConst.GOAL));

         duration = horizon;
         Double b5 = userRiskProfile.getDefaultDoubleValue(RiskConst.RETIREMENTAGE, 67.0);
         Double b6 = age.doubleValue();

         Double b7;
         if (goal.equals(RiskConst.GOALS.RETIRED)) {
            b7 = 0.0;
         }
         else
         {
            b7 = (horizon != null) ? horizon : b5 - age;
            b7 = (b7 < 0.0) ? 0.0 : b7; // Cannot be negative.
         }
         Double b8 = userRiskProfile.getAnswerDouble(RiskConst.INITIALINVESTMENT);
         Double b9 = userRiskProfile.getAnswerDouble(RiskConst.RECURRINGINVESTMENT);
         Double b10 = userRiskProfile.getAnswerDouble(RiskConst.RECURRINGPERIOD);

         Double b11 = userRiskProfile.getDefaultDoubleValue(RiskConst.WITHDRAWALPERIOD, 0.0);
         // Double b11 = 95 - b5;
         Double interestRate = userRiskProfile.getDefaultDoubleValue(RiskConst.WITHDRAWLRATE, 0.04);
         Double presentvalue = presentValue(b9,interestRate,b7.intValue());
         Double b12 = Math.max(Math.min(Math.round((b7+presentvalue/b8*b10/2)+b11/2),30.0),2.0);

         Double b13 = Math.min((b12-2)/28*maxScore,maxScore);
         setRisk0(b13);
         return b13;
      }
      catch (Exception ex)
      {
         value = maxScore;
         setRisk0(value);
      }
      return value;
   }
}
