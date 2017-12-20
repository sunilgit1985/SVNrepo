package com.invessence.custody.uob.data;

import java.util.Date;

/**
 * Created by sagar on 12/20/2017.
 */
public class OwnerBankDetails
{
   private Long acctnum;
   private Integer acctOwnerId;
   private String bankName;
   private String bankAccountNo;
   private String bankAddressStreet1;
   private String bankAddressStreet2;
   private String bankAddressStreet3;
   private String bankAddressStreet4;
   private String bankAddressCity;
   private String bankAddressState;
   private String bankAddressZipCode;
   private String bankAddressCountry;
   private String swiftBic;
   private String correspondentBank;
   private String correspondentBankSwiftBic;
   private Date created;
   private String createdBy;
   private Date updated;
   private String updatedBy;

   public Long getAcctnum()
   {
      return acctnum;
   }

   public void setAcctnum(Long acctnum)
   {
      this.acctnum = acctnum;
   }

   public Integer getAcctOwnerId()
   {
      return acctOwnerId;
   }

   public void setAcctOwnerId(Integer acctOwnerId)
   {
      this.acctOwnerId = acctOwnerId;
   }

   public String getBankName()
   {
      return bankName;
   }

   public void setBankName(String bankName)
   {
      this.bankName = bankName;
   }

   public String getBankAccountNo()
   {
      return bankAccountNo;
   }

   public void setBankAccountNo(String bankAccountNo)
   {
      this.bankAccountNo = bankAccountNo;
   }

   public String getBankAddressStreet1()
   {
      return bankAddressStreet1;
   }

   public void setBankAddressStreet1(String bankAddressStreet1)
   {
      this.bankAddressStreet1 = bankAddressStreet1;
   }

   public String getBankAddressStreet2()
   {
      return bankAddressStreet2;
   }

   public void setBankAddressStreet2(String bankAddressStreet2)
   {
      this.bankAddressStreet2 = bankAddressStreet2;
   }

   public String getBankAddressStreet3()
   {
      return bankAddressStreet3;
   }

   public void setBankAddressStreet3(String bankAddressStreet3)
   {
      this.bankAddressStreet3 = bankAddressStreet3;
   }

   public String getBankAddressStreet4()
   {
      return bankAddressStreet4;
   }

   public void setBankAddressStreet4(String bankAddressStreet4)
   {
      this.bankAddressStreet4 = bankAddressStreet4;
   }

   public String getBankAddressCity()
   {
      return bankAddressCity;
   }

   public void setBankAddressCity(String bankAddressCity)
   {
      this.bankAddressCity = bankAddressCity;
   }

   public String getBankAddressState()
   {
      return bankAddressState;
   }

   public void setBankAddressState(String bankAddressState)
   {
      this.bankAddressState = bankAddressState;
   }

   public String getBankAddressZipCode()
   {
      return bankAddressZipCode;
   }

   public void setBankAddressZipCode(String bankAddressZipCode)
   {
      this.bankAddressZipCode = bankAddressZipCode;
   }

   public String getBankAddressCountry()
   {
      return bankAddressCountry;
   }

   public void setBankAddressCountry(String bankAddressCountry)
   {
      this.bankAddressCountry = bankAddressCountry;
   }

   public String getSwiftBic()
   {
      return swiftBic;
   }

   public void setSwiftBic(String swiftBic)
   {
      this.swiftBic = swiftBic;
   }

   public String getCorrespondentBank()
   {
      return correspondentBank;
   }

   public void setCorrespondentBank(String correspondentBank)
   {
      this.correspondentBank = correspondentBank;
   }

   public String getCorrespondentBankSwiftBic()
   {
      return correspondentBankSwiftBic;
   }

   public void setCorrespondentBankSwiftBic(String correspondentBankSwiftBic)
   {
      this.correspondentBankSwiftBic = correspondentBankSwiftBic;
   }

   public Date getCreated()
   {
      return created;
   }

   public void setCreated(Date created)
   {
      this.created = created;
   }

   public String getCreatedBy()
   {
      return createdBy;
   }

   public void setCreatedBy(String createdBy)
   {
      this.createdBy = createdBy;
   }

   public Date getUpdated()
   {
      return updated;
   }

   public void setUpdated(Date updated)
   {
      this.updated = updated;
   }

   public String getUpdatedBy()
   {
      return updatedBy;
   }

   public void setUpdatedBy(String updatedBy)
   {
      this.updatedBy = updatedBy;
   }

   @Override
   public String toString()
   {
      return "OwnerBankDetails{" +
         "acctnum=" + acctnum +
         ", acctOwnerId=" + acctOwnerId +
         ", bankName='" + bankName + '\'' +
         ", bankAccountNo='" + bankAccountNo + '\'' +
         ", bankAddressStreet1='" + bankAddressStreet1 + '\'' +
         ", bankAddressStreet2='" + bankAddressStreet2 + '\'' +
         ", bankAddressStreet3='" + bankAddressStreet3 + '\'' +
         ", bankAddressStreet4='" + bankAddressStreet4 + '\'' +
         ", bankAddressCity='" + bankAddressCity + '\'' +
         ", bankAddressState='" + bankAddressState + '\'' +
         ", bankAddressZipCode='" + bankAddressZipCode + '\'' +
         ", bankAddressCountry='" + bankAddressCountry + '\'' +
         ", swiftBic='" + swiftBic + '\'' +
         ", correspondentBank='" + correspondentBank + '\'' +
         ", correspondentBankSwiftBic='" + correspondentBankSwiftBic + '\'' +
         ", created=" + created +
         ", createdBy='" + createdBy + '\'' +
         ", updated=" + updated +
         ", updatedBy='" + updatedBy + '\'' +
         '}';
   }
}
