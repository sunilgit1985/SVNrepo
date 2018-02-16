package com.invmodel.risk.data;

import java.util.*;

/**
 * Created by prashant on 11/13/2017.
 */
public class RiskConst
{
   public enum GOALS {
      RETIREMENT("RETIREMENT",1),
      PROPERTY("PROPERTY",2),
      EDUCATION("EDUCATION",3),
      LEGACY("LEGACY",4),
      BUILDWEALTH("BUILDWEALTH",5),
      SAVING("SAVING",6),
      INCOME("INCOME",7),
      RETIRED("RETIRED",11),
      COLLEGE("COLLEGE",12),
      UNDEFINED("UNDEFINED",99);

      String displayValue;
      Integer codeNum;

      GOALS(String displayValue, Integer codeNum)
      {
         this.displayValue = displayValue;
         this.codeNum = codeNum;
      }

      public String getDisplayValue()
      {
         return displayValue;
      }

      public Integer getCodeNum()
      {
         return codeNum;
      }

      private static final Map lookup =
         new HashMap();

      static
      {
         //Create reverse lookup hash map
         for (GOALS m : GOALS.values())
         {
            lookup.put(m.getDisplayValue(), m);
         }
      }

      public static GOALS displayToGoal(String value)
      {
         //the reverse lookup by simply getting
         //the value from the lookup HsahMap.
         value = value.toUpperCase();
         if (lookup.containsKey(value))
            return (GOALS) lookup.get(value);
         else
            return GOALS.UNDEFINED;
      }


   }

   public enum INVESTMENTTERMS {
      YEARLY,
      MONTHLY,
      WEEKLY,
      QUATERLY
   }

   public enum CALCFORMULAS {
      C,
      D,
      A
   }

   public enum CALCMETHODS {
      STANDARD,
      AGETIME,
      CUSTOM
   }


   public static String RISKQUESTIONKEY         = "RISK";

   public static String THEME                = "THEME";

   public static String PREDEFINEDMODEL   = "FIXED";
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
   public static String TOTALINVESTMENT   = "TOTALINVESTMENT";
   public static String RECURRINGINVESTMENT = "RECURRINGINVESTMENT";
   public static String RECURRINGTERM     = "RECURRINGTERM";
   public static String RECURRINGPERIOD   = "RECURRINGPERIOD";
   public static String KEEPLIQUID        = "KEEPLIQUID";
   public static String TAXABLE           = "TAXABLE";
   public static String TAXRATE           = "TAXRATE";
   public static String EXPERIENCE        = "EXPERIENCE";
   public static String INTERESTRATE      = "INTERESTRATE";

   public static String WITHDRAWLAMOUNT   = "WITHDRAWLAMOUNT";
   public static String WITHDRAWLRATE     = "WITHDRAWLRATE";
   public static String AGEPOWERVALUE     = "AGEPOWERVALUE";
   public static String AGEWEIGHT         = "AGEWEIGHT";
   public static String MAXDURATION       = "MAXDURATION";
   public static String MAXSCORE          = "MAXSCORE";
   public static String RETIREMENTAGE     = "RETIREMENTAGE";
   public static String WITHDRAWLAGE      = "WITHDRAWLAGE";
   public static String RISKADUSTMENT      = "RISKADJUSTMENT";

   public static String ALTTHEME        = "THEME-";

   public static String FINETUNEAJUSTMENTS   = "FINETUNEAJUSTMENTS";
   public static Integer RISKQSORTNUM      = 900;
   public static Integer CUSTOMSORTNUM    = 999;

   public static String MININTITIALRQMT = "MININTITIALRQMT";
   public static String MIN2NDINTIALRQMT = "MIN2NDINTIALRQMT";
   public static String MINRECCURRINGRQMT = "MINRECCURRINGRQMT";

}
