package com.invmodel.risk.data;

import java.util.*;

import com.invmodel.Const.InvConst;

/**
 * Created by prashant on 11/14/2017.
 */
public class RiskCalc
{
   public UserRiskProfile userRiskProfile;

   public String advisor, theme;
   public RiskConst.CALCFORMULAS riskFormula;
   public Integer maxScore;

   public Integer age, horizon, recurringPeriod, withDrwalPeriod;
   public Double investment, recurring, withdrawlamount;

   private Double scoreDeviation;
   private Double riskScore;

   private Calendar cal = Calendar.getInstance();

   public RiskCalc()
   {
      this.userRiskProfile = null;
      setDefault();
   }

   public RiskCalc(UserRiskProfile userRiskProfile)
   {
      this.userRiskProfile = userRiskProfile;
      setDefault();
   }

   public RiskCalc(UserRiskProfile userRiskProfile, Long acctnum)
   {
      this.userRiskProfile = userRiskProfile;
      userRiskProfile.setAcctnum(acctnum);
   }

   public void setDefault()
   {
      if (userRiskProfile != null)
      {
         advisor = userRiskProfile.getAdvisor();
         theme = userRiskProfile.getDefaultStrValue(RiskConst.THEME, InvConst.DEFAULT_THEME);
         maxScore = userRiskProfile.getDefaultIntValue(RiskConst.MAXSCORE, 100);
         age = userRiskProfile.getDefaultAge();
         horizon = null;
         recurringPeriod = userRiskProfile.getDefaultIntValue(RiskConst.RECURRINGPERIOD, 0);
         withDrwalPeriod = userRiskProfile.getDefaultIntValue(RiskConst.WITHDRAWALPERIOD, 0);
         investment = userRiskProfile.getDefaultInitialInvestment();
         recurring = userRiskProfile.getDefaultRecurringInvestment();
         withdrawlamount = userRiskProfile.getDefaultDoubleValue(RiskConst.WITHDRAWALPERIOD, 0.0);
         scoreDeviation = userRiskProfile.getDefaultDoubleValue(RiskConst.FINETUNEAJUSTMENTS, 15.0);
      }
      else
      {
         theme = InvConst.DEFAULT_THEME;
         maxScore = 100;
         age = 30;
         horizon = null;
         recurringPeriod = 0;
         withDrwalPeriod = 0;
         investment = 100000.0;
         recurring = 0.0;
         withdrawlamount = 0.0;
         scoreDeviation = 15.0;
      }
      riskFormula = RiskConst.CALCFORMULAS.C;
      riskScore = 0.0;
   }

   public UserRiskProfile getUserRiskProfile()
   {
      return userRiskProfile;
   }

   public String getTheme()
   {
      return theme;
   }

   public void setTheme(String theme)
   {
      this.theme = theme;
      if (userRiskProfile != null)
      {
         userRiskProfile.setAnswer(RiskConst.THEME, theme);
      }
   }

   public String getAdvisor()
   {
      return advisor;
   }

   public void setAdvisor(String advisor)
   {
      this.advisor = advisor;
      if (userRiskProfile != null)
      {
         userRiskProfile.setAdvisor(advisor);
      }
   }

   public Integer getAge()
   {
      return age;
   }

   public void setAge(Integer age)
   {
      this.age = age;
   }

   public Integer getHorizon()
   {
      return horizon;
   }

   public void setHorizon(Integer horizon)
   {
      this.horizon = horizon;
   }

   public Integer getRecurringPeriod()
   {
      return recurringPeriod;
   }

   public void setRecurringPeriod(Integer recurringPeriod)
   {
      this.recurringPeriod = recurringPeriod;
   }

   public Integer getWithDrwalPeriod()
   {
      return withDrwalPeriod;
   }

   public void setWithDrwalPeriod(Integer withDrwalPeriod)
   {
      this.withDrwalPeriod = withDrwalPeriod;
   }

   public Double getInvestment()
   {
      return investment;
   }

   public void setInvestment(Double investment)
   {
      if (investment == null || investment == 0.0)
      {
         if (userRiskProfile != null)
            this.investment = userRiskProfile.getDefaultInitialInvestment();
         else
            this.investment = 100000.0;
      }
      else
      {
         this.investment = investment;
      }
   }

