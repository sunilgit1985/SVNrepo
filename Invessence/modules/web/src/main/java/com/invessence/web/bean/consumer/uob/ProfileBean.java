package com.invessence.web.bean.consumer.uob;

import java.util.*;
import javax.faces.bean.*;
import javax.faces.context.FacesContext;

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

   private List<WebMenuItem> goalsdata = null;
   private List<WebMenuItem> currencyList = null;
   public WebMenuItem selectedGoal;
   public WebMenuItem selectedCurrency;
   public Integer selectedRetirementGoal;
   public String selectedClass="";


   public void loadDropDownList()
   {
      goalsdata = webMenuList.getMenulist().get(WebMenuList.ListComponent.GOAL.toString());
      currencyList = webMenuList.getMenulist().get(WebMenuList.ListComponent.CURRENCY.toString());
   }

   @Override
   public void initUI()
   {
      super.initUI();
      selectedGoal = null;
      pagemanager = new PagesImpl(10);  // Set number of pages as per UI.
      progressbar = new ProgressBarImpl(0.0, (100.0/pagemanager.getMaxNoofPages()));

   }
   @Override
   public void gotoStartOverPage()
   {
      pagemanager.setPage(0);
      uiLayout.doMenuAction("consumer", "cadd.xhtml?acct=" + getCustomer().getAcctnum() + "&app=" + UIMode.Edit.toString());
   }

   public void setAdvisor(String advisor) {
      if (advisor != null)
      {
         loadWebMenuList(customer.getAdvisor());
         customer.setAdvisor(advisor);
         customer.riskProfile.setAdvisor(advisor);
         riskCalc = new UOBRiskCalc(customer.riskProfile);
      }
   }

   public void setDefault() {
      setAdvisor(webutil.getWebprofile().getDefaultAdvisor());
      loadDropDownList();  // This process will reload all dropdown list.
      pagemanager.initPage();
      createAssetPortfolio();
   }

   public void preRenderReview()
   {

      try
      {
         if (!FacesContext.getCurrentInstance().isPostback())
         {
         }
      }
      catch (Exception ex)
      {
      }
   }

   @Override
   public void preRenderView()
   {

      try
      {
         if (!FacesContext.getCurrentInstance().isPostback())
         {
            if (beanmode == null)
            {
               beanmode = UIMode.New;
            }
            if (!(beanmode.equals(UIMode.New) || beanmode.equals(UIMode.Edit)))
            {
               webutil.redirect("/login.xhtml", null);
               return;
            }

            if (beanmode.equals(UIMode.New))
            {
               initUI();
               super.preRenderView();
               setDefault();
            }
         }
      }
      catch (Exception ex)
      {
      }
   }

   public List<WebMenuItem> getGoalsdata()
   {
      return goalsdata;
   }

   public List<WebMenuItem> getCurrencyList()
   {
      return currencyList;
   }

   public Integer getAge() {
      if (getCustomer() != null)
      {
         return getCustomer().getAge();
      }
      else return null;

   }

   public void setAge(Integer age)
   {
      if (getCustomer() != null)
      {
         getCustomer().setAge(age);
         adjustInitialRisk();
      }
   }

   public Integer getHorizon() {
      if (getCustomer() != null)
      {
         return getCustomer().getHorizon();
      }
      else return null;

   }

   public void setHorizon(Integer horizon)
   {
      if (getCustomer() != null)
      {
         getCustomer().setHorizon(horizon);
         adjustInitialRisk();
      }
   }

   public Integer getWithdrawlPeriod() {
      if (getCustomer() != null)
      {
         return getCustomer().riskProfile.getAnswerInt(RiskConst.WITHDRAWALPERIOD);
      }
      else return null;

   }

   public void setWithdrawlPeriod(Integer period)
   {
      if (getCustomer() != null)
      {
         getCustomer().riskProfile.setAnswer(RiskConst.WITHDRAWALPERIOD, period);
         adjustInitialRisk();
      }
   }

   public Integer getInitialInvestment() {
      if (getCustomer() != null)
      {
         getCustomer().getInitialInvestment();
      }
      return null;
   }

   public void setInitialInvestment(Integer investment)
   {
      getCustomer().setInitialInvestment(investment);
      adjustInitialRisk();
   }

   public Integer getRecurringInvestment() {
      if (getCustomer() != null)
      {
         return getCustomer().getRecurringInvestment();
      }
      return null;
   }

   public void setRecurringInvestment(Integer investment)
   {
      getCustomer().setRecurringInvestment(investment);
      adjustInitialRisk();
   }

   public Integer getRecurringPeriod() {
      if (getCustomer() != null)
      {
         return getCustomer().riskProfile.getAnswerInt(RiskConst.RECURRINGPERIOD);
      }
      return null;
   }

   public void setRecurringPeriod(Integer period)
   {
      getCustomer().riskProfile.setAnswer(RiskConst.RECURRINGPERIOD,period);
      adjustInitialRisk();
   }

   private void adjustInitialRisk() {
      getRiskCalc().ageTimeFormula(getCustomer().getAge(), getCustomer().getHorizon());
   }

   public WebMenuItem getSelectedGoal() {
      return selectedGoal;
   }

   public void setSelectedGoal(WebMenuItem selectedItem) {
      this.selectedGoal = selectedItem;
   }

   public Integer getSelectedGoalValue() {
      return (selectedGoal == null ) ? 0 : converter.getIntData(selectedGoal.getSelectedValue());
   }

   public WebMenuItem getSelectedCurrency() {
      return selectedCurrency;
   }

   public void setSelectedCurrency(WebMenuItem selectedItem) {
      this.selectedCurrency = selectedItem;
   }

   private Boolean validatePage(Integer pagenum)
   {
      Boolean dataOK = true;
      pagemanager.clearErrorMessage(pagenum);
      switch (pagenum)
      {
         case 0:
            break;
         case 1:
            break;
         case 2:
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
      }
      return dataOK;
   }

   private void setRiskAns(Integer question, String value) {
      Integer ans;
      if (value != null) {
         ans = converter.getIntData(value);
         riskCalc.setQuestionsRisk(3, ans, 0.0);
      }
   }

   public String getRiskAns1() {
      return getCustomer().riskProfile.getRiskAnswer(1).toString();
   }

   public void setRiskAns1(String value) {
      setRiskAns(1,value);
   }

   public Boolean getRiskAns2() {
      Integer ans = getCustomer().riskProfile.getRiskAnswer(2);
      if (ans != null) {
         switch (ans) {
            case 1:
               return true;
            default:
               break;
         }
      }
      return false;
   }

   public void setRiskAns2(Boolean value) {
      if (value) {
         riskCalc.setQuestionsRisk(2,1,0.0);
      }
      else {
         riskCalc.setQuestionsRisk(2,2,0.0);
      }
   }

   public Boolean getRiskAns3() {
      Integer ans = getCustomer().riskProfile.getRiskAnswer(3);
      if (ans != null) {
         switch (ans) {
            case 1:
               return true;
            default:
               break;
         }
      }
      return false;
   }

   public void setRiskAns3(Boolean value) {
      if (value) {
         riskCalc.setQuestionsRisk(3,1,0.0);
      }
      else {
         riskCalc.setQuestionsRisk(3,2,0.0);
      }
   }

   public String getRiskAns4() {
      return getCustomer().riskProfile.getRiskAnswer(4).toString();
   }

   public void setRiskAns4(String value) {
      setRiskAns(4,value);
   }

   public String getRiskAns5() {
      return getCustomer().riskProfile.getRiskAnswer(5).toString();
   }

   public void setRiskAns5(String value) {
      setRiskAns(5,value);
   }

   public String getRiskAns6() {
      return getCustomer().riskProfile.getRiskAnswer(6).toString();
   }

   public void setRiskAns6(String value) {
      setRiskAns(6,value);
   }

   public String getRiskAns7() {
      return getCustomer().riskProfile.getRiskAnswer(7).toString();
   }

   public void setRiskAns7(String value) {
      setRiskAns(7,value);
   }

   public String getRiskAns8() {
      return getCustomer().riskProfile.getRiskAnswer(8).toString();
   }

   public void setRiskAns8(String value) {
      setRiskAns(8,value);
   }

   public void onChangeName() {
   }

   public void onChangeValue()
   {
      formEdit = true;
      riskCalc.calculate();
      createAssetPortfolio();
   }

   public void onChangeCurrency()
   {
      formEdit = true;
   }

   public Integer getSelectedRetirementGoal()
   {
      return selectedRetirementGoal;
   }

   public void selectRetireType(Integer value) {
      if (value != null) {
         selectedRetirementGoal = value;
         if (value == 2) {
            getCustomer().riskProfile.setGoals(RiskConst.GOALS.RETIRED.toString());
         }
         else
         {
            getCustomer().riskProfile.setGoals(RiskConst.GOALS.RETIREMENT.toString());
         }
      }
   }

   public String getRetireImage(Integer num) {
      if (num != null)
      {
         return ((selectedRetirementGoal != null && selectedRetirementGoal == num) ? selectedCheckedImage : defaultCheckedImage);
      }
      else
         return defaultCheckedImage;

      }

   public String getSelectedClass(Integer num) {
      if (num != null)
      {
         return ((selectedRetirementGoal != null && selectedRetirementGoal == num) ? "selRetGoal" : "");
      }
      else
         return "";

   }

   public String getPrintName() {
      if (getCustomer() != null && getCustomer().getName() != null) {
         return getCustomer().getName() + ", ";
      }
      return "";
   }
}
