package invtest;

import com.invmodel.asset.data.AssetClass;
import com.invmodel.inputData.ProfileData;
import com.invmodel.portfolio.data.Portfolio;

/**
 * Created by prashant on 12/21/2017.
 */
public class PrintData
{
   ProfileData profiledata;
   AssetClass[] aamc;
   Portfolio[] pfclass;

   public PrintData(ProfileData pdata, AssetClass[] aamc, Portfolio[] pfclass)
   {
      this.profiledata = pdata;
      this.aamc = aamc;
      this.pfclass = pfclass;
   }

   public ProfileData getProfileData()
   {
      return profiledata;
   }

   public AssetClass[] getAamc()
   {
      return aamc;
   }

   public Portfolio[] getPfclass()
   {
      return pfclass;
   }

}
