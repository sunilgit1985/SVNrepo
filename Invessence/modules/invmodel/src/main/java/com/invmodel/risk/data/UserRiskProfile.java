package com.invmodel.risk.data;

import java.util.*;

import com.invmodel.risk.dao.RiskFetchDAO;
import com.invmodel.risk.data.RiskConst;


/**
 * Created by prashant on 11/9/2017.
 */
public class UserRiskProfile
{
   private String advisor;
   private Long acctnum;
   private Integer knockout;
   private Map<String, UserRiskData> riskData;
   private Map<Integer, RiskScore> riskScores;
   private AdvisorRiskMaster advisorRiskMaster;

   private RiskFetchDAO riskfetchDAO;

   public UserRiskProfile()
   {
      riskfetchDAO = new RiskFetchDAO();
      riskData = new HashMap<String, UserRiskData>();
      riskScores = new HashMap<Integer, RiskScore>();
      knockout = 0;
      advisorRiskMaster = new AdvisorRiskMaster();
   }

   public UserRiskProfile(AdvisorRiskMaster advisorRiskMaster)
   {
      riskfetchDAO = new RiskFetchDAO();
      riskData = new HashMap<String, UserRiskData>();
      riskScores = new HashMap<Integer, RiskScore>();
      this.knockout = 0;
      this.advisorRiskMaster = advisorRiskMaster;
      this.advisor = advisorRiskMaster.getAdvisor();
      initUserRiskProfileDefault();
   }

   public UserRiskProfile(String advisor, Long acctnum)
   {
      riskfetchDAO = new RiskFetchDAO();
      riskData = new HashMap<String, UserRiskData>();
      riskScores = new HashMap<Integer, RiskScore>();
      this.knockout = 0;
      fetchUserRiskData(advisor, acctnum);
   }

   private void initUserRiskProfileDefault()
   {
      if (this.advisorRiskMaster != null)
      {
         Map<String, AdvisorRiskMasterData> riskMasterMap = advisorRiskMaster.getAdvisorMasterdata();
         if (riskMasterMap != null)
         {
            for (AdvisorRiskMasterData data : riskMasterMap.values())
            {
               if (data.getSaveforUser())
               {
                  if (riskData.containsKey(data.getKey()))
                  {
                     setAnswer(data.getKey(), data.getDefaultStrValue(), data.getDataType());
                  }
                  else {
                     UserRiskData userdata = new UserRiskData(data.getSortorder(), data.getKey(), data.getDefaultStrValue(), data.getDataType(), null);
                     riskData.put(data.getKey(), userdata);
                  }
               }
            }
         }

         Map<Integer, AdvisorRiskMapping> riskMappingMap = advisorRiskMaster.getAdvisorMappings();
         if (riskMappingMap != null)
         {
            for (AdvisorRiskMapping data : riskMappingMap.values())
            {
               String key = RiskConst.RISKQUESTIONKEY + data.getRiskQuestion().toString();
               Integer sortorder = RiskConst.RISKQSORTNUM + data.getRiskQuestion();
               if (riskData.containsKey(key))
               {
                  setAnswer(key, "0", "I", data.getDefaultWeight());
               }
               else {
                  UserRiskData userdata = new UserRiskData(sortorder, key, "0", "I", null);
                  riskData.put(key, userdata);

               }
            }
         }
      }
   }

   public void fetchUserRiskData(String advisor, Long acctnum)
   {
      setAdvisor(advisor);
      setAcctnum(acctnum);
      initUserRiskProfileDefault();
      collectUserData();
   }

   public void collectUserData() {
      if (acctnum != null)
      {
         riskfetchDAO.fetchRiskData(this);
         riskfetchDAO.fetchRiskScores(this);
      }
   }

   public String getAdvisor()
   {
      return advisor;
   }

   public void setAdvisor(String advisor)
   {
      this.advisor = advisor;
   }

   public AdvisorRiskMaster getAdvisorRiskMaster()
   {
      return advisorRiskMaster;
   }

