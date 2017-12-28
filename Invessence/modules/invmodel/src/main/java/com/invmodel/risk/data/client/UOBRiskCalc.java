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

   public Double ageTimeFormula(Double maxScore, Integer age, Integer horizon,
                                Double investment, Double recurrring,
                                Integer recurringPeriod, Integer withDrwalPeriod,
                                Double interestRate) {

      Double presentvalue = presentValue(recurrring,interestRate,horizon);
      Double goalDuration = 30.0;
      if (investment > 0.0)
      {
         goalDuration = Math.max(Math.min(Math.round((horizon + presentvalue / investment * recurringPeriod / 2) + withDrwalPeriod / 2), 30.0), 2.0);
      }
      Double value = Math.min((goalDuration-2)/28*maxScore,maxScore);
      value = maxScore - value ;
      return value;

   }

   @Override
   public Double ageTimeFormula(Integer age, Integer horizon)
   {
      Double maxScore = userRiskProfile.getMaxScore();
      Double value = 0.0;
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

         // RiskConst.GOALS goal = RiskConst.GOALS.valueOf(userRiskProfile.getAnswer(RiskConst.GOAL));

         duration = horizon;
         Double b5 = userRiskProfile.getDefaultDoubleValue(RiskConst.RETIREMENTAGE, 67.0);
         Double b6 = age.doubleValue();

         Double b7;
         b7 = (horizon != null) ? horizon : b5 - age;
         b7 = (b7 < 0.0) ? 0.0 : b7; // Cannot be negative.
         Double b8 = userRiskProfile.getAnswerDouble(RiskConst.INITIALINVESTMENT);
         Double b9 = userRiskProfile.getAnswerDouble(RiskConst.RECURRINGINVESTMENT);
         Double b10 = userRiskProfile.getAnswerDouble(RiskConst.RECURRINGPERIOD);

         Double b11 = userRiskProfile.getDefaultDoubleValue(RiskConst.WITHDRAWALPERIOD, 0.0);
         // Double b11 = 95 - b5;
         Double interestRate = userRiskProfile.getDefaultDoubleValue(RiskConst.WITHDRAWLRATE, 0.04);

         Double b13 = ageTimeFormula(maxScore, age, b7.intValue(),b8, b9, b10.intValue(), b11.intValue(), interestRate);
         b13 = maxScore - b13;
         return b13;
      }
      catch (Exception ex)
      {
         value = 0.0;
      }
      return value;
   }

   @Override
   public void calculate(Integer years)
   {

      Double maxScore;
      Integer age;
      Integer horizon;
      Double investment, recurrring;
      Integer recurringPeriod, withDrwalPeriod;
      Double interestRate;

      if (userRiskProfile == null)
      {
         return;
      }

      if (userRiskProfile.getAdvisorRiskMaster().getAdvisorMasterdata().containsKey(RiskConst.MAXSCORE))
      {
         maxScore = userRiskProfile.getAdvisorRiskMaster().getAdvisorMasterdata().get(RiskConst.MAXSCORE).getDefaultDoubleValue();
      }
      else
         maxScore = 100.0;

      Integer numberofQuestions = userRiskProfile.getRiskQuestion();

      if (userRiskProfile.getCalcFormula() == RiskConst.CALCFORMULAS.C)
      {
         years = (years == null || years < 1) ? 1 : years;
         age = userRiskProfile.getAge();
         horizon = userRiskProfile.getHorizon();
         investment = userRiskProfile.getAnswerDouble(RiskConst.INITIALINVESTMENT);
         recurrring = userRiskProfile.getAnswerDouble(RiskConst.RECURRINGINVESTMENT);
         recurringPeriod = userRiskProfile.getAnswerInt(RiskConst.RECURRINGPERIOD);
         if (recurringPeriod == null)
            recurringPeriod = 0;

         withDrwalPeriod = userRiskProfile.getAnswerInt(RiskConst.WITHDRAWALPERIOD);
         if (withDrwalPeriod == null)
            withDrwalPeriod = 1;

         // Double b11 = 95 - b5;
         interestRate = userRiskProfile.getDefaultDoubleValue(RiskConst.WITHDRAWLRATE, 0.04);


         userRiskProfile.getALLRiskScores().clear();
         for (Integer thisyear = 0 ; thisyear <= years - 1 ; thisyear++)  {

            if (userRiskProfile.getKnockout() > 0)
            {
               userRiskProfile.setAllCashFlag(thisyear, true);
               continue;
            }

            Double tempWeight = 0.0;
            // This will redetermine the score since age and horizon are changing over period of years.
            Double value =             ageTimeFormula(maxScore, age, horizon,
                                               investment, recurrring,
                                               recurringPeriod, withDrwalPeriod,
                                               interestRate);

            // The reason, we are NOT starting with Zero, is because the Zero represents Age/Horizon Risk default.
            // Above Age and Horizon are already calculated in value.  *** Can we optimize!
            for (int loop = 1; loop <= numberofQuestions + 1; loop++)
            {
               tempWeight = userRiskProfile.getRiskAnswerWeight(loop);
               if (tempWeight != null)
               {
                  value = (tempWeight > value) ? tempWeight : value;
               }
            }

            value = (value < 0.0) ? 0.0 : value;
            value = (value > maxScore) ? maxScore : value;
            value = (maxScore - value);
            userRiskProfile.initRiskScore(thisyear, false, value);
            age = (age++ >= 100) ? 100 : age; // Increase the age.
            horizon = (horizon-- <= 0) ? 0 : horizon; // Decrease horizon
            recurrring = (recurrring-- <= 0) ? 0 : recurrring; // Decrease the recurring
            // Only once the horizon is reaced to zero, then start the withdrawl
            if (horizon <= 0)
            {
               withDrwalPeriod = (withDrwalPeriod-- <= 0) ? 0 : withDrwalPeriod;
            }
         }
      }
   }

   @Override
   public void calculate() {
      calculate(0);
   }

}
