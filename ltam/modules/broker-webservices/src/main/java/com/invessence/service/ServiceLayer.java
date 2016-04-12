package com.invessence.service;

import java.util.List;

import com.invessence.bean.*;

/**
 * Created by abhangp on 3/11/2016.
 */
public interface ServiceLayer
{
   public void createPendingUser();
   public WSCallStatus updateEmail(String clientAccountID, String newEmail);
   public WSCallStatus updateMailingAddress(String clientAccountID,
                                            String firstName,String middleName,String lastName,
                                            String addressLine1, String addressLine2,String addressLine3,
                                            String postalZip, short countryCode,
                                            String voicePhone, String altPhone, String faxPhone, String emailAddress);

   public WSCallResult getUserBankAcctDetails(String clientAccountID);

   public WSCallStatus fundAccount(String clientAccountID, int fundID, double amount, String accountNumber);
   public WSCallStatus fundTransfer(String clientAccountID, int fromFundID, int toFundID, double amount, String accountNumber);

   //Future required functions

   //public WSCallStatus loginUser(String clientAccountID);
   //public WSCallStatus createUser(String clientAccountID, String securityQuestion, String securityAnswer);
   //public WSCallStatus isUserExist(String userId);
   //public WSCallStatus getMailingAddress(String clientAccountID);

}