   public Double getRecurring()
   {
      return recurring;
   }

   public void setRecurring(Double recurring)
   {
      this.recurring = recurring;
   }

   public Double getWithdrawlamount()
   {
      return withdrawlamount;
   }

   public void setWithdrawlamount(Double withdrawlamount)
   {
      this.withdrawlamount = withdrawlamount;
   }

   public RiskConst.CALCFORMULAS getRiskFormula()
   {
      return riskFormula;
   }

   public void setRiskFormula(RiskConst.CALCFORMULAS riskFormula)
   {
      this.riskFormula = riskFormula;
   }

   public Double getRiskScore()
   {
      return riskScore;
   }

   public void setRiskScore(Double riskScore)
   {
      this.riskScore = riskScore;
   }

   public Integer getScoreInfo() {
      if (userRiskProfile != null) {
         if (userRiskProfile.getRiskScoreObj(0) != null) {
            return userRiskProfile.getRiskScoreObj(0).standardScore.intValue();
         }
      }
      return riskScore.intValue();
   }

   private Integer getScoreAdjustments()
   {
      if (userRiskProfile != null){
         return userRiskProfile.getDefaultIntValue(RiskConst.RISKADUSTMENT,15);
      }

//      if (userRiskProfile != null)
//      {
//         if (userRiskProfile.getRiskScoreObj(0) != null)
//         {
//            if (userRiskProfile.getRiskScoreObj(0).adjustment >= 0.0)
//            {
//               return userRiskProfile.getRiskScoreObj(0).adjustment.intValue();
//            }
//         }
//      }
      return 0;
   }

   public void setScoreLowerBound(Integer scoreLowerBound)
   {
   }

   public void setScoreUpperBound(Integer scoreUpperBound)
   {

   }

   public Integer getScoreLowerBound() {
      Integer adjustment = getScoreInfo() - getScoreAdjustments();
      return ((adjustment <= 0) ? 0 :  adjustment);
   }

