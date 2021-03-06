package com.invessence.custody.uob.data;

/**
 * Created by abhangp on 10/26/2017.
 */
public class OwnerMiscDetails
{
   private String fatherName;
   private String motherMaidenName;
   private String nameOfPrimarySchool;
   private String qualifications;
   private String qualificationsSpecify;
   private String mailAddressSameAsPhysical;
   private String consentCallContact;
   private String consentTextContact;
   private String reasonForMailAddreDiffer;
   private String reasonForUnemployment;
   private String permanentRsdntOfSingapore;
   private String confirmEmail;

   @Override
   public String toString()
   {
      return "OwnerMiscDetails{" +
         "fatherName='" + fatherName + '\'' +
         ", motherMaidenName='" + motherMaidenName + '\'' +
         ", nameOfPrimarySchool='" + nameOfPrimarySchool + '\'' +
         ", qualifications='" + qualifications + '\'' +
         ", qualificationsSpecify='" + qualificationsSpecify + '\'' +
         ", mailAddressSameAsPhysical='" + mailAddressSameAsPhysical + '\'' +
         ", consentCallContact='" + consentCallContact + '\'' +
         ", consentTextContact='" + consentTextContact + '\'' +
         ", reasonForMailAddreDiffer='" + reasonForMailAddreDiffer + '\'' +
         ", reasonForUnemployment='" + reasonForUnemployment + '\'' +
         ", permanentRsdntOfSingapore='" + permanentRsdntOfSingapore + '\'' +
         ", confirmEmail='" + confirmEmail + '\'' +
         '}';
   }

   public String getMailAddressSameAsPhysical()
   {
      return mailAddressSameAsPhysical;
   }

   public void setMailAddressSameAsPhysical(String mailAddressSameAsPhysical)
   {
      this.mailAddressSameAsPhysical = mailAddressSameAsPhysical;
   }

   public String getFatherName()
   {
      return fatherName;
   }

   public void setFatherName(String fatherName)
   {
      this.fatherName = fatherName;
   }

   public String getMotherMaidenName()
   {
      return motherMaidenName;
   }

   public void setMotherMaidenName(String motherMaidenName)
   {
      this.motherMaidenName = motherMaidenName;
   }

   public String getNameOfPrimarySchool()
   {
      return nameOfPrimarySchool;
   }

   public void setNameOfPrimarySchool(String nameOfPrimarySchool)
   {
      this.nameOfPrimarySchool = nameOfPrimarySchool;
   }

   public String getQualifications()
   {
      return qualifications;
   }

   public void setQualifications(String qualifications)
   {
      this.qualifications = qualifications;
   }

   public String getQualificationsSpecify()
   {
      return qualificationsSpecify;
   }

   public void setQualificationsSpecify(String qualificationsSpecify)
   {
      this.qualificationsSpecify = qualificationsSpecify;
   }

   public String getConsentCallContact()
   {
      return consentCallContact;
   }

   public void setConsentCallContact(String consentCallContact)
   {
      this.consentCallContact = consentCallContact;
   }

   public String getConsentTextContact()
   {
      return consentTextContact;
   }

   public void setConsentTextContact(String consentTextContact)
   {
      this.consentTextContact = consentTextContact;
   }

   public String getReasonForMailAddreDiffer()
   {
      return reasonForMailAddreDiffer;
   }

   public void setReasonForMailAddreDiffer(String reasonForMailAddreDiffer)
   {
      this.reasonForMailAddreDiffer = reasonForMailAddreDiffer;
   }

   public String getReasonForUnemployment()
   {
      return reasonForUnemployment;
   }

   public void setReasonForUnemployment(String reasonForUnemployment)
   {
      this.reasonForUnemployment = reasonForUnemployment;
   }

   public String getPermanentRsdntOfSingapore()
   {
      return permanentRsdntOfSingapore;
   }

   public void setPermanentRsdntOfSingapore(String permanentRsdntOfSingapore)
   {
      this.permanentRsdntOfSingapore = permanentRsdntOfSingapore;
   }

   public String getConfirmEmail()
   {
      return confirmEmail;
   }

   public void setConfirmEmail(String confirmEmail)
   {
      this.confirmEmail = confirmEmail;
   }
}
