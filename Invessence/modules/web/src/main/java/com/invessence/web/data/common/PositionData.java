package com.invessence.web.data.common;

import java.text.DecimalFormat;
import java.util.*;
import javax.faces.bean.ManagedProperty;

import com.invessence.web.dao.common.*;
import com.invessence.web.util.*;
import com.invmodel.asset.data.*;
import org.primefaces.model.chart.PieChartModel;

/**
 * Created by prashant on 10/24/2017.
 */
public class PositionData
{
   private List<Position> positionList;
   private List<Transaction> transactionList;
   private List<Position> displayPositionList = new ArrayList<Position>();
   private DataDisplayConverter dconveter = new DataDisplayConverter();

   @ManagedProperty("#{webutil}")
   public WebUtil webutil;
   public void setWebutil(WebUtil webutil)
   {
      this.webutil = webutil;
   }

   public WebUtil getWebutil()
   {
      return webutil;
   }

   @ManagedProperty("#{positionDAO}")
   private PositionDAO positionDAO;
   @ManagedProperty("#{transactionDAO}")
   private TransactionDAO transactionDAO;

   private Map<String, Asset> managedAssetsMap = new LinkedHashMap<String, Asset>();
   private List<Asset> managedAssetsList = new ArrayList<Asset>();

   private Double totalAllocation;
   private Integer totalshare;
   private Double totalvalue;
   private Double totalmoney;
   private Double totalpnl;
   private Double totalYield;
   private Double totalExpenseRatio;
   private Double totalRisk;
   private Double totalFees;
   private Double goalDesired;
   private Double goalReached;
   private Long acctnum;
   private String firstname, lastname, dateOpened, clientAccountID,accountAlias;
   private Boolean managed;
   private Map<String,Double> currencyWiseTotal;
   private String settlmentTotal;

   public void setPositionDAO(PositionDAO positionDAO)
   {
      this.positionDAO = positionDAO;
   }

   public PositionDAO getPositionDAO()
   {
      return positionDAO;
   }

   public List<Position> getDisplayPositionList()
   {
      return displayPositionList;
   }

   public Long getAcctnum()
   {
      return acctnum;
   }

   public void setAcctnum(Long acctnum)
   {
      this.acctnum = acctnum;
   }

   public String getFirstname()
   {
      return firstname;
   }

   public void setFirstname(String firstname)
   {
      this.firstname = firstname;
   }

   public String getLastname()
   {
      return lastname;
   }

   public void setLastname(String lastname)
   {
      this.lastname = lastname;
   }

   public String getFullName() {
      if (lastname != null && lastname.length() > 0)
         return this.lastname + ", " + this.firstname;
      else
         return firstname + " Portfolio";
   }

   public String getDateOpened()
   {
      if (dateOpened != null)
      {
         return dateOpened.substring(0, 4) + "-" + dateOpened.substring(4, 6) + "-" + dateOpened.substring(6);
      }
      return dateOpened;
   }

   public void setDateOpened(String dateOpened)
   {
      this.dateOpened = dateOpened;
   }

   public String getClientAccountID()
   {
      return clientAccountID;
   }

   public void setClientAccountID(String clientAccountID)
   {
      this.clientAccountID = clientAccountID;
   }

   public String getAccountAlias()
   {
      return accountAlias;
   }

   public void setAccountAlias(String accountAlias)
   {
      this.accountAlias = accountAlias;
   }

   public Boolean getManaged()
   {
      return managed;
   }

   public void setManaged(Boolean managed)
   {
      this.managed = managed;
   }

   public Map<String, Asset> getManagedAssetsMap()
   {
      return managedAssetsMap;
   }

   public void setManagedAssetsMap(Map<String, Asset> managedAssetsMap)
   {
      this.managedAssetsMap = managedAssetsMap;
   }

   public List<Asset> getManagedAssetsList()
   {
      return managedAssetsList;
   }

   public void setManagedAssetsList(List<Asset> managedAssetsList)
   {
      this.managedAssetsList = managedAssetsList;
   }

