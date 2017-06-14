package com.invmodel.Const;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 10/9/13
 * Time: 6:14 PM
 * To change this template use File | Settings | File Templates.
 */
public class InvConst
{

   public static String CONSUMER_RISK_FORMULA = "C";
   public static String ADVISOR_RISK_FORMULA = "A";

   // Used in Asset Model
   public static String DEFAULT_THEME="0.Core";
   public static String DEFAULT_BASKET="Growth";
   public static String DEFAULT_TAXABLE_THEME="T.0.Core";
   public static String DEFAULT_TAXABLE_BASKET="Growth";
   public static String INVESSENCE_ADVISOR="Invessence";


   public static Double MNGT_FEES = 0.00;
   public static double MIN_MNGT_FEES_DOLLARS = 0.0;

   public static Integer ASSET_INTERPOLATION = 100;
   public static Integer ASSET_DEFAULT_POINT = 10;
   public static Double ASSET_PRECISION = 0.00001;

   public static Integer MAX_DURATION = 80;
   public static Integer MAX_RISK_OFFSET = 28;

   // Used in Portfolio Model
   public static int PORTFOLIO_INTERPOLATION = 100;
   public static Double MAX_CAPM_RETURNS = 0.12;
   public static Double MIN_CAPM_RETURNS = 0.01;

   public static int PORTFOLIO_DEFAULT_POINT = 70;
   public static Double PORTFOLIO_PRECISION = 0.000001;
   public static double PORTFOLIO_MNAGEMENT_FEES = 0.00;

   public static double MIN_CURRENT_ASSET = 0.0;

   public static double MONTHLY_CHILD_COST = 0;

   public static double MIN_LIQUID_CASH = 0.0;

   public static double ASSET_TRIGGER = 0.015;

   public static double CASH_TRIGGER = 0.005;

   //May want to change this to profile data
   public static double TLH_SHORT_THRESHOLd = 0.05;
   public static double TLH_Long_THRESHOLd = 0.05;

   public final static String TRADE_MODE = "Robo";

}
