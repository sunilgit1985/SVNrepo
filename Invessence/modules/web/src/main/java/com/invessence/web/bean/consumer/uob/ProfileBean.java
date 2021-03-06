package com.invessence.web.bean.consumer.uob;

import java.util.*;
import javax.faces.bean.*;
import javax.faces.context.FacesContext;

import com.invessence.converter.JavaUtil;
import com.invessence.web.bean.consumer.PortfolioCreationUI;
import com.invessence.web.constant.WebConst;
import com.invessence.web.util.*;
import com.invessence.web.util.Impl.*;
import com.invmodel.risk.data.RiskConst;
import com.invmodel.risk.data.client.UOBRiskCalc;

/**
 * Created by prashant on 11/16/2017.
 */

@ManagedBean(name = "uobProfile")
@SessionScoped
public class ProfileBean extends PortfolioCreationUI
{

   private ArrayList<WebMenuItem> goalsdata = null;
   private Map<String, WebMenuItem> currencyMap = null;
   public WebMenuItem selectedGoal;
   public WebMenuItem selectedCurrency;
   public Boolean selectedRetirementGoal = true;
   private String revwPnlExpYrFndLbl;
   private String selectedMobileGoal;

   @Override
   public void initUI()
   {
      super.initUI();
      selectedGoal = null;
      pagemanager = new PagesImpl(9);  // Set number of pages as per UI.
      progressbar = new ProgressBarImpl(0.0, (100.0 / pagemanager.getMaxNoofPages()));
   }

   private void setDefaultSwitch()
   {
      setRiskAns2(true);
      setRiskAns3(true);
   }

   public void setDefault()
   {
      pagemanager.initPage();

      // Since Risk Score Question #2 and #3 are knockout question, we'll assume the default (Only on New account)
      setAdvisor(getCustomer().getAdvisor());
      if (beanmode.equals(UIMode.New) )
      {
//         setAdvisor(webutil.getWebprofile().getDefaultAdvisor());
         setDefaultSwitch();
      }
      loadDropDownList();  // This process will reload all dropdown list.

      if (webutil.isUserLoggedIn())
      {
         if (getCustomer().getAcctnum() != null)
         {
            Map<String, WebMenuItem> goalMap = webMenuList.getMenuItemMap(WebMenuList.ListComponent.GOAL.toString());
            if (goalMap.containsKey(getCustomer().getGoal().toUpperCase()))
            {
               // Upload the data from DB and set selection as if user selected it.
               selectedMobileGoal=getCustomer().getGoal().toUpperCase();
               selectedGoal = goalMap.get(getCustomer().getGoal().toUpperCase());
               reOrganizeGoalList();  // Reorg the list so that last selected one shows up
               selectedRetirementGoal =!getCustomer().getRiskProfile().getAnswerBoolean(RiskConst.GOALS.RETIRED.toString());
            }

            // Now load the Currency info.
            if (currencyMap.containsKey(getCustomer().getGoal().toUpperCase()))
            {
               selectedCurrency = currencyMap.get(getCustomer().getTradeCurrency());
            }
         }
      }
   /*  Since, the RiskCalc is created with userRiskProfile, we don't neet to set value.
      if(!getCustomer().getManaged()){
         if(beanmode.equals(UIMode.New)){
            riskCalc.setInvestment(getCustomer().getDefaultInvestment());
         }else{ // Must be edit mode...
            riskCalc.setAge(getCustomer().getAge());
            riskCalc.setHorizon(getCustomer().getHorizon());
            riskCalc.setRecurringPeriod(getRecurringPeriod());
            setRiskTotalInvestment(getCustomer().getInvestmentAmount());
            setRecurringInvestment(getCustomer().getRecurringInvestment());
         }
      }else{
         // All other mode, if managed...
         riskCalc.setAge(getCustomer().getAge());
         riskCalc.setHorizon(getCustomer().getHorizon());
         riskCalc.setRecurringPeriod(getRecurringPeriod());
         setRiskTotalInvestment(getCustomer().getInvestmentAmount());
         setRecurringInvestment(getCustomer().getRecurringInvestment());
      }
   */
      createAssetPortfolio();
      if(beanmode.equals(UIMode.New) || beanmode.equals(UIMode.Edit)){
         getCustomer().setCanSaveData(true);
      }else {
         getCustomer().setCanSaveData(false);
      }
   }