   public void setAdvisorRiskMaster(AdvisorRiskMaster advisorRiskMaster)
   {
      this.advisorRiskMaster = advisorRiskMaster;
   }

   public String getDefaultStrValue(String key, String defaultValue)
   {
      String value = defaultValue;
      if (getRiskData().containsKey(key)) {
         value = getRiskData().get(key).getAnswer();
      }
      else
      {
         if (getAdvisorRiskMaster().getAdvisorMasterdata().containsKey(key))
         {
            value = getAdvisorRiskMaster().getAdvisorMasterdata().get(key).getDefaultDoubleValue().toString();
         }
      }
      return value;
   }

   public Double getDefaultDoubleValue(String key, Double defaultValue)
   {
      Double value = defaultValue;
      if (getRiskData().containsKey(key)) {
         value = getRiskData().get(key).getAnswerDouble();
      }
      else
      {
         if (getAdvisorRiskMaster().getAdvisorMasterdata().containsKey(key))
         {
            value = getAdvisorRiskMaster().getAdvisorMasterdata().get(key).getDefaultDoubleValue();
         }
      }
      return value;
   }

   public Long getAcctnum()
   {
      return acctnum;
   }

   public void setAcctnum(Long acctnum)
   {
      this.acctnum = acctnum;
   }

   public Integer getKnockout()
   {
      return knockout;
   }

   public void addKnockout()
   {
      this.knockout = (this.knockout + 1 > this.riskScores.size()) ? this.riskScores.size() : this.knockout + 1;
   }

   public void removeKnockout()
   {
      this.knockout = ((this.knockout - 1) < 0) ? 0 : this.knockout - 1;
   }

   public Double getMaxScore() {
      return (getDefaultDoubleValue(RiskConst.MAXSCORE, 100.0));
   }

   public Double getRiskScore(Integer year)
   {
      if (knockout > 0)
      {
         if (riskScores != null)
         {
            if (year > 0 && year < riskScores.size())
            {
               return riskScores.get(year).getScore();
            }
         }
      }
      return 0.0;
   }

   public ArrayList<RiskScore> getALLRiskScores()
   {
      ArrayList<RiskScore> list = new ArrayList<RiskScore>();
      for (RiskScore score : riskScores.values())
      {
         list.add(score);
      }
      return list;
   }

   public RiskScore getRiskScoreObj(Integer year)
   {
      if (riskScores != null)
      {
         if (riskScores.containsKey(year))
         {
            return riskScores.get(year);
         }
      }
      return null;
   }


   public void setRiskScores(Integer datevalue, String calcFormula,
                             Boolean allCashFlag, Double score,
                             Double standardScore,
                             Double assetScore,
                             Double portfolioScore,
                             Double adjustment)
   {
      if (riskScores != null)
      {
         RiskScore thisScore = new RiskScore(datevalue, calcFormula,
                                             allCashFlag,
                                             score,
                                             standardScore,
                                             assetScore,
                                             portfolioScore,
                                             adjustment);

         riskScores.put(datevalue, thisScore);
      }
   }

   public void setScore(Integer score)
   {
      setScore(0,score.doubleValue());

   }

   public void setScore(Integer year, Double score)
   {
      if (riskScores.containsKey(year))
      {
         riskScores.get(year).setScore(score);
      }
      else
      {
         setRiskScores(year, getAnswer(RiskConst.CALCFORMULA),
                       false,
                       score, score, score, score, 0.0);
      }
   }

   public Double getScore(Integer year)
   {
      if (riskScores.containsKey(year))
      {
         return riskScores.get(year).getScore();
      }
      return 0.0;
   }

   public void setAssetScore(Integer score)
   {
      setAssetScore(0,score.doubleValue());

   }

   public void initRiskScore(Integer year, Boolean allCashFlag, Double score) {
      setRiskScores(year, getAnswer(RiskConst.CALCFORMULA),
                    false,
                    score, score, score, score, 0.0);
   }

