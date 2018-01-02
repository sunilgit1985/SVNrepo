package com.invmodel.risk.data;

import java.util.*;

/**
 * Created by prashant on 11/14/2017.
 */
public class RiskCalc
{
   public UserRiskProfile userRiskProfile;

   private Calendar cal = Calendar.getInstance();

   public RiskCalc()
   {
      this.userRiskProfile = null;
   }

   public RiskCalc(UserRiskProfile userRiskProfile)
   {
      this.userRiskProfile = userRiskProfile;
/*
      if (userRiskProfile != null)
      {
         ageTimeFormula(userRiskProfile.getAge(), userRiskProfile.getHorizon());
      }
*/

   }

   public RiskCalc(UserRiskProfile userRiskProfile, Long acctnum)
   {
      this.userRiskProfile = userRiskProfile;
      userRiskProfile.setAcctnum(acctnum);
   }

   private String getDateValue(Integer increment)
   {
      Integer year = cal.get(cal.YEAR);
      Integer month = cal.get(cal.MONTH);
      Integer date = cal.get(cal.DATE);
      increment = ((increment == null) ? 0 : ((increment < 0) ? 0 : increment));
      year = year + increment;
      return (year.toString() + month.toString() + date.toString());
   }

   public void setAssetRisk(Integer year, Double score)
   {
      if (userRiskProfile != null)
      {
         year = (year == null) ? 0 : year;
         userRiskProfile.setAssetScore(year, score);
      }
   }

   public void setPortfolioRisk(Integer year, Double score)
   {
      if (userRiskProfile != null)
      {
         year = (year == null) ? 0 : year;
         userRiskProfile.setPortfolioScore(year, score);
      }
   }

   public void setStandardScore(Integer year, Double score)
   {
      if (userRiskProfile != null)
      {
         year = (year == null) ? 0 : year;
         userRiskProfile.setStandardScore(year, score);
      }
   }

   public void setAllCashFlag(Integer year, Boolean allCashFlag)
   {
      if (userRiskProfile != null)
      {
         year = (year == null) ? 0 : year;
         userRiskProfile.setAllCashFlag(year, allCashFlag);
      }
   }

   public ArrayList<RiskScore> getAllScores()
   {
      if (userRiskProfile != null)
      {
         userRiskProfile.getALLRiskScores();
      }
      return null;
   }

   public Boolean getKnockOutFlag()
   {
      try
      {
         return (userRiskProfile.getKnockout() > 0) ? true : false;
      }
      catch (Exception ex)
      {
         return false;
      }

   }

   public Double getScore(Integer year)
   {
      Double score;
      year = (year == null) ? 0 : year;
      if (getKnockOutFlag())
      {
         return 0.0;
      }

      if (userRiskProfile != null)
      {
         return userRiskProfile.getScore(year);
      }
      return 0.0;
   }

   public Double getStandardScore(Integer year)
   {
      year = (year == null) ? 0 : year;
      if (getKnockOutFlag())
      {
         return 0.0;
      }

      if (userRiskProfile != null)
      {
         return userRiskProfile.getStandardScore(year);
      }
      return 0.0;
   }

   public Double getAssetScore(Integer year)
   {
      year = (year == null) ? 0 : year;
      if (getKnockOutFlag())
      {
         return 0.0;
      }

      if (userRiskProfile != null)
      {
         return userRiskProfile.getAssetScore(year);
      }
      return 0.0;
   }

   public Double getPortfolioScore(Integer year)
   {
      year = (year == null) ? 0 : year;
      if (getKnockOutFlag())
      {
         return 0.0;
      }

      if (userRiskProfile != null)
      {
         return userRiskProfile.getPortfolioScore(year);
      }
      return 0.0;
   }

