package com.invessence.web.data.common;

import java.util.*;
import javax.faces.bean.ManagedProperty;

import com.invessence.web.dao.common.CommonDAO;

/**
 * Created by Prashant on 12/16/2016.
 */
public class WebProfile
{
   String url;
   Boolean forced; // forced, would mean override the default url and use given URL.
   String mode;    // This mode will be set on forced.  (DEMO, UAT to control some flow on webpage).
   Map<String, String> webInfo;


   public WebProfile()
   {
      url=null;
      forced=false;
      webInfo = new HashMap<String, String>();
      setdefault();
   }

   public Map<String, String> getWebInfo()
   {
      return webInfo;
   }

   public void setWebInfo(Map<String, String> webInfo)
   {
      if (webInfo != null) { this.webInfo = webInfo; }
   }

   public String getInfo(String key) {
      if (webInfo != null) {
         if (webInfo.containsKey(key)) {
            return webInfo.get(key);
         }
      }
      return null;
   }

   public String getUrl()
   {
      return url;
   }

   public void setUrl(String url)
   {
      this.url = url;
   }

   public Boolean getForced()
   {
      return forced;
   }

   public void setForced(Boolean forced)
   {
      this.forced = forced;
   }

   public String getMode()
   {
      return mode;
   }

   public void setMode(String mode)
   {
      this.mode = mode;
   }



   public void setdefault() {
      webInfo.put(	"ARCHIVE.CLOSED"	,	"10"	);
      webInfo.put(	"ARCHIVE.INACTIVE"	,	"30"	);
      webInfo.put(	"ARCHIVE.UNOPENED"	,	"30"	);
      webInfo.put(	"CSS.CUSTODY"	,	"css/inv.css"	);
      webInfo.put(	"CSS.CUSTOM"	,	"css/inv.css"	);
      webInfo.put(	"CUSTODY.URL"	,	"https://www.interactivebrokers.com/Universal/servlet/formWelcome?&partnerID=Invessence&invitedBy=dmNtMDMxNzE2"	);
      webInfo.put(	"CUSTODY.SERVICE"	,	"URL"	);
      webInfo.put(	"DEFAULT.MODEL"	,	"0.Wealth"	);
      webInfo.put(	"DEFAULT.REP"	,	""	);
      webInfo.put(	"DIR.CONSUMER"	,	"invessence"	);
      webInfo.put(	"CSS.DIR"	,	"inv"	);
      webInfo.put(	"DIR.CUSTODY"	,	""	);
      webInfo.put(	"DIR.TEMPLATE"	,	"/template/common/spark"	);
      webInfo.put(	"EMAIL.MAIN"	,	"info@invessence.com"	);
      webInfo.put(	"EMAIL.OPERATION"	,	"operations@invessence.com"	);
      webInfo.put(	"EMAIL.SUPPORT"	,	"support@invessence.com"	);
      webInfo.put(	"EMAIL.USER"	,	"noreply@invessence.com"	);
      webInfo.put(	"HTML.FORGOT"	,	"invessence-Forgot.htm"	);
      webInfo.put(	"HTML.LOCKED"	,	"invessence-Locked.htm"	);
      webInfo.put(	"HTML.RESET"	,	"invessence-Reset.htm"	);
      webInfo.put(	"HTML.WELCOME"	,	"invessence-Welcome.htm"	);
      webInfo.put(	"HTML.WELCOME.ADV"	,	"invessence-Welcome.htm"	);
      webInfo.put(	"INVESTMENT.MIN1ST"	,	"2000"	);
      webInfo.put(	"INVESTMENT.MIN2ND"	,	"50"	);
      webInfo.put(	"INVESTMENT.RECURRING1ST"	,	"50"	);
      webInfo.put(	"INVESTMENT.RECURRING2ND"	,	"50"	);
      webInfo.put(	"PHONE.MAIN"	,	"(201) 977-1955"	);
      webInfo.put(	"PHONE.SUPPORT"	,	"(201) 977-1954"	);
      webInfo.put(	"SUBJECT.EMAIL.ACTIVATE"	,	"Welcome to Invessence – Activate Your Account"	);
      webInfo.put(	"SUBJECT.EMAIL.LOCKED"	,	"Invessence – Account is locked"	);
      webInfo.put(	"SUBJECT.EMAIL.RESET"	,	"Invessence – Reset Your Password"	);
      webInfo.put(	"SUBJECT.EMAIL.WELCOME"	,	"Welcome to Invessence – Activate Your Account"	);
      webInfo.put(	"URL.SECURE"	,	"https://invessence.com"	);
      webInfo.put(	"URL.WEBSITE"	,	"http://invessence.com"	);
      webInfo.put(	"WEB.COMPANYNAME"	,	"Invessence"	);
      webInfo.put(	"WEB.COPYRIGHT"	,	"Invessence"	);
      webInfo.put(	"WEB.LOGO"	,	"images/logo/invessence.png"	);
      webInfo.put(	"WEB.LOGOLIB"	,	"invessence"	);
      webInfo.put(	"WEB.LOGOSIZE"	,	"200px"	);
      webInfo.put(	"WEB.MODE"	,	"PROD"	);
      webInfo.put(	"WEB.THEME"	,	"spark"	);
      webInfo.put(	"WEB.THEMELIB"	,	"spark-layout"	);
      webInfo.put(	"WEB.GOOGLEANALYTICS"	,	"bb_googleanalytics.js"	);
   }