   public void setAssetScore(Integer year, Double score)
   {
      if (riskScores.containsKey(year))
      {
         riskScores.get(year).setAssetScore(score);
      }
      else
      {
         initRiskScore(year, false, score);
      }
   }

   public Double getAssetScore(Integer year)
   {
      if (year >= 0 && year < riskScores.size())
      {
         return riskScores.get(year).getAssetScore();
      }
      return 0.0;
   }

   public void setPortfolioScore(Integer score)
   {
      setPortfolioScore(0,score.doubleValue());

   }

   public void setPortfolioScore(Integer year, Double score)
   {
      if (riskScores.containsKey(year))
      {
         riskScores.get(year).setPortfolioScore(score);
      }
      else
      {
         initRiskScore(year, false, score);
      }
   }

   public Double getPortfolioScore(Integer year)
   {
      if (year >= 0 && year < riskScores.size())
      {
         return riskScores.get(year).getPortfolioScore();
      }
      return 0.0;
   }

   public void setStandardScore(Integer score)
   {
      setStandardScore(0,score.doubleValue());

   }

   public void setStandardScore(Integer year, Double score)
   {
      if (riskScores.containsKey(year))
      {
         riskScores.get(year).setStandardScore(score);
      }
      else
      {
         initRiskScore(year, false, score);
      }
   }

   public Double getStandardScore(Integer year)
   {
      if (year >= 0 && year < riskScores.size())
      {
         return riskScores.get(year).getStandardScore();
      }
      return 0.0;
   }

   public void setAllCashFlag(Integer year, Boolean thisflag)
   {
      if (riskScores.containsKey(year))
      {
         riskScores.get(year).setAllCashFlag(thisflag);
      }
      else
      {
         initRiskScore(year, thisflag, 0.0);
      }
   }

   public Boolean getAllCashFlag(Integer year)
   {
      if (year > 0 && year < riskScores.size())
      {
         return riskScores.get(year).getAllCashFlag();
      }
      return false;
   }


   // -------------------------------------------


   public Map<String, UserRiskData> getRiskData()
   {
      return riskData;
   }

   public void setRiskData(UserRiskData data)
   {
      if (data != null)
      {
         String key = data.getKey();
         if (riskData.containsKey(key))
         {
            riskData.get(key).setAnswer(data.getAnswer(), data.getAnswerType());
            riskData.get(key).setRiskScore(data.getRiskScore());
         }
         else
         {
            riskData.put(key, data);
         }
      }
   }

   private void setRiskData(String key, String answer, String answerType, Double score)
   {
      if (riskData.containsKey(key))
      {
         riskData.get(key).setAnswer(answer, answerType);
         riskData.get(key).setRiskScore(score);
      }
      else
      {
         UserRiskData data = new UserRiskData(RiskConst.CUSTOMSORTNUM, key, answer, answerType, score);
         riskData.put(key, data);
      }
   }

   public Integer getRiskQuestion() {
      if (riskData.containsKey(RiskConst.RISKQUESTIONS)) {
         return riskData.get(RiskConst.RISKQUESTIONS).getAnswerInt();
      }
      return 0;
   }

   public String getAnswer(String key)
   {
      if (riskData.containsKey(key))
      {
         return riskData.get(key).getAnswer();
      }
      return null;
   }

   public void setAnswer(String key, String answer)
   {
      setAnswer( key,  answer,  "T");
   }

   public void setAnswer(String key, Integer answer)
   {
      setAnswer( key,  answer.toString(),  "I");
   }

   public void setAnswer(String key, Double answer)
   {
      setAnswer( key,  answer.toString(),  "D");
   }

   public void setAnswer(String key, Boolean answer)
   {
      setAnswer( key,  answer.toString(),  "B");
   }

   private void setAnswer(String key, String answer, String answerType)
   {
      if (riskData != null)
      {
         if (riskData.containsKey(key))
         {
            riskData.get(key).setAnswer(answer, answerType);
         }
         else
         {
            setRiskData(key, answer, answerType, null);
         }
      }
   }

