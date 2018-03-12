package com.invessence.web.data;

import com.invessence.web.data.common.CustomerData;
import com.invessence.web.util.Logger;
import com.invmodel.risk.data.*;

/**
 * Created by prashant on 11/16/2017.
 */
public class Customer extends CustomerData implements Logger
{

   UserRiskProfile userRiskProfile;
   RiskCalc riskCalc;

   public Customer()
   {
      userRiskProfile = new UserRiskProfile();
      riskCalc = new RiskCalc();
   }

   public void preRender()
   {

   }

}
