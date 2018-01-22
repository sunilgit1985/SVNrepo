package com.invessence.web.bean.custody;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.faces.bean.*;
import javax.faces.context.FacesContext;

import com.invessence.custody.uob.UOBDataMaster;
import com.invessence.custody.uob.data.OwnerBankDetails;
import com.invessence.service.bean.Generic.Country;
import com.invessence.service.util.*;
import com.invessence.web.constant.WebConst;
import com.invessence.web.dao.consumer.ConsumerListDataDAO;
import com.invessence.web.data.common.CustomerData;
import com.invessence.web.service.custody.*;
import com.invessence.web.util.*;
import org.apache.commons.logging.*;

/**
 * Created by sagar on 1/17/2018.
 */
@ManagedBean(name = "uobFundBean")
@SessionScoped
public class UOBFund implements Serializable
{
   protected final Log logger = LogFactory.getLog(getClass());
   @ManagedProperty("#{uobCustodyService}")
   private CustodyService custodyService;

   @ManagedProperty("#{webutil}")
   private WebUtil webutil;

   @ManagedProperty("#{consumerListDataDAO}")
   private ConsumerListDataDAO listDAO;

   @ManagedProperty("#{aoWebLayer}")
   private AOWebLayer aoWebLayer;


   @ManagedProperty("#{uiLayout}")
   private UILayout uiLayout;

   private String selFundAcct, selChngStndInst;
   private boolean dsplFundDtls, dsplStndInstrDtls;
   private String beanacctnum;
   private String beanlogonID;
   private Date dtInvstDate, minInvstDate;
   private Long invstmAmount;
   private UOBDataMaster uobDataMaster;
   private String priHldrBnkAddr, fndError;
   private List<String> countries;
   private long beanAcctNum, beanLogonId;
   Map<String, Country> countryDetails = (Map<String, Country>) ServiceDetails.genericDetails.get(Constant.GENERIC_DETAILS.COUNTRY.toString());

   public void prerender()
   {
      String msgheader;
      try
      {
         if (!FacesContext.getCurrentInstance().isPostback())
         {
            if (!getWebutil().validatePriviledge(WebConst.ROLE_USER))
            {
               return;
            }

            if (getBeanacctnum() == null || getBeanacctnum().isEmpty())
            {
               msgheader = "dctd.100";
               getWebutil().redirecttoMessagePage("ERROR", "Access Denied", msgheader);
               return;
            }
            String valOutput = isValidAcctNum();
            setBeanAcctNum(getBeanAcctNum());

            if (valOutput.equalsIgnoreCase("NOACCOUNTMAP") || !valOutput.equalsIgnoreCase("success"))
            {
               msgheader = "dctd.201";
               getWebutil().redirecttoMessagePage("ERROR", "Access Denied", msgheader);
               return;
            }
            resetData();

            uobDataMaster = custodyService.fetch(getBeanAcctNum(), false);
            priHldrBnkAddr = getCstmaBnkAddr(uobDataMaster.getIndividualOwnersDetails().getOwnerBankDetails());
            countries = new ArrayList<String>(countryDetails.keySet());
         }
      }
      catch (Exception ex)
      {
         logger.info("Exception: raised during Starting TD CTO process.");
      }
   }

   private String isValidAcctNum()
   {
      String retValue = "";
      ArrayList<CustomerData> selAccountList = null;
      if (getWebutil().getUserInfoData() == null)
      {
         selAccountList = listDAO.getClientProfileList(Long.parseLong(getBeanlogonID()), getBeanAcctNum(), null, webutil.getWebprofile().getDefaultAdvisor(), webutil.getWebprofile().getDefaultRep());
      }
      else
      {
         beanLogonId = getWebutil().getUserInfoData().getLogonID();
         selAccountList = listDAO.getClientProfileList(getBeanLogonId(), getBeanAcctNum(), null, webutil.getUserInfoData().getAdvisor(), webutil.getUserInfoData().getRep());
      }
      if (selAccountList == null || selAccountList.size() == 0)
      {

         retValue = "NOACCOUNTMAP";
         return retValue;
      }
      if (selAccountList != null
         && (selAccountList.get(0).getCanIEditAccount()  || selAccountList.get(0).getHasClientID()))
      {
         retValue = "success";
         return retValue;
      }
      else
      {
         retValue = "ACCOUNTMANAGED";
         return retValue;
      }
   }