   public void setAnswer(String key, String answer, String answerType, Double riskScore)
   {
      if (riskData != null)
      {
         if (riskData.containsKey(key))
         {
            riskData.get(key).setAnswer(answer, answerType);
            riskData.get(key).setRiskScore(riskScore);
         }
         else
         {
            setRiskData(key, answer, answerType, riskScore);
         }
      }
   }

   private void setNewAnswer(String key, String answer, String answerType, Double riskScore)
   {
      String prevanswer;

      if (riskData == null)
         return;

      if (riskData.containsKey(key))
      {
         prevanswer = riskData.get(key).getAnswer();
         if (! prevanswer.equalsIgnoreCase(answer))
         {
            riskData.get(key).setAnswer(answer, answerType);
            riskData.get(key).setRiskScore(riskScore);
            setAnswer(key, answer.toString(), "I", riskScore);
         }
      }
      else {
         setRiskData(key, answer, answerType, riskScore);
      }
   }

   public Integer getAge()
   {
      return (riskData.containsKey(RiskConst.AGE) ? riskData.get(RiskConst.AGE).getAnswerInt() : null);
   }

   public Integer getDefaultAge()
   {
      Integer value = getAge();
      return (value == null || value < 0) ? 30 : value;
   }

   public Integer getHorizon()
   {
      return (riskData.containsKey(RiskConst.HORIZON) ? riskData.get(RiskConst.HORIZON).getAnswerInt() : null);
   }

   public Double getDefaultInitialInvestment()
   {
      return (riskData.containsValue(RiskConst.INITIALINVESTMENT) ?
                     riskData.get(RiskConst.INITIALINVESTMENT).getAnswerDouble() : 100000.0);

   }

   public Double getDefaultRecurringInvestment()
   {
      return (riskData.containsValue(RiskConst.RECURRINGINVESTMENT) ?
         riskData.get(RiskConst.RECURRINGINVESTMENT).getAnswerDouble() : 0.0);

   }

   public Integer getDefaultHorizon()
   {
      Integer value = getHorizon();
      return (value == null || value < 0) ? 35 : value;
   }

   public Double getTotalInvestment(Integer duration)
   {

      Double investment = riskData.containsValue(RiskConst.INITIALINVESTMENT) ?
         riskData.get(RiskConst.INITIALINVESTMENT).getAnswerDouble() : 0.0;
      Double recurring = riskData.containsValue(RiskConst.RECURRINGINVESTMENT) ?
         riskData.get(RiskConst.RECURRINGINVESTMENT).getAnswerDouble() : 0.0;
      if (investment == null || investment <= 0.0)
      {
         return investment;
      }


      Integer horizon;
      if (duration == null) {
         horizon = duration;
      }
      else {
         horizon = riskData.containsValue(RiskConst.HORIZON) ?
            riskData.get(RiskConst.HORIZON).getAnswerInt() : 0;
      }
      if (horizon == null || horizon <= 0) {
         return investment;
      }

      String term = riskData.containsValue(RiskConst.RECURRINGTERM) ?
         riskData.get(RiskConst.RECURRINGTERM).getAnswer() : null;
      Double recurringperiod = 1.0;
      if (term != null)
      {
         if (getRecurringTerms() == RiskConst.INVESTMENTTERMS.MONTHLY)
         {
            recurringperiod = (horizon.doubleValue() * 12.0);
         }
         if (getRecurringTerms() == RiskConst.INVESTMENTTERMS.YEARLY)
         {
            recurringperiod =  (horizon.doubleValue());
         }
         if (getRecurringTerms() == RiskConst.INVESTMENTTERMS.QUATERLY)
         {
            recurringperiod =  (horizon.doubleValue() * 4.0);
         }
         if (getRecurringTerms() == RiskConst.INVESTMENTTERMS.WEEKLY)
         {
            recurringperiod =  (horizon.doubleValue() * 52.0);
         }
      }
      return investment + (recurring * recurringperiod);
   }

