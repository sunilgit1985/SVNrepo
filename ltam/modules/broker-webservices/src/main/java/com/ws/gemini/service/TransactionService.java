package com.ws.gemini.service;

import com.invessence.bean.*;

/**
 * Created by abhangp on 3/28/2016.
 */
public interface TransactionService
{
   public WSCallStatus fundAccount(UserAcctDetails userAcctDetails, int fundID, double amount, String accountNumber) throws Exception;
   public WSCallStatus fundTransfer(UserAcctDetails userAcctDetails, int fromFundID, int toFundID, double amount, String accountNumber) throws Exception;
}
