package com.invessence.web.bean.consumer;

import java.util.*;

import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import javax.faces.event.*;

import com.invessence.web.bean.common.UserInterface;
import com.invessence.web.constant.*;
import com.invessence.web.controller.HighChartsController;
import com.invessence.web.dao.common.*;
import com.invessence.web.dao.consumer.*;
import com.invessence.web.data.common.*;
import com.invmodel.model.ModelUtil;
import com.invmodel.risk.data.*;
import org.apache.commons.logging.*;
import org.primefaces.event.*;

/**
 * Created by prashant on 11/16/2017.
 */
public class PortfolioCreationUI extends UserInterface
{

   @ManagedProperty("#{modelUtil}")
   public ModelUtil modelUtil;

   @ManagedProperty("#{consumerListDataDAO}")
   public ConsumerListDataDAO listDAO;

   @ManagedProperty("#{userInfoDAO}")
   public UserInfoDAO userInfoDAO;

   @ManagedProperty("#{consumerSaveDataDAO}")
   public ConsumerSaveDataDAO saveDAO;

   @ManagedProperty("#{tradeDAO}")
   public TradeDAO tradeDAO;


   public enum UIMode {
      New("N"),
      Edit("E"),
      ChangeStrategy("C"),
      Confirm("V"),
      View("W"),
      Advisor("A");

      String mode;

      UIMode(String mode)
      {
         this.mode = mode;
      }

      public String getMode()
      {
         return mode;
      }
   }

   enum UIAssetChart {
      Pie("P"),
      Donut("D"),
      Bar("B");

      String assetchart;

      UIAssetChart(String assetchart)
      {
         this.assetchart = assetchart;
      }

      public String getAssetchart()
      {
         return assetchart;
      }
   }

   public Long beanAcctnum;
   public UIMode beanmode;
   public String backURL;
   public String interfaceMode;

   private CustomerData savedCustomer = null;
   private CustomerData customer = null;
   private RiskCalc riskCalc = null;

   // UI management variables
   public Boolean formEdit = false;
   public Boolean canOpenAccount = false;

   // Panel Controls
   public Boolean welcomeDialog;
   public Boolean disablegraphtabs, disabledetailtabs;
   public Boolean displayGoalGraph;
   public Boolean displayDataPanel;
   public Boolean displayConfirmPanel;

   // Buttons
   public Boolean disableChangeStragegyButton;

   @Override
   public Log getLogger()
   {
      return logger;
   }

   public PortfolioCreationUI()
   {
   }

   public void setModelUtil(ModelUtil modelUtil)
   {
      this.modelUtil = modelUtil;
   }

   public void setListDAO(ConsumerListDataDAO listDAO)
   {
      this.listDAO = listDAO;
   }

   public void setUserInfoDAO(UserInfoDAO userInfoDAO)
   {
      this.userInfoDAO = userInfoDAO;
   }

   public void setSaveDAO(ConsumerSaveDataDAO saveDAO)
   {
      this.saveDAO = saveDAO;
   }

   public void setTradeDAO(TradeDAO tradeDAO)
   {
      this.tradeDAO = tradeDAO;
   }

   public Long getBeanAcctnum()
   {
      return beanAcctnum;
   }

   public void setBeanAcctnum(Long beanAcctnum)
   {
      this.beanAcctnum = converter.getLongData(beanAcctnum);
   }

   public String getInterfaceMode()
   {
      return interfaceMode;
   }

   public void setInterfaceMode(String interfaceMode)
   {
      this.interfaceMode = interfaceMode;
      if (interfaceMode != null && beanmode == null)
      {
         beanmode = UIMode.valueOf(interfaceMode);
      }
   }

   public String getBackURL()
   {
      return backURL;
   }

   public void setBackURL(String backURL)
   {
      this.backURL = backURL;
   }

   public CustomerData getSavedCustomer()
   {
      return savedCustomer;
   }

   public CustomerData getCustomer()
   {
      return customer;
   }

   public RiskCalc getRiskCalc()
   {
      return riskCalc;
   }

