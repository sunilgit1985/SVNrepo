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

   private Integer getDuration(Integer age, Integer horizon)
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
   public Double ageTimeFormula(Integer age, Integer horizon,
                                Double investment, Double recurring,
                                Integer recurringPeriod, Integer withDrwalPeriod
   )
   {
      Double interestRate = 0.04;
      if (userRiskProfile != null)
      {
         interestRate = userRiskProfile.getDefaultDoubleValue(RiskConst.INTERESTRATE, 0.04);
      }

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

      horizon = getDefaultHorizon();
      Double presentvalue = presentValue(recurring, interestRate, horizon);
      Double goalDuration = 30.0;
      withDrwalPeriod = (withDrwalPeriod == null) ? 0 : withDrwalPeriod;
      if (investment > 0.0)
      {
         goalDuration = Math.max(Math.min(Math.round((horizon + presentvalue / investment * recurringPeriod / 2) + withDrwalPeriod / 2), 30.0), 2.0);
      }
      Double value = Math.min((goalDuration - 2) / 28 * maxScore, maxScore);
      value = maxScore - value;
      return value;

   }

}
