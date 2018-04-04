package com.invessence.web.bean.consumer.bellrock;

import java.util.*;
import javax.faces.application.FacesMessage;
import javax.faces.bean.*;
import javax.faces.context.FacesContext;

import com.invessence.converter.JavaUtil;
import com.invessence.web.bean.consumer.PortfolioCreationUI;
import com.invessence.web.constant.WebConst;
import com.invessence.web.util.*;
import com.invessence.web.util.Impl.*;
import com.invmodel.asset.data.Asset;
import com.invmodel.inputData.ProfileData;
import com.invmodel.performance.data.ProjectionData;
import com.invmodel.risk.data.RiskConst;
import com.invmodel.risk.data.client.BellRockRiskCalc;

/**
 * Created by prashant on 11/16/2017.
 */

@ManagedBean(name = "deep200pb")
@SessionScoped
public class ProfileBeanV2 extends PortfolioCreationUI
{

   private String newapp;
   private ArrayList<WebMenuItem> goalsdata = null;
   private Map<String, WebMenuItem> currencyMap = null;
   public WebMenuItem selectedGoal;
   public WebMenuItem selectedCurrency;
   public Boolean selectedRetirementGoal = true;
   private String revwPnlExpYrFndLbl;
   private String selectedGoalStr;
   private Boolean formPortfolioEdit = false;
   private Boolean displayGoalText = false;
   ArrayList<ProjectionData[]> projectionDatas;
   private BRCharts charts = new BRCharts();
   public Chart chart;
   private String whichChart;

   public BRCharts getCharts()
   {
      return charts;
   }

   public void setCharts(BRCharts charts)
   {
      this.charts = charts;
   }

   @Override
   public void initUI()
   {
      super.initUI();
      selectedGoal = null;
      pagemanager = new PagesImpl(5);  // Set number of pages as per UI.
      progressbar = new ProgressBarImpl(0.0, (100.0 / pagemanager.getMaxNoofPages()));
   }

   private void setDefaultSwitch()
   {
   }

   @Override
   public Integer getInitialInvestment()
   {
      if(getCustomer().getInitialInvestment()==null){
         return getCustomer().getRiskProfile().getDefaultInitialInvestment().intValue();
      }
      return getCustomer().getInitialInvestment();
   }

   @Override
   public void setInitialInvestment(Integer initialInvestment)
   {
      super.setInitialInvestment(initialInvestment);

      if (initialInvestment == null)
         initialInvestment = 0;

      String newTheme;
      if (initialInvestment < 10000) {
         newTheme = getCustomer().getRiskProfile().getDefaultStrValue(RiskConst.ALTTHEME+"1",null);
      }
      else {
         if (initialInvestment < 50000) {

            newTheme = getCustomer().getRiskProfile().getDefaultStrValue(RiskConst.ALTTHEME+"2",null);
         }
         else {
            newTheme = getCustomer().getRiskProfile().getDefaultStrValue(RiskConst.ALTTHEME+"3",null);
         }
      }
      if(newTheme!=null)
      {
         getCustomer().setTheme(newTheme);
      }
   }


   public String getNewapp()
   {
      return newapp;
   }

   public Boolean getDisplayGoalText()
   {
      return displayGoalText;
   }

   public void setDisplayGoalText(Boolean displayGoalText)
   {
      this.displayGoalText = displayGoalText;
   }

   public void setNewapp(String newapp)
   {
      this.newapp = newapp;
   }
   public Boolean getFormPortfolioEdit()
   {
      return formPortfolioEdit;
   }

   public void setFormPortfolioEdit(Boolean formPortfolioEdit)
   {
      this.formPortfolioEdit = formPortfolioEdit;
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
               //selectedMobileGoal=getCustomer().getGoal().toUpperCase();
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
      if(!getCustomer().getManaged()){
         if(beanmode.equals(UIMode.New)){
            riskCalc.setInvestment(getCustomer().getDefaultInvestment());
         }else{
            setRiskTotalInvestment(getCustomer().getInitialInvestment().doubleValue());
         }
      }else{
         riskCalc.setInvestment(getCustomer().getActualInvestment());
      }
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
         whichChart = "pie";
         // Need to find out why this is being tested???
         if (getCustomer() == null)
         {
            initUI();
            if (beanmode == null)
            {
               beanmode = UIMode.Review;
            }
           // fetchClientData();
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
            if (newapp != null && newapp.startsWith("N"))
            {
               setNewapp("N");
               beanAcctnum = null;
            }
            else {
               setNewapp("E");
            }
            formPortfolioEdit = false;
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
   public void startover()
   {
      closeFTPanel();
      riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.C);
      pagemanager.setPage(0);
      super.startover();
   }

   @Override
   public void gotoNextPage()
   {
      Integer currentpage = pagemanager.getPage();

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
         /*if (currentpage == 3)
         {
            doPerformanceChart();
         }
         riskCalc.calculate();
         createAssetPortfolio();*/
         if(currentpage == 2){
            calcProjectionChart();
            doProjectionChart();
         }
      }
      else
      {
         // Certain pages have default FacesContext to display error messages.
         FacesContext context = FacesContext.getCurrentInstance();
         context.addMessage(null, new FacesMessage(pagemanager.getErrorMessage(), pagemanager.getErrorMessage()));
      }
   }

