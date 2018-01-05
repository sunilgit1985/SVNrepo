package com.invessence.web.bean.common;

import java.util.*;
import javax.faces.bean.ManagedProperty;

import com.invessence.converter.*;
import com.invessence.web.dao.common.CommonDAO;
import com.invessence.web.util.*;
import com.invessence.web.util.Impl.*;
import com.invmodel.model.ModelUtil;
import org.apache.commons.logging.*;

/**
 * Created by prashant on 12/7/2017.
 */
public class UserInterface implements Logger
{
   protected final Log logger = LogFactory.getLog(getClass());

   @ManagedProperty("#{webutil}")
   public WebUtil webutil;

   @ManagedProperty("#{uiLayout}")
   public UILayout uiLayout;

   @ManagedProperty("#{webMessage}")
   public WebMessage messageText;

   @ManagedProperty("#{commonDAO}")
   public CommonDAO listCommonDAO;

   public WebMenuList webMenuList;

   // Charts
   public Chart chart;

   // Utils
   public SQLData converter;
   public JavaUtil jutil;
   public PagesImpl pagemanager;
   public ProgressBarImpl progressbar;
   Calendar cal;


   public String defaultCheckedImage = "/javax.faces.resource/images/checkedN.png.xhtml?ln=invessence";
   public String selectedCheckedImage = "/javax.faces.resource/images/checkedY.png.xhtml?ln=invessence";

   public UserInterface()
   {
      webMenuList = new WebMenuList();
      jutil = new JavaUtil();
      converter = new SQLData();
      chart = new Chart();
      cal = Calendar.getInstance();

   }

   @Override
   public Log getLogger()
   {
      return logger;
   }

   public void setWebutil(WebUtil webutil)
   {
      this.webutil = webutil;
   }

   public void setUiLayout(UILayout uiLayout)
   {
      this.uiLayout = uiLayout;
   }

   public void setMessageText(WebMessage messageText)
   {
      this.messageText = messageText;
   }

   public void setListCommonDAO(CommonDAO listCommonDAO)
   {
      this.listCommonDAO = listCommonDAO;
   }

   public void setWebMenuList(WebMenuList webMenuList)
   {
      this.webMenuList = webMenuList;
   }

   public void loadWebMenuList(String advisor)
   {
      webMenuList = listCommonDAO.loadWebPagesMenuItems(advisor);
   }

   public Integer getProgressBar() {
      return progressbar.getProgressBar().intValue();
   }

   public WebUtil getWebutil()
   {
      return webutil;
   }

   public SQLData getConverter()
   {
      return converter;
   }

   public JavaUtil getJutil()
   {
      return jutil;
   }

   public PagesImpl getPagemanager()
   {
      return pagemanager;
   }

   public Chart getChart()
   {
      return chart;
   }

   public Integer getCurrentYear() {
      return cal.get(cal.YEAR);
   }

   public Integer getYear(Integer numofyears) {
      Integer thisYear = getCurrentYear();
      if (numofyears != null && numofyears > 0) {
         return thisYear + numofyears;
      }
      return thisYear;
   }

   public Boolean hasData(String data)
   {
      if (data != null && !data.isEmpty() && data.length() > 0)
      {
         return true;
      }
      return false;
   }

   public Boolean hasData(Long data)
   {
      if (data == null || data == 0)
      {
         return false;
      }
      return true;
   }
   public Boolean hasData(Integer data)
   {
      if (data == null || data == 0)
      {
         return false;
      }
      return true;
   }
   public Boolean hasData(Double data)
   {
      if (data == null || data == 0.0)
      {
         return false;
      }
      return true;
   }
}
