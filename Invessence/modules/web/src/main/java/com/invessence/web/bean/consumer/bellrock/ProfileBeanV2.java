package com.invessence.web.bean.consumer.bellrock;

import java.util.*;
import javax.faces.application.FacesMessage;
import javax.faces.bean.*;
import javax.faces.context.FacesContext;

import com.invessence.converter.JavaUtil;
import com.invessence.web.bean.consumer.PortfolioCreationUI;
import com.invessence.web.constant.WebConst;
import com.invessence.web.util.Impl.*;
import com.invessence.web.util.*;
import com.invmodel.inputData.ProfileData;
import com.invmodel.performance.data.ProjectionData;
import com.invmodel.risk.data.RiskConst;
import com.invmodel.risk.data.client.BellRockRiskCalc;

/**
 * Created by prashant on 11/16/2017.
 */

@ManagedBean(name = "bellrockpb")
@SessionScoped
public class ProfileBeanV2 extends PortfolioCreationUI
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
      pagemanager = new PagesImpl(5);  // Set number of pages as per UI.
      progressbar = new ProgressBarImpl(0.0, (100.0 / pagemanager.getMaxNoofPages()));
   }

   private void setDefaultSwitch()
   {
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
         if (currentpage == 3)
         {
            doPerformanceChart();
         }
         riskCalc.calculate();
         createAssetPortfolio();
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
                     if (! getCustomer().getGoal().equalsIgnoreCase("retirement"))
                     {
                        validateOK = false;
                        pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.accounttype.retirement", "Goal cannot be changed as this is already an IRA. Please reset to Retirement.", new Object[]{getCustomer().getGoal()}));
                     }
                  }
               }
               if (getCustomer().getGoal().equalsIgnoreCase("retirement"))
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
                     if (getCustomer().getRiskProfile().getAnswerInt(RiskConst.RETIREDAGE) == null)
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
               else
               {
                  if (getCustomer().getGoal().equalsIgnoreCase("college"))
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
            }
            break;
         case 1: // Investment Choices
            ans = getCustomer().getRiskProfile().getRiskAnswer(1);
            if (!hasData(ans))
            {
               validateOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.risk.radio.required", "Please choose one of these choices.", null));
            }
            break;
         case 2: // Investment Risk
            ans = getCustomer().getRiskProfile().getRiskAnswer(2);
            if (!hasData(ans))
            {
               validateOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.risk.meter.required", "Please select the image that best represents your tolerance for risk.", null));
            }
            break;
         case 3: // Investment Projection
            ans = getCustomer().getRiskProfile().getRiskAnswer(3);
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
      setRiskAns(2, value);
   }

   public String getRiskAns3()
   {
      return getCustomer().riskProfile.getRiskAnswer(3).toString();
   }

   public void setRiskAns3(String value)
   {
      setRiskAns(2, value);
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
