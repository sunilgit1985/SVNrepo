package com.invessence.web.bean.consumer.uob;

import java.util.*;
import javax.faces.bean.*;
import javax.faces.context.FacesContext;

import com.invessence.converter.SQLData;
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
   public Integer selectedRetirementGoal;

   @Override
   public void initUI()
   {
      super.initUI();
      selectedGoal = null;
      pagemanager = new PagesImpl(10);  // Set number of pages as per UI.
      progressbar = new ProgressBarImpl(0.0, (100.0 / pagemanager.getMaxNoofPages()));
   }

   public void setDefault()
   {
      setAdvisor(webutil.getWebprofile().getDefaultAdvisor());
      pagemanager.initPage();

      // Client Specific Process
      Integer savedGoal = 0;

      loadDropDownList();  // This process will reload all dropdown list.
      // Since Risk Score Question #2 and #3 are knockout question, we'll assume the default (Only on New account)
      if (beanmode == UIMode.New)
      {
         setRiskAns2(true);
         setRiskAns3(false);
      }
      createAssetPortfolio(1);
   }

   public void preRenderReview()
   {

      if (!FacesContext.getCurrentInstance().isPostback())
      {
         if (getCustomer() == null)
         {
            initUI();
            if (beanmode == null)
            {
               beanmode = UIMode.Review;
            }
            super.preRenderView();
            setDefault();
            getCustomer().copyData(getSavedCustomer());
            createAssetPortfolio(30);
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

            if (beanmode.equals(UIMode.New) || beanmode.equals(UIMode.ChangeStrategy))
            {
               initUI();
               super.preRenderView();
               setDefault();
               if (beanmode.equals(UIMode.ChangeStrategy))
               {
                  getCustomer().copyData(getSavedCustomer());
               }
            }
         }
      }
      catch (Exception ex)
      {
      }
   }

   public void loadDropDownList()
   {
      goalsdata = webMenuList.getMenuArrayList(WebMenuList.ListComponent.GOAL.toString());
      currencyMap = new HashMap<String, WebMenuItem>();
      List<WebMenuItem> currencyList = webMenuList.getMenuArrayList(WebMenuList.ListComponent.CURRENCY.toString());
      currencyMap = webMenuList.getMenuItemMap(WebMenuList.ListComponent.CURRENCY.toString());
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
      if (beanmode.equals(UIMode.New))
      {
         validated = validateIntroPage();
      }
      else {
         validated = validatePage(0);
      }

      if (validated)
      {
         pagemanager.setPage(1);
         progressbar.nextProgress();
         createAssetPortfolio(1);
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
      if (validatePage(pagemanager.getPage()))
      {
         // If in New mode, and once the first page conditions are satisfied, we revert the mode to Edit.
         if (beanmode.equals(UIMode.New))
         {
            beanmode = UIMode.Edit;
         }
         createAssetPortfolio(1);
         if (pagemanager.getPage() == 2) {
            reOrganizeGoalList();
         }
         super.gotoNextPage();
      }
   }

   @Override
   public void gotoPrevPage() {
      if (pagemanager.getPage() == 2) {
         reOrganizeGoalList();
      }
      super.gotoPrevPage();
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
   public void createAssetPortfolio(Integer numofyears)
   {
      super.createAssetPortfolio(numofyears);
      // Supporting old version
      Double score = getCustomer().getRiskProfile().getScore(0);
      getCustomer().setRiskIndex(score);
      score = getCustomer().getRiskProfile().getAssetScore(0);
      getCustomer().setAllocationIndex(score.intValue());
      getCustomer().setPortfolioIndex(score.intValue());
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
         return false;
      }
      return true;
   }

   public Integer getAge()
   {
      return getCustomer().getAge();
   }

   public void setAge(Integer age)
   {
      getCustomer().setAge(age);
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
      if (getCustomer() != null)
      {
         getCustomer().setHorizon(horizon);
      }
      adjustInitialRisk();

   }

   public Integer getWithdrawlPeriod()
   {
      return getCustomer().riskProfile.getAnswerInt(RiskConst.WITHDRAWALPERIOD);
   }

   public void setWithdrawlPeriod(Integer period)
   {
      getCustomer().riskProfile.setAnswer(RiskConst.WITHDRAWALPERIOD, period);
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
   }

   private void adjustInitialRisk()
   {
      Double score0, score1;
      Integer defaultHorizon, age;
      Integer retirementage;
      RiskConst.GOALS selectedGoalValue;
      age = getCustomer().getAge();

      if (age == null || age == 0)
      {
         age = getCustomer().getRiskProfile().getAnswerInt(RiskConst.AGE);
      }

      defaultHorizon = getCustomer().getHorizon();
      if (selectedGoal != null)
      {
         selectedGoalValue = RiskConst.GOALS.displayToGoal(selectedGoal.getDisplayName());

         if (selectedGoalValue.equals(RiskConst.GOALS.LEGACY))
         {
            score0 = 0.0; // For Lengacy, we are storing the result in Ans 1.
            getCustomer().getRiskProfile().setRiskAnswer(0, 1, score0);
         }
         else
         {
            if (selectedGoalValue.equals(RiskConst.GOALS.RETIREMENT))
            {
               if (defaultHorizon == null)
               {
                  retirementage = getCustomer().getRiskProfile().getAnswerInt(RiskConst.RETIREMENTAGE);
                  defaultHorizon = retirementage - age;
               }
               defaultHorizon = (defaultHorizon < 0) ? 0 : defaultHorizon;
               score0 = getRiskCalc().ageTimeFormula(age, defaultHorizon);
               score1 = 0.0; // For Lengacy, we are storing the result in Ans 1.
               getCustomer().getRiskProfile().setRiskAnswer(0, 1, score0);
               getCustomer().getRiskProfile().setRiskAnswer(1, 0, score1);
            }
            else
            {
               if (defaultHorizon == null)
               {
                  defaultHorizon = 1;
               }
               score1 = 0.0; // For Lengacy, we are storing the result in Ans 1.
               getCustomer().getRiskProfile().setRiskAnswer(1, 0, score1);
            }

         }
      }
      else {
         score0 = getRiskCalc().ageTimeFormula(age, defaultHorizon);
         getCustomer().getRiskProfile().setRiskAnswer(0, 1, score0);
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
         String goalName = selectedItem.getDisplayName();
         getCustomer().setGoal(goalName);
         getCustomer().setPortfolioName(goalName);
         // reOrganizeGoalList(selectedItem.getDisplayName());
         // Reset Rest of data.
         getCustomer().horizon = null;  // Only reset profiledata
         setWithdrawlPeriod(null);
         if (goalName.equals(RiskConst.GOALS.BUILDWEALTH.getDisplayValue()))
         {
            getCustomer().setCustomName(null);
         }
         else
         {
            getCustomer().setCustomName(goalName);


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
      return selectedCurrency;
   }

   public void setSelectedCurrency(WebMenuItem selectedItem)
   {
      this.selectedCurrency = selectedItem;
   }

   private Boolean validateIntroPage() {
      Boolean dataOK = true;
      Integer ans;
      pagemanager.clearErrorMessage(0);
      if (!hasData(getCustomer().getName()))
      {
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.name.required", "Name is required", null));
      }
      if (!hasData(getCustomer().getEmail()))
      {
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.email.required", "Email is required", null));
      }
      if (beanmode.equals(UIMode.New))
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
      if (!hasData(getCustomer().getAge().toString()))
      {
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.age.required", "Age is required", null));
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
            if (!hasData(getCustomer().getAge().toString()))
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.age.required", "Age is required", null));
            }
            break;
         case 1: // Goal Page
            if (selectedGoal == null)
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.goal.required", "Goal must be selected.", null));

            }
            else
            {
               RiskConst.GOALS thisgoal = RiskConst.GOALS.displayToGoal(selectedGoal.getDisplayName());
               if (thisgoal.equals(RiskConst.GOALS.RETIREMENT))
               {
                  if (selectedRetirementGoal == 0)
                  {
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.retirementflag.required", "Choose one of the choices below.", null));
                  }
                  else
                  {
                     if (selectedRetirementGoal == 1)
                     {
                        if (!hasData(getCustomer().getHorizon().toString()))
                        {
                           pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.retirement.horizon.required", "Please enter when you plan to retire", null));
                        }
                     }
                     if (!hasData(getWithdrawlPeriod().toString()))
                     {
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.retirement.withdrwl.required", "Please enter when you plan to withdrwal", null));
                     }
                  }
               }
            }
            break;
         case 2: // Investment Page
            if (getInitialInvestment() == null || getInitialInvestment() == 0)
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.initialInvestment.required", "Initial Investment is required", null));
            }
            break;
         case 3: // Asset/Liabilty/Networth
            if (getCustomer().getAccountFinancials().getNetworth() == null || getCustomer().getAccountFinancials().getNetworth() == 0)
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.networth.required", "Networth value is required", null));
            }
            break;
         case 4: // Risk Questions start (First two are imbedded in this page.
            // Don't need to check, as the default are set when starting.
            break;
         case 5:
            ans = getCustomer().riskProfile.getRiskAnswer(4);
            if (ans == null || ans == 0)
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.riskans.required", "Must select one of the choices below", null));
            }
            break;
         case 6:
            ans = getCustomer().riskProfile.getRiskAnswer(5);
            if (ans == null || ans == 0)
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.riskans.required", "Must select one of the choices below", null));
            }
            break;
         case 7:
            ans = getCustomer().riskProfile.getRiskAnswer(6);
            ;
            if (ans == null || ans == 0)
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.riskans.required", "Must select one of the choices below", null));
            }
            break;
         case 8:
            ans = getCustomer().riskProfile.getRiskAnswer(7);
            ;
            if (ans == null || ans == 0)
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.riskans.required", "Must select one of the choices below", null));
            }
            break;
         case 9:
            ans = getCustomer().riskProfile.getRiskAnswer(8);
            ;
            if (ans == null || ans == 0)
            {
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.riskans.required", "Must select one of the choices below", null));
            }
            break;
      }

      if (pagemanager.getErrorMessage() != null && !pagemanager.getErrorMessage().isEmpty())
      {
         dataOK = false;
      }

      this.dataOK = dataOK;
      return dataOK;
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

   public Integer getSelectedRetirementGoal()
   {
      return selectedRetirementGoal;
   }

   public void selectRetireType(Integer value)
   {
      if (value != null)
      {
         selectedRetirementGoal = value;
         if (value == 2)
         {
            getCustomer().setGoal(RiskConst.GOALS.RETIRED.toString());
         }
         else
         {
            getCustomer().setGoal(RiskConst.GOALS.RETIRED.toString());
         }
      }
   }

   public String getRetireImage(Integer num)
   {
      if (num != null)
      {
         return ((selectedRetirementGoal != null && selectedRetirementGoal == num) ? selectedCheckedImage : defaultCheckedImage);
      }
      else
      {
         return defaultCheckedImage;
      }

   }

   public String getSelectedClass(Integer num)
   {
      if (num != null)
      {
         return ((selectedRetirementGoal != null && selectedRetirementGoal == num) ? "selRetGoal" : "");
      }
      else
      {
         return "";
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
