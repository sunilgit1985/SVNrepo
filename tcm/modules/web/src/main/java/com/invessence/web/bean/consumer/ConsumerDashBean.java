package com.invessence.web.bean.consumer;

import java.io.Serializable;
import java.util.*;
import javax.faces.bean.*;
import javax.faces.context.FacesContext;

import com.invessence.web.constant.*;
import com.invessence.web.dao.consumer.*;
import com.invessence.web.data.common.CustomerData;
import com.invessence.web.util.*;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 1/3/15
 * Time: 6:52 PM
 * To change this template use File | Settings | File Templates.
 */

@ManagedBean(name = "cdash")
@SessionScoped
public class ConsumerDashBean implements Serializable
{
   private static final long serialVersionUID = 1001L;

   @Autowired
   private WebUtil webutil;

   @ManagedProperty("#{consumerListDataDAO}")
   private ConsumerListDataDAO listDAO;
   public void setListDAO(ConsumerListDataDAO listDAO)
   {
      this.listDAO = listDAO;
   }

   private List<CustomerData> manageAccountList;

   private CustomerData selectedAccount;


   public void preRenderView()
   {

      Long logonid;
      String fetchStatus;
      try
      {
         if (!FacesContext.getCurrentInstance().isPostback())
         {
            if (webutil.validatePriviledge(WebConst.ROLE_USER)) {
               logonid = webutil.getLogonid();

               if (logonid != null)
                  collectData(logonid);
            }
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
   }

/*
   @PostConstruct
   public void init()
   {
      Long logonid;
      String fetchStatus;
      try
      {
         if (webutil.validatePriviledge(Const.ROLE_USER)) {
            logonid = webutil.getLogonid();

            if (logonid != null)
               collectData(logonid);
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
   }
*/

   public String getLoggedUserName() {
      return webutil.getLastFirstName();
   }

   public void collectData(Long logonid)
   {
       manageAccountList = listDAO.getClientProfileData(logonid,null);
    }


   public List<CustomerData> getManageAccountList()
   {
      return manageAccountList;
   }

   public CustomerData getSelectedAccount()
   {
      return selectedAccount;
   }

   public void setSelectedAccount(CustomerData selectedAccount)
   {
      this.selectedAccount = selectedAccount;
   }

   public String doSelectedAction()
   {
      String whichXML;
      try
      {
         if (getSelectedAccount().getManaged())
         {
            whichXML = "/common/overview.xhtml?acct="+selectedAccount.getAcctnum().toString();
         }
         else {
            whichXML = "/consumer/cadd.xhtml?acct="+selectedAccount.getAcctnum().toString();
         }
         webutil.redirect(whichXML, null);
      }
      catch (Exception ex)
      {
         return ("failed");
      }

      return ("success");
   }

}