   public void initUI() {
      highChartsController = new HighChartsController();
      charts = new PrimefacesCharts();
      formEdit = false;
      disablegraphtabs = true;
      disabledetailtabs = true;
      disableChangeStragegyButton = true;
      welcomeDialog = true;
      displayGoalGraph = false;
      displayDataPanel=false;
      displayConfirmPanel=false;
      backURL=null;

      setInterfaceMode(UIMode.New.toString());
      resetData();
   };


   public void preRenderView()
   {

      try
      {
         if (!FacesContext.getCurrentInstance().isPostback())
         {
            customer.setCalcFormula(RiskConst.CALCFORMULAS.CALCULATED.toString());
            // For both new and existing client, this fetch is called.  It determines the default values.
            fetchClientData();

/*
            if(FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("ProfileCnf")!=null){
               setInterfaceMode(UIMode.Confirm.toString());
               // dsplStrategyCnfPnl=(Boolean)FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("ProfileCnf");
               FacesContext.getCurrentInstance().getExternalContext().getSessionMap().remove("ProfileCnf");
            }

            if(FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("ProfileCnf1")!=null){
               FacesContext.getCurrentInstance().getExternalContext().getSessionMap().remove("ProfileCnf1");
               setInterfaceMode(UIMode.New.toString());
            }
*/
         }
      }
      catch (Exception e)
      {
         resetData();
      }
   }

   public void resetData()
   {
      customer = new CustomerData();

      // This is short term solution.  Since Data needs DAO object to collect data.
      // We are passing it as collected on UI.
      customer.initDao(webutil, modelUtil, uiLayout,
                       listDAO, userInfoDAO,
                       saveDAO, tradeDAO,
                       messageText);
      customer.setDefault();
   }

   public void fetchClientData()
   {
      try
      {
         resetData();
         if (beanAcctnum != null && beanAcctnum > 0L)
         {
            loadProfileData(beanAcctnum);
            customer.setSaveVisitor(false);
            if (beanmode != null && beanmode == UIMode.ChangeStrategy)
            {
               savedCustomer = new CustomerData();
               savedCustomer.copyData(customer);  // Need a way to do clean copy.
            }
            else {
               setInterfaceMode(UIMode.Edit.toString());
            }
         }
         else
         {
            // 1) Remember we called New account from Dashboard.  So the first case is based on Dashboard.
            if(webutil.isUserLoggedIn())  {
               customer.setSaveVisitor(false);
            }

            setInterfaceMode(UIMode.New.toString());
            customer.loadNewClientData();

         }

         webMenuList = listCommonDAO.loadWebPagesMenuItems(customer.getAdvisor());
      }
      catch (Exception ex)
      {
         String stackTrace = ex.getMessage();
         webutil.alertSupport("PortfolioCreation.fetchClient", "Error:PortfolioCreation.fetchClient",
                              "error.fetchClient", stackTrace);
      }

   }

   public void loadProfileData(Long acctnum)
   {

      try
      {
         customer.loadProfileData(acctnum);
         customer.loadRiskData();
         formEdit = false;
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }


   public void onAllocSlider(SlideEndEvent event)
   {
//      System.out.println(event.getValue());
      customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.DIRECT.name());
      customer.riskProfile.setScore(event.getValue());
      customer.riskProfile.setAssetScore(event.getValue());
      formEdit = true;
      createAssetPortfolio();
   }

   public void onPortfolioSlider(SlideEndEvent event)
   {
      //setDefaultRiskIndex(event.getValue());
      customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.DIRECT.name());
      customer.riskProfile.setPortfolioScore(event.getValue());
      formEdit = true;
      createAssetPortfolio();
   }

   public void doAllocReset()
   {
      customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.CALCULATED.name());
      createAssetPortfolio();
