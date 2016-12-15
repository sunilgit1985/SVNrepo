package com.invessence.bean.advisor;

import java.io.Serializable;
import java.util.*;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.*;
import javax.faces.context.FacesContext;

import com.invessence.bean.*;
import com.invessence.dao.advisor.*;
import com.invessence.data.common.AccountData;
import com.invessence.util.*;


@ManagedBean(name = "manageAdvisorBean")
@ViewScoped
public class ManageAdvisorBean implements Serializable
{
   private static final long serialVersionUID = 100003L;

   WebUtil webutil = new WebUtil();
   Menu menu = new Menu();

/*
   @ManagedProperty("#{advisorBean}")
   private AdvisorBean abean;
*/

   @ManagedProperty("#{advisorListDataDAO}")
   private AdvisorListDataDAO advisorListDataDAO;

   @ManagedProperty("#{advisorSaveDataDAO}")
   private AdvisorSaveDataDAO advisorSaveDataDAO;

/*
   @ManagedProperty("#{positionBean}")
   private PositionBean positionBean;
*/

   private ArrayList<AccountData> accountDataList = new ArrayList<AccountData>();
   private ArrayList<AccountData> filteredDataList = new ArrayList<AccountData>();
   private String filteredClient;
   private AccountData selectedAccount;

   @ManagedProperty("#{emailMessage}")
   private EmailMessage messageSource;


   public EmailMessage getMessageSource()
   {
      return messageSource;
   }

   public void setMessageSource(EmailMessage messageSource)
   {
      this.messageSource = messageSource;
   }

   @PostConstruct
   public void init()
   {
      Long logonid;
      try
      {
         if (webutil.validatePriviledge("ADVISOR")) {
            logonid = webutil.getLogonid();

            if (logonid != null)
            {
               if (accountDataList == null || accountDataList.size() == 0) {
                  filterData();
               }
            }
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
   }


/*
   public void setAbean(AdvisorBean abean)
   {
      this.abean = abean;
   }

   public void setPositionBean(PositionBean positionBean)
   {
      this.positionBean = positionBean;
   }
*/

   public void setAdvisorListDataDAO(AdvisorListDataDAO advisorListDataDAO)
   {
      this.advisorListDataDAO = advisorListDataDAO;
   }

   public void setAdvisorSaveDataDAO(AdvisorSaveDataDAO advisorSaveDataDAO)
   {
      this.advisorSaveDataDAO = advisorSaveDataDAO;
   }

   public AdvisorSaveDataDAO getAdvisorSaveDataDAO()
   {
      return advisorSaveDataDAO;
   }

   public ArrayList<AccountData> getAccountDataList()
   {
      return accountDataList;
   }

   public void setAccountDataList(ArrayList<AccountData> accountDataList)
   {
      this.accountDataList = accountDataList;
   }

   public void collectData(Long logonid)
   {
      try
      {
         if (logonid != null)
         {
            if (accountDataList == null)
               accountDataList = new ArrayList<AccountData>();

            if (filteredDataList == null)
               filteredDataList = new ArrayList<AccountData>();

            accountDataList.clear();

            accountDataList = advisorListDataDAO.getListOfAccounts(logonid, null);
         }
      }
      catch (Exception ex)
      {
         System.out.println("Error in Advisor collecting data:" + ex.getMessage());
      }
   }

   public void filterData() {

      collectData(webutil.getLogonid());
      if (getFilteredClient() == null || getFilteredClient().length() == 0)
        filteredDataList = accountDataList;
      else {
         filteredDataList.clear();
         for (AccountData adata: accountDataList){
            if (adata.getAcctStatus().startsWith(getFilteredClient()))
               filteredDataList.add(adata);
         }
      }
   }

   public AdvisorListDataDAO getAdvisorListDataDAO()
   {
      return advisorListDataDAO;
   }

   public ArrayList<AccountData> getFilteredDataList()
   {
      return filteredDataList;
   }

   public void setFilteredDataList(ArrayList<AccountData> filteredDataList)
   {
      this.filteredDataList = filteredDataList;
   }

   public String getFilteredClient()
   {
      return filteredClient;
   }

   public void setFilteredClient(String filteredClient)
   {
      this.filteredClient = filteredClient;
   }

   public AccountData getSelectedAccount()
   {
      return selectedAccount;
   }

   public void setSelectedAccount(AccountData selectedAccount)
   {
      this.selectedAccount = selectedAccount;
   }

   public String doManagedAction()
   {
      try
      {
         if (getSelectedAccount() == null)
         {
            return "failed";
         }

         if (getSelectedAccount().getAcctStatus().equals("Active"))
         {
            //positionBean.findPosition(getSelectedAccount().getLogonid(), getSelectedAccount().getAcctnum());
            menu.doMenuAction("/common/overview.xhtml?acct="+getSelectedAccount().getAcctnum().toString());
         }
         else
         {
            //abean.loadData(getSelectedAccount().getAcctnum());
            menu.doMenuAction("/advisor/add.xhtml?acct="+getSelectedAccount().getAcctnum().toString());
            //advisorBean.findGoals(getLogonid(), getAcctnum());
         }
      }
      catch (Exception ex)
      {
         return ("failed");
      }

      return ("success");
   }

   public String doDelete(AccountData selected)
   {
      try
      {
         if (selected == null)
         {
            return "failed";
         }

         if (selected.getAccttype().equals("Active"))
         {
            FacesContext.getCurrentInstance().addMessage(null,
                                                         new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                                                          "",
                                                                          "Can not delete ACTIVE account.  Please close the account."));
         }
         else
         {
            advisorSaveDataDAO.deleteUserAccount(selected.getAcctnum());
            filterData();
         }

      }
      catch (Exception ex)
      {
         return ("failed");
      }

      return ("success");
   }

}