   public String getCid()
   {
      return getInfo("CID");
   }
   public String getHomepage() { return getInfo("URL.WEBSITE");}
   public String getSecurehomepage()
   {
      return getInfo("URL.SECURE");
   }

   public String getMainemail() {return getInfo("EMAIL.MAIN");}
   public String getSupportemail() { return getInfo("EMAIL.SUPPORT");}
   public String getEmailUser()
   {
      return getInfo("EMAIL.USER");
   }
   public String getOperationUser()
   {
      return getInfo("EMAIL.OPERATION");
   }

   public String getMainphone()
   {
      return getInfo("PHONE.MAIN");
   }
   public String getSupportphone() { return getInfo("PHONE.SUPPORT"); }

   public String getForwardservice()
   {
      return getInfo("CUSTODY.SERVICE");
   }
   public String getCustodyURL()
   {
      return getInfo("CUSTODY.URL");
   }

   public String getConsumerdir()
   {
      return getInfo("DIR.CONSUMER");
   }
   public String getTemplatedir()
   {
      return getInfo("DIR.TEMPLATE");
   }
   public String getCustodydir()
   {
      return getInfo("DIR.CUSTODY");
   }

   public String getCssdir()
   {
      return getInfo("CSS.DIR");
   }
   public String getCustomcss()
   {
      return getInfo("CSS.CUSTOM");
   }
   public String getCustodycss()
   {
      return getInfo("CSS.CUSTODY");
   }

   public String getCompanyname() { return getInfo("WEB.COMPANYNAME"); }
   public String getLogo() { return getInfo("WEB.LOGO");}
   public String getLogolib() {return getInfo("WEB.LOGOLIB");}
   public String getLogosize() { return getInfo("LOGO.SIZE"); }
   public String getTheme() {  return getInfo("WEB.THEME"); }
   public String getThemelib() {  return getInfo("WEB.THEMELIB"); }
   public String getWebmode()
   {
      return getInfo("WEB.MODE");
   }
   public String getCopyright()
   {
      return getInfo("WEB.COPYRIGHT");
   }
   public String getGoogleAnalytic()
   {
      return getInfo("WEB.GOOGLEANALYTICS");
   }


   public String getEmailTemplate(String key) { return getInfo(key); }
   public String getEmailSubject(String key) { return getInfo(key); }

}
