package com.invessence.web.constant;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 5/18/16
 * Time: 9:55 PM
 * To change this template use File | Settings | File Templates.
 */
public class WebConst
{
   public final static String DEFAULT_THEME = "modena";
   public final static String DEFAULT_LOGO = "images/logo/LOGO.png";
   public final static String DEFAULT_LOGOLIB = "invessence";

   public static String LOGONID_PARAM = "p_logonid";
   public static String ACCTNO_PARAM = "p_acctnum";
   public static String USER_INFO = "userinfo";
   public static String WEB_INFO = "webinfo";
   public static String WEB_MENU = "webmenu";
   public static String USERLOGON_ATTEMPTS = "attempts";
   public static String USERLOGON_ACCTTYPE = "accttype";
   public static String USERLOGON_ACCESS = "access";
   public static Integer MAX_ATTEMPTS = 4; // Offset from 0, therefore 2 = 3 attempts
   public static String DB_FUNCTION_ADD = "A";
   public static String DB_FUNCTION_MOD = "M";

   public static String PROFILE_STANDARD_PROCESS = "Q";
   public static String PROFILE_ADVANCE_PROCESS = "D";

   public static String CONSUMER_RISK_FORMULA = "C";
   public static String ADVISOR_RISK_FORMULA = "A";

   public final static String URL_HOME = "index.html";

   public final static String ROLE_ADMIN = "ADMIN";
   public final static String ROLE_SALES = "SALES";
   public final static String ROLE_SUPPORT = "SUPPORT";
   public final static String ROLE_ADVISOR = "ADVISOR";
   public final static String DEVEL_ADVISOR = "DEVELOPER";
   public final static String ROLE_DEVELOPER = "DEVELOPER";

   public final static String ROLE_OWNER = "OWNER";
   public final static String ROLE_USER = "USER";
   public final static String ACCESS_USER_FULL = "F";
   // public final static String ACCESS_USER_VIEW = "V"; By default you have view privileges if data is entered in DB user_access_role

   public final static String WEB_CONSUMER = "User";
   public final static String WEB_ALL = "ALL";
   public final static String WEB_USER = "User";
   public final static String WEB_ADVISOR = "Advisor";
   public final static String WEB_ADMIN = "SuperAdmin";

   /*
      public final static String HTML_WELCOME = "HTML.WELCOME";
      public final static String HTML_LOCKED = "HTML.LOCKED";
      public final static String HTML_RESET = "HTML.RESET";
      public final static String HTML_WELCOME_ADV = "HTML.WELCOME.ADV";
      public final static String HTML_INVOICE = "HTML.INVOICE";
      public final static String HTML_SURVEY = "HTML.SURVEY";
   */
   public final static String EMAIL_ACTIVATE = "EMAIL_ACTIVATE";
   public final static String EMAIL_LOCKED = "EMAIL_LOCKED";
   public final static String EMAIL_RESET = "EMAIL_RESET";
   public final static String EMAIL_WELCOME = "EMAIL_WELCOME";
   public final static String EMAIL_WELCOME_ADV = "EMAIL_WELCOME_ADV";

   public final static String EMAIL_ACTIVATE_SUBJECT = "EMAIL.ACTIVATE.SUBJECT";
   public final static String EMAIL_FORGOT_SUBJECT = "EMAIL.FORGOT.SUBJECT";
   public final static String EMAIL_LOCKED_SUBJECT = "EMAIL.LOCKED.SUBJECT";
   public final static String EMAIL_RESET_SUBJECT = "EMAIL.RESET.SUBJECT";
   public final static String EMAIL_WELCOME_SUBJECT = "EMAIL.WELCOME.SUBJECT";
   public final static String EMAIL_WELCOME_ADV_SUBJECT = "EMAIL.WELCOME.SUBJECT";

   public final static String HTML_BASE_PATH = "HTML.BASE.PATH";
   public final static String HTML_ACTIVATED = "HTML.ACTIVATED";
   public final static String HTML_WELCOME = "HTML.WELCOME";
   public final static String HTML_LOCKED = "HTML.LOCKED";
   public final static String HTML_RESET = "HTML.RESET";
   public final static String HTML_FORGOT = "HTML.FORGOT";
   public final static String HTML_WELCOME_ADV = "HTML.WELCOME.ADV";
   public final static String HTML_INVOICE = "HTML.INVOICE";
   public final static String HTML_SURVEY = "HTML.SURVEY";

   public final static String TRADE_PROCESS_RECON="R";
   public final static String TRADE_PROCESS_NEW="N";
   public final static String TRADE_PROCESS_ALLOC="A";
   public final static String TRADE_PROCESS_DATE="D";

   public final static String TRADE_PROCESS_STAT_NEW="N";
   public final static String TRADE_PROCESS_STAT_REVIEW="R";
   public final static String TRADE_PROCESS_STAT_PROCESSED="P";

   public final static String INVDB_TO_AUDIT="invdbtoaudit";
   public final static String PREDEFINED="Predefined";
   public final static String SUCCESS="success";
   public final static String VALIDATION="validation";
   public final static String APPROVED="Approved";
   public final static String VALIDATION_SUCCESS="Validate Success";
   public final static String PROJECTION="projection";
   public final static String PERFORMANCE="perormance";
   public final static String VERIFIED="Verified";
   public final static String AUDIT_TO_INVDB="audittoinvdb";
   public final static String ROLLBACKED="Rollbacked";
   public final static String UPLOADED="Uploaded";

   public final static String SEL_ACCOUNT="account";

}
