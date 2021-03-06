package com.invmodel.rebalance.data;

/**
 * Created with IntelliJ IDEA.
 * User: pichaimanir
 * Date: 8/19/13
 * Time: 4:50 PM
 * To change this template use File | Settings | File Templates.
 */
public class HoldingData
{

   private boolean processed = false;
   private Long instrumentid;
   private String ticker;
   private String substituteTicker;
   private String assetclass;
   private String subclass;
   private String color;
   private Double qty;
   private Double subQty;
   private Double weight;

   private String tradeCurrency;
   private String description;
   private String side;
   private Double costBasisPrice;
   private Double costBasisMoney;
   private Double markPrice;
   private Double subMarketPrice;
   private Double positionValue;

   private String levelOfDetail;
   private Double yield;
   private Double expenseRatio;
   private Double risk;

   private Boolean washSaleFlag; //True meaning should not trade, false meaning trading is permitted
   private Boolean outRightSellFlag; //If ticker is not in new portfolio and trade is bigger than 31 days, set true

   private Boolean tlhSellShortFlag;
   private Boolean tlhSellLongFlag;

   //Short gain and loss
   private Double relShortGain;
   private Double relShortLoss;
   private Double unrelShortGain;
   private Double unrelShortLoss;

   //Long gain and loss
   private Double relLongGain;
   private Double relLongLoss;
   private Double unrelLongGain;
   private Double unrelLongLoss;

   //Breakdown of tax lots by long held and short held
   private Double longProceeds;
   private Double longTimeShares;
   private Double shortProceeds;
   private Double shortTimeShares;

   private String settleCurrency;
   private Double exchangeRate;
   private Double settleQty;
   private Double settleMarkPrice;
   private Double settlePosition;

   private Double settleLongProceeds;
   private Double settleLongTimeShares;
   private Double settleShortProceeds;
   private Double settleShortTimeShares;

   public HoldingData()
   {
   }

   public HoldingData(boolean processed, Long instrumentid,
                      String ticker, String substituteTicker,
                      String assetclass, String subclass, String color,
                      Double qty, Double subQty, Double weight,
                      String tradeCurrency, String description, String side,
                      Double costBasisPrice, Double costBasisMoney, Double markPrice,
                      Double subMarketPrice, Double positionValue, String levelOfDetail,
                      Double yield, Double expenseRatio, Double risk,
                      Boolean washSaleFlag, Boolean outRightSellFlag, Boolean tlhSellShortFlag,
                      Boolean tlhSellLongFlag, Double relShortGain, Double relShortLoss,
                      Double unrelShortGain, Double unrelShortLoss, Double relLongGain,
                      Double relLongLoss, Double unrelLongGain, Double unrelLongLoss,
                      Double longProceeds, Double longTimeShares, Double shortProceeds,
                      Double shortTimeShares, String settleCurrency, Double exchangeRate,
                      Double settleQty, Double settleMarkPrice, Double settlePosition,
                      Double settleLongProceeds, Double settleLongTimeShares,
                      Double settleShortProceeds, Double settleShortTimeShares,
                      Double fifoPnlUnrealized)
   {
      this.processed = processed;
      this.instrumentid = instrumentid;
      this.ticker = ticker;
      this.substituteTicker = substituteTicker;
      this.assetclass = assetclass;
      this.subclass = subclass;
      this.color = color;
      this.qty = qty;
      this.subQty = subQty;
      this.weight = weight;
      this.tradeCurrency = tradeCurrency;
      this.description = description;
      this.side = side;
      this.costBasisPrice = costBasisPrice;
      this.costBasisMoney = costBasisMoney;
      this.markPrice = markPrice;
      this.subMarketPrice = subMarketPrice;
      this.positionValue = positionValue;
      this.levelOfDetail = levelOfDetail;
      this.yield = yield;
      this.expenseRatio = expenseRatio;
      this.risk = risk;
      this.washSaleFlag = washSaleFlag;
      this.outRightSellFlag = outRightSellFlag;
      this.tlhSellShortFlag = tlhSellShortFlag;
      this.tlhSellLongFlag = tlhSellLongFlag;
      this.relShortGain = relShortGain;
      this.relShortLoss = relShortLoss;
      this.unrelShortGain = unrelShortGain;
      this.unrelShortLoss = unrelShortLoss;
      this.relLongGain = relLongGain;
      this.relLongLoss = relLongLoss;
      this.unrelLongGain = unrelLongGain;
      this.unrelLongLoss = unrelLongLoss;
      this.longProceeds = longProceeds;
      this.longTimeShares = longTimeShares;
      this.shortProceeds = shortProceeds;
      this.shortTimeShares = shortTimeShares;
      this.settleCurrency = settleCurrency;
      this.exchangeRate = exchangeRate;
      this.settleQty = settleQty;
      this.settleMarkPrice = settleMarkPrice;
      this.settlePosition = settlePosition;
      this.settleLongProceeds = settleLongProceeds;
      this.settleLongTimeShares = settleLongTimeShares;
      this.settleShortProceeds = settleShortProceeds;
      this.settleShortTimeShares = settleShortTimeShares;
      this.fifoPnlUnrealized = fifoPnlUnrealized;
   }