   public void preRenderConfirm()
   {

      if (!FacesContext.getCurrentInstance().isPostback())
      {
         // Need to find out why this is being tested???
         if (getCustomer() == null)
         {
            initUI();
            if (beanmode == null)
            {
               beanmode = UIMode.Review;
            }
            super.preRenderView();
            setDefault();
//            getCustomer().copyData(getSavedCustomer());
         }else {
            riskCalc.setAge(getCustomer().getAge());
            riskCalc.setHorizon(getCustomer().getHorizon());
            riskCalc.setRecurringPeriod(getRecurringPeriod());
            setRecurringInvestment(getCustomer().getRecurringInvestment());
            createAssetPortfolio();
            createGlidePath();
         }
      }
   }

   @Override
   public void preRenderView()
   {

      try
      {
         if (!FacesContext.getCurrentInstance().isPostback())
         {
            if (interfaceMode == null)
            {
               beanmode = UIMode.New;
            }

            if (!(beanmode.equals(UIMode.New) || beanmode.equals(UIMode.Edit)))
            {
               if (!webutil.isUserLoggedIn())
               {
                  webutil.redirect("/login.xhtml", null);
                  return;
               }
            }

            initUI();

//            if (getCustomer() == null)
//            {
               // If the user is doing new portfolio from existing account, we can skip the PortfolioCreation registration process.


               /*  Don't redirect, let the cadd handle the appropriate page.
               if (webutil.isUserLoggedIn())
               {
                  gotoRiskQuestions();
               }
               */

               super.preRenderView();
               setDefault();

            if(beanmode.equals(UIMode.Confirm)){
               super.gotoReview();
               return;
            }
//               if (beanmode.equals(UIMode.ChangeStrategy) || beanmode.equals(UIMode.Confirm)  )
//               {
//                  getCustomer().copyData(getSavedCustomer());
//               }
//            }
         }
      }
      catch (Exception ex)
      {
         System.out.println("Error "+ex);
         ex.printStackTrace();
      }
   }

   public void loadDropDownList()
   {
      goalsdata = webMenuList.getMenuArrayList(WebMenuList.ListComponent.GOAL.toString());
      currencyMap = new HashMap<String, WebMenuItem>();
      List<WebMenuItem> currencyList = webMenuList.getMenuArrayList(WebMenuList.ListComponent.CURRENCY.toString());

      currencyMap = webMenuList.getMenuItemMap(WebMenuList.ListComponent.CURRENCY.toString());
      // Only for Currency create this selected as default
      if (currencyMap.containsKey(getCustomer().getTradeCurrency()))
      {
         selectedCurrency = currencyMap.get(getCustomer().getTradeCurrency());
      }

   }

   public void reOrganizeGoalList()
   {
      ArrayList<WebMenuItem> reorglist = new ArrayList<WebMenuItem>();
      Integer startingPoint;
      if (selectedGoal != null)
      {
         if (goalsdata != null)
         {
            Integer numofitems = goalsdata.size();
            Integer listnum = 0;
            // First find the item
            Integer found = -1;
            for (WebMenuItem item : goalsdata)
            {
               if (found >= 0)
               {
                  reorglist.add(item);
               }
               else
               {
                  if (item.getDisplayName().equals(selectedGoal.getDisplayName()))
                  {
                     found = listnum;
                     reorglist.add(item);
                  }
               }
               listnum++;
            }

            found = (found == -1) ? numofitems : found;
            if (found > 0)
            {
               // Now fill the remaining in order
               for (listnum = 0; listnum < found; listnum++)
               {
                  reorglist.add(goalsdata.get(listnum));
               }
            }

            goalsdata = reorglist;
         }
      }
   }

   @Override
   public void gotoPortfolioCreation()
   {
      Boolean validated = true;
      if (beanmode.equals(UIMode.New) && ! webutil.isUserLoggedIn())
      {
         validated = validateIntroPage();
      }
      else
      {
         validated = validatePage(0);
      }

      if (validated)
      {
         pagemanager.setPage(0);
         super.gotoNextPage();
         createAssetPortfolio();
         uiLayout.doMenuAction("consumer", "portfolioCreate/cEdit.xhtml");
      }
   }

   @Override
   public void gotoRiskQuestions()
   {
      super.gotoRiskQuestions();
   }

