package com.invessence.web.data.custody.td;

import java.util.Date;

public class AcctOwnersDetails {
   private Long acctnum;
   private Integer acctOwnerId;
   private String ownership;  // Primary, or Joint
   private String firstName;
   private String midInitial;
   private String lastName;
   private String ssn;
   private String dob;
   private String phoneNumber;
   private String phoneNumberNonUS;
   private String secondPhoneNumber;
   private String secondPhoneNumberNonUS;
   private String emailAddress;
   private String physicalAddressStreet;
   private String physicalAddressCity;
   private String physicalAddressState;
   private String physicalAddressZipCode;
   private String mailingAddressStreet;
   private String mailingAddressCity;
   private String mailingAddressState;
   private String mailingAddressZipCode;
   private Boolean citizenShipFlag;
   private String citizenshiId;
   private String countryOfCitizenship;
   private String countryOfDualCitizenship;
   private String countryOfBirth;
   private String isSPF;
   private String spfDetail;
   private String isDirectorShareholder;
   private String directorShareholderDetail;
   private String bd;
   private String bdDetail;
   private Double ownershipPercent;
   private Date created;
   private String createdBy;
   private Date updated;
   private String updatedBy;

   public AcctOwnersDetails()
   {
   }

   public AcctOwnersDetails(Long acctnum, Integer acctOwnerId, String ownership)
   {
      this.acctnum = acctnum;
      this.acctOwnerId = acctOwnerId;
      this.ownership = ownership;
   }

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

   public String getOwnership()
   {
      return ownership;
   }

   public void setOwnership(String ownership)
   {
      this.ownership = ownership;
   }

   public String getFirstName()
   {
      return firstName;
   }

   public void setFirstName(String firstName)
   {
      this.firstName = firstName;
   }

   public String getMidInitial()
   {
      return midInitial;
   }

   public void setMidInitial(String midInitial)
   {
      this.midInitial = midInitial;
   }

   public String getLastName()
   {
      return lastName;
   }

   public void setLastName(String lastName)
   {
      this.lastName = lastName;
   }

   public String getSsn()
   {
      return ssn;
   }

   public void setSsn(String ssn)
   {
      this.ssn = ssn;
   }

   public String getDob()
   {
      return dob;
   }

   public void setDob(String dob)
   {
      this.dob = dob;
   }

   public String getPhoneNumber()
   {
      return phoneNumber;
   }

   public void setPhoneNumber(String phoneNumber)
   {
      this.phoneNumber = phoneNumber;
   }

   public String getPhoneNumberNonUS()
   {
      return phoneNumberNonUS;
   }

   public void setPhoneNumberNonUS(String phoneNumberNonUS)
   {
      this.phoneNumberNonUS = phoneNumberNonUS;
   }

   public String getSecondPhoneNumber()
   {
      return secondPhoneNumber;
   }

   public void setSecondPhoneNumber(String secondPhoneNumber)
   {
      this.secondPhoneNumber = secondPhoneNumber;
   }

   public String getSecondPhoneNumberNonUS()
   {
      return secondPhoneNumberNonUS;
   }

   public void setSecondPhoneNumberNonUS(String secondPhoneNumberNonUS)
   {
      this.secondPhoneNumberNonUS = secondPhoneNumberNonUS;
   }

   public String getEmailAddress()
   {
      return emailAddress;
   }

   public void setEmailAddress(String emailAddress)
   {
      this.emailAddress = emailAddress;
   }

   public String getPhysicalAddressStreet()
   {
      return physicalAddressStreet;
   }

   public void setPhysicalAddressStreet(String physicalAddressStreet)
   {
      this.physicalAddressStreet = physicalAddressStreet;
   }

   public String getPhysicalAddressCity()
   {
      return physicalAddressCity;
   }

   public void setPhysicalAddressCity(String physicalAddressCity)
   {
      this.physicalAddressCity = physicalAddressCity;
   }

   public String getPhysicalAddressState()
   {
      return physicalAddressState;
   }

   public void setPhysicalAddressState(String physicalAddressState)
   {
      this.physicalAddressState = physicalAddressState;
   }

   public String getPhysicalAddressZipCode()
   {
      return physicalAddressZipCode;
   }

   public void setPhysicalAddressZipCode(String physicalAddressZipCode)
   {
      this.physicalAddressZipCode = physicalAddressZipCode;
   }

   public String getMailingAddressStreet()
   {
      return mailingAddressStreet;
   }

   public void setMailingAddressStreet(String mailingAddressStreet)
   {
      this.mailingAddressStreet = mailingAddressStreet;
   }

   public String getMailingAddressCity()
   {
      return mailingAddressCity;
   }

   public void setMailingAddressCity(String mailingAddressCity)
   {
      this.mailingAddressCity = mailingAddressCity;
   }

   public String getMailingAddressState()
   {
      return mailingAddressState;
   }

   public void setMailingAddressState(String mailingAddressState)
   {
      this.mailingAddressState = mailingAddressState;
   }

   public String getMailingAddressZipCode()
   {
      return mailingAddressZipCode;
   }

   public void setMailingAddressZipCode(String mailingAddressZipCode)
   {
      this.mailingAddressZipCode = mailingAddressZipCode;
   }

   public Boolean getCitizenShipFlag()
   {
      return citizenShipFlag;
   }

   public void setCitizenShipFlag(Boolean citizenShipFlag)
   {
      this.citizenShipFlag = citizenShipFlag;
      if (citizenShipFlag) {
         setCitizenshiId("USCITZ");
      }
      else {
         setCitizenshiId(null);
      }
   }

   public String getCitizenshiId()
   {
      return citizenshiId;
   }

   public void setCitizenshiId(String citizenshiId)
   {
      this.citizenshiId = citizenshiId;
   }

   public String getCountryOfCitizenship()
   {
      return countryOfCitizenship;
   }

   public void setCountryOfCitizenship(String countryOfCitizenship)
   {
      this.countryOfCitizenship = countryOfCitizenship;
   }

   public String getCountryOfDualCitizenship()
   {
      return countryOfDualCitizenship;
   }

   public void setCountryOfDualCitizenship(String countryOfDualCitizenship)
   {
      this.countryOfDualCitizenship = countryOfDualCitizenship;
   }

   public String getCountryOfBirth()
   {
      return countryOfBirth;
   }

   public void setCountryOfBirth(String countryOfBirth)
   {
      this.countryOfBirth = countryOfBirth;
   }

   public String getSPF()
   {
      return isSPF;
   }

   public void setSPF(String SPF)
   {
      isSPF = SPF;
   }

   public String getSpfDetail()
   {
      return spfDetail;
   }

   public void setSpfDetail(String spfDetail)
   {
      this.spfDetail = spfDetail;
   }

   public String getDirectorShareholder()
   {
      return isDirectorShareholder;
   }

   public void setDirectorShareholder(String directorShareholder)
   {
      isDirectorShareholder = directorShareholder;
   }

   public String getDirectorShareholderDetail()
   {
      return directorShareholderDetail;
   }

   public void setDirectorShareholderDetail(String directorShareholderDetail)
   {
      this.directorShareholderDetail = directorShareholderDetail;
   }

   public String getBd()
   {
      return bd;
   }

   public void setBd(String bd)
   {
      this.bd = bd;
   }

   public String getBdDetail()
   {
      return bdDetail;
   }

   public void setBdDetail(String bdDetail)
   {
      this.bdDetail = bdDetail;
   }

   public Double getOwnershipPercent()
   {
      return ownershipPercent;
   }

   public void setOwnershipPercent(Double ownershipPercent)
   {
      this.ownershipPercent = ownershipPercent;
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
