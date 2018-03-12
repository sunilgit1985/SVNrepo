package com.invmodel.dao.data;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 6/8/15
 * Time: 11:17 PM
 * To change this template use File | Settings | File Templates.
 */
public class HolisticOptimizedData
{
   String advisor;
   String theme;
   Map<String, Double> primeAssetInfo = new HashMap<String, Double>();
   Integer  offset;
   String[] rbsatickers;
   double[] optimizedWeights;
   double[] risk;
   double[] portReturns;
   double[][] weights;
   double[][] coVarOfFunds;
   double[] minSortedError;
   int [] fundOffset;

   public double[] getMinSortedError()
   {
      return minSortedError;
   }

   public void setMinSortedError(double[] minSortedError)
   {
      this.minSortedError = minSortedError;
   }

   public int getNextFundOffset(int i)
   {
      return fundOffset[i];
   }

   public void setFundOffset(int[] fundOffset)
   {
      this.fundOffset = fundOffset;
   }

   public double[][] getWeights()
   {
      return weights;
   }
   public double[] getNextWeights(int i)
   {
      return weights[i];
   }

   public void setWeights(double[][] weights)
   {
      this.weights = weights;
   }

   public double[][] getCoVarOfFunds()
   {
      return coVarOfFunds;
   }

   public void setCoVarOfFunds(double[][] coVarOfFunds)
   {
      this.coVarOfFunds = coVarOfFunds;
   }

   public String getAdvisor()
   {
      return advisor;
   }

   public void setAdvisor(String advisor)
   {
      this.advisor = advisor;
   }

   public String getTheme()
   {
      return theme;
   }

   public void setTheme(String theme)
   {
      this.theme = theme;
   }

   public Map<String, Double> getPrimeAssetInfo()
   {
      return primeAssetInfo;
   }

   public void setPrimeAssetInfo(Map<String, Double> primeAssetInfo)
   {
      this.primeAssetInfo = primeAssetInfo;
   }

   public Integer getOffset()
   {
      return offset;
   }

   public void setOffset(Integer offset)
   {
      this.offset = offset;
   }

   public String[] getRbsatickers()
   {
      return rbsatickers;
   }

   public void setRbsatickers(String[] rbsatickers)
   {
      this.rbsatickers = rbsatickers;
   }

   public double[] getOptimizedWeights()
   {
      return optimizedWeights;
   }

   public void setOptimizedWeights(double[] optimizedWeights)
   {
      this.optimizedWeights = optimizedWeights;
   }

   public double[] getRisk()
   {
      return risk;
   }

   public double getRiskOffset(Integer offset)
   {
      offset = (offset < 0) ? 0: offset;

      if (offset < risk.length)
         return Math.sqrt(252)* risk[offset];
      else
         return Math.sqrt(252)* risk[risk.length];
   }

   public void setRisk(double[] risk)
   {
      this.risk = risk;
   }

   public double[] getPortReturns()
   {
      return portReturns;
   }

   public double getPortReturnsOffset(Integer offset)
   {
      offset = (offset < 0) ? 0: offset;

      if (offset < portReturns.length)
         return portReturns[offset];
      else
         return portReturns[portReturns.length];
   }


   public void setPortReturns(double[] portReturns)
   {
      this.portReturns = portReturns;
   }
}