   @Override
   public void gotoNextPage()
   {
      try
      {
         if (validatePage(pagemanager.getPage()))
         {
            // If in New mode, and once the first page conditions are satisfied, we revert the mode to Edit.
            if (beanmode.equals(UIMode.New))
            {
               beanmode = UIMode.Edit;
            }

            riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.C);
            getCustomer().getRiskProfile().setCalcFormula(RiskConst.CALCFORMULAS.C.toString());
            createAssetPortfolio();

            if (riskCalc.getKnockOutFlag())
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.knockout", "Cannot proceed further. You are an extremely conservative investor and this tool may not be right for you. ", null));
               return;
            }
            getCustomFlags(pagemanager.getPage()+1);
            super.gotoNextPage();
         }else{
            if (pagemanager.getPage() == 1)
            {
               reOrganizeGoalList();
            }
         }
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   @Override
   public void gotoPrevPage()
   {
      try
      {
         rollbackRiskQuestion(pagemanager.getPage());
         if (pagemanager.getPage() == 2)
         {
            reOrganizeGoalList();
         }

         getCustomFlags(pagemanager.getPage()-1);
         pagemanager.clearErrorMessage(pagemanager.getPage());
         super.gotoPrevPage();
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   @Override
   public void gotoReview()
   {
      if (validatePage(pagemanager.getPage()))
      {
         super.gotoReview();
      }
   }

   @Override
   public void createAssetPortfolio()
   {
      try
      {
         super.createAssetPortfolio();
         // Supporting old version
         Double score = getCustomer().getRiskProfile().getScore(0);
         getCustomer().setRiskIndex(score);
         score = getCustomer().getRiskProfile().getAssetScore(0);
         getCustomer().setAllocationIndex(score.intValue());
         getCustomer().setPortfolioIndex(score.intValue());
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void setAdvisor(String advisor)
   {
      if (advisor != null)
      {
         loadWebMenuList(customer.getAdvisor());
         customer.setAdvisor(advisor);
         customer.riskProfile.setAdvisor(advisor);
         riskCalc = new UOBRiskCalc(customer.riskProfile);
      }
   }


   public List<WebMenuItem> getGoalsdata()
   {
      return goalsdata;
   }

   public Map<String, WebMenuItem> getCurrencyMap()
   {
      return currencyMap;
   }

   public Boolean getDisableModeForIntroPage()
   {
      if (beanmode == null || beanmode == UIMode.New)
      {
         if (webutil.isUserLoggedIn()) {
            return false;
         }
         return true;
      }
      return false;
   }

   @Override
   public void setAge(Integer age)
   {
      super.setAge(age);
      adjustInitialRisk();
   }

   @Override
   public void setHorizon(Integer horizon)
   {
      super.setHorizon(horizon);
      adjustInitialRisk();

   }

   @Override
   public void setTradeCurrency(String currency)
   {
      super.setTradeCurrency(currency);
      if (currencyMap.containsKey(currency))
      {
         selectedCurrency = currencyMap.get(currency);
      }
   }

   private void adjustInitialRisk()
   {
      Double score;
      RiskConst.GOALS selectedGoalValue;
      Integer age, horizon;

      try
      {
         if (selectedGoal != null)
         {
            selectedGoalValue = RiskConst.GOALS.displayToGoal(selectedGoal.getDisplayName());
            if (selectedGoalValue.equals(RiskConst.GOALS.LEGACY))
            {
               getCustomer().getRiskProfile().setRiskAnswer(0, 0, 0.0);
               return;
            }
         }
         age = getCustomer().getAge();
         horizon = getCustomer().getHorizon();
         score = getRiskCalc().ageTimeFormula(age, horizon);
         getCustomer().getRiskProfile().setRiskAnswer(0, 1, score);
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public WebMenuItem getSelectedGoal()
   {
      return selectedGoal;
   }

   public void setSelectedGoal(WebMenuItem selectedItem)
   {
      this.selectedGoal = selectedItem;
      if (selectedItem != null)
      {
         String goal = selectedItem.getKey();
         getCustomer().setGoal(goal);
         selectedMobileGoal=goal;
         getCustomer().setPortfolioName(selectedItem.getDisplayName());
         // reOrganizeGoalList(selectedItem.getDisplayName());
         // Reset Rest of data.
         getCustomer().horizon = null;  // Only reset profiledata
//         setWithdrawlPeriod(null);
         if (goal.equalsIgnoreCase(RiskConst.GOALS.BUILDWEALTH.toString()))
         {
            getCustomer().setCustomName(null);
         }
         else
         {
            getCustomer().setCustomName(selectedItem.getDisplayName());
         }
//         if (goal.equalsIgnoreCase(RiskConst.GOALS.RETIREMENT.toString())){
//            setWithdrawlPeriod(30);
//         }else{
            setWithdrawlPeriod(getCustomer().getRiskProfile().getDefaultIntValue(RiskConst.WITHDRAWALPERIOD,null));
//         }
      }
   }

   public Integer getSelectedGoalValue()
   {
      if (selectedGoal != null)
      {
         RiskConst.GOALS thisgoal = RiskConst.GOALS.displayToGoal(selectedGoal.getKey());
         return thisgoal.getCodeNum();
      }
      return 0;
   }

   public WebMenuItem getSelectedCurrency()
   {
      if (selectedCurrency == null)
      {
         String defaultStr = webutil.getWebprofile().getDefaultCurrency();
         if (currencyMap.containsKey(defaultStr))
         {
            return currencyMap.get(defaultStr);
         }
      }
      return selectedCurrency;
   }

   public void setSelectedCurrency(WebMenuItem selectedItem)
   {
      this.selectedCurrency = selectedItem;
   }

   private Boolean validateIntroPage()
   {
      Boolean dataOK = true;
      Integer ans;
      pagemanager.clearErrorMessage(0);
      if (!hasData(getCustomer().getAge()))
      {
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.age.required", "Age is required.", null));
      }else if (!JavaUtil.isInRange(getCustomer().getAge(),21,null))
      {
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.minAge.required", "You should be atleast 21 year old to invest.", new Object[]{21}));
      }
      if (!hasData(getCustomer().getName()))
      {
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.name.required", "Name is required.", null));
      }
      if (!hasData(getCustomer().getEmail()))
      {
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.email.required", "Email address is required.", null));
      }

      // Don't register if there are error...  Because once registered, the user will be locked to continue.
      if (beanmode.equals(UIMode.New) && ! hasData(pagemanager.getErrorMessage()))
      {
         if (!webutil.isUserLoggedIn() && hasData(getCustomer().getEmail()))
         {
            String msg = registerUser();
            if (!msg.isEmpty())
            {
               pagemanager.setErrorMessage(msg);
            }
         }
      }

      if (hasData(pagemanager.getErrorMessage()))
      {
         dataOK = false;
      }
      this.dataOK = dataOK;
      return dataOK;
   }


   private Boolean validatePage(Integer pagenum)
   {
      Boolean dataOK = true;
      Integer ans;
      pagemanager.clearErrorMessage(pagenum);
      switch (pagenum)
      {
         case 0: // This is Intro page
            if (!hasData(getCustomer().getAge()))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.age.required", "Age is required.", null));
            }
            else if (!JavaUtil.isInRange(getCustomer().getAge(), 0, null))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.age.invalid", "Negative value is not allowed for age.", null));
            }
            else if (!JavaUtil.isInRange(getCustomer().getAge(), 21, null))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.minAge.required", "You should be atleast 21 year old to invest.", new Object[]{21}));
            }
            break;
         case 1: // Goal Page
            if (selectedGoal == null)
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.goal.required", "Goal must be selected.", null));

            }
            else
            {
               RiskConst.GOALS thisgoal = RiskConst.GOALS.displayToGoal(selectedGoal.getKey());
               if (thisgoal.equals(RiskConst.GOALS.RETIREMENT))
               {
                  if (getSelectedRetirementGoal())
                  {
                     if (!hasData(getCustomer().getHorizon()))
                     {
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.retirement.horizon.required", "Please enter when you plan to retire.", null));
                     }
                     else if (!JavaUtil.isInRange(getCustomer().getHorizon(), 0, null))
                     {
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.retirement.horizon.invalid", "Negative value is not allowed for retirement years.", null));
                     }
                  }else{
                     setHorizon(0);
                  }
                  if (!hasData(getWithdrawlPeriod()))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.retirement.withdrwl.required", "Please enter when you plan to withdraw.", null));
                  }
                  else if (!JavaUtil.isInRange(getWithdrawlPeriod(), 0, null))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.retirement.withdrwl.invalid", "Negative value is not allowed for withdrawl years.", null));
                  }
               }
               if (thisgoal.equals(RiskConst.GOALS.PROPERTY))
               {
                  if (!hasData(getCustomer().getHorizon()))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.property.horizon.required", "Please enter when you plan to purchase property.", null));
                  }
                  else if (!JavaUtil.isInRange(getCustomer().getHorizon(), 0, null))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.property.horizon.invalid", "Negative value is not allowed for investment years.", null));
                  }
                  setWithdrawlPeriod(null);
               }
               if (thisgoal.equals(RiskConst.GOALS.EDUCATION))
               {
                  if (!hasData(getCustomer().getHorizon()))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.education.horizon.required", "Please enter when you expect your child to enter college/university.", null));
                  }
                  else if (!JavaUtil.isInRange(getCustomer().getHorizon(), null, 20))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.education.maxHorizon.required", " Education goal can not exceed 20 years", new Object[]{20}));
                  }
                  else if (!JavaUtil.isInRange(getCustomer().getHorizon(), 0, null))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.education.horizon.invalid", "Negative value is not allowed for Education goal.", null));
                  }
               }
               if (thisgoal.equals(RiskConst.GOALS.BUILDWEALTH))
               {
                  if (!hasData(getCustomer().getHorizon()))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.buildwealth.horizon.required", "Please enter how long you plan to invest.", null));
                  }
                  else if (!JavaUtil.isInRange(getCustomer().getHorizon(), 0, null))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.buildwealth.horizon.invalid", "Negative value is not allowed for investment years.", new Object[]{21}));
                  }
                  if (!JavaUtil.isInRange(getWithdrawlPeriod(), 0, null))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.buildwealth.withdrawlPrd.invalid", "Negative value is not allowed for withdrawl period.", new Object[]{21}));
                  }
               }
               if (thisgoal.equals(RiskConst.GOALS.LEGACY))
               {
                  Integer legacyAnswer = getCustomer().getRiskProfile().getRiskAnswer(1);
                  if (!hasData(legacyAnswer))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.legacy.horizon.required", "Please choose your planning aim.", null));
                  }
                  setWithdrawlPeriod(null);
                  setHorizon(30);
               }
            }
            break;
         case 2: // Investment Page
            RiskConst.GOALS thisgoal = RiskConst.GOALS.displayToGoal(selectedGoal.getKey());
            if (!hasData(getInitialInvestment()))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.initialInvestment.required", "Initial investment amount is required.", null));
            }
            else
            {
               Double minInitialRequired;
               if (webutil.isUserLoggedIn())
               {
                  minInitialRequired = getCustomer().riskProfile.getDefaultDoubleValue(RiskConst.MIN2NDINTIALRQMT, 1.0);
               }
               else
               {
                  minInitialRequired = getCustomer().riskProfile.getDefaultDoubleValue(RiskConst.MININTITIALRQMT, 1.0);
               }
               if (getInitialInvestment() < minInitialRequired.intValue())
               {
//                  pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.mininitialInvestment.required", "A minimum investment of " + minInitialRequired.toString() + " is required.", new Object[]{minInitialRequired.toString()}));
                  String strMsg = getPortfolioInvstmCurr() + " " + getWebutil().getDataDisplayConverter().displayWithComma(minInitialRequired.intValue());
                  pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.mininitialInvestment.required", "A minimum investment of " + strMsg + " is required.", new Object[]{strMsg}));

               }
            }
            if (selectedRetirementGoal && !thisgoal.equals(RiskConst.GOALS.LEGACY))
            {
               if (!JavaUtil.isInRange(getRecurringInvestment(), 0, null))
               {
                  pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.recurringInvestment.invalid", "Negative value is not allowed for per annum contribution.", null));
               }
               else if (hasData(getRecurringInvestment()))
               {
                  Double minRecurrInvstmt;
                  minRecurrInvstmt = getCustomer().riskProfile.getDefaultDoubleValue(RiskConst.MINRECCURRINGRQMT, 0.0);
                  if (getRecurringInvestment() > 0.0 && getRecurringInvestment() < minRecurrInvstmt)
                  {
                     String strMsg = getWebutil().getDataDisplayConverter().displayWithComma(minRecurrInvstmt.intValue());
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.minrecurringInvestment.required", "A minimum recurring investment of " + strMsg + " is required.", new Object[]{strMsg}));
                  }

                  if (!hasData(getRecurringPeriod()))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.recurringPrd.required", "Recurring period is required.", null));
                  }
                  else if (!JavaUtil.isInRange(getRecurringPeriod(), 0, null))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.recurringPrd.invalid", "Negative value is not allowed for recurring period.", null));
                  }
               }
            }
            break;
         case 3: // Asset/Liabilty/Networth
            if(hasData(getCustomer().getAccountFinancials().getHomeEquity()) &&
               !JavaUtil.isInRange(getCustomer().getAccountFinancials().getHomeEquity().intValue(), 0, null))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.priRes.invalid", "Negative value is not allowed for primary residence.", null));
            }
            if(hasData(getCustomer().getAccountFinancials().getInvestment()) &&
               !JavaUtil.isInRange(getCustomer().getAccountFinancials().getInvestment().intValue(), 0, null))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.invstAsst.invalid", "Negative value is not allowed for investable assets.", null));
            }
            if(hasData(getCustomer().getAccountFinancials().getHouseholdwages()) &&
               !JavaUtil.isInRange(getCustomer().getAccountFinancials().getHouseholdwages().intValue(), 0, null))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.houseWdgs.invalid", "Negative value is not allowed for employment income / income from business.", null));
            }
            if(hasData(getCustomer().getAccountFinancials().getOtherincome()) &&
               !JavaUtil.isInRange(getCustomer().getAccountFinancials().getOtherincome().intValue(), 0, null))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.otherincome.invalid", "Negative value is not allowed for other source of income.", null));
            }
            if(hasData(getCustomer().getAccountFinancials().getMortgageLoan()) &&
               !JavaUtil.isInRange(getCustomer().getAccountFinancials().getMortgageLoan().intValue(), 0, null))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.mortgageLoan.invalid", "Negative value is not allowed for mortgage loan on primary residence.", null));
            }
            if(hasData(getCustomer().getAccountFinancials().getOtherDebt()) &&
               !JavaUtil.isInRange(getCustomer().getAccountFinancials().getOtherDebt().intValue(), 0, null))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.otherDebt.invalid", "Negative value is not allowed for liabilities.", null));
            }
            if (!hasData(getCustomer().getAccountFinancials().getNetworth()))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.networth.required", "Current net worth amount is required.", null));
            }
            if (hasData(getCustomer().getAccountFinancials().getNetworth()) &&
               !JavaUtil.isInRange(getCustomer().getAccountFinancials().getNetworth().intValue(), 0, null))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.networth.invalid", "Negative value is not allowed for net worth amount.", null));
            }
            break;
         case 4: // Risk Questions start (First two are imbedded in this page.
            // Don't need to check, as the default are set when starting.
            break;
         case 5:
            ans = getCustomer().riskProfile.getRiskAnswer(4);
            if (ans == null || ans == 0)
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.riskans.required", "Please select one of the  risk tolerance choices.", null));
            }
            break;
         case 6:
            ans = getCustomer().riskProfile.getRiskAnswer(5);
            if (!hasData(ans))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.riskans.required", "Please select one of the  risk tolerance choices", null));
            }
            break;
         case 7:
            ans = getCustomer().riskProfile.getRiskAnswer(6);
            if (!hasData(ans))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.riskans.required", "Please select one of the  risk tolerance choices.", null));
            }
            break;
         case 8:
            ans = getCustomer().riskProfile.getRiskAnswer(7);
            if (!hasData(ans))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.riskans.required", "Please select one of the  risk tolerance choices.", null));
            }
            break;
         case 9:
            ans = getCustomer().riskProfile.getRiskAnswer(8);
            if (!hasData(ans))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.riskans.required", "Please select one of the  risk tolerance choices.", null));
            }
            break;
      }

      if (hasData(pagemanager.getErrorMessage()))
      {
         dataOK = false;
      }

      this.dataOK = dataOK;
      return dataOK;
   }

   private void rollbackRiskQuestion(Integer pageno) {
      Boolean isinEditMode = webutil.isUserLoggedIn();

      if (webutil.isUserLoggedIn() && getSavedCustomer() != null) {
         switch (pageno)
         {
            case 1:
               getCustomer().riskProfile.setRiskQuestionWeight(1,getSavedCustomer().riskProfile.getDefaultIntValue(RiskConst.RISKQUESTIONKEY + "1", 0),0.0);
               break;
            case 4:
               getCustomer().riskProfile.setRiskQuestionWeight(2,getSavedCustomer().riskProfile.getDefaultIntValue(RiskConst.RISKQUESTIONKEY + "2", 0),0.0);
               getCustomer().riskProfile.setRiskQuestionWeight(3,getSavedCustomer().riskProfile.getDefaultIntValue(RiskConst.RISKQUESTIONKEY + "3", 0),0.0);
               break;
            case 5:
               getCustomer().riskProfile.setRiskQuestionWeight(4,getSavedCustomer().riskProfile.getDefaultIntValue(RiskConst.RISKQUESTIONKEY + "4", 0),0.0);
               break;
            case 6:
               getCustomer().riskProfile.setRiskQuestionWeight(5,getSavedCustomer().riskProfile.getDefaultIntValue(RiskConst.RISKQUESTIONKEY + "5", 0),0.0);
               break;
            case 7:
               getCustomer().riskProfile.setRiskQuestionWeight(6,getSavedCustomer().riskProfile.getDefaultIntValue(RiskConst.RISKQUESTIONKEY + "6", 0),0.0);
               break;
            case 8:
               getCustomer().riskProfile.setRiskQuestionWeight(7,getSavedCustomer().riskProfile.getDefaultIntValue(RiskConst.RISKQUESTIONKEY + "7", 0),0.0);
               break;
            case 9:
               getCustomer().riskProfile.setRiskQuestionWeight(8,getSavedCustomer().riskProfile.getDefaultIntValue(RiskConst.RISKQUESTIONKEY + "8", 0),0.0);
               break;
            default:
         }
      }
      else {
         switch (pageno)
         {
            case 1:
               getCustomer().riskProfile.setRiskQuestionWeight(1,0,0.0);
               break;
            case 4:
               setDefaultSwitch();
               break;
            case 5:
               getCustomer().riskProfile.setRiskQuestionWeight(4,0,0.0);
               break;
            case 6:
               getCustomer().riskProfile.setRiskQuestionWeight(5,0,0.0);
               break;
            case 7:
               getCustomer().riskProfile.setRiskQuestionWeight(6,0,0.0);
               break;
            case 8:
               getCustomer().riskProfile.setRiskQuestionWeight(7,0,0.0);
               break;
            case 9:
               getCustomer().riskProfile.setRiskQuestionWeight(8,0,0.0);
               break;
            default:
         }

      }
   }

   private void setRiskAns(Integer question, String value)
   {
      Integer ans;
      if (value != null)
      {
         ans = converter.getIntData(value);
         riskCalc.setQuestionsRisk(question, ans, 0.0);
      }
   }

   public String getRiskAns1()
   {
      return getCustomer().riskProfile.getRiskAnswer(1).toString();
   }

   public void setRiskAns1(String value)
   {
      setRiskAns(1, value);
   }

   public Boolean getRiskAns2()
   {
      Integer ans = getCustomer().riskProfile.getRiskAnswer(2);
      if (ans != null)
      {
         switch (ans)
         {
            case 1:
               return true;
            default:
               break;
         }
      }
      return false;
   }

   public void setRiskAns2(Boolean value)
   {
      if (value)
      {
         riskCalc.setQuestionsRisk(2, 1, 0.0);
      }
      else
      {
         riskCalc.setQuestionsRisk(2, 2, 0.0);
      }
   }

   public Boolean getRiskAns3()
   {
      Integer ans = getCustomer().riskProfile.getRiskAnswer(3);
      if (ans != null)
      {
         switch (ans)
         {
            case 1:
               return true;
            default:
               break;
         }
      }
      return false;
   }

   public void setRiskAns3(Boolean value)
   {
      if (value)
      {
         riskCalc.setQuestionsRisk(3, 1, 0.0);
      }
      else
      {
         riskCalc.setQuestionsRisk(3, 2, 0.0);
      }
   }

   public String getRiskAns4()
   {
      return getCustomer().riskProfile.getRiskAnswer(4).toString();
   }

   public void setRiskAns4(String value)
   {
      setRiskAns(4, value);
   }

   public String getRiskAns5()
   {
      return getCustomer().riskProfile.getRiskAnswer(5).toString();
   }

   public void setRiskAns5(String value)
   {
      setRiskAns(5, value);
   }

   public String getRiskAns6()
   {
      return getCustomer().riskProfile.getRiskAnswer(6).toString();
   }

   public void setRiskAns6(String value)
   {
      setRiskAns(6, value);
   }

   public String getRiskAns7()
   {
      return getCustomer().riskProfile.getRiskAnswer(7).toString();
   }

   public void setRiskAns7(String value)
   {
      setRiskAns(7, value);
   }

   public String getRiskAns8()
   {
      return getCustomer().riskProfile.getRiskAnswer(8).toString();
   }

   public void setRiskAns8(String value)
   {
      String newTheme = null;
      if (value.equalsIgnoreCase("1")) {
         newTheme = getCustomer().getRiskProfile().getDefaultStrValue(RiskConst.ALTTHEME+value,null);
      }
      else {
         newTheme = webutil.getWebprofile().getModel();
      }
      if (newTheme != null)
      {
         getCustomer().setTheme(newTheme);
         riskCalc.setTheme(newTheme);
      }
      setRiskAns(8, value);
   }

   public void onChangeName()
   {
   }

   public void onChangeValue()
   {
      formEdit = true;
      createAssetPortfolio();
   }

   public void onChangeCurrency()
   {
      formEdit = true;
   }

   public Boolean getSelectedRetirementGoal()
   {
      return (selectedRetirementGoal == null) ? true : selectedRetirementGoal;
   }

   public void setSelectedRetirementGoal(Boolean flag)
   {
      selectedRetirementGoal = flag;
      getCustomer().getRiskProfile().setAnswer(RiskConst.GOALS.RETIRED.toString(),  !flag);
      if (flag) {
         getCustomer().setCustomName(RiskConst.GOALS.RETIREMENT.getDisplayValue());
      }
      else {
         getCustomer().setCustomName(RiskConst.GOALS.RETIRED.getDisplayValue());
      }
   }


   public String getPrintName()
   {
      if (getCustomer() != null && getCustomer().getName() != null)
      {
         return getCustomer().getName() + ", ";
      }
      return "";
   }

   public String getPortfolioInvstmCurr(){
      String strReturn="";
      strReturn=currencyMap.get(getTradeCurrency()).getShortname();
      return strReturn;
   }

   public void getCustomFlags(Integer pageno){
      switch (pageno)
      {
         case 0:
            if ((selectedGoal != null) && (pagemanager.getLastPageVisited() == 1))
            {
               reOrganizeGoalList();
            }
            break;
         case 1:
            if (selectedGoal != null)
            {
               reOrganizeGoalList();
            }
            break;
         case 2:
            RiskConst.GOALS thisgoal = RiskConst.GOALS.displayToGoal(selectedGoal.getKey());
            if ((!selectedRetirementGoal && thisgoal.equals(RiskConst.GOALS.RETIREMENT))  || thisgoal.equals(RiskConst.GOALS.LEGACY)){
               setRecurInvstAmtFlg(false);
               setRecurInvstPrdFlag(false);
               setRecurringInvestment(0);
               setRecurringPeriod(0);
//               revwPnlExpYrFndLbl="NA";
            }else{
               setRecurInvstAmtFlg(true);
               setRecurInvstPrdFlag(true);
//               revwPnlExpYrFndLbl= ""+getYear(getHorizon());
            }
            //enableRecurInvstPnl();
            break;
         case 3:
            break;
         case 4:
            break;
         case 5:
            break;
         case 6:
            break;
         case 7:
            break;
         case 8:
            break;
         case 9:
            break;
         default:
      }
   }

   public String getRevwPnlExpYrFndLbl()
   {
      if((!selectedRetirementGoal && RiskConst.GOALS.displayToGoal(selectedGoal.getKey()).equals(RiskConst.GOALS.RETIREMENT))  || RiskConst.GOALS.displayToGoal(selectedGoal.getKey()).equals(RiskConst.GOALS.LEGACY)){
         revwPnlExpYrFndLbl="NA";
      }else{
         revwPnlExpYrFndLbl= ""+getYear(getHorizon());
      }
      return revwPnlExpYrFndLbl;
   }

   public void setRevwPnlExpYrFndLbl(String revwPnlExpYrFndLbl)
   {
      this.revwPnlExpYrFndLbl = revwPnlExpYrFndLbl;
   }

   @Override
   public void cancelCS()
   {
      goBack();
   }

   public void onChngGoal(){
     // if(true){
         // System.out.println("Hello");
     // }
   }

   public String getSelectedMobileGoal()
   {
      return selectedMobileGoal;
   }

   public void setSelectedMobileGoal(String selectedMobileGoal)
   {
      if(selectedMobileGoal==null || selectedMobileGoal.equalsIgnoreCase("select")){
         if(getSelectedGoal()!=null)
         {
            selectedMobileGoal = getSelectedGoal().getKey();
         }
      }else{
         this.selectedMobileGoal = selectedMobileGoal;
         for (int i=0;i<goalsdata.size();i++)
         {
            if(goalsdata.get(i).getKey().equalsIgnoreCase(selectedMobileGoal))
            {
               setSelectedGoal(goalsdata.get(i));
               selectedGoal=goalsdata.get(i);
               break;
            }
         }
      }
   }
}