   public void resetData()
   {
      selFundAcct = null;
      selChngStndInst = null;
      dsplFundDtls = false;
      dsplStndInstrDtls = false;
      dtInvstDate = new Date();
      minInvstDate = dtInvstDate;
      priHldrBnkAddr = null;
   }

   public String getCstmaBnkAddr(OwnerBankDetails ownerBankDetails)
   {
      StringBuilder sb = new StringBuilder();
      if (ownerBankDetails.getBankAddressStreet1() != null)
      {
         sb.append(ownerBankDetails.getBankAddressStreet1() + "");
      }
      if (ownerBankDetails.getBankAddressStreet2() != null)
      {
         sb.append(ownerBankDetails.getBankAddressStreet2() + "");
      }
      if (ownerBankDetails.getBankAddressStreet3() != null)
      {
         sb.append(ownerBankDetails.getBankAddressStreet3() + "");
      }
      if (sb.length() > 0)
      {
         return sb.toString();
      }
      return null;
   }


   public List<String> completeText(String query)
   {
      List<String> MySortStrings = new ArrayList<String>();
      if (query.length() > 2)
      {
         for (int i = 0; i < countries.size(); i++)
         {
            if (countries.get(i).toLowerCase().contains(query.toLowerCase()))
            {
               MySortStrings.add(countries.get(i));
            }
         }
      }
      return MySortStrings;
   }

   public void onSelFndFnctn(String strFuncCat)
   {
      if (strFuncCat.equalsIgnoreCase("FUND"))
      {
         setDsplFundDtls(true);
         setDsplStndInstrDtls(false);
         setSelChngStndInst(null);
      }
      else if (strFuncCat.equalsIgnoreCase("CHNGINSTRN"))
      {
         setDsplFundDtls(false);
         setDsplStndInstrDtls(true);
         setSelFundAcct(null);
      }
   }

   public void submitFundForm()
   {
      try
      {
         if (validate())
         {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            custodyService.saveFundingEditDtls(Long.parseLong(beanacctnum), "a123", sdf.format(dtInvstDate), invstmAmount, "T");
            custodyService.mangeUserProfile(getBeanAcctNum(),"D",getBeanLogonId());
            getUiLayout().doMenuAction("custody", "custodyConfirmation.xhtml");
            dtInvstDate = new Date();
            invstmAmount = null;
         }
      }
      catch (Exception e)
      {
         System.out.println("Exception in submitFundForm " + e);
      }
   }

   public void CancelForm()
   {
      try
      {
         setDsplFundDtls(false);
         setDsplStndInstrDtls(false);
         setSelChngStndInst(null);
         setSelFundAcct(null);
      }
      catch (Exception e)
      {
         System.out.println("Exception in CancelForm " + e);
      }
   }

   private boolean validate()
   {
      Boolean dataOK = true;
      StringBuilder sb = null;
      try
      {
         sb = new StringBuilder();
         fndError = null;
         if (dtInvstDate == null)
         {
            sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.fund.edit.fundDt", "Funding date is required.", null));
         }
         if (invstmAmount == null || invstmAmount == 0)
         {
            sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.fund.edit.fundAmt", "Funding amount is required.", null));
         }
         if (sb.length() > 0)
         {
            dataOK = false;
            fndError = sb.toString();
         }
         else
         {
            dataOK = true;
            fndError = null;
         }
      }
      catch (Exception e)
      {
         System.out.println("Exception in validate " + e);
      }
      finally
      {
         sb = null;
      }
      return dataOK;
   }

   public String getSelFundAcct()
   {
      return selFundAcct;
   }