   public Boolean getOutRightSellFlag()
   {
      return outRightSellFlag;
   }

   public void setOutRightSellFlag(Boolean outRightSellFlag)
   {
      this.outRightSellFlag = outRightSellFlag;
   }

   public Double getLongProceeds()
   {
      return longProceeds;
   }

   public void setLongProceeds(Double longProceeds)
   {
      this.longProceeds = longProceeds;
   }

   public Double getLongTimeShares()
   {
      return ((longTimeShares == null) ? 0.0 : longTimeShares);
   }

   public void setLongTimeShares(Double longTimeShares)
   {
      this.longTimeShares = longTimeShares;
   }

   public Double getShortProceeds()
   {
      return ((shortProceeds == null) ? 0.0 : shortProceeds);
   }

   public void setShortProceeds(Double shortProceeds)
   {
      this.shortProceeds = shortProceeds;
   }

   public Double getShortTimeShares()
   {
      return ((shortTimeShares == null) ? 0.0 : shortTimeShares);
   }

   public void setShortTimeShares(Double shortTimeShares)
   {
      this.shortTimeShares = shortTimeShares;
   }

   public Boolean isTlhSellLongFlag()
   {
      return ((tlhSellLongFlag == null) ? false : tlhSellLongFlag);
   }

   public void setTlhSellLongFlag(Boolean tlhSellLongFlag)
   {
      this.tlhSellLongFlag = tlhSellLongFlag;
   }

   public Boolean isTlhSellShortFlag()
   {
      return ((tlhSellShortFlag == null) ? false : tlhSellShortFlag);
   }

   public void setTlhSellShortFlag(Boolean tlhSellShortFlag)
   {
      this.tlhSellShortFlag = tlhSellShortFlag;
   }

   public Double getSubQty()
   {
      return subQty;
   }

   public void setSubQty(Double subQty)
   {
      this.subQty = subQty;
   }

   public Double getSubMarketPrice()
   {
      return subMarketPrice;
   }

   public void setSubMarketPrice(Double subMarketPrice)
   {
      this.subMarketPrice = subMarketPrice;
   }

   public Double getRelShortGain()
   {
      return relShortGain;
   }

   public void setRelShortGain(Double relShortGain)
   {
      this.relShortGain = relShortGain;
   }

   public Double getRelShortLoss()
   {
      return relShortLoss;
   }

   public void setRelShortLoss(Double relShortLoss)
   {
      this.relShortLoss = relShortLoss;
   }

   public Double getUnrelShortGain()
   {
      return unrelShortGain;
   }

   public void setUnrelShortGain(Double unrelShortGain)
   {
      this.unrelShortGain = unrelShortGain;
   }

   public Double getUnrelShortLoss()
   {
      return unrelShortLoss;
   }

   public void setUnrelShortLoss(Double unrelShortLoss)
   {
      this.unrelShortLoss = unrelShortLoss;
   }

   public Double getRelLongGain()
   {
      return relLongGain;
   }

   public void setRelLongGain(Double relLongGain)
   {
      this.relLongGain = relLongGain;
   }

   public Double getRelLongLoss()
   {
      return relLongLoss;
   }

   public void setRelLongLoss(Double relLongLoss)
   {
      this.relLongLoss = relLongLoss;
   }

   public Double getUnrelLongGain()
   {
      return unrelLongGain;
   }

   public void setUnrelLongGain(Double unrelLongGain)
   {
      this.unrelLongGain = unrelLongGain;
   }

   public Double getUnrelLongLoss()
   {
      return unrelLongLoss;
   }

   public void setUnrelLongLoss(Double unrelLongLoss)
   {
      this.unrelLongLoss = unrelLongLoss;
   }

   private Double fifoPnlUnrealized;

   public String getSubstituteTicker()
   {
      return substituteTicker;
   }

   public void setSubstituteTicker(String substituteTicker)
   {
      this.substituteTicker = substituteTicker;
   }

   public Boolean getWashSaleFlag()
   {
      return washSaleFlag;
   }

   public void setWashSaleFlag(Boolean washSaleFlag)
   {
      this.washSaleFlag = washSaleFlag;
   }

   public boolean isProcessed()
   {
      return processed;
   }

   public void setProcessed(boolean processed)
   {
      this.processed = processed;
   }

    public Long getInstrumentid()
   {
      return instrumentid;
   }

   public void setInstrumentid(Long instrumentid)
   {
      this.instrumentid = instrumentid;
   }

   public String getTicker()
   {
      return ticker;
   }

