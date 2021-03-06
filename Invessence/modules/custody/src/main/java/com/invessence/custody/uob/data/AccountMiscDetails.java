package com.invessence.custody.uob.data;

/**
 * Created by abhangp on 10/24/2017.
 */
public class AccountMiscDetails
{
   private String existingTradeAcctNumber;
   private String isExistingIndividualAcct;
   private String salesPersonName;
   private String havingRepDtls;
   private String havingGST;

   @Override
   public String toString()
   {
      return "AccountMiscDetails{" +
         "existingTradeAcctNumber='" + existingTradeAcctNumber + '\'' +
         ", isExistingIndividualAcct='" + isExistingIndividualAcct + '\'' +
         ", salesPersonName='" + salesPersonName + '\'' +
         ", havingRepDtls='" + havingRepDtls + '\'' +
         ", havingGST='" + havingGST + '\'' +
         '}';
   }

   public String getIsExistingIndividualAcct()
   {
      return isExistingIndividualAcct;
   }

   public void setIsExistingIndividualAcct(String isExistingIndividualAcct)
   {
      this.isExistingIndividualAcct = isExistingIndividualAcct;
   }

   public String getSalesPersonName()
   {
      return salesPersonName;
   }

   public void setSalesPersonName(String salesPersonName)
   {
      this.salesPersonName = salesPersonName;
   }

   public String getExistingTradeAcctNumber()
   {
      return existingTradeAcctNumber;
   }

   public void setExistingTradeAcctNumber(String existingTradeAcctNumber)
   {
      this.existingTradeAcctNumber = existingTradeAcctNumber;
   }


   public String getHavingRepDtls()
   {
      return havingRepDtls;
   }

   public void setHavingRepDtls(String havingRepDtls)
   {
      this.havingRepDtls = havingRepDtls;
   }

   public String getHavingGST()
   {
      return havingGST;
   }

   public void setHavingGST(String havingGST)
   {
      this.havingGST = havingGST;
   }
}