   @Override
   public void gotoPrevPage()
   {
      try
      {
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
         riskCalc = new BellRockRiskCalc(customer.riskProfile);
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
         /*
         if (selectedGoal != null)
         {
            selectedGoalValue = RiskConst.GOALS.displayToGoal(selectedGoal.getDisplayName());
            if (selectedGoalValue.equals(RiskConst.GOALS.LEGACY))
            {
               getCustomer().getRiskProfile().setRiskAnswer(0, 0, 0.0);
               return;
            }
         }
         */
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
         // selectedMobileGoal=goal;
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
      Boolean validateOK = true;
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
         validateOK = false;
      }
      this.dataOK = validateOK;
      return validateOK;
   }


   private Boolean validatePage(Integer pagenum)
   {

      Boolean validateOK = true;
      Integer ans;
      pagemanager.clearErrorMessage(pagenum);

      if (pagenum == null)
      {
         return false;
      }

      Integer minInvestmentRequired = 0;
      if (webutil.getWebprofile().getWebInfo().containsKey("INVESTMENT.MIN1ST"))
      {
         minInvestmentRequired = webutil.converter.getIntData(webutil.getWebprofile().getWebInfo().containsKey("INVESTMENT.MIN1ST"));
      }

      if (minInvestmentRequired == null || minInvestmentRequired == 0)
      {
         minInvestmentRequired = 2000;
      }

      switch (pagenum)
      {
         case 0: // Accttype page

            if (getCustomer().getGoal() == null || getInitialInvestment() == null)
            {
               validateOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.investment.required", "Min $2,000 investment required", new Object[]{"$2,000"}));
            }
            if (getInitialInvestment() != null && getInitialInvestment() < minInvestmentRequired)
            {
               validateOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.investment.constraint", "Min $2,000 investment required", new Object[]{"$2,000"}));
            }

            if (getCustomer().getGoal() != null)
            {
               if (getCustomer().getAccountType() != null)
               {
                  if (getCustomer().getAccountType().equalsIgnoreCase("Traditional IRA") || getCustomer().getAccountType().equalsIgnoreCase("Roth IRA")
                     || getCustomer().getAccountType().equalsIgnoreCase("SEP IRA") || getCustomer().getAccountType().equalsIgnoreCase("Roll Over IRA"))
                  {
                     if (! getCustomer().getGoal().equalsIgnoreCase("RETIREMENT"))
                     {
                        validateOK = false;
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.accounttype.retirement", "Goal cannot be changed as this is already an IRA. Please reset to Retirement.", new Object[]{getCustomer().getGoal()}));
                     }
                  }
               }
               if (getCustomer().getGoal().equalsIgnoreCase("RETIREMENT"))
               {
                  if (getAge() == null)
                  {
                     validateOK = false;
                     pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.age.constraint", "Age must be between 18 and 100 years.", null));
                  }
                  else
                  {
                     if ((getAge() < 18) || (getAge() > 100))
                     {
                        validateOK = false;
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.age.constraint", "Age must be between 18 and 100 years.", null));
                     }
                  }

                  if (! getCustomer().getRiskProfile().getAnswerBoolean(RiskConst.RETIRED))
                  {
                     if(getCustomer().getRiskProfile().getAnswerInt(RiskConst.RETIREDAGE) == null)
                     {
                        validateOK = false;
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.retireage.required", "When do you plan to retire?", null));
                     }
                     else if (getCustomer().getRiskProfile().getAnswerInt(RiskConst.RETIREDAGE) <= getAge())
                     {
                        validateOK = false;
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.retireage.constraint", "Retirement age must be greater than current age.", null));
                     }
                     else if (getCustomer().getRiskProfile().getAnswerInt(RiskConst.RETIREDAGE) > 100)
                     {
                        validateOK = false;
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.retireage.constraint2", "Retirement age must be less than 100 years.", null));
                     }
                  }
               }
               else if (getCustomer().getGoal().equalsIgnoreCase("COLLEGE"))
                  {
                     if (! hasData(getHorizon()))
                     {
                        validateOK = false;
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.college.required", "When does your child plan to attend college?", null));
                     }
                     else if (getHorizon() < 1 || getHorizon() > 18)
                     {
                        validateOK = false;
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.college.constraint", "Number of years to invest must be between 1 and 18 years.", null));
                     }
                  }
                  else
                  {
                     if (! hasData(getHorizon()))
                     {
                        validateOK = false;
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.otherhorizon.required", "When do you plan to use these funds?", null));
                     }
                     else if (getHorizon() < 1 || getHorizon() > 100)
                     {
                        validateOK = false;
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.otherhorizon.constraint", "Number of years to invest must be between 1 and 100 years.", null));
                     }
                  }
               }

            break;
         case 1: // Investment Choices
            ans = getCustomer().getRiskProfile().getRiskAnswer(2);
            if (!hasData(ans))
            {
               validateOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.risk.radio.required", "Please choose one of these choices.", null));
            }
            break;
         case 2: // Investment Risk
            ans = getCustomer().getRiskProfile().getRiskAnswer(3);
            if (!hasData(ans))
            {
               validateOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.risk.meter.required", "Please select the image that best represents your tolerance for risk.", null));
            }
            break;
         case 3: // Investment Projection
            ans = getCustomer().getRiskProfile().getRiskAnswer(4);
            if (!hasData(ans))
            {
               validateOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.risk.projection.required", "Please choose an investment strategy.", null));
            }
            break;
      }

      this.dataOK = validateOK;
      return validateOK;
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

   public String getRiskAns2()
   {
      return getCustomer().riskProfile.getRiskAnswer(2).toString();
   }

   public void setRiskAns2(String value)
   {
      if(value!=null && !value.equals(""))
      {
         getCustomer().riskProfile.setAnswer(RiskConst.RISKQUESTIONKEY + "2", Integer.parseInt(value));
      }
      setRiskAns(2, value);
   }

   public String getRiskAns3()
   {
      return getCustomer().riskProfile.getRiskAnswer(3).toString();
   }

   public void setRiskAns3(String value)
   {
      if(value!=null && !value.equals(""))
      {
         getCustomer().riskProfile.setAnswer(RiskConst.RISKQUESTIONKEY + "3", Integer.parseInt(value));
      }
      setRiskAns(3, value);
   }

   public String getRiskAns4()
   {
      return getCustomer().riskProfile.getRiskAnswer(4).toString();
   }

   public void setRiskAns4(String value)
   {
      if(value!=null && !value.equals(""))
      {
         getCustomer().riskProfile.setAnswer(RiskConst.RISKQUESTIONKEY + "4", Integer.parseInt(value));
      }
      setRiskAns(4, value);
   }
   public String getRiskAns5()
   {
      return getCustomer().riskProfile.getRiskAnswer(5).toString();
   }

   public void setRiskAns5(String value)
   {
      if(value!=null && !value.equals(""))
      {
         getCustomer().riskProfile.setAnswer(RiskConst.RISKQUESTIONKEY + "5", Integer.parseInt(value));
      }
      setRiskAns(5, value);
   }
   public String getAns4Tag2(Integer which)
   {
      if (which != null)
      {
         if (getRiskAns4() != null && getRiskAns4().equalsIgnoreCase(which.toString()))
         {
            return "Container90 ProjectionSlabHeight ProjectionSlabHeight_Selected";
         }
      }
      return "Container90 ProjectionSlabHeight";
   }

   public String getAns4Tag1(Integer which)
   {
      if (which != null)
      {
         if (getRiskAns4() != null && getRiskAns4().equalsIgnoreCase(which.toString()))
         {
            return "triangleShape Fleft triangleShape_Selected";
         }
      }
      return "triangleShape Fleft";
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
            if ((!selectedRetirementGoal && thisgoal.equals(RiskConst.GOALS.RETIREMENT))){
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
      if((!selectedRetirementGoal && RiskConst.GOALS.displayToGoal(selectedGoal.getKey()).equals(RiskConst.GOALS.RETIREMENT)) ){
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
      if (customer.getGoal() == null || customer.getGoal().isEmpty())
      {
         displayGoalText = false;
      }
      else
      {
         displayGoalText = true;
         selectedRetirementGoal = true;
        /* setAge(null);
         setRetirementAge(null);
         setHorizon(null);
         setWithdrawlPeriod(null);*/
      }

   }

/*
   public String getSelectedMobileGoal()
   {
      return selectedMobileGoal;
   }
*/

   public String getSelectedGoalStr()
   {
      return selectedGoalStr;
   }

   public void setSelectedGoalStr(String selectedGoalStr)
   {

      if(selectedGoalStr!=null && !selectedGoalStr.equalsIgnoreCase("select")){
         for (int i = 0; i < goalsdata.size(); i++)
         {
            if (goalsdata.get(i).getKey().equalsIgnoreCase(selectedGoalStr))
            {
               setSelectedGoal(goalsdata.get(i));
               this.selectedGoal = goalsdata.get(i);
               break;
            }
         }
      }
      this.selectedGoalStr=selectedGoalStr;
   }

   public void onGoalChangeValue()
   {
      if (customer.getGoal() == null || customer.getGoal().isEmpty())
      {
         displayGoalText = false;
      }
      else
      {
         displayGoalText = true;
         selectedRetirementGoal = true;
         setAge(null);
         setRetirementAge(null);
         setHorizon(null);
         setWithdrawlPeriod(null);
      }
   }

   public void riskSelected(Integer value)
   {
      setRiskAns3(value.toString());
      formEdit = true;
      riskCalc.calculate();
      createAssetPortfolio();
   }

   public String getRiskGraphic(Integer value)
   {
      String defaultImage = "/javax.faces.resource/images/gl";
      String selectedImage = "/javax.faces.resource/images/sgl";
      String extension = ".png.xhtml?ln=tcm";

      if (getRiskAns3() == null)
      {
         return defaultImage + value.toString() + extension;
      }
      else
      {
         if (getRiskAns3().equalsIgnoreCase(value.toString()))
         {
            return selectedImage + value.toString() + extension;
         }
         else
         {
            return defaultImage + value.toString() + extension;
         }
      }

   }

   public void doProjectionChart()
   {
      String event = getRiskAns4();
      Integer whichslide = null;

      if ((event != null) && (!event.isEmpty()))
      {
         whichslide = webutil.getConverter().getIntData(event);
      }

      if (whichslide == null)
      {
         if (getRiskAns3() != null && !getRiskAns3().isEmpty())
         {
            whichslide = webutil.getConverter().getIntData(getRiskAns3()); // See comment below, we are offsetting it by one.
         }
         else
         {
            whichslide = 0;
         }
      }

      if (whichslide > 0)
      { // Answers are stored in 1 to 5.  Whereas array is from 0-4
         whichslide -= 1;   // We have to offset the slider by 1 if > 0
      }
      //  Calls for Projection creation chart by using HighChart
      if (getProjectionDatas() != null)
      {
         if (getProjectionDatas().size() > 0)
         {
            Integer portfolioID = getProjectionDatas().size() - 1;
            charts.createProjectionHighChart(getProjectionDatas().get(whichslide),
                                             getHorizon(),
                                             getAge(),
                                             riskCalc.getHorizon(),
                                             getProjectionDatas().get(portfolioID));
         }

      }
      formEdit = true;
      riskCalc.calculate();
      createAssetPortfolio();
   }

   public ArrayList<ProjectionData[]> getProjectionDatas()
   {
      return projectionDatas;
   }

   public void calcProjectionChart() {
      if (customer.getModelUtil() != null) {
         projectionDatas = customer.getModelUtil().buildProjectionData(customer.getProfileInstance());
      }

   }

   public void setProjectionDatas(ArrayList<ProjectionData[]> projectionDatas)
   {
      this.projectionDatas = projectionDatas;
   }

   public Double getTotalRisk()
   {
      return customer.getTotalRisk();

   }

   public Double getTotalExpectedReturns()
   {
      return customer.getTotalExpectedReturns();
   }

   public ArrayList<Asset> getEditableAsset()
   {
      return customer.getEditableAsset();
   }

   public void setEditableAsset(Asset data)
   {
      customer.setEditableAsset(data);
   }

   private void createCharts()
   {

      try
      {
         formEdit = true;
         // charts.setMeterGuage(getMeterRiskIndicator());
         if (customer.getAssetData() != null)
         {
            charts.createPieModel(customer.getAssetData(), 0);
            // charts.createBarChart(getAssetData(), 0);
         }
         else
         {
            charts.resetCharts();
         }
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }


   public void doPerformanceFinalpage()
   {
      if (getFixedModel())
      {
         ProjectionData[] performancedata = modelUtil.buildPerformanceChart((ProfileData) customer.getInstance(), getFixedFMModel());
         charts.createProjectionHighChart(performancedata,
                                          getHorizon(),
                                          getAge(),
                                          getRetirementAge(),
                                          null);
      }
   }


   public void refreshChart()
   {

      if (whichChart.toLowerCase().equals("pie"))
      {
         charts.createPieModel(customer.getAssetData(), 0);
      }
      else if (whichChart.toLowerCase().equals("bar"))
      {
         charts.createBarChart(customer.getAssetData(), 0);
      }

   }

   public String getWhichChart()
   {
      return whichChart;
   }

   public void setWhichChart(String whichChart)
   {
      this.whichChart = whichChart;
   }

   public String getEmail()
   {
      return customer.getEmail();
   }

   public void setEmail(String email)
   {
      customer.setEmail(email);
   }

   public String getFirstname()
   {
      return customer.getFirstname();
   }

   public void setFirstname(String firstname)
   {
      customer.setFirstname(firstname);
   }

   public String getLastname()
   {
      return customer.getLastname();
   }

   public void setLastname(String lastname)
   {
      customer.setLastname(lastname);
   }
}
