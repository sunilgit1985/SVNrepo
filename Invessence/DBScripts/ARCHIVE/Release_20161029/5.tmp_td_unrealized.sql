CREATE TABLE `temp`.`tmp_td_unrealized` (
  `custodialID` varchar(20) NOT NULL DEFAULT '',
  `businessDate` varchar(20) NOT NULL DEFAULT '',
  `accountNumber` varchar(30) NOT NULL DEFAULT '',
  `accountType` varchar(30) NOT NULL DEFAULT '',
  `securityType` varchar(20) DEFAULT NULL,
  `symbolCUSIP` varchar(30) NOT NULL DEFAULT '',
  `currentQuantity` varchar(20) DEFAULT NULL,
  `costBasis` varchar(20) DEFAULT NULL,
  `adjustedCostBasis` varchar(20) DEFAULT NULL,
  `unrealizedGainLoss` varchar(20) DEFAULT NULL,
  `costBasisFullyKnown` varchar(1) DEFAULT NULL,
  `certifiedFlag` varchar(1) DEFAULT NULL,
  `originalPurchaseDate` varchar(20) NOT NULL DEFAULT '',
  `originalPurchasePrice` varchar(20) DEFAULT NULL,
  `washSaleIndicator` varchar(1) DEFAULT NULL,
  `disallowedAmount` varchar(20) DEFAULT NULL,
  `averagedCost` varchar(20) DEFAULT NULL,
  `bookCost` varchar(20) DEFAULT NULL,
  `bookProceeds` varchar(20) DEFAULT NULL,
  `fixedIncomeCostAdjustment` varchar(20) DEFAULT NULL,
  `ID` varchar(30) NOT NULL DEFAULT '',
  `securityName` varchar(60) DEFAULT NULL,
  `covered` varchar(20) DEFAULT NULL,
  `unknownTotal` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`accountNumber`,`businessDate`,`symbolCUSIP`,`originalPurchaseDate`,`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