   public Double presentValue(Double futureValue, Double interestRate, Integer years) {
      try {
         Double presentvalue = 0.0;
         for (Integer loop = 1; loop <= years; loop++)
         {
            presentvalue += futureValue / (Math.pow((1.0 + interestRate), loop.doubleValue()));
         }
         return presentvalue;
      }
      catch (Exception ex) {
         return 0.0;
      }
   }

   public Double ageTimeFormula(Integer age, Integer horizon)
   {
      Double value;
     try
      {
         Double agePowerValue = userRiskProfile.getDefaultDoubleValue(RiskConst.AGEPOWERVALUE, 1.7);
         Double ageWeight = userRiskProfile.getDefaultDoubleValue(RiskConst.AGEWEIGHT, 1.0);
         Double maxDuration = userRiskProfile.getDefaultDoubleValue(RiskConst.MAXDURATION, 15.0);
         Double maxScore = userRiskProfile.getMaxScore();

         age = (age == null) ? 30 : age;
         horizon = (horizon == null) ? 1 : horizon;
         Double horPowerAdj = horizon / maxDuration;
         if (horPowerAdj > 1.0)
         {
            horPowerAdj = 1.0;
         }
         agePowerValue = agePowerValue * horPowerAdj;

         value = Math.pow((age.doubleValue() / maxScore), agePowerValue);
         value = Math.min(maxScore * value, ageWeight * maxScore);
         value = (value > maxScore) ? maxScore : value;

         //JAV 6/2/2017 when Horizon is 1 its aways cash type portfolio
         if (horizon == 1)
         {
            value = 100.0;
         }
         return value;
      }
      catch (Exception ex)
      {
         value = 0.0;
      }
      return value;
   }

   public Double getUserRiskQuestionsWeight(Integer question)
   {
      return userRiskProfile.getRiskAnswerWeight(question);
   }

   public void setQuestionsRisk(Integer question, Integer answer, Double weight)
   {
      userRiskProfile.setRiskQuestionWeight(question,  answer,  weight);
   }

   public void setRisk0(Double score)
   {
      if (userRiskProfile != null)
      {
         // Double score = ageTimeFormula(age, userRiskProfile.getHorizon());
         setQuestionsRisk(0, 0, score);
      }
   }

   private void calcAgeTime(Integer year, Integer age, Integer horizon)
   {
      Double maxScore = 100.0;
      Double value = 0.0;
      try
      {

         if (userRiskProfile == null)
         {
            return;
         }

         userRiskProfile.initRiskScore(year, false, 0.0);
         if (userRiskProfile.getKnockout() > 0)
         {
            userRiskProfile.setAllCashFlag(year, true);
            return;
         }

         if (userRiskProfile.getAdvisorRiskMaster().getAdvisorMasterdata().containsKey(RiskConst.MAXSCORE))
         {
            maxScore = userRiskProfile.getAdvisorRiskMaster().getAdvisorMasterdata().get(RiskConst.MAXSCORE).getDefaultDoubleValue();
         }

         Integer numberofQuestions = userRiskProfile.getRiskQuestion();
         Double tempWeight = 0.0;
         // This will redetermine the score since age and horizon are changing over period of years.
         value = ageTimeFormula(age, horizon);
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
         userRiskProfile.initRiskScore(year, false, value);

      }
      catch (Exception ex)
      {
         userRiskProfile.setAllCashFlag(year, true);
      }

   }

   public void calculate(Integer years)
   {
      Integer age;
      Integer horizon;
      if (userRiskProfile.getCalcFormula() == RiskConst.CALCFORMULAS.C)
      {
         years = (years == null || years < 1) ? 1 : years;
         age = userRiskProfile.getAge();
         horizon = userRiskProfile.getHorizon();

         userRiskProfile.getALLRiskScores().clear();
         for (Integer thisyear = 0 ; thisyear <= years - 1 ; thisyear++)  {
            calcAgeTime(thisyear, age, horizon);
            age++;
            horizon--;
         }
      }
   }

   public void calculate() {
      calculate(0);
   }
}