   public Double getKeepLiquidCash()
   {
      Double value = riskData.get(RiskConst.KEEPLIQUID).getAnswerDouble();
      return ((value == null || value < 0.0) ? 0.0 : value);
   }

   public Integer getRiskAnswer(Integer question)
   {
      if (riskData != null)
      {
         String key = RiskConst.RISKQUESTIONKEY + question.toString();
         if (riskData.containsKey(key))
         {
            return riskData.get(key).getAnswerInt();
         }
      }
      return 0;
   }

   public Double getRiskAnswerWeight(Integer question)
   {
      if (riskData != null)
      {
         String key = RiskConst.RISKQUESTIONKEY + question.toString();
         if (riskData.containsKey(key))
         {
            return riskData.get(key).getRiskScore();
         }
      }
      return 0.0;
   }

   public void setRiskAnswer(Integer question, Integer answer, Double weight)
   {
      if (riskData != null)
      {
         String key = RiskConst.RISKQUESTIONKEY + question.toString();
         if (riskData.containsKey(key))
         {
            setRiskData(key, answer.toString(), "I", weight);
         }
         else {
            Integer sortnum = RiskConst.RISKQSORTNUM + question;
            UserRiskData userdata = new UserRiskData(sortnum, key, answer.toString(), "I", weight );
            riskData.put(key,userdata);
         }
      }
   }

   public void setInitialInvestment(Double investment)
   {
      setNewAnswer(RiskConst.INITIALINVESTMENT, investment.toString(), "D", 0.0);
   }

   public void setRecurringInvestment(Double investment)
   {
      setNewAnswer(RiskConst.RECURRINGINVESTMENT, investment.toString(), "D", 0.0);
   }

   public void setAge(Integer age)
   {
      setNewAnswer(RiskConst.AGE, age.toString(), "I", 0.0);
   }

   public void setHorizon(Integer horizon)
   {
      setNewAnswer(RiskConst.HORIZON, horizon.toString(), "I", 0.0);
   }

   public RiskConst.CALCMETHODS getCalcMethod()
   {
      String method = riskData.get(RiskConst.CALCMETHOD).getAnswer();
      for (RiskConst.CALCMETHODS s: RiskConst.CALCMETHODS.values()) {
         if (s.toString().startsWith(method)) {
            return s;
         }
      }

      throw new IllegalArgumentException( method );
   }

   public void setCalcFormula(String method)
   {
      setNewAnswer(RiskConst.CALCMETHOD, method, "T", 0.0);
   }

   public RiskConst.CALCFORMULAS getCalcFormula()
   {
      String formula = riskData.get(RiskConst.CALCFORMULA).getAnswer();
      for (RiskConst.CALCFORMULAS s: RiskConst.CALCFORMULAS.values()) {
         if (s.toString().startsWith(formula)) {
            return s;
         }
      }

      throw new IllegalArgumentException( formula );
   }

   public void setGoals(String goal) {
      setNewAnswer(RiskConst.GOAL, goal, "T", 0.0);
   }

   public RiskConst.GOALS getGoal()
   {
      String goal = riskData.get(RiskConst.GOAL).getAnswer();
      for (RiskConst.GOALS s: RiskConst.GOALS.values()) {
         if (s.toString().startsWith(goal)) {
            return s;
         }
      }
      throw new IllegalArgumentException( goal );
   }

   public void setRecurringTerms(String term) {
      setNewAnswer(RiskConst.RECURRINGTERM, term, "T", 0.0);
   }

   public RiskConst.INVESTMENTTERMS getRecurringTerms()
   {
      String term = riskData.get(RiskConst.RECURRINGTERM).getAnswer();
      for (RiskConst.INVESTMENTTERMS s: RiskConst.INVESTMENTTERMS.values()) {
         if (s.toString().startsWith(term)) {
            return s;
         }
      }
      throw new IllegalArgumentException( term );
   }

}