//      System.out.println(" doAllocReset ind "+getAllocationIndex());
      customer.setSliderAllocationIndex(customer.riskProfile.getStandardScore(0).intValue());
   }

   public void refresh()
   {
      createAssetPortfolio();
   }

   public void createAssetPortfolio()
   {

      try
      {
         formEdit = true;
         riskCalc.calculate(1);
         customer.createAssetPortfolio();
         createCharts();
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   private void createCharts()
   {

      try
      {
         Map<String, String> configMap = webutil.getWebprofile().getWebInfo();
         customer.setTypeOfChart(configMap.get("CHART.ASSET.ALLOCATION"));// HIGHCHART.2DDONUT for highchart and PRIMEFACES.2DDONUT for primfaces
         if (configMap.get("CHART.ASSET.ALLOCATION") != null &&
            configMap.get("CHART.ASSET.ALLOCATION").equalsIgnoreCase("HIGHCHART.2DDONUT"))
         {
            customer.setResultChart(highChartsController.highChartrequesthandler(customer.getPortfolioData(), customer.getAssetData(), configMap));
         }
         if (configMap.get("CHART.RECOMMENDED.ASSET.ALLOCATION") != null && configMap.get("CHART.ASSET.ALLOCATION") != null &&
            configMap.get("CHART.RECOMMENDED.ASSET.ALLOCATION").equalsIgnoreCase("PRIMEFACES.BARCHART")
            || configMap.get("CHART.ASSET.ALLOCATION").equalsIgnoreCase("PRIMEFACES.2DDONUT"))
         {

            formEdit = true;
            // charts.setMeterGuage(getMeterRiskIndicator());
            if (customer.getAssetData() != null)
            {
               charts.createPieModel(customer.getAssetData(), 0);
               charts.createBarChart(customer.getAssetData(), 0);
            }
            else
            {
               charts.resetCharts();
            }
         }
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void saveProfile()
   {
      long acctnum;
      try
      {
         if (customer.getCanSaveData())
         {
            if (formEdit)
            {
               customer.saveProfile();
               formEdit = false;
            }
         }
      }
      catch (Exception ex)
      {
         String stackTrace = ex.getMessage();
         webutil.alertSupport("ConsumerEdit.saveprofile", "Error:ConsumerEdit.SaveProfile",
                              "error.saveprofile", stackTrace);
      }

   }


   public void savePrefProfile(ActionEvent event)
   {
      createAssetPortfolio();
      customer.saveProfile();
      formEdit = false;
   }

   public void savePanelProfile()
   {
      customer.saveProfile();
      formEdit = false;
      // RequestContext.getCurrentInstance().openDialog("/pages/consumer/fundingDialog.xhtml");
   }

   public Boolean getEnableNextButton()
   {
      return (! pagemanager.isLastPage());
   }

   public Integer getCurrentPage() {
      return ((pagemanager != null) ? pagemanager.getPage() : 0);
   }

   public Boolean getEnablePrevButton()
   {
      return (!pagemanager.isFirstPage());
   }

   public void gotoPrevPage()
   {
      if (! pagemanager.isFirstPage())
      {
         pagemanager.prevPage();
         progressbar.previousProgress();
      }
   }

   public void gotoNextPage()
   {
      if (! pagemanager.isLastPage())
      {
         pagemanager.nextPage();
         progressbar.nextProgress();
         // saveProfile();
      }
   }

   public void gotoStartOverPage()
   {
      pagemanager.setPage(0);
   }

   public void saveAccount()
   {
      long acctnum;
      try
      {
         customer.saveProfile();

         if (customer.getDoesUserHavaLogonID())
         {
            gotoCustodyInfoForm(); // If user is already looged in then redirect to opne account page.
         }
         else
         {
            pagemanager.nextPage();
         }

      }
      catch (Exception ex)
      {
         String stackTrace = ex.getMessage();
         ex.printStackTrace();
         webutil.alertSupport("UOBProfile.saveAccount", "Error:UOBProfile.saveAccount",
                              "error.saveAccount", stackTrace);
      }

   }

   public void showFTPanel()
   {
/*    To redesign
      if (customer.getSavedRiskFormula() == null || customer.getSavedRiskFormula().isEmpty())
      {
         customer.setSavedRiskFormula(customer.getRiskCalcMethod());
//         System.out.println(" showFTPanel if  ind "+getAllocationIndex());
         customer.setSavedAllocSliderIndex(customer.getAllocationIndex());
      }
//      System.out.println(" showFTPanel ifouter  ind "+getAllocationIndex());
      setSliderAllocationIndex(getAllocationIndex());
      setDisplayFTPanel(true);
      setEnableChangeStrategy(false);
      setAltrOnChngStrategy(false);
//      System.out.println("riskVariance "+riskVariance);
      if(formEdit)
      {
         setCstmSliderMaxAlloc(((getAllocationIndex() + riskVariance) >= 99 ? 99 : getAllocationIndex() + riskVariance));
         setCstmSliderMinAlloc(((getAllocationIndex() - riskVariance) < 0 ? 0 : getAllocationIndex() - riskVariance));
      }else{
         setCstmSliderMaxAlloc(((riskCalculator.getRiskByQuestion().intValue() + riskVariance) >= 99 ? 99 : riskCalculator.getRiskByQuestion().intValue() + riskVariance));
         setCstmSliderMinAlloc(((riskCalculator.getRiskByQuestion().intValue() - riskVariance) < 0 ? 0 : riskCalculator.getRiskByQuestion().intValue() - riskVariance));
      }
*/

   }

   public void saveFTPanel() {
/*
      setSavedRiskFormula(getRiskCalcMethod());
//      System.out.println(" saveFTPanel ifouter  ind "+getAllocationIndex());
      setSavedAllocSliderIndex(getAllocationIndex());
      setSliderAllocationIndex(getAllocationIndex());
      if(formEdit){
         riskCalculator.setRiskOverride(Double.parseDouble(""+getAllocationIndex()));
      }else{
         riskCalculator.setRiskByQuestion(Double.parseDouble(""+getAllocationIndex()));
      }
      savePanelProfile();
      closeFTPanel();
*/
   }

   public void closeFTPanel() {
/*
      setDisplayFTPanel(false);
      setEnableChangeStrategy(true);
      setAltrOnChngStrategy(true);
      // RequestContext context = RequestContext.getCurrentInstance();
      //context.execute("PF('wvfineTunePanel.hide()')");
      //context.update("fineTunePanel");
*/
   }

   public void cancelFTPanel() {
/*
//      System.out.println("cancelFTPanel In");
      setRiskCalcMethod(getSavedRiskFormula());
      setSliderAllocationIndex(getSavedAllocSliderIndex());
      // riskCalculator.setRiskFormula(savedRiskFormula);
      setAllocationIndex(getSavedAllocSliderIndex());
      Double riskIndex = riskCalculator.calculateRisk();
      createAssetPortfolio(1, riskIndex);
      closeFTPanel();
//      System.out.println("cancelFTPanel Out");
*/
   }

   public void gotoReview() {
/*
      if (registerUser())
      {
         savePanelProfile();
         setDoesUserHavaLogonID(true);
         Double riskIndex = riskCalculator.calculateRisk();
         createAssetPortfolio(1, riskIndex);
         if (! masterpagemanager.isFirstPage())
            masterpagemanager.prevPage();
      }
*/
   }

   public void gotoCustodyInfoForm() {
/*
      if (!getDoesUserHavaLogonID())
      {
         // Call Register User.  If he is not registered.  If Registration fails, then stay on the same page.
         if (registerUser()) {
//            uiLayout.doMenuAction("consumer", "acc_opening.xhtml?acct=" + getAcctnum().toString());
            uiLayout.doCustody(getLogonid(),getAcctnum(),"custody","index.xhtml");
         }
      }
      else {
         if (getCanSaveData())
         {
            // If in Edit mode, then don't save till final changes are accounted for.
            // Need to keep the original data.
            uiLayout.doMenuAction("custody", "index.xhtml?acct=" + getAcctnum().toString());
         }
         else {
            uiLayout.doMenuAction("consumer", "addon/editReview.xhtml");
            // uiLayout.doMenuAction("consumer", "editReview.xhtml");

         }
      }

*/
   }

   public void processTransfer() {

      customer.tradeDAO.saveTradeProcessIdentifier(customer.getAcctnum(),
                                          WebConst.TRADE_PROCESS_ALLOC,
                                          WebConst.TRADE_PROCESS_STAT_NEW,
                                          "Changed Strategy");
      customer.setCanSaveData(true);
      formEdit = true;
      customer.saveProfile();
   }

   public Integer getDisplayRiskScore() {
      Integer score = 0;
      if (riskCalc != null) {
         score = riskCalc.getScore(0).intValue();
      }
      return score;
   }

}
