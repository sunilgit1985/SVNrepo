package com.invessence.broker.constants;

public interface BrokerServiceConstants
{
   static final String YEAR_MONTH_DAY_FORMAT = "yyyyMMdd";
   static final String YEAR_MONTH_FORMAT = "yyyyMM";

   static final String[] POSITION_TABLE_COLUMNS = {
      "ClientAccountID",
      "AccountAlias",
      "CurrencyPrimary",
      "AssetClass",
      "FXRateToBase",
      "Symbol",
      "Description",
      "ReportDate",
      "Side",
      "Quantity",
      "CostBasisPrice",
      "CostBasisMoney",
      "MarkPrice",
      "PositionValue",
      "FifoPnlUnrealized",
      "LevelOfDetail"};

   static final String[] ACCOUNT_TABLE_COLUMNS = {
      "ClientAccountID",
      "AccountAlias",
      "CurrencyPrimary",
      "Name",
      "AccountType",
      "CustomerType",
      "AccountCapabilities",
      "TradingPermissions",
      "DateOpened",
      "DateClosed",
      "Street",
      "Street2",
      "City",
      "State",
      "Country",
      "PostalCode"
   };

   static final String[] CASH_TRANSACTION_TABLE_COLUMN = {
      "clientAccountID",
      "currencyPrimary",
      "assetClass",
      "fxRateToBase",
      "symbol",
      "description",
      "reportDate",
      "amount",
      "type",
      "tradeID",
      "code"
   };

   static final String[] COMMISSION_TABLE_COLUMN =  {
      "clientAccountID",
      "fromDate",
      "toDate",
      "commission",
      "otherFee",
      "advisorFee"
   };

   static final String[] NAV_DAILY_TABLE_COLUMN = {
      "clientAccountID",
      "reportDate",
      "cash",
      "stock",
      "funds",
      "interestAccrual",
      "dividentAccrual",
      "total"
   };

   static final String[] TRADE_TABLE_COLUMN = {
      "clientAccountID",
      "currencyPrimary",
      "assetClass",
      "fxRateToBase",
      "symbol",
      "description",
      "tradeID",
      "reportDate",
      "quantity",
      "tradeprice",
      "proceed",
      "ibcommission",
      "levelofDetail"
   };

   static final String[] UNBNDLD_COMMISSION_TABLE_COLUMN = {
      "clientAccountID",
      "currencyPrimary",
      "assetClass",
      "fxRateToBase",
      "symbol",
      "description",
      "reportDate",
      "reportTime",
      "exchange",
      "buy_sell",
      "quantity",
      "price",
      "tradeID",
      "totalcommission",
      "brokerExecutionCharge",
      "brokerClearingCharge",
      "thirdPartyExecutionCharge",
      "thirdPartyRegulatoryCharge",
      "other"
   };

   static final String[] RELANDUNREL_TABLE_COLUMN = {
      "clientAccountID",
      "symbol",
      "reportDate",
      "realizedShortTermProfit",
      "realizedShortTermLoss",
      "realizedLongTermProfit",
      "realizedLongTermLoss",
      "totalRealizedPnl",
      "unrealizedProfit",
      "unrealizedLoss",
      "unrealizedSTProfit",
      "unrealizedSTLoss",
      "unrealizedLTProfit",
      "unrealizedLTLoss",
      "totalUnrealizedPnl",
      "totalFifoPnl"
   };

   static final String[] CASH_REPORT_TABLE_COLUMN = {
      "clientAccountID"	,
      "accountAlias"	,
      "currencyPrimary"	,
      "fromDate"	,
      "toDate"	,
      "startingCash"	,
      "startingCashSecurities"	,
      "startingCashCommodities"	,
      "commissions"	,
      "commissionsSecurities"	,
      "commissionsCommodities"	,
      "commissionsMTD"	,
      "commissionsYTD"	,
      "deposit_Withdrawals"	,
      "deposit_WithdrawalsSecurities"	,
      "deposit_WithdrawalsCommodities"	,
      "deposit_WithdrawalsMTD"	,
      "deposit_WithdrawalsYTD"	,
      "deposits"	,
      "depositsSecurities"	,
      "depositsCommodities"	,
      "depositsMTD"	,
      "depositsYTD"	,
      "withdrawals"	,
      "withdrawalsSecurities"	,
      "withdrawalsCommodities"	,
      "withdrawalsMTD"	,
      "withdrawalsYTD"	,
      "accountTransfers"	,
      "accountTransfersSecurities"	,
      "accountTransfersCommodities"	,
      "accountTransfersMTD"	,
      "accountTransfersYTD"	,
      "internalTransfers"	,
      "internalTransfersSecurities"	,
      "internalTransfersCommodities"	,
      "internalTransfersMTD"	,
      "internalTransfersYTD"	,
      "dividends"	,
      "dividendsSecurities"	,
      "dividendsCommodities"	,
      "dividendsMTD"	,
      "dividendsYTD"	,
      "brokerInterest"	,
      "brokerInterestSecurities"	,
      "brokerInterestCommodities"	,
      "brokerInterestMTD"	,
      "brokerInterestYTD"	,
      "bondInterest"	,
      "bondInterestSecurities"	,
      "bondInterestCommodities"	,
      "bondInterestMTD"	,
      "bondInterestYTD"	,
      "cashSettlingMtm"	,
      "cashSettlingMtmSecurities"	,
      "cashSettlingMtmCommodities"	,
      "cashSettlingMtmMTD"	,
      "cashSettlingMtmYTD"	,
      "netTradesSales"	,
      "netTradesSalesSecurities"	,
      "netTradesSalesCommodities"	,
      "netTradesSalesMTD"	,
      "netTradesSalesYTD"	,
      "netTradesPurchases"	,
      "netTradesPurchasesSecurities"	,
      "netTradesPurchasesCommodities"	,
      "netTradesPurchasesMTD"	,
      "netTradesPurchasesYTD"	,
      "advisorFees"	,
      "advisorFeesSecurities"	,
      "advisorFeesCommodities"	,
      "advisorFeesMTD"	,
      "advisorFeesYTD"	,
      "otherFees"	,
      "otherFeesSecurities"	,
      "otherFeesCommodities"	,
      "otherFeesMTD"	,
      "otherFeesYTD"	,
      "paymentInLieu"	,
      "paymentInLieuSecurities"	,
      "paymentInLieuCommodities"	,
      "paymentInLieuMTD"	,
      "paymentInLieuYTD"	,
      "transactionTax"	,
      "transactionTaxSecurities"	,
      "transactionTaxCommodities"	,
      "transactionTaxMTD"	,
      "transactionTaxYTD"	,
      "withholdingTax"	,
      "withholdingTaxSecurities"	,
      "withholdingTaxCommodities"	,
      "withholdingTaxMTD"	,
      "withholdingTaxYTD"	,
      "salesTax"	,
      "salesTaxSecurities"	,
      "salesTaxCommodities"	,
      "salesTaxMTD"	,
      "salesTaxYTD"	,
      "fXTranslationGain_Loss"	,
      "fXTranslationGain_LossSecurities"	,
      "fXTranslationGain_LossCommodities"	,
      "endingCash"	,
      "endingCashSecurities"	,
      "endingCashCommodities"	,
      "endingSettledCash"	,
      "endingSettledCashSecurities"	,
      "endingSettledCashCommodities"
   };
}