   public void collectData()
   {
      try
      {
         if (this.acctnum == null)
            webutil.redirect("/access-denied.xhtml", null);
         else
         {
            // Note: If no data is found, then blank form will display.  It is better then going to access denied, page.
            positionList = positionDAO.loadDBPosition(webutil, this.acctnum);
            transactionList = transactionDAO.loadTransaction(webutil, this.acctnum,"E");
            addTotals();
         }
      }
      catch (Exception ex)
      {
         System.out.println("Error in collect data from DB :" + ex.getMessage());
         ex.printStackTrace();
      }

   }

   public void addTotals()
   {
      Integer rows;
      try
      {
         totalAllocation = 0.0;
         totalshare = 0;
         totalvalue = 0.0;
         totalmoney = 0.0;
         totalpnl = 0.0;
         totalRisk = 0.0;
         totalYield = 0.0;
         totalExpenseRatio = 0.0;
         totalFees = 0.0;
         goalDesired = 0.0;
         goalReached = 0.0;

         displayPositionList.clear();
         if (positionList == null)
         {
            return;
         }
         rows = positionList.size();
         managedAssetsMap.clear();
         managedAssetsList.clear();
         if(currencyWiseTotal!=null)
         {
            currencyWiseTotal.clear();
         }else{
            currencyWiseTotal=new HashMap<String, Double>();
         }
        Double dbSettlmentTotal=0.0;
         int counter=0;
         this.managed = true;
         Boolean infoData = false;
         for (int loop = 0; loop < rows; loop++)
         {
            Position position = positionList.get(loop);
            if (position.getTicker() != null && position.getTicker().length() > 0)
               displayPositionList.add(position);
            String assetname =  (position.getAssetclass() == null) ? "Other": position.getAssetclass();
            if (assetname.toUpperCase().contains("STK"))
               this.managed = false;
            if (!managedAssetsMap.containsKey(assetname))
            {
               Asset asset = new Asset(assetname,
                                       assetname,    // Display name is not defined in Managed Asset.
                                       position.getColor(),
                                       0.0, 0.0, 0.0, 0.0, 0.0, position.getPositionValue(),
                                       position.getWeight(), position.getYield(), position.getRisk(),
                                       position.getExpenseRatio(), position.getPositionValue());
               managedAssetsMap.put(assetname, asset);
               managedAssetsList.add(counter++, asset);
            }
            else
            {
               Asset asset = managedAssetsMap.get(assetname);
               //asset.setHoldingweight(asset.getHoldingweight() + position.getWeight());
               asset.setHoldingValue(asset.getHoldingValue() + position.getPositionValue());
               asset.setHoldingReturn(asset.getHoldingReturn() + position.getYield());
               asset.setHoldingRisk(asset.getHoldingRisk() + position.getRisk());
               asset.setHoldingExpenseRatio(asset.getHoldingExpenseRatio() + position.getExpenseRatio());

               asset.setValue(asset.getHoldingValue());
            }

            if ((!infoData) && (position.getClientAccountID() != null))
            {
               infoData = true;
               setFirstname(position.getFirstname());
               setLastname(position.getLastname());
               setDateOpened(position.getDateOpened());
               setClientAccountID(position.getClientAccountID());
               setAccountAlias(position.getAccountAlias());
               totalFees = position.getFees();  // NOTE: This field contains the ytd total.  It is not by security;
            }
            totalAllocation = totalAllocation + position.getWeight();
            totalshare = totalshare + position.getQty();
            totalmoney = totalmoney + position.getCostBasisMoney();
            totalvalue = totalvalue + position.getPositionValue();
            totalpnl = totalpnl + position.getFifoPnlUnrealized();
            totalRisk = totalRisk + (position.getRisk());
            totalExpenseRatio = totalExpenseRatio + (position.getExpenseRatio());
            totalYield = totalYield + (position.getYield());
            if (position.getGoalAmount() != null) {
               goalDesired = position.getGoalAmount();
            }

            if (position.getGoalAmount() > 0.0) {
               goalReached = totalmoney / goalDesired;
            }

            // Recalc the actual weight
            if(currencyWiseTotal.isEmpty()){
               currencyWiseTotal.put(position.getSettleCurrency(),position.getSettleMoney());
            }else{
               if(currencyWiseTotal.containsKey(position.getSettleCurrency())){
                  Double value=position.getSettleMoney()+currencyWiseTotal.get(position.getSettleCurrency());
                  currencyWiseTotal.put(position.getSettleCurrency(),value);
               }else{
                  currencyWiseTotal.put(position.getSettleCurrency(),position.getSettleMoney());
               }
            }
            dbSettlmentTotal=dbSettlmentTotal+position.getPositionValue();
         }

         for (Asset asset: managedAssetsList) {
            Double assetHolingTotal = asset.getHoldingValue();
            asset.setAllocweight(assetHolingTotal/totalvalue);
            asset.setActualweight(assetHolingTotal/totalvalue);
            asset.setHoldingweight(assetHolingTotal/totalvalue);
         }
         DecimalFormat df2 = new DecimalFormat("##,###,##0.00");
         settlmentTotal= df2.format(dbSettlmentTotal);

      }
      catch (Exception ex)
      {
         System.out.println("Error when attempting to addTotal(position)" + ex.getMessage());
      }

   }

