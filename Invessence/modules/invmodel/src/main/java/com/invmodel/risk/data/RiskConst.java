package com.invmodel.risk.data;

/**
 * Created by prashant on 11/13/2017.
 */
public class RiskConst
{
   public enum GOALS {
      RETIREMENT,
      RETIRED,
      SAVING,
      EDUCATION,
      COLLEGE,
      PROPERTY,
      BUILDWEALTH,
      LEGACY,
      INCOME;
   }

   public enum INVESTMENTTERMS {
      YEARLY,
      MONTHLY,
      WEEKLY,
      QUATERLY
   }

   public enum CALCFORMULAS {
      CALCULATED,
      DIRECT,
      ADVISOR
   }

   public enum CALCMETHODS {
      STANDARD,
      AGETIME,
      CUSTOM
   }


   public static String RISKQUESTIONKEY         = "RISK";

   public static String THEME                = "THEME";

   public static String RISKQUESTIONS     = "RISKQUESTIONS";
   public static String CALCMETHOD        = "CALCMETHOD";
   public static String CALCFORMULA       = "CALCFORMULA";
   public static String GOAL              = "GOAL";
   public static String KNOCKOUT          = "KNOCKOUT";
   public static String AGE               = "AGE";
   public static String HORIZON           = "HORIZON";
   public static String WITHDRAWALPERIOD  = "WITHDRAWALPERIOD";
   public static String TRADECURRENCY     = "SGD";
   public static String SETTLECURRENCY    = "SGD";
   public static String INITIALINVESTMENT = "INITIALINVESTMENT";
   public static String RECURRINGINVESTMENT = "RECURRINGINVESTMENT";
   public static String RECURRINGTERM     = "RECURRINGTERM";
   public static String RECURRINGPERIOD   = "RECURRINGPERIOD";
   public static String KEEPLIQUID        = "KEEPLIQUID";
   public static String TAXABLE           = "TAXABLE";
   public static String TAXRATE           = "TAXRATE";
   public static String EXPERIENCE        = "EXPERIENCE";

   public static String WITHDRAWLRATE     = "WITHDRAWLRATE";
   public static String AGEPOWERVALUE     = "AGEPOWERVALUE";
   public static String AGEWEIGHT         = "AGEWEIGHT";
   public static String MAXDURATION       = "MAXDURATION";
   public static String MAXSCORE          = "MAXSCORE";
   public static String RETIREMENTAGE     = "65";
   public static String WITHDRAWLAGE      = "95";

   public static Integer RISKQSORTNUM      = 900;
   public static Integer CUSTOMSORTNUM    = 999;
}
