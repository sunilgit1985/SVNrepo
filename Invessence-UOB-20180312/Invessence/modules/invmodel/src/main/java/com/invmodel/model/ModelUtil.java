package com.invmodel.model;

import java.util.*;

import com.invmodel.asset.AssetAllocationModel;
import com.invmodel.asset.data.AssetClass;
import com.invmodel.inputData.ProfileData;
import com.invmodel.model.dynamic.PortfolioOptimizer;
import com.invmodel.model.fixedmodel.FixedModelOptimizer;
import com.invmodel.model.fixedmodel.data.FMData;
import com.invmodel.performance.ForwardProjection;
import com.invmodel.performance.data.ProjectionData;
import com.invmodel.portfolio.PortfolioModel;
import com.invmodel.portfolio.data.Portfolio;
import com.invmodel.rebalance.TLHSecurityCollection;
import com.invmodel.risk.data.*;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 6/20/16
 * Time: 2:20 PM
 * To change this template use File | Settings | File Templates.
 */
public class ModelUtil
{
   private AssetAllocationModel assetmodel;
   private PortfolioModel portfolioModel;
   private ForwardProjection forwardProjection;
   private static ModelUtil instance;
   private PortfolioOptimizer poptimizer = null;
   private FixedModelOptimizer fixoptimizer = null;
   private TLHSecurityCollection tlhSecurityCollection = null;



   public static synchronized ModelUtil getInstance()
   {
      if (instance == null)
      {
         instance = new ModelUtil();
      }

      return instance;
   }

   public ModelUtil()
   {
      super();
      portfolioModel = PortfolioModel.getInstance();
      forwardProjection = ForwardProjection.getInstance();
      assetmodel = AssetAllocationModel.getInstance();
      poptimizer = PortfolioOptimizer.getInstance();
      fixoptimizer = FixedModelOptimizer.getInstance();
      tlhSecurityCollection = TLHSecurityCollection.getInstance();
   }

   public void setAssetmodel(AssetAllocationModel assetmodel)
   {
      this.assetmodel = assetmodel;
   }

   public void setPortfolioModel(PortfolioModel portfolioModel)
   {
      this.portfolioModel = portfolioModel;
   }

   public void setProjectiondata(ForwardProjection forwardProjection)
   {
      this.forwardProjection = forwardProjection;
   }

   public AssetClass createAssetAllocation(RiskCalc riskCalc)
   {
      return assetmodel.createAllocation(riskCalc);

   }

   public Portfolio createPortfolioAllocation(AssetClass assetclass, RiskCalc riskCalc)
   {
      return portfolioModel.createPortfolio(assetclass, riskCalc);
   }

   public ArrayList<ProjectionData> createGlidePath(Integer years, RiskCalc riskCalc) {
      if (forwardProjection == null)
         return null;
      return forwardProjection.createGlidePath(years, riskCalc);
   }

   public AssetClass[] buildAllocation(ProfileData pdata)
   {
      return assetmodel.buildAllocation(pdata);

   }

   public PortfolioOptimizer getPoptimizer()
   {
      return poptimizer;
   }

   public void refreshData() {
      poptimizer.refreshDataFromDB();
      fixoptimizer.refreshDataFromDB();
      tlhSecurityCollection.refreshDataFromDB();
   }

   public ArrayList<FMData> getThemePortfolios(String theme) {
      if (fixoptimizer != null ) {
         return fixoptimizer.getThemePortfolios(theme);
      }
      return null;
   }

   public LinkedHashMap<String,FMData> getThemePortfoliosMap(String theme) {
      if (fixoptimizer != null ) {
         LinkedHashMap<String,FMData> stringFMDataLinkedHashMap=new LinkedHashMap<String, FMData>();
         for (FMData fmData:fixoptimizer.getThemePortfolios(theme)){
               stringFMDataLinkedHashMap.put(fmData.getDisplayname(),fmData);
         }
         return stringFMDataLinkedHashMap;
      }
      return null;
   }

   public FMData getThemePortfolios(String theme,String portfolioName) {
      if (fixoptimizer != null ) {
         for (FMData fmData:fixoptimizer.getAllThemes())
            if (fmData.getTheme().equalsIgnoreCase(theme)) {
            return fixoptimizer.getThemeByPortfolioName(theme,portfolioName);
         }
      }
      return null;
   }

   public Portfolio[] buildPortfolio(AssetClass[] assetData, ProfileData profileData)
   {
      return portfolioModel.buildPortfolio(assetData, profileData);
   }

   public ProjectionData[] buildPerformanceChart(ProfileData pdata, FMData fmdata) {
      return forwardProjection.buildFMPerformanceData(pdata, fmdata);
   }

   public ArrayList<ProjectionData[]> buildProjectionData(ProfileData pdata) {
      if (forwardProjection == null)
         return null;
       return forwardProjection.buildProjectionData(pdata);
   }

   public void goalTracking(ProfileData pdata) {
      forwardProjection.goalTracking(pdata);
   }
}