   public Integer getScoreUpperBound() {
      Integer adjustment = getScoreInfo() + getScoreAdjustments();
      return ((adjustment >= maxScore) ? maxScore :  adjustment);
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

   public void setScore(Integer year, Double score)
   {
      if (userRiskProfile != null)
      {
         year = (year == null) ? 0 : year;
         userRiskProfile.setScore(year, score);
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
      if (userRiskProfile != null)
      {
         return (userRiskProfile.getKnockout() > 0) ? true : false;
      }
      return false;

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

   public Double presentValue(Double futureValue, Double interestRate, Integer years)
   {
      try
      {
         Double presentvalue = 0.0;
         for (Integer loop = 1; loop <= years; loop++)
         {
            presentvalue += futureValue / (Math.pow((1.0 + interestRate), loop.doubleValue()));
         }
         return presentvalue;
      }
      catch (Exception ex)
      {
         return 0.0;
      }
   }

   public Integer getDefaultAge()
   {
      age = (age > 110) ? 110 : age; // Cannot be negative.
      return age;

   }

   public Integer getDefaultHorizon()
   {

      Integer tmp = horizon;

      if (tmp == null)
      {
         Integer b5;
         if (userRiskProfile != null)
         {
            b5 = userRiskProfile.getDefaultIntValue(RiskConst.RETIREMENTAGE, 67).intValue();
         }
         else
         {
            b5 = 67;
         }

         Integer age = getDefaultAge();
         tmp =  (b5 - age);
      }
      tmp = (tmp < 0) ? 1 : tmp; // Cannot be negative.
      return tmp;

   }

   public Integer getDefaultRecurringPeriod()
   {
      return recurringPeriod;
   }

   public Integer getDefaultWithDrwalPeriod()
   {
      return (withDrwalPeriod==null ? 0 :withDrwalPeriod);
   }

   public Double getDefaultInvestment()
   {
      return investment;
   }

   public Double getDefaultRecurring()
   {
      return recurring;
   }

   public Double getDefaultWithdrawlAmount()
   {
      return (withdrawlamount== null ? 0.0:withdrawlamount);
   }

   public Double ageTimeFormula(Integer age, Integer horizon)
   {
      Double value = ageTimeFormula(age, horizon,
                     investment, recurring,
                     recurringPeriod, withDrwalPeriod);
      userRiskProfile.setRiskQuestionWeight(0, 0, value);
      return value;
   }

   public Double ageTimeFormula(Integer age, Integer horizon,
                                Double investment, Double recurring,
                                Integer recurringPeriod, Integer withDrwalPeriod
   )
   {
      Double value;
      Double agePowerValue;
      Double ageWeight;
      Double maxDuration;
      Integer defaultAge = 30;

      try
      {
         if (userRiskProfile != null)
         {
            agePowerValue = userRiskProfile.getDefaultDoubleValue(RiskConst.AGEPOWERVALUE, 1.7);
            ageWeight = userRiskProfile.getDefaultDoubleValue(RiskConst.AGEWEIGHT, 1.0);
            maxDuration = userRiskProfile.getDefaultDoubleValue(RiskConst.MAXDURATION, 15.0);
            defaultAge = userRiskProfile.getDefaultAge();
         }
         else
         {
            agePowerValue = 1.7;
            ageWeight = 1.0;
            maxDuration = 15.0;
         }

         age = (age == null) ? defaultAge : age;
         horizon = (horizon == null) ? getDefaultHorizon() : horizon;
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

         value = maxScore - value;
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
      userRiskProfile.setRiskQuestionWeight(question, answer, weight);
   }

   public void setRisk0(Double score)
   {
      if (userRiskProfile != null)
      {
         // Double score = ageTimeFormula(age, userRiskProfile.getHorizon());
         setQuestionsRisk(0, 0, score);
      }
   }


   public void calculate()
   {
      Integer age, horizon;
      Double investment, recurring, withdrawlamount;
      Integer recurringPeriod, withDrwalPeriod;
      Double thisscore;

      if (userRiskProfile != null && userRiskProfile.getCalcFormula().toString().equalsIgnoreCase(RiskConst.CALCFORMULAS.C.toString()))
      {
         age = getDefaultAge();
         horizon = getDefaultHorizon();
         investment = getDefaultInvestment();
         recurring = getDefaultRecurring();
         recurringPeriod = getDefaultRecurringPeriod();
         withDrwalPeriod = getDefaultWithDrwalPeriod();
         withdrawlamount = getDefaultWithdrawlAmount();

         if (getKnockOutFlag())
         {
            thisscore = 0.0;
            userRiskProfile.initRiskScore(0, true, 0.0);
         }
         else
         {
            thisscore = calculateRisk(age, horizon, investment,
                                      recurring, recurringPeriod,
                                      withDrwalPeriod, withdrawlamount);
            userRiskProfile.initRiskScore(0, false, thisscore);
         }

         riskScore = thisscore;
         setRiskScore(thisscore);
      }

   }

   public Double calculateRisk(Integer age, Integer horizon, Double investment,
                               Double recurring, Integer recurringPeriod,
                               Integer withDrwalPeriod, Double withdrawlamount)
   {
      Double value = 0.0;
      if (getKnockOutFlag())
      {
         riskFormula = RiskConst.CALCFORMULAS.C;
         riskScore = value;
         return value;
      }

      if (riskFormula == (RiskConst.CALCFORMULAS.C))
      {
         riskFormula = RiskConst.CALCFORMULAS.C;
         Double tempWeight = 0.0;
         Integer numberofQuestions = userRiskProfile.getRiskQuestion();
         numberofQuestions = (numberofQuestions == null) ? 0 : numberofQuestions;
         value = ageTimeFormula(age, horizon, investment, recurring, recurringPeriod, withDrwalPeriod);

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
         return value;
      }

      return riskScore;
   }

   public Integer getIntRiskScore()
   {
      System.out.println("Final risk score ["+getRiskScore()+"]");
      if (riskScore==null && userRiskProfile != null) {
         if (userRiskProfile.getRiskScoreObj(0) != null) {
            return userRiskProfile.getRiskScoreObj(0).getScore().intValue();
         }
      }
      return riskScore.intValue();
   }

   public void setIntRiskScore(Integer intRiskScore)  {
      riskScore=intRiskScore.doubleValue();
   }
}