   public void setSelFundAcct(String selFundAcct)
   {
      this.selFundAcct = selFundAcct;
   }

   public String getSelChngStndInst()
   {
      return selChngStndInst;
   }

   public void setSelChngStndInst(String selChngStndInst)
   {
      this.selChngStndInst = selChngStndInst;
   }

   public boolean isDsplFundDtls()
   {
      return dsplFundDtls;
   }

   public void setDsplFundDtls(boolean dsplFundDtls)
   {
      this.dsplFundDtls = dsplFundDtls;
   }

   public boolean isDsplStndInstrDtls()
   {
      return dsplStndInstrDtls;
   }

   public void setDsplStndInstrDtls(boolean dsplStndInstrDtls)
   {
      this.dsplStndInstrDtls = dsplStndInstrDtls;
   }

   public String getBeanacctnum()
   {
      return beanacctnum;
   }

   public void setBeanacctnum(String beanacctnum)
   {
      this.beanacctnum = beanacctnum;
   }

   public String getBeanlogonID()
   {
      return beanlogonID;
   }

   public void setBeanlogonID(String beanlogonID)
   {
      this.beanlogonID = beanlogonID;
   }

   public UILayout getUiLayout()
   {
      return uiLayout;
   }

   public void setUiLayout(UILayout uiLayout)
   {
      this.uiLayout = uiLayout;
   }

   public WebUtil getWebutil()
   {
      return webutil;
   }

   public void setWebutil(WebUtil webutil)
   {
      this.webutil = webutil;
   }

   public CustodyService getCustodyService()
   {
      return custodyService;
   }

   public void setCustodyService(CustodyService custodyService)
   {
      this.custodyService = custodyService;
   }

   public ConsumerListDataDAO getListDAO()
   {
      return listDAO;
   }

   public void setListDAO(ConsumerListDataDAO listDAO)
   {
      this.listDAO = listDAO;
   }

   public AOWebLayer getAoWebLayer()
   {
      return aoWebLayer;
   }

   public void setAoWebLayer(AOWebLayer aoWebLayer)
   {
      this.aoWebLayer = aoWebLayer;
   }

   public Date getDtInvstDate()
   {
      return dtInvstDate;
   }

   public void setDtInvstDate(Date dtInvstDate)
   {
      this.dtInvstDate = dtInvstDate;
   }

   public Long getInvstmAmount()
   {
      return invstmAmount;
   }

   public void setInvstmAmount(Long invstmAmount)
   {
      this.invstmAmount = invstmAmount;
   }

   public UOBDataMaster getUobDataMaster()
   {
      return uobDataMaster;
   }

   public void setUobDataMaster(UOBDataMaster uobDataMaster)
   {
      this.uobDataMaster = uobDataMaster;
   }

   public String getPriHldrBnkAddr()
   {
      return priHldrBnkAddr;
   }

   public void setPriHldrBnkAddr(String priHldrBnkAddr)
   {
      this.priHldrBnkAddr = priHldrBnkAddr;
   }

   public List<String> getCountries()
   {
      return countries;
   }

   public void setCountries(List<String> countries)
   {
      this.countries = countries;
   }

   public Map<String, Country> getCountryDetails()
   {
      return countryDetails;
   }

   public void setCountryDetails(Map<String, Country> countryDetails)
   {
      this.countryDetails = countryDetails;
   }

   public String getFndError()
   {
      return fndError;
   }

   public void setFndError(String fndError)
   {
      this.fndError = fndError;
   }

   public Date getMinInvstDate()
   {
      return minInvstDate;
   }

   public void setMinInvstDate(Date minInvstDate)
   {
      this.minInvstDate = minInvstDate;
   }

   public long getBeanAcctNum()
   {
      return beanAcctNum;
   }

   public void setBeanAcctNum(long beanAcctNum)
   {
      this.beanAcctNum = beanAcctNum;
   }

   public long getBeanLogonId()
   {
      return beanLogonId;
   }

   public void setBeanLogonId(long beanLogonId)
   {
      this.beanLogonId = beanLogonId;
   }
}
