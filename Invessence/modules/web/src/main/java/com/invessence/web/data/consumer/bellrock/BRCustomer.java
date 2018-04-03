package com.invessence.web.data.consumer.bellrock;

import java.util.*;

import com.invessence.web.data.common.CustomerData;
import com.invmodel.model.fixedmodel.data.FMData;
import com.invmodel.performance.data.ProjectionData;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 6/15/16
 * Time: 4:29 PM
 * To change this template use File | Settings | File Templates.
 */
public class BRCustomer extends CustomerData
{
   public BRRiskCalculator riskCalculator;
   ArrayList<ProjectionData[]> projectionDatas;
   ArrayList<FMData> fixedModelPortfolioList;
   LinkedHashMap <String, FMData> fmDataLinkedHashMap;

   public BRCustomer()
   {
      super();
      riskCalculator = new BRRiskCalculator();
      projectionDatas = null;
   }

   @Override
   public Integer getAge()
   {
      return riskCalculator.getRiskAge();
   }

   @Override
   public void setAge(Integer age)
   {
      riskCalculator.setRiskAge(age);
      this.age = age;
   }

   @Override
   public Integer getHorizon()
   {
      return riskCalculator.getRiskHorizon();
   }

   @Override
   public void setHorizon(Integer horizon)
   {
      this.horizon = horizon;
      riskCalculator.setRiskHorizon(horizon);
   }


   @Override
   public String getGoal()
   {
      String theGoal = null;
      if (goal != null) {
         if (goal.contains("Retire")) {
            theGoal = "Retirement";
         }
         else {
            theGoal = goal;
         }
      }
      return theGoal;
   }

   @Override
   public void setGoal(String thisgoal)
   {
      if (thisgoal == null)
         goal = null;
      else
      if (thisgoal != null) {
         if (thisgoal.contains("Retire")) {
            if (riskCalculator.getRetired() == 1) {
               goal = "Post-Retirement";
            }
            else {
               goal = "Retirement";
            }
         }
         else {
            goal = thisgoal;
         }
      }
   }


   @Override
   public void setInitialInvestment(Integer initialInvestment)
   {
      this.initialInvestment = initialInvestment;
   }

   public BRRiskCalculator getRiskCalculator()
   {
      return riskCalculator;
   }

   public void setRiskCalculator(BRRiskCalculator riskCalculator)
   {
      this.riskCalculator = riskCalculator;
   }

   public ArrayList<ProjectionData[]> getProjectionDatas()
   {
      return projectionDatas;
   }

   public void calcProjectionChart() {
      if (getModelUtil() != null) {
         projectionDatas = getModelUtil().buildProjectionData(getProfileInstance());
      }

   }

   public ArrayList<FMData> getFixedModelPortfolioList()
   {
      return fixedModelPortfolioList;
   }

   public void setFixedModelPortfolioList(String theme)
   {
      fixedModelPortfolioList = (getTheme() != null) ? getModelUtil().getThemePortfolios(getTheme()) : null;
   }

   public LinkedHashMap<String, FMData> getFmDataLinkedHashMap()
   {
      return fmDataLinkedHashMap;
   }

   public void setFmDataLinkedHashMap(String theme)
   {
      fmDataLinkedHashMap = (getTheme() != null) ? getModelUtil().getThemePortfoliosMap(theme) : null;;
   }
}
