package invtest;

import com.invmodel.asset.data.AssetClass;
import com.invmodel.inputData.ProfileData;
import com.invmodel.model.ModelUtil;
import com.invmodel.portfolio.data.*;
import com.invmodel.risk.dao.RiskFetchDAO;
import com.invmodel.risk.data.*;

/**
 * Created by prashant on 11/13/2017.
 */
public class NewRiskCalc
{

   static RiskFetchDAO riskfetchDAO = new RiskFetchDAO();
   static ModelUtil modelUtil = ModelUtil.getInstance();
   static UserRiskProfile userRiskProfile;
   static AdvisorRiskMaster advisorRiskMaster;
   static RiskCalc riskCalc;

   public static void main(String[] args) throws Exception
   {
      testRisk(args);
   }

   public static void testRisk(String[] args) throws Exception
   {

      String advisor = "UOB";
      Long acctnum = null;

      advisorRiskMaster = new AdvisorRiskMaster(advisor);

      // Use existing account to collect data
      userRiskProfile = new UserRiskProfile(advisor, acctnum);

      overrideRisk(userRiskProfile);
      riskCalc = new RiskCalc(userRiskProfile);
      modelUtil.refreshData();

      // Data needed for Profiledata
      ProfileData profileData = new ProfileData();
      if (userRiskProfile.getRiskData().containsKey(RiskConst.INITIALINVESTMENT))
         profileData.setActualInvestment(userRiskProfile.getRiskData().get(RiskConst.INITIALINVESTMENT).getAnswerDouble());
      else
         profileData.setActualInvestment(100000.0);
      profileData.setAdvisor(advisor);
      profileData.setTheme(userRiskProfile.getAnswer(RiskConst.THEME));
      // ----

      calculateRisks(10);
      AssetClass[] aamc = modelUtil.buildAllocation(userRiskProfile, profileData);
      profileData.setAssetData(aamc);
      Portfolio[] pfclass = modelUtil.buildPortfolio(aamc, userRiskProfile, profileData);
      profileData.setPortfolioData(pfclass);
      System.out.print("Done");
   }

   public static void calculateRisks(Integer years) {
      // riskCalc.setAgeRisk(userRiskProfile.getAge());
      // riskCalc.setHorizonRisk(userRiskProfile.getHorizon());
      for (Integer loop = 1; loop <= userRiskProfile.getRiskQuestion(); loop ++) {
         riskCalc.setQuestionsRisk(loop, 1, null);
      }
      riskCalc.calculate(years);
   }


   public static void overrideRisk(UserRiskProfile userRiskProfile) {
      // userRiskProfile.setAnswer(RiskConst.ADVISOR, "UOB", "T");  This is already defined in default Init process
      userRiskProfile.setAnswer(RiskConst.THEME, "0.SGWealthSGD");
      userRiskProfile.setAnswer(RiskConst.GOAL, "Retirement");
      userRiskProfile.setAnswer(RiskConst.AGE, 45);
      userRiskProfile.setAnswer(RiskConst.HORIZON, 20);
      userRiskProfile.setAnswer(RiskConst.TRADECURRENCY, "SGD");
      userRiskProfile.setAnswer(RiskConst.SETTLECURRENCY, "SGD");
      userRiskProfile.setAnswer(RiskConst.INITIALINVESTMENT, 100000.0);
      userRiskProfile.setAnswer(RiskConst.RECURRINGINVESTMENT, 5000.0);
      userRiskProfile.setAnswer(RiskConst.RECURRINGTERM, "YEARLY");
      userRiskProfile.setAnswer(RiskConst.RECURRINGPERIOD, 1);
      userRiskProfile.setAnswer(RiskConst.WITHDRAWALPERIOD, 10);
      userRiskProfile.setAnswer(RiskConst.KEEPLIQUID, 0.0);
      userRiskProfile.setAnswer(RiskConst.KNOCKOUT, false);
      userRiskProfile.setAnswer(RiskConst.TAXABLE, false);
      userRiskProfile.setAnswer(RiskConst.TAXRATE, 0.20);
      userRiskProfile.setAnswer(RiskConst.EXPERIENCE, 1);

      userRiskProfile.setAnswer(RiskConst.RISKQUESTIONS, 7);
      userRiskProfile.setAnswer(RiskConst.CALCMETHOD, RiskConst.CALCMETHODS.AGETIME.toString());
      userRiskProfile.setAnswer(RiskConst.CALCFORMULA, RiskConst.CALCFORMULAS.C.toString().substring(1, 1));

   }


}