   public void setTicker(String ticker)
   {
      this.ticker = ticker;
   }

   public String getAssetclass()
   {
      return assetclass;
   }

   public void setAssetclass(String assetclass)
   {
      this.assetclass = assetclass;
   }

   public String getSubclass()
   {
      return subclass;
   }

   public void setSubclass(String subclass)
   {
      this.subclass = subclass;
   }

   public String getColor()
   {
      return color;
   }

   public void setColor(String color)
   {
      this.color = color;
   }

   public Double getQty()
   {
      return qty;
   }

   public void setQty(Double qty)
   {
      this.qty = qty;
   }

   public Double getWeight()
   {
      return weight;
   }

   public void setWeight(Double weight)
   {
      this.weight = weight;
   }

   public Double getWeightAsPercent() {
      if (getWeight() != null)
         return (getWeight() * 100);
      else
         return 0.0;
   }

   public String getTradeCurrency()
   {
      return tradeCurrency;
   }

   public void setTradeCurrency(String tradeCurrency)
   {
      this.tradeCurrency = tradeCurrency;
   }

   public String getDescription()
   {
      return description;
   }

   public void setDescription(String description)
   {
      this.description = description;
   }

   public String getSide()
   {
      return side;
   }

   public void setSide(String side)
   {
      this.side = side;
   }

   public Double getCostBasisPrice()
   {
      return costBasisPrice;
   }

   public void setCostBasisPrice(Double costBasisPrice)
   {
      this.costBasisPrice = costBasisPrice;
   }

   public Double getCostBasisMoney()
   {
      return costBasisMoney;
   }

   public void setCostBasisMoney(Double costBasisMoney)
   {
      this.costBasisMoney = costBasisMoney;
   }

   public Double getMarkPrice()
   {
      return markPrice;
   }

   public void setMarkPrice(Double markPrice)
   {
      this.markPrice = markPrice;
   }

   public Double getPositionValue()
   {
      return positionValue;
   }

   public void setPositionValue(Double positionValue)
   {
      this.positionValue = positionValue;
   }

   public Double getFifoPnlUnrealized()
   {
      return fifoPnlUnrealized;
   }

   public void setFifoPnlUnrealized(Double fifoPnlUnrealized)
   {
      this.fifoPnlUnrealized = fifoPnlUnrealized;
   }

   public String getLevelOfDetail()
   {
      return levelOfDetail;
   }

   public void setLevelOfDetail(String levelOfDetail)
   {
      this.levelOfDetail = levelOfDetail;
   }

   public Double getYield()
   {
      return yield;
   }

   public void setYield(Double yield)
   {
      this.yield = yield;
   }

   public Double getExpenseRatio()
   {
      return expenseRatio;
   }

   public void setExpenseRatio(Double expenseRatio)
   {
      this.expenseRatio = expenseRatio;
   }

   public Double getRisk()
   {
      return risk;
   }

   public void setRisk(Double risk)
   {
      this.risk = risk;
   }

   public Boolean getTlhSellShortFlag()
   {
      return tlhSellShortFlag;
   }

   public Boolean getTlhSellLongFlag()
   {
      return tlhSellLongFlag;
   }

   public String getSettleCurrency()
   {
      return settleCurrency;
   }

   public void setSettleCurrency(String settleCurrency)
   {
      this.settleCurrency = settleCurrency;
   }

   public Double getExchangeRate()
   {
      return exchangeRate;
   }

   public void setExchangeRate(Double exchangeRate)
   {
      this.exchangeRate = exchangeRate;
   }

   public Double getSettleLongProceeds()
   {
      return settleLongProceeds;
   }

   public void setSettleLongProceeds(Double settleLongProceeds)
   {
      this.settleLongProceeds = settleLongProceeds;
   }

   public Double getSettleLongTimeShares()
   {
      return settleLongTimeShares;
   }

   public void setSettleLongTimeShares(Double settleLongTimeShares)
   {
      this.settleLongTimeShares = settleLongTimeShares;
   }

   public Double getSettleShortProceeds()
   {
      return settleShortProceeds;
   }

   public void setSettleShortProceeds(Double settleShortProceeds)
   {
      this.settleShortProceeds = settleShortProceeds;
   }

   public Double getSettleShortTimeShares()
   {
      return settleShortTimeShares;
   }

   public void setSettleShortTimeShares(Double settleShortTimeShares)
   {
      this.settleShortTimeShares = settleShortTimeShares;
   }

   public Double getSettlePosition()
   {
      return settlePosition;
   }

   public Double getSettleMarkPrice()
   {
      return settleMarkPrice;
   }

   public void setSettlePosition(Double settlePosition)
   {
      this.settlePosition = settlePosition;
   }

   public Double getSettleQty()
   {
      return settleQty;
   }

   public void setSettleQty(Double settleQty)
   {
      this.settleQty = settleQty;
   }
}
