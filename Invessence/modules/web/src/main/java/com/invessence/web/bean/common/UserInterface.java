package com.invessence.web.bean.common;

import java.util.Map;
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

   public String defaultCheckedImage = "/javax.faces.resource/images/checkedN.png.xhtml?ln=invessence";
   public String selectedCheckedImage = "/javax.faces.resource/images/checkedY.png.xhtml?ln=invessence";

   public UserInterface()
   {
      webMenuList = new WebMenuList();
      jutil = new JavaUtil();
      converter = new SQLData();
      chart = new Chart();
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

   public Chart getChart()
   {
      return chart;
   }


}
