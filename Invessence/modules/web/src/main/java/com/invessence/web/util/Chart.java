package com.invessence.web.util;

import java.util.*;

import com.invessence.web.data.common.*;
import com.invmodel.asset.data.*;
import org.springframework.jca.cci.CannotCreateRecordException;

/**
 * Created by prashant on 12/17/2017.
 */
public class Chart
{
   private PrimefacesCharts primefacechart;
   private GenerateHighChartsData highChart;
   public Object chartData;
   private String typeOfChart;
   ArrayList<Map> consolidateAssetAndSubAssetList;


   public Chart()
   {
      primefacechart = new PrimefacesCharts();
      highChart = new GenerateHighChartsData();
   }

   public Object getMeterGuage()
   {
      return primefacechart.getMeterGuage();
   }
   public Object getBarChart()
   {
      return primefacechart.getBarChart();
   }
   public Object getLIneChart()
   {
      return primefacechart.lineChart;
   }
   public Object getPieChart()
   {
      return primefacechart.pieChart;
   }
   public String getChartData() { return  chartData.toString(); }

   public String create2DDONUTChart(AssetClass[] assetData, Map<String, String> webInfo){
      String chartJSON = "";
      if(webInfo.get("CHART.ASSET.ALLOCATION") != null &&
         webInfo.get("CHART.ASSET.ALLOCATION").equalsIgnoreCase("HIGHCHART.2DDONUT")){
         chartJSON =  highChart.create2DDONUTChart(new ArrayList<Asset>(assetData[0].getAssetclass().values()));
      }
      return chartJSON;
   }

   public ArrayList<Map> getConsolidateAssetAndSubAssetList()
   {
      return consolidateAssetAndSubAssetList;
   }

   public void setConsolidateAssetAndSubAssetList(ArrayList<Map> consolidateAssetAndSubAssetList)
   {
      this.consolidateAssetAndSubAssetList = consolidateAssetAndSubAssetList;
   }

   public String getTypeOfChart()
   {
      return typeOfChart;
   }

   public void setTypeOfChart(String typeOfChart)
   {
      this.typeOfChart = typeOfChart;
   }

   public void createAssetChart(AssetClass[] assetdata, WebUtil util) throws CannotCreateRecordException
   {
      Map<String, String> configMap = util.getWebprofile().getWebInfo();
      setTypeOfChart(configMap.get("CHART.ASSET.ALLOCATION"));// HIGHCHART.2DDONUT for highchart and PRIMEFACES.2DDONUT for primfaces
      if (assetdata != null)
      {
         if (configMap.get("CHART.ASSET.ALLOCATION") != null &&
            configMap.get("CHART.ASSET.ALLOCATION").equalsIgnoreCase("HIGHCHART.2DDONUT"))
         {
            chartData = (highChart.create2DDONUTChart(new ArrayList<Asset>(assetdata[0].getAssetclass().values())));
         }
         else {
            primefacechart.createPieModel(assetdata, 0);
            chartData = getPieChart();
         }
      }
   }

}
