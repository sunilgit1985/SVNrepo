package com.invessence.web.data.custody.td;

import java.util.Date;

public class AchBankDetail {
      private Long moveMoneyPayMethodID;
      private Long achId;
      private String bankAcctType;
      private String bankName;
      private String bankABARouting;
      private String bankCityState;
      private String bankPhoneNumber;
      private String bankAcctName;
      private String bankAcctNumber;
      private Date created;
      private String createdBy;
      private Date updated;
      private String updatedBy;

   public AchBankDetail()
   {
   }

   public Long getMoveMoneyPayMethodID()
   {
      return moveMoneyPayMethodID;
   }

   public void setMoveMoneyPayMethodID(Long moveMoneyPayMethodID)
   {
      this.moveMoneyPayMethodID = moveMoneyPayMethodID;
   }

   public Long getAchId()
   {
      return achId;
   }

   public void setAchId(Long achId)
   {
      this.achId = achId;
   }

   public String getBankAcctType()
   {
      return bankAcctType;
   }

   public void setBankAcctType(String bankAcctType)
   {
      this.bankAcctType = bankAcctType;
   }

   public String getBankName()
   {
      return bankName;
   }

   public void setBankName(String bankName)
   {
      this.bankName = bankName;
   }

   public String getBankABARouting()
   {
      return bankABARouting;
   }

   public void setBankABARouting(String bankABARouting)
   {
      this.bankABARouting = bankABARouting;
   }

   public String getBankCityState()
   {
      return bankCityState;
   }

   public void setBankCityState(String bankCityState)
   {
      this.bankCityState = bankCityState;
   }

   public String getBankPhoneNumber()
   {
      return bankPhoneNumber;
   }

   public void setBankPhoneNumber(String bankPhoneNumber)
   {
      this.bankPhoneNumber = bankPhoneNumber;
   }

   public String getBankAcctName()
   {
      return bankAcctName;
   }

   public void setBankAcctName(String bankAcctName)
   {
      this.bankAcctName = bankAcctName;
   }

   public String getBankAcctNumber()
   {
      return bankAcctNumber;
   }

   public void setBankAcctNumber(String bankAcctNumber)
   {
      this.bankAcctNumber = bankAcctNumber;
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
}