   public List<Position> getPositionList()
   {
      return positionList;
   }

   public void setPositionList(List<Position> positionList)
   {
      this.positionList = positionList;
   }

   public Double getTotalAllocation()
   {
      return totalAllocation;
   }

   public void setTotalAllocation(Double totalAllocation)
   {
      this.totalAllocation = totalAllocation;
   }

   public Integer getTotalshare()
   {
      return totalshare;
   }

   public Double getTotalvalue()
   {
      return totalvalue;
   }

   public Double getTotalmoney()
   {
      return totalmoney;
   }

   public void setTotalmoney(Double totalmoney)
   {
      this.totalmoney = totalmoney;
   }

   public Double getTotalpnl()
   {
      return totalpnl;
   }

   public void setTotalpnl(Double totalpnl)
   {
      this.totalpnl = totalpnl;
   }

   public Double getTotalYield()
   {
      return totalYield;
   }

   public void setTotalYield(Double totalYield)
   {
      this.totalYield = totalYield;
   }

   public Double getTotalExpenseRatio()
   {
      return totalExpenseRatio;
   }

   public void setTotalExpenseRatio(Double totalExpenseRatio)
   {
      this.totalExpenseRatio = totalExpenseRatio;
   }

   public Double getTotalRisk()
   {
      return totalRisk;
   }

   public void setTotalRisk(Double totalRisk)
   {
      this.totalRisk = totalRisk;
   }

   public Double getTotalFees()
   {
      return totalFees;
   }

   public void setTotalFees(Double totalFees)
   {
      this.totalFees = totalFees;
   }

   public Double getGoalDesired()
   {
      return goalDesired;
   }

   public Double getGoalReached()
   {
      return goalReached;
   }

   public String reviseRisk()
   {
      return "success";
   }

   public Map<String, Double> getCurrencyWiseTotal()
   {
      return currencyWiseTotal;
   }

   public void setCurrencyWiseTotal(Map<String, Double> currencyWiseTotal)
   {
      this.currencyWiseTotal = currencyWiseTotal;
   }



   public TransactionDAO getTransactionDAO()
   {
      return transactionDAO;
   }

   public void setTransactionDAO(TransactionDAO transactionDAO)
   {
      this.transactionDAO = transactionDAO;
   }

   public List<Transaction> getTransactionList()
   {
      return transactionList;
   }

   public void setTransactionList(List<Transaction> transactionList)
   {
      this.transactionList = transactionList;
   }

   public String getSettlmentTotal()
   {
      return settlmentTotal;
   }

   public void setSettlmentTotal(String settlmentTotal)
   {
      this.settlmentTotal = settlmentTotal;
   }
}
