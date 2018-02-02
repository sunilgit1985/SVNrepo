package com.invessence.web.bean.consumer.uob;

import java.util.*;
import javax.faces.bean.*;
import javax.faces.context.FacesContext;

import com.invessence.web.bean.consumer.PortfolioCreationUI;
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

   @Override
   public void initUI()
   {
      super.initUI();
      selectedGoal = null;
      pagemanager = new PagesImpl(10);  // Set number of pages as per UI.
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
               selectedGoal = goalMap.get(getCustomer().getGoal().toUpperCase());
               reOrganizeGoalList();  // Reorg the list so that last selected one shows up

               Boolean retiredflag = getCustomer().getRiskProfile().getAnswerBoolean(RiskConst.GOALS.RETIRED.toString());
            }

            // Now load the Currency info.
            if (currencyMap.containsKey(getCustomer().getGoal().toUpperCase()))
            {
               selectedCurrency = currencyMap.get(getCustomer().getTradeCurrency());
            }
         }
      }
      createAssetPortfolio();
      if(beanmode.equals(UIMode.New) || beanmode.equals(UIMode.Edit)){
         getCustomer().setCanSaveData(true);
      }else {
         getCustomer().setCanSaveData(false);
      }
   }

   public void preRenderReview()
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
         }

         if (getCustomer() != null) {
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
            createAssetPortfolio();

            if (riskCalc.getKnockOutFlag())
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.knockout", "Cannot proceed further. You are an extremely conservative investor and this tool may not be right for you. ", null));
               return;
            }

            if (pagemanager.getPage() == 2)
            {
               reOrganizeGoalList();
            }
            super.gotoNextPage();
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

   public Integer getAge()
   {
      return getCustomer().getAge();
   }

   public void setAge(Integer age)
   {
      getCustomer().setAge(age);
      riskCalc.setAge(age);
      adjustInitialRisk();
   }

   public Integer getHorizon()
   {
      if (getCustomer() != null)
      {
         return getCustomer().getHorizon();
      }
      else
      {
         return null;
      }

   }

   public void setHorizon(Integer horizon)
   {
      getCustomer().setHorizon(horizon);
      riskCalc.setHorizon(horizon);
      adjustInitialRisk();

   }

   public Integer getWithdrawlPeriod()
   {
      return getCustomer().riskProfile.getAnswerInt(RiskConst.WITHDRAWALPERIOD);
   }

   public void setWithdrawlPeriod(Integer period)
   {
      getCustomer().riskProfile.setAnswer(RiskConst.WITHDRAWALPERIOD, period);
      riskCalc.setWithDrwalPeriod(period);
   }

   public String getTradeCurrency()
   {
      return getCustomer().getTradeCurrency();
   }

   public void setTradeCurrency(String currency)
   {
      getCustomer().setTradeCurrency(currency);
      if (currencyMap.containsKey(currency))
      {
         selectedCurrency = currencyMap.get(currency);
      }
   }

   public Integer getInitialInvestment()
   {
      return getCustomer().getInitialInvestment();
   }

   public void setInitialInvestment(Integer investment)
   {
      getCustomer().setInitialInvestment(investment);
      getCustomer().setExchangeRate(getExchangeRate());
      Double exRate = getExchangeRate();
      Double calcInvestment = investment * ((exRate == null || exRate == 0.0) ? 1.0 : exRate);
      riskCalc.setInvestment(calcInvestment);
   }

   public Integer getRecurringInvestment()
   {
      if (getCustomer() != null)
      {
         return getCustomer().getRecurringInvestment();
      }
      return null;
   }

   public void setRecurringInvestment(Integer investment)
   {
      getCustomer().setRecurringInvestment(investment);
      riskCalc.setRecurring(investment.doubleValue());
   }

   public Integer getRecurringPeriod()
   {
      if (getCustomer() != null)
      {
         return getCustomer().riskProfile.getAnswerInt(RiskConst.RECURRINGPERIOD);
      }
      return null;
   }

   public void setRecurringPeriod(Integer period)
   {
      getCustomer().riskProfile.setAnswer(RiskConst.RECURRINGPERIOD, period);
      riskCalc.setRecurringPeriod(period);
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
         getCustomer().setPortfolioName(selectedItem.getDisplayName());
         // reOrganizeGoalList(selectedItem.getDisplayName());
         // Reset Rest of data.
         getCustomer().horizon = null;  // Only reset profiledata
         setWithdrawlPeriod(null);
         if (goal.equalsIgnoreCase(RiskConst.GOALS.BUILDWEALTH.toString()))
         {
            getCustomer().setCustomName(null);
         }
         else
         {
            getCustomer().setCustomName(selectedItem.getDisplayName());
         }
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
                     }
                     if (!hasData(getWithdrawlPeriod()))
                     {
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.retirement.withdrwl.required", "Please enter when you plan to withdraw.", null));
                     }
               }
               if (thisgoal.equals(RiskConst.GOALS.PROPERTY))
               {
                  if (!hasData(getCustomer().getHorizon()))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.property.horizon.required", "Please enter when you plan to purchase property.", null));
                  }
               }
               if (thisgoal.equals(RiskConst.GOALS.EDUCATION))
               {
                  if (!hasData(getCustomer().getHorizon()))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.education.horizon.required", "Please enter when you expect your child to enter college/university.", null));
                  }

               }
               if (thisgoal.equals(RiskConst.GOALS.BUILDWEALTH))
               {
                  if (!hasData(getCustomer().getHorizon()))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.buildwealth.horizon.required", "Please enter how long you plan to invest.", null));
                  }
               }
               if (thisgoal.equals(RiskConst.GOALS.LEGACY))
               {
                  Integer legacyAnswer = getCustomer().getRiskProfile().getRiskAnswer(1);
                  if (!hasData(legacyAnswer))
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.legacy.horizon.required", "Please choose your planning aim.", null));
                  }
               }
            }
            break;
         case 2: // Investment Page
            if (!hasData(getInitialInvestment()))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.initialInvestment.required", "Initial investment amount is required.", null));
            }
            else {
               Double minInitialRequired;
               if (webutil.isUserLoggedIn()) {
                  minInitialRequired = getCustomer().riskProfile.getDefaultDoubleValue(RiskConst.MIN2NDINTIALRQMT,1.0);
               }
               else {
                  minInitialRequired = getCustomer().riskProfile.getDefaultDoubleValue(RiskConst.MININTITIALRQMT,1.0);
               }
               if (getInitialInvestment() < minInitialRequired) {
//                  pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.mininitialInvestment.required", "A minimum investment of " + minInitialRequired.toString() + " is required.", new Object[]{minInitialRequired.toString()}));
                  pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.mininitialInvestment.required", "A minimum investment of ",null)+""+minInitialRequired.toString()+webutil.getMessageText().getDisplayMessage("validator.uob.profile.isRequired", " is required.",null));

               }
            }
            if (hasData(getRecurringInvestment()))
            {
               Double minInitialRequired;
               minInitialRequired = getCustomer().riskProfile.getDefaultDoubleValue(RiskConst.MINRECCURRINGRQMT, 0.0);
               if (getRecurringInvestment() > 0.0 && getRecurringInvestment() < minInitialRequired)
               {
//                  pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.minrecurringInvestment.required", "A minimum recurring investment of " + minInitialRequired.toString() + " is required.", new Object[]{minInitialRequired.toString()}));
                  pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.minrecurringInvestment.required", "A minimum recurring investment of ",null)+""+minInitialRequired.toString()+webutil.getMessageText().getDisplayMessage("validator.uob.profile.isRequired", " is required.",null));
               }
            }
            break;
         case 3: // Asset/Liabilty/Networth
            if (!hasData(getCustomer().getAccountFinancials().getNetworth()))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.networth.required", "Current net worth amount is required.", null));
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
      if (value.equalsIgnoreCase("1")) {
         getCustomer().setTheme("8.UOB.Sing");
         riskCalc.setTheme("8.UOB.Sing");
      }
      else {
         getCustomer().setTheme("8.UOB");
         riskCalc.setTheme("8.UOB");
      }
      setRiskAns(8, value);
   }

   public void onChangeName()
   {
   }

   public void onChangeValue()
   {
      formEdit = true;
      // createAssetPortfolio(1);
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
      getCustomer().getRiskProfile().setAnswer(RiskConst.GOALS.RETIRED.toString(), ! flag);
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
}
